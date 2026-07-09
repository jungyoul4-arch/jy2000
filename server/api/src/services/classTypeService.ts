import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { ClassType, ClassTypeCreate, ClassTypeListQuery, ClassTypeTeacher } from '../types';
import { AppError } from '../middlewares/errorHandler';
import * as XLSX from 'xlsx';

// 학년 코드 변환 헬퍼
const gradeToName = (grade: number): string => {
  if (grade >= 1 && grade <= 6) return `초${grade}`;
  if (grade >= 7 && grade <= 9) return `중${grade - 6}`;
  if (grade >= 10 && grade <= 12) return `고${grade - 9}`;
  return String(grade);
};

// 학년 문자열 → 숫자 코드 변환
const nameToGrade = (name: string): number => {
  const match = name.match(/^(초|중|고)(\d)$/);
  if (!match) return 0;
  const [, prefix, num] = match;
  const n = parseInt(num);
  if (prefix === '초') return n;       // 초1~6 = 1~6
  if (prefix === '중') return n + 6;   // 중1~3 = 7~9
  if (prefix === '고') return n + 9;   // 고1~3 = 10~12
  return 0;
};

// 과목 코드 변환 헬퍼
const subjectToName = (subject: number): string => {
  const subjects: { [key: number]: string } = {
    1: '국어',
    2: '수학',
    3: '영어',
    4: '과학',
    5: '사회'
  };
  return subjects[subject] || String(subject);
};

// 과목 문자열 → 숫자 코드 변환
const nameToSubject = (name: string): number => {
  const subjects: { [key: string]: number } = {
    '국어': 1,
    '수학': 2,
    '영어': 3,
    '과학': 4,
    '사회': 5
  };
  return subjects[name] || 0;
};

export class ClassTypeService {
  // 반 형태 목록 조회
  async getList(query: ClassTypeListQuery): Promise<{ data: ClassType[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 100;
    const offset = (page - 1) * perPage;

    const conditions: string[] = ['ct.deleted_at IS NULL'];
    const params: any[] = [];

    if (query.grade !== undefined) {
      conditions.push('ct.grade = ?');
      params.push(query.grade);
    }

    if (query.subject !== undefined) {
      conditions.push('ct.subject = ?');
      params.push(query.subject);
    }

    if (query.year !== undefined) {
      conditions.push('ct.year = ?');
      params.push(query.year);
    }

    if (query.format !== undefined) {
      conditions.push('ct.format = ?');
      params.push(query.format);
    }

    if (query.search) {
      conditions.push('ct.class_type_name LIKE ?');
      params.push(`%${query.search}%`);
    }

    const whereClause = conditions.join(' AND ');

    // Count query
    const countSql = `SELECT COUNT(*) as total FROM class_type ct WHERE ${whereClause}`;
    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    // Data query with teachers (joined with User table)
    const dataSql = `
      SELECT
        ct.class_type_id,
        ct.class_type_name,
        ct.year,
        ct.grade,
        ct.subject,
        ct.format,
        ct.unit_price,
        ct.is_active,
        ct.created_at,
        ct.updated_at,
        GROUP_CONCAT(
          CONCAT(ctt.teacher_id, ':', COALESCE(u.name, ''))
          ORDER BY ctt.id SEPARATOR ','
        ) as teacher_info
      FROM class_type ct
      LEFT JOIN class_type_teacher ctt ON ct.class_type_id = ctt.class_type_id
      LEFT JOIN User u ON ctt.teacher_id = u.user_id
      WHERE ${whereClause}
      GROUP BY ct.class_type_id
      ORDER BY ct.class_type_id DESC
      LIMIT ? OFFSET ?
    `;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    const data = rows.map(row => {
      // Parse teacher_info string into array of { teacher_id, teacher_name }
      let teachers: ClassTypeTeacher[] = [];
      if (row.teacher_info) {
        teachers = row.teacher_info.split(',').map((info: string) => {
          const [id, name] = info.split(':');
          return { teacher_id: parseInt(id), teacher_name: name || '' };
        });
      }

      return {
        ...row,
        teachers,
        is_active: Boolean(row.is_active)
      };
    }) as ClassType[];

    return { data, total };
  }

  // 반 형태 상세 조회
  async getById(classTypeId: number): Promise<ClassType> {
    const sql = `
      SELECT
        ct.class_type_id,
        ct.class_type_name,
        ct.year,
        ct.grade,
        ct.subject,
        ct.format,
        ct.unit_price,
        ct.is_active,
        ct.created_at,
        ct.updated_at
      FROM class_type ct
      WHERE ct.class_type_id = ? AND ct.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [classTypeId]);

    if (rows.length === 0) {
      throw new AppError('Class type not found', 404);
    }

    // Get teachers with names from User table
    const [teachers] = await pool.query<RowDataPacket[]>(
      `SELECT ctt.teacher_id, u.name as teacher_name
       FROM class_type_teacher ctt
       LEFT JOIN User u ON ctt.teacher_id = u.user_id
       WHERE ctt.class_type_id = ?
       ORDER BY ctt.id`,
      [classTypeId]
    );

    return {
      ...rows[0],
      teachers: teachers.map(t => ({
        teacher_id: t.teacher_id,
        teacher_name: t.teacher_name || ''
      })),
      is_active: Boolean(rows[0].is_active)
    } as ClassType;
  }

  // 강사 이름으로 User ID 조회 (kind=3 선생님/멘토)
  private async findTeacherIdByName(connection: any, name: string): Promise<number | null> {
    const [rows] = await connection.query(
      `SELECT user_id FROM User WHERE name = ? ORDER BY user_id LIMIT 1`,
      [name]
    ) as [RowDataPacket[], any];
    return rows.length > 0 ? rows[0].user_id : null;
  }

  // 반 형태 생성
  async create(data: ClassTypeCreate): Promise<ClassType> {
    const connection = await pool.getConnection();
    const notFoundTeachers: string[] = [];

    try {
      await connection.beginTransaction();

      // 중복 체크 (반형태명 + 학년 + 과목 조합)
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT class_type_id FROM class_type WHERE class_type_name = ? AND grade = ? AND subject = ? AND deleted_at IS NULL',
        [data.class_type_name, data.grade, data.subject]
      );

      if (existing.length > 0) {
        throw new AppError('이미 등록된 반 형태입니다 (동일한 반형태명+학년+과목)', 400);
      }

      // Insert class_type
      const [result] = await connection.query<ResultSetHeader>(
        `INSERT INTO class_type (class_type_name, year, grade, subject, format, unit_price)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [data.class_type_name, data.year || null, data.grade, data.subject, data.format || null, data.unit_price || 0]
      );

      const classTypeId = result.insertId;

      // Resolve teacher IDs
      let teacherIds: number[] = [];

      // 1. teacher_ids가 있으면 직접 사용
      if (data.teacher_ids && data.teacher_ids.length > 0) {
        teacherIds = data.teacher_ids;
      }
      // 2. teacher_names가 있으면 이름으로 조회
      else if (data.teacher_names && data.teacher_names.length > 0) {
        for (const name of data.teacher_names) {
          const teacherId = await this.findTeacherIdByName(connection, name);
          if (teacherId) {
            teacherIds.push(teacherId);
          } else {
            notFoundTeachers.push(name);
          }
        }
      }

      // Insert teachers
      if (teacherIds.length > 0) {
        const teacherValues = teacherIds.map(id => [classTypeId, id]);
        await connection.query(
          'INSERT INTO class_type_teacher (class_type_id, teacher_id) VALUES ?',
          [teacherValues]
        );
      }

      await connection.commit();

      // Log not found teachers
      if (notFoundTeachers.length > 0) {
        console.warn(`[ClassType] 반 형태 생성 시 User 테이블에서 찾을 수 없는 강사: ${notFoundTeachers.join(', ')}`);
      }

      return this.getById(classTypeId);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 반 형태 수정
  async update(classTypeId: number, data: Partial<ClassTypeCreate>): Promise<ClassType> {
    const connection = await pool.getConnection();
    const notFoundTeachers: string[] = [];

    try {
      await connection.beginTransaction();

      // 존재 확인
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT class_type_id FROM class_type WHERE class_type_id = ? AND deleted_at IS NULL',
        [classTypeId]
      );

      if (existing.length === 0) {
        throw new AppError('Class type not found', 404);
      }

      // 중복 체크 (자신 제외) - 반형태명+학년+과목 조합이 변경되는 경우
      if (data.class_type_name !== undefined || data.grade !== undefined || data.subject !== undefined) {
        // 현재 값 조회
        const [current] = await connection.query<RowDataPacket[]>(
          'SELECT class_type_name, grade, subject FROM class_type WHERE class_type_id = ?',
          [classTypeId]
        );

        const newName = data.class_type_name ?? current[0].class_type_name;
        const newGrade = data.grade ?? current[0].grade;
        const newSubject = data.subject ?? current[0].subject;

        const [duplicate] = await connection.query<RowDataPacket[]>(
          'SELECT class_type_id FROM class_type WHERE class_type_name = ? AND grade = ? AND subject = ? AND class_type_id != ? AND deleted_at IS NULL',
          [newName, newGrade, newSubject, classTypeId]
        );

        if (duplicate.length > 0) {
          throw new AppError('이미 등록된 반 형태입니다 (동일한 반형태명+학년+과목)', 400);
        }
      }

      // Update class_type
      const updates: string[] = [];
      const params: any[] = [];

      if (data.class_type_name !== undefined) {
        updates.push('class_type_name = ?');
        params.push(data.class_type_name);
      }
      if (data.year !== undefined) {
        updates.push('year = ?');
        params.push(data.year);
      }
      if (data.grade !== undefined) {
        updates.push('grade = ?');
        params.push(data.grade);
      }
      if (data.subject !== undefined) {
        updates.push('subject = ?');
        params.push(data.subject);
      }
      if (data.format !== undefined) {
        updates.push('format = ?');
        params.push(data.format);
      }
      if (data.unit_price !== undefined) {
        updates.push('unit_price = ?');
        params.push(data.unit_price);
      }

      if (updates.length > 0) {
        params.push(classTypeId);
        await connection.query(
          `UPDATE class_type SET ${updates.join(', ')} WHERE class_type_id = ?`,
          params
        );
      }

      // Update teachers if provided
      if (data.teacher_ids !== undefined || data.teacher_names !== undefined) {
        // Delete existing teachers
        await connection.query(
          'DELETE FROM class_type_teacher WHERE class_type_id = ?',
          [classTypeId]
        );

        // Resolve teacher IDs
        let teacherIds: number[] = [];

        if (data.teacher_ids && data.teacher_ids.length > 0) {
          teacherIds = data.teacher_ids;
        } else if (data.teacher_names && data.teacher_names.length > 0) {
          for (const name of data.teacher_names) {
            const teacherId = await this.findTeacherIdByName(connection, name);
            if (teacherId) {
              teacherIds.push(teacherId);
            } else {
              notFoundTeachers.push(name);
            }
          }
        }

        // Insert new teachers
        if (teacherIds.length > 0) {
          const teacherValues = teacherIds.map(id => [classTypeId, id]);
          await connection.query(
            'INSERT INTO class_type_teacher (class_type_id, teacher_id) VALUES ?',
            [teacherValues]
          );
        }
      }

      await connection.commit();

      // Log not found teachers
      if (notFoundTeachers.length > 0) {
        console.warn(`[ClassType] 반 형태 수정 시 User 테이블에서 찾을 수 없는 강사: ${notFoundTeachers.join(', ')}`);
      }

      return this.getById(classTypeId);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 반 형태명으로 정확히 일치하는 항목 찾기
  async findByName(classTypeName: string): Promise<ClassType | null> {
    const sql = `
      SELECT
        ct.class_type_id,
        ct.class_type_name,
        ct.year,
        ct.grade,
        ct.subject,
        ct.format,
        ct.unit_price,
        ct.is_active,
        ct.created_at,
        ct.updated_at,
        GROUP_CONCAT(
          CONCAT(ctt.teacher_id, ':', COALESCE(u.name, ''))
          ORDER BY ctt.id SEPARATOR ','
        ) as teacher_info
      FROM class_type ct
      LEFT JOIN class_type_teacher ctt ON ct.class_type_id = ctt.class_type_id
      LEFT JOIN User u ON ctt.teacher_id = u.user_id
      WHERE ct.class_type_name = ? AND ct.deleted_at IS NULL
      GROUP BY ct.class_type_id
      LIMIT 1
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [classTypeName]);

    if (rows.length === 0) {
      return null;
    }

    const row = rows[0];
    let teachers: ClassTypeTeacher[] = [];
    if (row.teacher_info) {
      teachers = row.teacher_info.split(',').map((info: string) => {
        const [id, name] = info.split(':');
        return { teacher_id: parseInt(id), teacher_name: name || '' };
      });
    }

    return {
      ...row,
      teachers,
      is_active: Boolean(row.is_active)
    } as ClassType;
  }

  // 반 형태 삭제 (soft delete)
  async delete(classTypeId: number): Promise<void> {
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT class_type_id FROM class_type WHERE class_type_id = ? AND deleted_at IS NULL',
      [classTypeId]
    );

    if (existing.length === 0) {
      throw new AppError('Class type not found', 404);
    }

    await pool.query<ResultSetHeader>(
      'UPDATE class_type SET deleted_at = NOW(), is_active = 0 WHERE class_type_id = ?',
      [classTypeId]
    );
  }

  // 엑셀 파일에서 class_type 초기화
  async initFromExcel(filePath: string): Promise<{ inserted: number; skipped: number; notFoundTeachers: string[] }> {
    const workbook = XLSX.readFile(filePath);

    // '단가입력' 시트 사용
    const sheetName = '단가입력';
    const sheet = workbook.Sheets[sheetName];
    if (!sheet) {
      throw new AppError(`시트 '${sheetName}'를 찾을 수 없습니다`, 400);
    }

    const data = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[][];

    if (data.length < 2) {
      throw new AppError('엑셀 파일에 데이터가 없습니다', 400);
    }

    // 헤더: 반형태, 학년, 과목, 단가(원장님 입력), 참고: 등장 행수, 참고: 강사, ...
    const connection = await pool.getConnection();
    let inserted = 0;
    let skipped = 0;
    const notFoundTeachers: string[] = [];

    try {
      await connection.beginTransaction();

      // 기존 데이터 전체 삭제 (초기화)
      await connection.query('DELETE FROM class_type_teacher');
      await connection.query('DELETE FROM class_type');

      // 데이터 행 처리 (첫 번째 행은 헤더)
      for (let i = 1; i < data.length; i++) {
        const row = data[i];
        if (!row || !row[0]) continue;

        const classTypeName = String(row[0]).trim();  // 반형태
        const gradeStr = String(row[1]).trim();       // 학년 (고1, 고2, ...)
        const subjectStr = String(row[2]).trim();     // 과목
        const unitPrice = parseInt(row[3]) || 0;      // 단가
        const teachersStr = row[5] ? String(row[5]).trim() : '';  // 강사들

        // 학년/과목 코드 변환
        const grade = nameToGrade(gradeStr);
        const subject = nameToSubject(subjectStr);

        if (!grade || !subject) {
          console.warn(`[ClassType Init] 학년/과목 변환 실패 - row ${i}: grade=${gradeStr}, subject=${subjectStr}`);
          skipped++;
          continue;
        }

        // 중복 체크 (반형태명 + 학년 + 과목 조합)
        const [existing] = await connection.query<RowDataPacket[]>(
          'SELECT class_type_id FROM class_type WHERE class_type_name = ? AND grade = ? AND subject = ?',
          [classTypeName, grade, subject]
        );

        if (existing.length > 0) {
          console.warn(`[ClassType Init] 중복 반형태 스킵 - ${classTypeName}`);
          skipped++;
          continue;
        }

        // class_type 삽입
        const [result] = await connection.query<ResultSetHeader>(
          `INSERT INTO class_type (class_type_name, grade, subject, unit_price)
           VALUES (?, ?, ?, ?)`,
          [classTypeName, grade, subject, unitPrice]
        );

        const classTypeId = result.insertId;

        // 강사 처리
        if (teachersStr) {
          const teacherNames = teachersStr.split(',').map(t => t.trim()).filter(t => t);

          for (const teacherName of teacherNames) {
            // User 테이블에서 teacher_id 찾기
            const [users] = await connection.query<RowDataPacket[]>(
              'SELECT user_id FROM User WHERE name = ? ORDER BY user_id LIMIT 1',
              [teacherName]
            );

            if (users.length > 0) {
              await connection.query(
                'INSERT INTO class_type_teacher (class_type_id, teacher_id) VALUES (?, ?)',
                [classTypeId, users[0].user_id]
              );
            } else {
              if (!notFoundTeachers.includes(teacherName)) {
                notFoundTeachers.push(teacherName);
              }
            }
          }
        }

        inserted++;
      }

      await connection.commit();

      // 로그 출력
      if (notFoundTeachers.length > 0) {
        console.warn(`[ClassType Init] User 테이블에서 찾을 수 없는 강사: ${notFoundTeachers.join(', ')}`);
      }

      return { inserted, skipped, notFoundTeachers };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new ClassTypeService();
