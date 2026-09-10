import * as crypto from 'crypto';
import * as fs from 'fs';
import * as path from 'path';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import * as XLSX from 'xlsx';

import pool from '../config/database';
import { AppError } from '../middlewares/errorHandler';

/**
 * 재원생 DB 엑셀(aca2000 월말 추출)을 enroll_snapshot에 적재한다.
 *
 * 대시보드가 엑셀 파일이 아니라 이 테이블을 읽게 하는 것이 목적이다.
 * 2~8월은 1회 적재하고, 이후로는 매월 업로드 한 번이면 된다.
 */

// 엑셀의 과목 컬럼 — 순서와 표기를 원본 그대로 둔다.
// 과학 세부(통합과학/물리/화학/생명/지구과학)를 살리는 게 이 테이블의
// 핵심 목적이라 여기서 뭉개면 대시보드의 과학 섹션이 통째로 죽는다.
const SUBJECT_COLUMNS = [
  '국어', '영어', '수학',
  '통합과학', '물리', '화학', '생명', '지구과학', '과학',
  '약술국어', '약술수학', '약술영어', '약술주말국어', '약술주말수학', '약술모의',
  '수리논술', '통합사회',
] as const;

const SUBJECT_GROUP: { [key: string]: string } = {
  국어: '국어',
  영어: '영어',
  수학: '수학',
  통합과학: '과학', 물리: '과학', 화학: '과학', 생명: '과학', 지구과학: '과학', 과학: '과학',
  통합사회: '사회',
  약술국어: '약술', 약술수학: '약술', 약술영어: '약술',
  약술주말국어: '약술', 약술주말수학: '약술', 약술모의: '약술',
  수리논술: '논술',
};

export interface ParsedRow {
  studentName: string;
  schoolName: string | null;
  grade: number | null;
  attendType: string | null;
  subject: string;
  subjectGroup: string;
  className: string;
  classKind: string;
  teachers: string[];
}

export interface ParseResult {
  rows: ParsedRow[];
  studentCount: number;
}

/**
 * 학년 표기를 User.grade 코드 체계로 옮긴다.
 * 6=초6, 7~9=중1~3, 10~12=고1~3, 13=N수
 */
const parseGrade = (raw: unknown): number | null => {
  const s = String(raw ?? '').trim();
  if (!s) return null;

  if (s.startsWith('N')) return 13;

  const m = s.match(/^(초등?|중|고)\s*(\d)$/);
  if (!m) return null;

  const n = Number(m[2]);
  if (m[1].startsWith('초')) return n;
  if (m[1] === '중') return n + 6;
  return n + 9;
};

/**
 * 반 성격을 반명에서 판정한다.
 *
 * 9월부터 학교별 내신대비반이 별도 클래스로 대량 등록돼(반당 1~몇 명)
 * 정규반과 섞어 세면 「반 규모 분포」·「소인수 반」이 1~2명짜리 반으로
 * 뒤덮인다. 집계 단계에서 가를 수 있도록 적재할 때 표시해 둔다.
 *
 * 약술은 '약술 모의'처럼 이름에 모의가 들어가도 상시 과정이라 특강이 아니다.
 */
const parseClassKind = (className: string, subject: string): string => {
  if (subject.startsWith('약술')) return '정규';
  if (/내신/.test(className)) return '내신';
  if (/모의|모고|특강|썸머|윈터|전국/.test(className)) return '특강';
  return '정규';
};

/**
 * DB 경로에서 과목을 정한다.
 *
 * Class.genre_id는 국어/수학/영어/과학/사회 다섯 갈래뿐이라 과학을 뭉갠다.
 * 엑셀은 통합과학·물리·화학·생명·지구과학을 나눠 두고 대시보드의 과학
 * 섹션이 그걸 쓰므로, 반명에서 세부를 되살린다.
 * 9월 엑셀로 확인한 결과 반명에 과목이 그대로 들어 있었다
 * ('S고1통합과학ES지성현(토1)', 'S고2세포와물질대사E성현T(일7)' 등).
 */
const GENRE_TO_SUBJECT: { [key: number]: string } = {
  1: '국어', 2: '수학', 3: '영어', 4: '과학', 5: '통합사회',
};

/**
 * 반명 접두의 과목 코드를 읽는다 — K=국어, M=수학, E=영어, S=과학, So=사회.
 * classService.generateClassName()이 이 규칙으로 이름을 만든다.
 *
 * genre_id보다 이쪽이 정확하다. 8월 검증에서 국어 반이 genre_id=4(과학)로
 * 들어 있는 사례가 나왔고, genre_id=0인 미분류 반도 44건 있었다.
 */
const prefixSubject = (className: string): number | null => {
  const bare = className
    .replace(/^\s*\[[^\]]*\]\s*/, '') // '[2026 1학기 중간고사 대비] ' 같은 파생 접두
    .replace(/^\s*20\d\d\S*\s*/, ''); // '2026 ', '2026썸머 ' 같은 연도 접두

  const m = bare.match(/^(So|[KMES])(?=[가-힣0-9])/);
  if (!m) return null;

  return { K: 1, M: 2, E: 3, S: 4, So: 5 }[m[1]] ?? null;
};

const subjectOf = (genreId: number, className: string): string => {
  // 약술을 가장 먼저 본다. '약술형논술종합반'처럼 논술이 들어가는 이름이
  // 있어 논술 판정을 먼저 하면 전부 논술로 빨려 들어간다.
  if (/약술/.test(className)) {
    if (/모의/.test(className)) return '약술모의';
    const isMath = /수학|논술|^M|M고|M중/.test(className);
    if (/주말/.test(className)) return isMath ? '약술주말수학' : '약술주말국어';
    if (isMath) return '약술수학';
    if (/영어/.test(className)) return '약술영어';
    return '약술국어';
  }

  // 과학 세부. 반명에 과목이 그대로 들어 있어 되살릴 수 있다.
  if (/통합과학/.test(className)) return '통합과학';
  if (/물리|역학과에너지/.test(className)) return '물리';
  if (/화학|물질과에너지|화학반응/.test(className)) return '화학';
  if (/생명|세포와물질대사/.test(className)) return '생명';
  if (/지구과학/.test(className)) return '지구과학';

  if (/논술/.test(className)) return '수리논술';

  // 반명 접두 → genre_id → 반명 안의 과목 단어 순으로 떨어뜨린다.
  const code = prefixSubject(className) ?? (genreId > 0 ? genreId : null);
  if (code) return GENRE_TO_SUBJECT[code] ?? '기타';

  if (/국어/.test(className)) return '국어';
  if (/수학|미적분|확통|기하|대수/.test(className)) return '수학';
  if (/영어/.test(className)) return '영어';
  if (/과학/.test(className)) return '과학';
  if (/사회|한국사|통사/.test(className)) return '통합사회';

  return '기타';
};

/**
 * 과목 칸 하나를 편다.
 *
 * 칸 형식은 '○ 강사명\n반명'이고, 한 칸에 이 덩어리가 여럿 들어간다
 * (정규 + 특강 병행). 그래서 저장 단위가 학생×과목이 아니라
 * 학생×과목×반이다. 강사가 비어 '○\n반명'만 있는 칸도 있다.
 */
const parseCell = (raw: unknown): { teachers: string[]; className: string }[] => {
  const text = String(raw ?? '');
  if (!text.trim()) return [];

  const out: { teachers: string[]; className: string }[] = [];

  for (const chunk of text.split('○')) {
    const lines = chunk
      .split('\n')
      .map((s) => s.trim())
      .filter((s) => s !== '');

    if (lines.length === 0) continue;

    let teachers: string[] = [];
    let className: string;

    if (lines.length === 1) {
      // 강사 없이 반명만 있는 칸. 다만 반명 없이 강사만 남은 찌꺼기와
      // 구분해야 한다 — 반명에는 항상 숫자나 괄호가 들어간다.
      if (lines[0].length <= 4 && !/[0-9()（）]/.test(lines[0])) continue;
      className = lines[0];
    } else {
      teachers = lines[0].split('·').map((s) => s.trim()).filter(Boolean);
      className = lines.slice(1).join(' ');
    }

    if (!className) continue;
    out.push({ teachers, className });
  }

  return out;
};

export class EnrollSnapshotService {
  /**
   * 엑셀 파일을 읽어 적재할 행 목록으로 만든다. DB는 건드리지 않는다.
   */
  parseWorkbook(filePath: string): ParseResult {
    const workbook = XLSX.readFile(filePath);

    // '재원생' 시트가 원본이다. '반별 명단' 시트는 여기서 파생되는 값이라
    // 따로 담지 않는다 — class_name으로 group by 하면 그대로 나온다.
    const sheetName = workbook.SheetNames.includes('재원생')
      ? '재원생'
      : workbook.SheetNames[0];
    const sheet = workbook.Sheets[sheetName];

    const table = XLSX.utils.sheet_to_json<unknown[]>(sheet, { header: 1 });
    if (table.length < 2) {
      throw new AppError('엑셀에 데이터가 없습니다', 400);
    }

    const header = (table[0] as unknown[]).map((h) => String(h ?? '').trim());
    const at = (name: string) => header.indexOf(name);

    const iName = at('이름');
    const iSchool = at('학교');
    const iGrade = at('학년');
    const iType = at('구분');

    if (iName < 0) {
      throw new AppError("'이름' 컬럼을 찾을 수 없습니다. 재원생 DB 엑셀이 맞는지 확인하세요", 400);
    }

    const rows: ParsedRow[] = [];
    const students = new Set<string>();

    for (let r = 1; r < table.length; r++) {
      const row = table[r] as unknown[];
      if (!row || row.length === 0) continue;

      const studentName = String(row[iName] ?? '').trim();
      if (!studentName) continue;

      students.add(studentName);

      const schoolName = iSchool >= 0 ? String(row[iSchool] ?? '').trim() || null : null;
      const grade = iGrade >= 0 ? parseGrade(row[iGrade]) : null;
      const attendType = iType >= 0 ? String(row[iType] ?? '').trim() || null : null;

      for (const subject of SUBJECT_COLUMNS) {
        const col = at(subject);
        if (col < 0) continue;

        for (const { teachers, className } of parseCell(row[col])) {
          rows.push({
            studentName,
            schoolName,
            grade,
            attendType,
            subject,
            subjectGroup: SUBJECT_GROUP[subject] ?? '기타',
            className,
            classKind: parseClassKind(className, subject),
            teachers,
          });
        }
      }
    }

    return { rows, studentCount: students.size };
  }

  /**
   * 파일 하나를 특정 년월 스냅샷으로 적재한다.
   *
   * 같은 년월이 이미 있으면 지우고 새로 넣는다(재업로드 허용).
   * 다만 다른 달에 같은 파일이 올라오는 사고는 막는다 — 6월과 7월
   * 파일이 md5까지 동일했던 전례가 있어 file_hash를 검사한다.
   */
  async importFile(
    filePath: string,
    year: number,
    month: number,
    options: { asOfDate?: string | null; allowDuplicateFile?: boolean } = {}
  ): Promise<{ snapshotId: number; rowCount: number; studentCount: number }> {
    const { rows, studentCount } = this.parseWorkbook(filePath);
    if (rows.length === 0) {
      throw new AppError('적재할 수강 데이터가 없습니다', 400);
    }

    const buffer = fs.readFileSync(filePath);
    const fileHash = crypto.createHash('md5').update(buffer).digest('hex');

    if (!options.allowDuplicateFile) {
      const [dup] = await pool.query<RowDataPacket[]>(
        'SELECT year, month FROM enroll_snapshot WHERE file_hash = ? AND NOT (year = ? AND month = ?)',
        [fileHash, year, month]
      );
      if (dup.length > 0) {
        throw new AppError(
          `이미 ${dup[0].year}년 ${dup[0].month}월로 올라간 것과 동일한 파일입니다. ` +
            '다른 달 파일을 받았는지 확인하세요',
          400
        );
      }
    }

    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      await connection.query('DELETE FROM enroll_snapshot WHERE year = ? AND month = ?', [year, month]);

      const [head] = await connection.query<ResultSetHeader>(
        `INSERT INTO enroll_snapshot
           (year, month, as_of_date, source_kind, source_file, file_hash, student_count, row_count)
         VALUES (?, ?, ?, 'excel', ?, ?, ?, ?)`,
        [year, month, options.asOfDate ?? null, path.basename(filePath), fileHash, studentCount, rows.length]
      );
      const snapshotId = head.insertId;

      await this.insertRows(connection, snapshotId, year, month, rows);
      await this.matchIds(connection, snapshotId);

      await connection.commit();
      return { snapshotId, rowCount: rows.length, studentCount };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * 한 달의 스냅샷을 다른 달로 그대로 복제한다.
   *
   * 7월 전용 조치다. 6월과 7월 엑셀이 md5까지 동일해 7월 원본이
   * 사실상 없다. 월 축을 비우면 시계열이 끊기므로 6월 값을 넣고
   * source_note에 그 사실을 남긴다 — 6→7월 변화가 0으로 나오는 게
   * 데이터에 근거한 사실이 된다.
   */
  async copyMonth(
    from: { year: number; month: number },
    to: { year: number; month: number },
    note: string
  ): Promise<{ snapshotId: number; rowCount: number }> {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      const [src] = await connection.query<RowDataPacket[]>(
        'SELECT * FROM enroll_snapshot WHERE year = ? AND month = ?',
        [from.year, from.month]
      );
      if (src.length === 0) {
        throw new AppError(`${from.year}년 ${from.month}월 스냅샷이 없습니다`, 404);
      }
      const source = src[0];

      await connection.query('DELETE FROM enroll_snapshot WHERE year = ? AND month = ?', [to.year, to.month]);

      // file_hash는 복제본에 넣지 않는다. 원본과 같은 해시를 두면
      // 중복 검사에 걸려 이후 진짜 7월 파일을 못 올리게 된다.
      const [head] = await connection.query<ResultSetHeader>(
        `INSERT INTO enroll_snapshot
           (year, month, as_of_date, source_kind, source_file, file_hash, source_note, student_count, row_count)
         VALUES (?, ?, NULL, 'excel', ?, NULL, ?, ?, ?)`,
        [to.year, to.month, source.source_file, note, source.student_count, source.row_count]
      );
      const snapshotId = head.insertId;

      await connection.query(
        `INSERT INTO enroll_snapshot_row
           (snapshot_id, year, month, student_name, student_id, school_name, school_id,
            grade, attend_type, subject, subject_group, class_name, class_kind)
         SELECT ?, ?, ?, student_name, student_id, school_name, school_id,
                grade, attend_type, subject, subject_group, class_name, class_kind
         FROM enroll_snapshot_row WHERE snapshot_id = ?`,
        [snapshotId, to.year, to.month, source.snapshot_id]
      );

      // 강사는 row_id가 새로 발급되므로 반명·과목·학생으로 다시 잇는다.
      await connection.query(
        `INSERT INTO enroll_snapshot_teacher (row_id, teacher_name, teacher_id, year, month)
         SELECT dst.row_id, t.teacher_name, t.teacher_id, ?, ?
         FROM enroll_snapshot_row dst
         JOIN enroll_snapshot_row srcr
           ON srcr.snapshot_id = ?
          AND srcr.student_name = dst.student_name
          AND srcr.subject = dst.subject
          AND srcr.class_name <=> dst.class_name
         JOIN enroll_snapshot_teacher t ON t.row_id = srcr.row_id
         WHERE dst.snapshot_id = ?`,
        [to.year, to.month, source.snapshot_id, snapshotId]
      );

      const [cnt] = await connection.query<RowDataPacket[]>(
        'SELECT COUNT(*) AS n FROM enroll_snapshot_row WHERE snapshot_id = ?',
        [snapshotId]
      );

      await connection.commit();
      return { snapshotId, rowCount: Number(cnt[0].n) };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * DB에서 직접 그 달의 스냅샷을 만든다 (2026-09 이후 경로).
   *
   * '그 달에 수업기록이 있는 반'을 운영 중인 반으로 본다.
   * Class.is_active는 종료 특강이 1로 남아 못 쓰고, orzo_url_class_id는
   * 이름 변경 시 대부분 복사되지 않아 못 쓴다. 실제 수업이 있었는가만이
   * 신뢰할 수 있는 신호였다.
   *
   * 반을 세는 단위가 까다롭다. class_id ↔ course_id가 M:N이라
   *   · class_id  기준: 이름이 바뀔 때마다 새 행이 생겨 같은 반이 2~3개로 쪼개짐
   *   · course_id 기준: 통합과학처럼 여러 반이 한 코스를 공유해 하나로 뭉침
   * 그래서 둘을 이분그래프로 보고 연결요소를 한 반으로 묶는다.
   * 9월 10일치로 검증했을 때 학생 443명(엑셀 442) · 수강 1,146건(엑셀 1,126)으로
   * 1~2% 안에 들어왔다.
   */
  async snapshotFromDb(
    year: number,
    month: number,
    options: {
      asOfDate?: string | null;
      note?: string | null;
      /** 다른 년월로 저장한다. 엑셀분과 나란히 두고 비교할 때만 쓴다. */
      storeAs?: { year: number; month: number };
    } = {}
  ): Promise<{ snapshotId: number; rowCount: number; studentCount: number; classCount: number }> {
    const from = `${year}-${String(month).padStart(2, '0')}-01`;
    const to =
      month === 12
        ? `${year + 1}-01-01`
        : `${year}-${String(month + 1).padStart(2, '0')}-01`;

    // 조회 기간은 year/month가 정하고, 저장 위치만 storeAs가 바꾼다.
    const storeYear = options.storeAs?.year ?? year;
    const storeMonth = options.storeAs?.month ?? month;

    // 수업기록 → 클래스인 코스 → 반설정 → Class 로 이어지는 매핑 체인.
    // ClassRecord.class_id는 클래스인 쪽 ID라 Class와 안 맞는다(매칭 0건).
    // course_id로 타야 한다.
    const CHAIN = `
      FROM ClassRecord cr
      JOIN MV_ClassGroupMember2 g ON g.classin_course_id = cr.course_id
      JOIN MV_ClassConfig cfg     ON cfg.id = g.class_config_id
      JOIN Class c                ON c.class_id = cfg.server_class_id
    `;
    const PERIOD = 'WHERE cr.reg_dt >= ? AND cr.reg_dt < ?';

    const [edges] = await pool.query<RowDataPacket[]>(
      `SELECT DISTINCT cr.course_id, c.class_id ${CHAIN} ${PERIOD}`,
      [from, to]
    );
    if (edges.length === 0) {
      throw new AppError(`${year}년 ${month}월에 수업기록이 없습니다`, 404);
    }

    // 연결요소 — class_id와 course_id를 한 그래프의 노드로 놓고 합친다.
    const parent = new Map<string, string>();
    const find = (x: string): string => {
      if (!parent.has(x)) parent.set(x, x);
      let root = x;
      while (parent.get(root) !== root) root = parent.get(root)!;
      while (parent.get(x) !== root) {
        const next = parent.get(x)!;
        parent.set(x, root);
        x = next;
      }
      return root;
    };
    const union = (a: string, b: string) => {
      const ra = find(a);
      const rb = find(b);
      if (ra !== rb) parent.set(ra, rb);
    };
    for (const e of edges) {
      union(`c${e.class_id}`, `o${e.course_id}`);
    }
    const groupOf = (classId: number) => find(`c${classId}`);

    const [members] = await pool.query<RowDataPacket[]>(
      `SELECT DISTINCT
         c.class_id, c.class_name, c.genre_id,
         m.user_id, u.name AS student_name, u.grade,
         si.school_id, s.school_name
       ${CHAIN}
       JOIN ClassMember m       ON m.class_id = c.class_id
                               AND m.kind = 2 AND m.active_flag = 1
       JOIN User u              ON u.user_id = m.user_id
       LEFT JOIN student_info si ON si.student_id = u.user_id
       LEFT JOIN School s        ON s.school_id = si.school_id
       ${PERIOD}`,
      [from, to]
    );

    const [teacherRows] = await pool.query<RowDataPacket[]>(
      `SELECT DISTINCT c.class_id, m.user_id AS teacher_id, u.name AS teacher_name
       ${CHAIN}
       JOIN ClassMember m ON m.class_id = c.class_id
                          AND m.kind = 3 AND m.active_flag = 1
       JOIN User u        ON u.user_id = m.user_id
       ${PERIOD}`,
      [from, to]
    );

    // 그룹별 대표 반명. '[2026 1학기 중간고사 대비] …' 같은 파생 이름 대신
    // 대괄호 없는 정본 이름을 고른다. 과목 세부와 내신 여부를 이 이름에서
    // 뽑으므로 정본이 잡혀야 한다.
    const groupName = new Map<string, { name: string; genre: number }>();
    for (const r of members) {
      const key = groupOf(r.class_id);
      const cur = groupName.get(key);
      const name = String(r.class_name ?? '');
      const better =
        !cur ||
        (cur.name.startsWith('[') && !name.startsWith('[')) ||
        (cur.name.startsWith('[') === name.startsWith('[') && name.length > cur.name.length);
      if (better) groupName.set(key, { name, genre: Number(r.genre_id) });
    }

    const teachersByGroup = new Map<string, Map<string, number | null>>();
    for (const t of teacherRows) {
      const key = groupOf(t.class_id);
      if (!teachersByGroup.has(key)) teachersByGroup.set(key, new Map());
      teachersByGroup.get(key)!.set(String(t.teacher_name), t.teacher_id ?? null);
    }

    // (그룹, 학생) 하나가 수강 한 건이다. 같은 반이 여러 class_id로
    // 쪼개져 있어도 여기서 합쳐진다.
    const seen = new Set<string>();
    const rows: {
      groupKey: string;
      studentName: string;
      studentId: number;
      schoolName: string | null;
      schoolId: number | null;
      grade: number | null;
      subject: string;
      subjectGroup: string;
      className: string;
      classKind: string;
    }[] = [];

    for (const r of members) {
      const key = groupOf(r.class_id);
      const dedupe = `${key}|${r.user_id}`;
      if (seen.has(dedupe)) continue;
      seen.add(dedupe);

      const rep = groupName.get(key)!;
      const subject = subjectOf(rep.genre, rep.name);

      rows.push({
        groupKey: key,
        studentName: String(r.student_name ?? ''),
        studentId: Number(r.user_id),
        schoolName: r.school_name ?? null,
        schoolId: r.school_id || null,
        grade: r.grade || null,
        subject,
        subjectGroup: SUBJECT_GROUP[subject] ?? '기타',
        className: rep.name,
        classKind: parseClassKind(rep.name, subject),
      });
    }

    // 동명이인에 접미를 붙인다.
    //
    // 집계는 student_name 기준이다(엑셀분은 student_id 매칭률이 86~88%라
    // id로 세면 이탈이 부풀려진다). 엑셀은 aca2000이 '김나경A'/'김나경B'로
    // 구분해 두는데 DB에는 접미가 없어, 그대로 두면 9월부터 동명이인이
    // 한 명으로 합쳐져 재원생이 과소 집계된다. 같은 규칙으로 맞춘다.
    const idsByName = new Map<string, Set<number>>();
    for (const r of rows) {
      if (!idsByName.has(r.studentName)) idsByName.set(r.studentName, new Set());
      idsByName.get(r.studentName)!.add(r.studentId);
    }

    const suffixOf = new Map<number, string>();
    for (const [name, ids] of idsByName) {
      if (ids.size < 2) continue;
      // user_id 순으로 A, B, C… 를 매긴다. 순서가 고정돼야 달이 바뀌어도
      // 같은 학생이 같은 접미를 유지한다.
      [...ids]
        .sort((a, b) => a - b)
        .forEach((id, i) => suffixOf.set(id, String.fromCharCode(65 + i)));
      void name;
    }

    if (suffixOf.size > 0) {
      for (const r of rows) {
        const suffix = suffixOf.get(r.studentId);
        if (suffix) r.studentName = `${r.studentName}${suffix}`;
      }
    }

    const studentCount = new Set(rows.map((r) => r.studentId)).size;
    const classCount = new Set(rows.map((r) => r.groupKey)).size;

    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      await connection.query('DELETE FROM enroll_snapshot WHERE year = ? AND month = ?', [storeYear, storeMonth]);

      const [head] = await connection.query<ResultSetHeader>(
        `INSERT INTO enroll_snapshot
           (year, month, as_of_date, source_kind, source_note, student_count, row_count)
         VALUES (?, ?, ?, 'db', ?, ?, ?)`,
        [storeYear, storeMonth, options.asOfDate ?? null, options.note ?? null, studentCount, rows.length]
      );
      const snapshotId = head.insertId;

      const values = rows.map((r) => [
        snapshotId, storeYear, storeMonth,
        r.studentName, r.studentId, r.schoolName, r.schoolId, r.grade,
        null, // attend_type — 단과/종합은 수강료 체계 값이라 DB에 없다
        r.subject, r.subjectGroup, r.className, r.classKind,
      ]);

      const [inserted] = await connection.query<ResultSetHeader>(
        `INSERT INTO enroll_snapshot_row
           (snapshot_id, year, month, student_name, student_id, school_name, school_id,
            grade, attend_type, subject, subject_group, class_name, class_kind)
         VALUES ?`,
        [values]
      );

      const firstId = inserted.insertId;
      const teacherValues: unknown[][] = [];
      rows.forEach((r, i) => {
        const teachers = teachersByGroup.get(r.groupKey);
        if (!teachers) return;
        for (const [name, id] of teachers) {
          teacherValues.push([firstId + i, name, id, storeYear, storeMonth]);
        }
      });

      if (teacherValues.length > 0) {
        await connection.query(
          `INSERT IGNORE INTO enroll_snapshot_teacher
             (row_id, teacher_name, teacher_id, year, month) VALUES ?`,
          [teacherValues]
        );
      }

      await connection.commit();
      return { snapshotId, rowCount: rows.length, studentCount, classCount };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  private async insertRows(
    connection: any,
    snapshotId: number,
    year: number,
    month: number,
    rows: ParsedRow[]
  ): Promise<void> {
    // 한 달에 1,000~1,600행이라 한 번에 밀어 넣어도 부담이 없다.
    const values = rows.map((r) => [
      snapshotId, year, month,
      r.studentName, r.schoolName, r.grade, r.attendType,
      r.subject, r.subjectGroup, r.className, r.classKind,
    ]);

    const [result] = await connection.query(
      `INSERT INTO enroll_snapshot_row
         (snapshot_id, year, month, student_name, school_name, grade, attend_type,
          subject, subject_group, class_name, class_kind)
       VALUES ?`,
      [values]
    );

    // 벌크 INSERT는 첫 row_id만 돌려주지만 InnoDB가 연속 발급하므로
    // 순서대로 더해 가면 각 행의 id를 알 수 있다.
    const firstId = (result as ResultSetHeader).insertId;

    const teacherValues: unknown[][] = [];
    rows.forEach((r, i) => {
      for (const name of r.teachers) {
        teacherValues.push([firstId + i, name, year, month]);
      }
    });

    if (teacherValues.length > 0) {
      await connection.query(
        `INSERT IGNORE INTO enroll_snapshot_teacher (row_id, teacher_name, year, month) VALUES ?`,
        [teacherValues]
      );
    }
  }

  /**
   * 이름으로 student_id / school_id / teacher_id를 이어 준다. 최선 노력이다.
   *
   * 엑셀은 동명이인을 '김나경A'/'김나경B'로 구분하지만 User에는 접미가
   * 없어 그런 이름은 매칭되지 않는다. 집계는 student_name 기준으로 하므로
   * 매칭 실패가 대시보드 수치에 영향을 주지 않는다 — 학생 상세로 넘어가는
   * 링크 용도다. 그래서 이름이 유일한 경우에만 잇고 애매하면 비워 둔다.
   */
  private async matchIds(connection: any, snapshotId: number): Promise<void> {
    await connection.query(
      `UPDATE enroll_snapshot_row r
       JOIN (
         SELECT name, MIN(user_id) AS user_id
         FROM User WHERE kind = 2
         GROUP BY name HAVING COUNT(*) = 1
       ) u ON u.name = r.student_name
       SET r.student_id = u.user_id
       WHERE r.snapshot_id = ?`,
      [snapshotId]
    );

    await connection.query(
      `UPDATE enroll_snapshot_row r
       JOIN School s ON s.school_name = r.school_name
       SET r.school_id = s.school_id
       WHERE r.snapshot_id = ?`,
      [snapshotId]
    );

    await connection.query(
      `UPDATE enroll_snapshot_teacher t
       JOIN enroll_snapshot_row r ON r.row_id = t.row_id
       JOIN (
         SELECT name, MIN(user_id) AS user_id
         FROM User WHERE kind <> 2
         GROUP BY name HAVING COUNT(*) = 1
       ) u ON u.name = t.teacher_name
       SET t.teacher_id = u.user_id
       WHERE r.snapshot_id = ?`,
      [snapshotId]
    );
  }
}

export default new EnrollSnapshotService();
