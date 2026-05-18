import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { ClassListItem, ClassDetail, ClassListQuery, ClassCreate, ClassUpdate, ClassMember, LectureDate } from '../types';
import { AppError } from '../middlewares/errorHandler';

// 과목 코드 맵
const GENRE_MAP: { [key: number]: string } = {
  1: 'K',   // 국어
  2: 'M',   // 수학
  3: 'E',   // 영어
  4: 'S',   // 과학
  5: 'So',  // 사회
  99: 'X'   // 기타
};

// 과목 이름 맵
const GENRE_NAME_MAP: { [key: number]: string } = {
  1: '국어',
  2: '수학',
  3: '영어',
  4: '과학',
  5: '사회',
  99: '기타'
};

// 레벨 코드 맵
const LEVEL_MAP: { [key: number]: string } = {
  1: 'A',   // 최상위
  2: 'B',   // 상위
  3: 'C',   // 중위
  4: 'D',   // 기초
  99: 'X'   // 기타
};

// 레벨 이름 맵
const LEVEL_NAME_MAP: { [key: number]: string } = {
  1: '최상위',
  2: '상위',
  3: '중위',
  4: '기초',
  99: '기타'
};

export class ClassService {
  // 학년 문자열 생성
  private getGradeStr(grade: number): string {
    if (grade >= 7 && grade <= 9) {
      return `중${grade - 6}`;
    } else if (grade >= 10 && grade <= 12) {
      return `고${grade - 9}`;
    } else if (grade === 14) {
      return '성인';
    } else {
      return '기타';
    }
  }

  // 반 이름 자동 생성
  private generateClassName(
    year: number,
    genreId: number,
    grade: number,
    curriculum: number,
    level: number,
    teacherNames: string[],
    lectureDates: LectureDate[]
  ): string {
    const genreCode = GENRE_MAP[genreId] || 'X';
    const gradeStr = this.getGradeStr(grade);
    const curriculumStr = curriculum === 1 ? '정' : '특';
    const levelStr = LEVEL_MAP[level] || 'X';

    // S/T: Solo or Team
    const teamStr = teacherNames.length > 1 ? 'T' : 'S';

    // 선생님 이름 끝 2자
    const teacherSuffix = teacherNames.map(name => {
      if (name.length >= 2) {
        return name.slice(-2);
      }
      return name;
    }).join('');

    // 강의 일시
    const lectureDateStr = lectureDates.map(d => `${d.day}${d.start_time}`).join('');

    return `${year} ${genreCode}${gradeStr}${curriculumStr}${levelStr}${teamStr}${teacherSuffix}(${lectureDateStr})`;
  }

  // 강의 일시를 lecture_date1~5로 분리
  private splitLectureDates(lectureDates: LectureDate[]): { [key: string]: string } {
    const result: { [key: string]: string } = {
      lecture_date1: '',
      lecture_date2: '',
      lecture_date3: '',
      lecture_date4: '',
      lecture_date5: ''
    };

    lectureDates.slice(0, 5).forEach((ld, index) => {
      result[`lecture_date${index + 1}`] = `${ld.day}${ld.start_time}`;
    });

    return result;
  }

  // 반 목록 조회
  async getList(query: ClassListQuery): Promise<{ data: ClassListItem[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 50;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'reg_dt';
    const order = query.order || 'desc';

    // Build WHERE clause
    const conditions: string[] = ['c.is_active = 1'];
    const params: any[] = [];

    if (query.genre_id) {
      conditions.push('c.genre_id = ?');
      params.push(query.genre_id);
    }

    if (query.grade) {
      conditions.push('ci.grade = ?');
      params.push(query.grade);
    }

    if (query.level) {
      conditions.push('ci.level = ?');
      params.push(query.level);
    }

    if (query.year) {
      conditions.push('ci.year = ?');
      params.push(query.year);
    }

    if (query.search) {
      // 반 이름, 선생님 이름, 학생 이름 검색
      conditions.push(`(
        c.class_name LIKE ? OR
        c.class_id IN (
          SELECT cm.class_id FROM ClassMember cm
          JOIN User u ON cm.user_id = u.user_id
          WHERE u.name LIKE ? AND cm.active_flag = 1
        )
      )`);
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // 전체 개수 조회
    const [countResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(DISTINCT c.class_id) as total
       FROM Class c
       LEFT JOIN ClassInfo ci ON c.class_id = ci.class_id
       ${whereClause}`,
      params
    );
    const total = countResult[0].total;

    // 목록 조회
    const allowedSortColumns = ['class_id', 'class_name', 'reg_dt', 'genre_id'];
    const sortColumn = allowedSortColumns.includes(sort) ? `c.${sort}` : 'c.reg_dt';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';

    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT
        c.class_id,
        c.class_name,
        c.is_active,
        c.genre_id,
        c.reg_dt,
        ci.grade,
        ci.curriculum,
        ci.level,
        ci.year,
        ci.monthly_fee,
        ci.lecture_date1,
        ci.lecture_date2,
        ci.lecture_date3,
        ci.lecture_date4,
        ci.lecture_date5
       FROM Class c
       LEFT JOIN ClassInfo ci ON c.class_id = ci.class_id
       ${whereClause}
       ORDER BY ${sortColumn} ${sortOrder}
       LIMIT ? OFFSET ?`,
      [...params, perPage, offset]
    );

    // 각 반의 선생님들 조회
    const classIds = rows.map(r => r.class_id);
    let teachersMap: { [key: number]: { user_id: number; name: string }[] } = {};

    if (classIds.length > 0) {
      const [teachers] = await pool.query<RowDataPacket[]>(
        `SELECT cm.class_id, cm.user_id, u.name
         FROM ClassMember cm
         JOIN User u ON cm.user_id = u.user_id
         WHERE cm.class_id IN (?) AND cm.kind = 3 AND cm.active_flag = 1`,
        [classIds]
      );

      teachers.forEach(t => {
        if (!teachersMap[t.class_id]) {
          teachersMap[t.class_id] = [];
        }
        teachersMap[t.class_id].push({ user_id: t.user_id, name: t.name });
      });
    }

    // 데이터 변환
    const data: ClassListItem[] = rows.map(row => {
      // 강의 일시 조합
      const lectureDates = [
        row.lecture_date1,
        row.lecture_date2,
        row.lecture_date3,
        row.lecture_date4,
        row.lecture_date5
      ].filter(d => d && d.trim() !== '').join(', ');

      return {
        class_id: row.class_id,
        class_name: row.class_name,
        is_active: row.is_active,
        genre_id: row.genre_id,
        genre_name: GENRE_NAME_MAP[row.genre_id],
        reg_dt: row.reg_dt,
        grade: row.grade,
        grade_name: row.grade ? this.getGradeStr(row.grade) : undefined,
        curriculum: row.curriculum,
        level: row.level,
        level_name: row.level ? LEVEL_NAME_MAP[row.level] : undefined,
        year: row.year,
        monthly_fee: row.monthly_fee,
        lecture_dates: lectureDates,
        teachers: teachersMap[row.class_id] || []
      };
    });

    return { data, total };
  }

  // 반 상세 조회
  async getById(classId: number): Promise<ClassDetail> {
    // Class + ClassInfo 조회
    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT
        c.class_id,
        c.class_name,
        c.is_active,
        c.genre_id,
        c.reg_dt,
        ci.grade,
        ci.curriculum,
        ci.level,
        ci.year,
        ci.term_start,
        ci.term_end,
        ci.lecture_date1,
        ci.lecture_date2,
        ci.lecture_date3,
        ci.lecture_date4,
        ci.lecture_date5,
        ci.monthly_fee
       FROM Class c
       LEFT JOIN ClassInfo ci ON c.class_id = ci.class_id
       WHERE c.class_id = ?`,
      [classId]
    );

    if (rows.length === 0) {
      throw new AppError('Class not found', 404);
    }

    const row = rows[0];

    // 선생님들 조회
    const [teachers] = await pool.query<RowDataPacket[]>(
      `SELECT cm.user_id, cm.class_id, cm.kind, cm.active_flag, u.name as user_name, u.phone
       FROM ClassMember cm
       JOIN User u ON cm.user_id = u.user_id
       WHERE cm.class_id = ? AND cm.kind = 3 AND cm.active_flag = 1`,
      [classId]
    );

    // 학생들 조회
    const [students] = await pool.query<RowDataPacket[]>(
      `SELECT cm.user_id, cm.class_id, cm.kind, cm.active_flag, u.name as user_name, u.phone
       FROM ClassMember cm
       JOIN User u ON cm.user_id = u.user_id
       WHERE cm.class_id = ? AND cm.kind = 2 AND cm.active_flag = 1`,
      [classId]
    );

    // ClassInfo가 없는 경우 기본값 제공
    const currentYear = new Date().getFullYear();

    return {
      class_id: row.class_id,
      class_name: row.class_name,
      is_active: row.is_active,
      genre_id: row.genre_id,
      genre_name: GENRE_NAME_MAP[row.genre_id],
      reg_dt: row.reg_dt,
      info: {
        class_id: row.class_id,
        grade: row.grade ?? 99,
        curriculum: row.curriculum ?? 1,
        level: row.level ?? 99,
        year: row.year ?? currentYear,
        term_start: row.term_start,
        term_end: row.term_end,
        lecture_date1: row.lecture_date1,
        lecture_date2: row.lecture_date2,
        lecture_date3: row.lecture_date3,
        lecture_date4: row.lecture_date4,
        lecture_date5: row.lecture_date5,
        monthly_fee: row.monthly_fee
      },
      teachers: teachers.map(t => ({
        user_id: t.user_id,
        class_id: t.class_id,
        kind: t.kind,
        active_flag: t.active_flag,
        user_name: t.user_name,
        phone: t.phone
      })),
      students: students.map(s => ({
        user_id: s.user_id,
        class_id: s.class_id,
        kind: s.kind,
        active_flag: s.active_flag,
        user_name: s.user_name,
        phone: s.phone
      }))
    };
  }

  // 반 등록
  async create(data: ClassCreate, userId: number): Promise<ClassDetail> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 선생님 이름 조회
      const [teacherRows] = await connection.query<RowDataPacket[]>(
        `SELECT user_id, name FROM User WHERE user_id IN (?) AND kind = 3 AND active_flag = 1`,
        [data.teacher_ids]
      );
      const teacherNames = teacherRows.map(t => t.name);

      // 반 이름 생성 (사용자가 제공한 이름이 없으면 자동 생성)
      const className = data.class_name || this.generateClassName(
        data.year,
        data.genre_id,
        data.grade,
        data.curriculum,
        data.level,
        teacherNames,
        data.lecture_dates
      );

      // 1. Class 테이블 INSERT
      const [classResult] = await connection.query<ResultSetHeader>(
        `INSERT INTO Class (class_name, is_active, genre_id, reg_dt)
         VALUES (?, 1, ?, NOW())`,
        [className, data.genre_id]
      );
      const classId = classResult.insertId;

      // 2. ClassInfo 테이블 INSERT
      const lectureDatesMap = this.splitLectureDates(data.lecture_dates);
      await connection.query(
        `INSERT INTO ClassInfo (class_id, grade, curriculum, level, year, term_start, term_end,
         lecture_date1, lecture_date2, lecture_date3, lecture_date4, lecture_date5, monthly_fee)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          classId,
          data.grade,
          data.curriculum,
          data.level,
          data.year,
          data.term_start || null,
          data.term_end || null,
          lectureDatesMap.lecture_date1,
          lectureDatesMap.lecture_date2,
          lectureDatesMap.lecture_date3,
          lectureDatesMap.lecture_date4,
          lectureDatesMap.lecture_date5,
          data.monthly_fee || null
        ]
      );

      // 3. ClassMember 테이블에 선생님들 INSERT
      for (const teacherId of data.teacher_ids) {
        await connection.query(
          `INSERT INTO ClassMember (user_id, class_id, kind, active_flag)
           VALUES (?, ?, 3, 1)`,
          [teacherId, classId]
        );
      }

      await connection.commit();

      return this.getById(classId);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 반 수정
  async update(classId: number, data: ClassUpdate): Promise<ClassDetail> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 현재 반 정보 조회
      const [currentClass] = await connection.query<RowDataPacket[]>(
        `SELECT c.*, ci.* FROM Class c
         LEFT JOIN ClassInfo ci ON c.class_id = ci.class_id
         WHERE c.class_id = ?`,
        [classId]
      );

      if (currentClass.length === 0) {
        throw new AppError('Class not found', 404);
      }

      // Class 테이블 업데이트
      const classUpdateFields: string[] = [];
      const classUpdateParams: any[] = [];

      if (data.genre_id !== undefined) {
        classUpdateFields.push('genre_id = ?');
        classUpdateParams.push(data.genre_id);
      }
      if (data.is_active !== undefined) {
        classUpdateFields.push('is_active = ?');
        classUpdateParams.push(data.is_active);
      }
      if (data.class_name !== undefined) {
        classUpdateFields.push('class_name = ?');
        classUpdateParams.push(data.class_name);
      }

      if (classUpdateFields.length > 0) {
        classUpdateParams.push(classId);
        await connection.query(
          `UPDATE Class SET ${classUpdateFields.join(', ')} WHERE class_id = ?`,
          classUpdateParams
        );
      }

      // ClassInfo 테이블 업데이트
      const infoUpdateFields: string[] = [];
      const infoUpdateParams: any[] = [];

      if (data.grade !== undefined) {
        infoUpdateFields.push('grade = ?');
        infoUpdateParams.push(data.grade);
      }
      if (data.curriculum !== undefined) {
        infoUpdateFields.push('curriculum = ?');
        infoUpdateParams.push(data.curriculum);
      }
      if (data.level !== undefined) {
        infoUpdateFields.push('level = ?');
        infoUpdateParams.push(data.level);
      }
      if (data.year !== undefined) {
        infoUpdateFields.push('year = ?');
        infoUpdateParams.push(data.year);
      }
      if (data.term_start !== undefined) {
        infoUpdateFields.push('term_start = ?');
        infoUpdateParams.push(data.term_start);
      }
      if (data.term_end !== undefined) {
        infoUpdateFields.push('term_end = ?');
        infoUpdateParams.push(data.term_end);
      }
      if (data.monthly_fee !== undefined) {
        infoUpdateFields.push('monthly_fee = ?');
        infoUpdateParams.push(data.monthly_fee);
      }
      if (data.lecture_dates !== undefined) {
        const lectureDatesMap = this.splitLectureDates(data.lecture_dates);
        infoUpdateFields.push('lecture_date1 = ?', 'lecture_date2 = ?', 'lecture_date3 = ?', 'lecture_date4 = ?', 'lecture_date5 = ?');
        infoUpdateParams.push(
          lectureDatesMap.lecture_date1,
          lectureDatesMap.lecture_date2,
          lectureDatesMap.lecture_date3,
          lectureDatesMap.lecture_date4,
          lectureDatesMap.lecture_date5
        );
      }

      if (infoUpdateFields.length > 0) {
        // ClassInfo 존재 여부 확인
        const [existingInfo] = await connection.query<RowDataPacket[]>(
          `SELECT class_id FROM ClassInfo WHERE class_id = ?`,
          [classId]
        );

        if (existingInfo.length > 0) {
          // 존재하면 UPDATE
          infoUpdateParams.push(classId);
          await connection.query(
            `UPDATE ClassInfo SET ${infoUpdateFields.join(', ')} WHERE class_id = ?`,
            infoUpdateParams
          );
        } else {
          // 존재하지 않으면 INSERT (기본값과 함께)
          const currentYear = new Date().getFullYear();
          await connection.query(
            `INSERT INTO ClassInfo (class_id, grade, curriculum, level, year, term_start, term_end,
             lecture_date1, lecture_date2, lecture_date3, lecture_date4, lecture_date5, monthly_fee)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
              classId,
              data.grade ?? 99,
              data.curriculum ?? 1,
              data.level ?? 99,
              data.year ?? currentYear,
              data.term_start ?? null,
              data.term_end ?? null,
              data.lecture_dates ? this.splitLectureDates(data.lecture_dates).lecture_date1 : '',
              data.lecture_dates ? this.splitLectureDates(data.lecture_dates).lecture_date2 : '',
              data.lecture_dates ? this.splitLectureDates(data.lecture_dates).lecture_date3 : '',
              data.lecture_dates ? this.splitLectureDates(data.lecture_dates).lecture_date4 : '',
              data.lecture_dates ? this.splitLectureDates(data.lecture_dates).lecture_date5 : '',
              data.monthly_fee ?? null
            ]
          );
        }
      }

      // 선생님 변경
      if (data.teacher_ids !== undefined) {
        // 기존 선생님 비활성화
        await connection.query(
          `UPDATE ClassMember SET active_flag = 0 WHERE class_id = ? AND kind = 3`,
          [classId]
        );

        // 새 선생님 추가/재활성화
        for (const teacherId of data.teacher_ids) {
          await connection.query(
            `INSERT INTO ClassMember (user_id, class_id, kind, active_flag)
             VALUES (?, ?, 3, 1)
             ON DUPLICATE KEY UPDATE active_flag = 1`,
            [teacherId, classId]
          );
        }
      }

      // 학생 변경
      if (data.student_ids !== undefined) {
        // 기존 학생 비활성화
        await connection.query(
          `UPDATE ClassMember SET active_flag = 0 WHERE class_id = ? AND kind = 2`,
          [classId]
        );

        // 새 학생 추가/재활성화
        for (const studentId of data.student_ids) {
          await connection.query(
            `INSERT INTO ClassMember (user_id, class_id, kind, active_flag)
             VALUES (?, ?, 2, 1)
             ON DUPLICATE KEY UPDATE active_flag = 1`,
            [studentId, classId]
          );
        }
      }

      await connection.commit();

      return this.getById(classId);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 반 삭제
  async delete(classId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 1. ClassMember 삭제
      await connection.query(
        `DELETE FROM ClassMember WHERE class_id = ?`,
        [classId]
      );

      // 2. ClassInfo 삭제
      await connection.query(
        `DELETE FROM ClassInfo WHERE class_id = ?`,
        [classId]
      );

      // 3. Class 삭제
      const [result] = await connection.query<ResultSetHeader>(
        `DELETE FROM Class WHERE class_id = ?`,
        [classId]
      );

      if (result.affectedRows === 0) {
        throw new AppError('Class not found', 404);
      }

      await connection.commit();

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 멤버 추가
  async addMember(classId: number, userId: number, kind: number): Promise<void> {
    // 반 존재 확인
    const [classRows] = await pool.query<RowDataPacket[]>(
      `SELECT class_id FROM Class WHERE class_id = ?`,
      [classId]
    );

    if (classRows.length === 0) {
      throw new AppError('Class not found', 404);
    }

    // 사용자 존재 확인
    const [userRows] = await pool.query<RowDataPacket[]>(
      `SELECT user_id FROM User WHERE user_id = ? AND active_flag = 1`,
      [userId]
    );

    if (userRows.length === 0) {
      throw new AppError('User not found', 404);
    }

    // 멤버 추가 또는 재활성화
    await pool.query(
      `INSERT INTO ClassMember (user_id, class_id, kind, active_flag)
       VALUES (?, ?, ?, 1)
       ON DUPLICATE KEY UPDATE active_flag = 1, kind = ?`,
      [userId, classId, kind, kind]
    );
  }

  // 멤버 제거
  async removeMember(classId: number, userId: number): Promise<void> {
    const [result] = await pool.query<ResultSetHeader>(
      `UPDATE ClassMember SET active_flag = 0 WHERE class_id = ? AND user_id = ?`,
      [classId, userId]
    );

    if (result.affectedRows === 0) {
      throw new AppError('Member not found', 404);
    }
  }

  // 선생님 목록 조회
  async getTeachers(search?: string): Promise<{ user_id: number; name: string; phone: string }[]> {
    let query = `SELECT user_id, name, phone FROM User WHERE kind = 3 AND active_flag = 1`;
    const params: any[] = [];

    if (search) {
      query += ` AND (name LIKE ? OR phone LIKE ?)`;
      const searchTerm = `%${search}%`;
      params.push(searchTerm, searchTerm);
    }

    query += ` ORDER BY name ASC LIMIT 100`;

    const [rows] = await pool.query<RowDataPacket[]>(query, params);

    return rows.map(row => ({
      user_id: row.user_id,
      name: row.name,
      phone: row.phone
    }));
  }

  // 사용자 검색 (학생 또는 선생님)
  async searchUsers(search: string, kind?: number): Promise<{ user_id: number; name: string; phone: string; kind: number }[]> {
    // 학생(kind=2)은 active_flag 상관없이 검색, 선생님(kind=3)은 active만
    let query = `SELECT user_id, name, phone, kind FROM User WHERE 1=1`;
    const params: any[] = [];

    if (kind === 2) {
      // 학생: active_flag 상관없이 모두 검색
      query += ` AND kind = 2`;
    } else if (kind === 3) {
      // 선생님: active만
      query += ` AND kind = 3 AND active_flag = 1`;
    } else {
      // 둘 다: 학생은 전체, 선생님은 active만
      query += ` AND ((kind = 2) OR (kind = 3 AND active_flag = 1))`;
    }

    query += ` AND (name LIKE ? OR phone LIKE ?)`;
    const searchTerm = `%${search}%`;
    params.push(searchTerm, searchTerm);

    query += ` ORDER BY name ASC LIMIT 50`;

    const [rows] = await pool.query<RowDataPacket[]>(query, params);

    return rows.map(row => ({
      user_id: row.user_id,
      name: row.name,
      phone: row.phone,
      kind: row.kind
    }));
  }
}

export default new ClassService();
