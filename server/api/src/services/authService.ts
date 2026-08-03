import pool from '../config/database';
import { RowDataPacket } from 'mysql2';
import { AppError } from '../middlewares/errorHandler';

// 인증 코드 저장소 (메모리)
interface AuthCode {
  code: string;
  userId: number;
  phone: string;
  expiresAt: Date;
}

const authCodes: Map<string, AuthCode> = new Map();

// 정율톡 로그인 API
const JUNGYOULTALK_LOGIN_URL = 'https://jungyoul.com/chat_server/api_login.php';

// 로그인 불가 사용자 유형 (User.kind: 1=관리자, 2=학생, 3=선생님, 4=학부모, 5=상담원)
const LOGIN_BLOCKED_KINDS = [2, 4];

// 정율톡 로그인 API 응답
interface JungyoulTalkLoginResponse {
  status: string;
  message?: string;
  user?: {
    user_id: number;
    name: string;
    nick_name?: string;
    phone: string;
    kind: number;
    student_id?: number | null;
    is_official_tutor?: boolean;
  };
}

// 만료된 코드 정리 (5분마다)
setInterval(() => {
  const now = new Date();
  for (const [key, value] of authCodes.entries()) {
    if (value.expiresAt < now) {
      authCodes.delete(key);
    }
  }
}, 5 * 60 * 1000);

export class AuthService {
  // 전화번호로 사용자 조회 (kind=1,3,5,6,7 - 학생/보호자 제외)
  async findUserByPhone(phone: string): Promise<any> {
    const sql = `
      SELECT user_id, name, kind, phone, email, fcm_token, is_admin
      FROM User
      WHERE phone = ?
        AND kind IN (1, 3, 5, 6, 7)
        AND active_flag = 1
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [phone]);

    if (rows.length === 0) {
      return null;
    }

    return rows[0];
  }

  // 4자리 랜덤 인증 코드 생성
  generateCode(): string {
    return Math.floor(1000 + Math.random() * 9000).toString();
  }

  // 인증 코드 요청
  async requestCode(phone: string): Promise<{ userId: number; userName: string }> {
    // 1. 사용자 조회
    const user = await this.findUserByPhone(phone);

    if (!user) {
      throw new AppError('등록되지 않았거나 로그인 권한이 없는 전화번호입니다.', 401);
    }

    // 2. fcm_token 체크 (정율톡 설치 여부)
    if (!user.fcm_token || user.fcm_token === '') {
      throw new AppError('인증코드 발송 불가능-정율톡 설치 필요', 400);
    }

    // 3. 인증 코드 생성
    const code = this.generateCode();
    const expiresAt = new Date(Date.now() + 3 * 60 * 1000); // 3분 후 만료

    // 4. 인증 코드 저장
    authCodes.set(phone, {
      code,
      userId: user.user_id,
      phone,
      expiresAt
    });

    // 5. 정율톡으로 인증 코드 발송
    await this.sendAuthCode(user.user_id, code);

    return {
      userId: user.user_id,
      userName: user.name
    };
  }

  // 정율톡 API로 인증 코드 발송
  async sendAuthCode(receiverId: number, code: string): Promise<void> {
    const message = `인증코드=${code}, '정율 상담 관리'에서 보낸 인증 코드입니다.`;

    try {
      const response = await fetch('https://jungyoul.com/chat_server/api_id.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          receiver_id: receiverId.toString(),
          message: message
        })
      });

      const result = await response.json() as { status: string; receiver_name?: string };

      if (result.status !== 'success') {
        console.error('정율톡 발송 실패:', result);
        throw new AppError('인증 코드 발송에 실패했습니다.', 500);
      }

      console.log(`인증 코드 발송 완료: ${result.receiver_name}`);
    } catch (error) {
      console.error('정율톡 API 오류:', error);
      throw new AppError('인증 코드 발송에 실패했습니다.', 500);
    }
  }

  // 인증 코드 확인
  async verifyCode(phone: string, code: string): Promise<any> {
    const authCode = authCodes.get(phone);

    if (!authCode) {
      throw new AppError('인증 코드가 없거나 만료되었습니다.', 401);
    }

    if (authCode.expiresAt < new Date()) {
      authCodes.delete(phone);
      throw new AppError('인증 코드가 만료되었습니다.', 401);
    }

    if (authCode.code !== code) {
      throw new AppError('인증 코드가 일치하지 않습니다.', 401);
    }

    // 인증 성공 - 코드 삭제
    authCodes.delete(phone);

    // 사용자 정보 조회
    const user = await this.findUserByPhone(phone);

    // 마지막 로그인 시간 업데이트
    await pool.query(
      'UPDATE User SET last_login_dt = NOW() WHERE user_id = ?',
      [user.user_id]
    );

    return {
      userId: user.user_id,
      name: user.name,
      kind: user.kind,
      phone: user.phone,
      email: user.email,
      isAdmin: user.is_admin === 1
    };
  }

  // 정율톡 계정으로 로그인 (전화번호 + 패스워드)
  async loginWithJungyoulTalk(phone: string, password: string): Promise<any> {
    // 하이픈 등 제거하여 숫자만 사용
    const normalizedPhone = phone.replace(/[^0-9]/g, '');

    if (!normalizedPhone) {
      throw new AppError('전화번호를 입력해주세요.', 400);
    }

    // 1. 정율톡 로그인 API 호출
    let result: JungyoulTalkLoginResponse;

    try {
      const response = await fetch(JUNGYOULTALK_LOGIN_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          phone: normalizedPhone,
          password,
        }),
      });

      result = (await response.json()) as JungyoulTalkLoginResponse;
    } catch (error) {
      console.error('정율톡 로그인 API 오류:', error);
      throw new AppError('정율톡 서버에 연결할 수 없습니다. 잠시 후 다시 시도해주세요.', 502);
    }

    // 2. 정율톡 인증 실패 (패스워드 불일치 / 패스워드 미설정 등)
    //    정율톡이 내려주는 안내 메시지를 그대로 전달한다
    if (result.status !== 'success' || !result.user) {
      throw new AppError(result.message || '전화번호 또는 패스워드가 일치하지 않습니다.', 401);
    }

    const talkUser = result.user;
    const talkKind = Number(talkUser.kind);

    // 3. 학생(2) / 학부모(4)는 사용 불가
    if (LOGIN_BLOCKED_KINDS.includes(talkKind)) {
      throw new AppError('학생/학부모 계정은 이 시스템을 사용할 수 없습니다.', 403);
    }

    // 4. 로컬 User 정보 조회 (정율톡과 user_id 체계를 공유)
    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT user_id, name, kind, phone, email, is_admin, active_flag
       FROM User
       WHERE user_id = ?`,
      [talkUser.user_id]
    );

    const localUser = rows[0];

    if (!localUser) {
      throw new AppError('정율 상담 관리 시스템에 등록되지 않은 사용자입니다.', 403);
    }

    if (localUser.active_flag !== 1) {
      throw new AppError('비활성화된 계정입니다. 관리자에게 문의해주세요.', 403);
    }

    const kind = Number(localUser.kind ?? talkKind);

    if (LOGIN_BLOCKED_KINDS.includes(kind)) {
      throw new AppError('학생/학부모 계정은 이 시스템을 사용할 수 없습니다.', 403);
    }

    // 5. 마지막 로그인 시간 업데이트
    await pool.query('UPDATE User SET last_login_dt = NOW() WHERE user_id = ?', [
      localUser.user_id,
    ]);

    return {
      userId: localUser.user_id,
      name: localUser.name || talkUser.name,
      kind,
      phone: localUser.phone || talkUser.phone,
      email: localUser.email,
      // 경영 보고서 등 관리자 전용 기능은 kind=1(관리자) 기준
      isAdmin: kind === 1 || localUser.is_admin === 1,
    };
  }

  // ID/PW 로그인
  async loginWithCredentials(loginId: string, password: string): Promise<any> {
    // 하드코딩된 관리자 계정
    if (loginId === 'admin' && password === 'jysk') {
      return {
        userId: 0,
        name: '관리자',
        kind: 1,
        phone: '',
        email: '',
        isAdmin: true
      };
    }

    throw new AppError('아이디 또는 비밀번호가 일치하지 않습니다.', 401);
  }
}

export default new AuthService();
