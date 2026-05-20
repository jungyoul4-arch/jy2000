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
}

export default new AuthService();
