import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { MgmtData, MgmtDataListQuery } from '../types';
import { AppError } from '../middlewares/errorHandler';
import * as XLSX from 'xlsx';

// 학년 문자열을 숫자로 변환 (예: "고1" -> 10, "중2" -> 8)
function parseGrade(gradeStr: string | null | undefined, schoolLevel: string | null | undefined): number | null {
  if (!gradeStr) return null;

  const gradeNum = parseInt(gradeStr);
  if (isNaN(gradeNum)) return null;

  // school_level이 있으면 사용, 없으면 추론
  if (schoolLevel) {
    if (schoolLevel === '중' || schoolLevel.includes('중')) {
      return gradeNum + 6; // 중1=7, 중2=8, 중3=9
    } else if (schoolLevel === '고' || schoolLevel.includes('고')) {
      return gradeNum + 9; // 고1=10, 고2=11, 고3=12
    } else if (schoolLevel === '초' || schoolLevel.includes('초')) {
      return gradeNum; // 초1~6 = 1~6
    }
  }

  // school_level 없으면 그대로 반환 (1~12)
  return gradeNum;
}

export class MgmtDataService {
  // 경영 데이터 목록 조회
  async getList(query: MgmtDataListQuery): Promise<{ data: MgmtData[]; total: number; availableMonths: { year: number; month: number }[] }> {
    const page = query.page || 1;
    const perPage = query.perPage || 100;
    const offset = (page - 1) * perPage;

    // 사용 가능한 년월 목록 조회
    const [monthsResult] = await pool.query<RowDataPacket[]>(
      'SELECT DISTINCT year, month FROM mgmt_data ORDER BY year DESC, month DESC'
    );
    const availableMonths = monthsResult as { year: number; month: number }[];

    // 년월 결정: 지정된 값이 없으면 가장 최신 달
    let year = query.year;
    let month = query.month;

    if (!year || !month) {
      if (availableMonths.length > 0) {
        year = availableMonths[0].year;
        month = availableMonths[0].month;
      } else {
        // 데이터가 없는 경우 현재 년월
        const now = new Date();
        year = now.getFullYear();
        month = now.getMonth() + 1;
      }
    }

    const conditions: string[] = ['m.year = ?', 'm.month = ?'];
    const params: any[] = [year, month];

    if (query.search) {
      conditions.push('(u_student.name LIKE ? OR s.school_name LIKE ? OR u_teacher.name LIKE ?)');
      params.push(`%${query.search}%`, `%${query.search}%`, `%${query.search}%`);
    }

    const whereClause = conditions.join(' AND ');

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM mgmt_data m
      LEFT JOIN User u_student ON m.student_id = u_student.user_id
      LEFT JOIN School s ON m.school_id = s.school_id
      LEFT JOIN User u_teacher ON m.teacher_id = u_teacher.user_id
      WHERE ${whereClause}
    `;
    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    // Data query with JOINs
    const dataSql = `
      SELECT
        m.mgmt_data_id,
        m.year,
        m.month,
        m.student_id,
        u_student.name as student_name,
        m.school_id,
        s.school_name,
        m.grade,
        m.enrollment_count,
        m.comp_class_type,
        m.subject,
        m.teacher_id,
        u_teacher.name as teacher_name,
        m.class_name1,
        m.class_type_id,
        ct.class_type_name,
        m.created_at
      FROM mgmt_data m
      LEFT JOIN User u_student ON m.student_id = u_student.user_id
      LEFT JOIN School s ON m.school_id = s.school_id
      LEFT JOIN User u_teacher ON m.teacher_id = u_teacher.user_id
      LEFT JOIN class_type ct ON m.class_type_id = ct.class_type_id
      WHERE ${whereClause}
      ORDER BY u_student.name ASC, m.mgmt_data_id ASC
      LIMIT ? OFFSET ?
    `;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as MgmtData[],
      total,
      availableMonths
    };
  }

  // 특정 년월 데이터 삭제
  async deleteByMonth(year: number, month: number): Promise<number> {
    const [result] = await pool.query<ResultSetHeader>(
      'DELETE FROM mgmt_data WHERE year = ? AND month = ?',
      [year, month]
    );

    return result.affectedRows;
  }

  // 학생 ID 찾기 (이름 + 학교명으로 매칭)
  private async findStudentId(connection: any, studentName: string, schoolName?: string): Promise<{ studentId: number | null; schoolId: number | null }> {
    if (!studentName) return { studentId: null, schoolId: null };

    // 학교명이 있으면 학교도 함께 매칭
    if (schoolName) {
      const [students] = await connection.query(
        `SELECT u.user_id, si.school_id
         FROM User u
         LEFT JOIN student_info si ON u.user_id = si.student_id
         LEFT JOIN School s ON si.school_id = s.school_id
         WHERE u.name = ? AND u.kind = 2
         AND (s.school_name LIKE ? OR ? = '')
         ORDER BY u.user_id
         LIMIT 1`,
        [studentName, `%${schoolName}%`, schoolName]
      ) as [RowDataPacket[], any];

      if (students.length > 0) {
        return { studentId: students[0].user_id, schoolId: students[0].school_id };
      }
    }

    // 학교 없이 이름만으로 매칭
    const [students] = await connection.query(
      `SELECT u.user_id, si.school_id
       FROM User u
       LEFT JOIN student_info si ON u.user_id = si.student_id
       WHERE u.name = ? AND u.kind = 2
       ORDER BY u.user_id
       LIMIT 1`,
      [studentName]
    ) as [RowDataPacket[], any];

    if (students.length > 0) {
      return { studentId: students[0].user_id, schoolId: students[0].school_id };
    }

    return { studentId: null, schoolId: null };
  }

  // 강사 ID 찾기 (이름으로 매칭)
  private async findTeacherId(connection: any, teacherName: string): Promise<number | null> {
    if (!teacherName) return null;

    const [teachers] = await connection.query(
      `SELECT user_id FROM User WHERE name = ? ORDER BY user_id LIMIT 1`,
      [teacherName]
    ) as [RowDataPacket[], any];

    return teachers.length > 0 ? teachers[0].user_id : null;
  }

  // 학교 ID 찾기 또는 생성 (학교명으로 매칭, 없으면 생성)
  private async findOrCreateSchoolId(connection: any, schoolName: string, newSchools: string[]): Promise<number | null> {
    if (!schoolName) return null;

    // 먼저 기존 학교 검색
    const [schools] = await connection.query(
      `SELECT school_id FROM School WHERE school_name LIKE ? LIMIT 1`,
      [`%${schoolName}%`]
    ) as [RowDataPacket[], any];

    if (schools.length > 0) {
      return schools[0].school_id;
    }

    // 학교가 없으면 새로 생성
    // school_kind: 학교명에서 추론 (중=1, 고=2, 기본=2)
    let schoolKind = 2; // 기본값: 고등학교
    if (schoolName.includes('중') && !schoolName.includes('고')) {
      schoolKind = 1; // 중학교
    }

    // region_kind: 99 (기타) - 권역 정보 없음
    const regionKind = 99;

    const [result] = await connection.query(
      `INSERT INTO School (school_name, school_kind, region_kind, is_active) VALUES (?, ?, ?, 1)`,
      [schoolName, schoolKind, regionKind]
    ) as [ResultSetHeader, any];

    // 새로 추가된 학교 기록
    if (!newSchools.includes(schoolName)) {
      newSchools.push(schoolName);
    }

    console.log(`[MgmtData] 새 학교 추가: ${schoolName} (school_id: ${result.insertId}, school_kind: ${schoolKind === 1 ? '중학교' : '고등학교'})`);

    return result.insertId;
  }

  // 반형태 ID 찾기 (반형태명으로 매칭)
  private async findClassTypeId(connection: any, classTypeName: string): Promise<number | null> {
    if (!classTypeName) return null;

    const [classTypes] = await connection.query(
      `SELECT class_type_id FROM class_type WHERE class_type_name = ? AND deleted_at IS NULL LIMIT 1`,
      [classTypeName]
    ) as [RowDataPacket[], any];

    return classTypes.length > 0 ? classTypes[0].class_type_id : null;
  }

  // 엑셀 파일에서 데이터 업로드
  async uploadFromExcel(filePath: string, year: number, month: number): Promise<{ inserted: number; matched: number; notFoundStudents: string[]; notFoundTeachers: string[]; newSchools: string[] }> {
    const workbook = XLSX.readFile(filePath);

    // 첫 번째 시트 (납입이력)
    const sheetName = workbook.SheetNames[0];
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[][];

    if (data.length < 2) {
      throw new AppError('엑셀 파일에 데이터가 없습니다', 400);
    }

    // 헤더 확인 (첫 번째 행)
    const headers = data[0] as string[];

    // 헤더 매핑
    const headerMap: { [key: string]: number } = {};
    headers.forEach((h, i) => {
      headerMap[h] = i;
    });

    // 기존 데이터 삭제
    await this.deleteByMonth(year, month);

    const connection = await pool.getConnection();
    let inserted = 0;
    let matched = 0;
    const notFoundStudents: string[] = [];
    const notFoundTeachers: string[] = [];
    const newSchools: string[] = [];

    try {
      await connection.beginTransaction();

      // 데이터 행 처리 (첫 번째 행은 헤더)
      for (let i = 1; i < data.length; i++) {
        const row = data[i];
        if (!row || row.length === 0) continue;

        const studentName = row[headerMap['학생이름']] || '';
        const schoolName = row[headerMap['학교']] || '';
        const teacherName = row[headerMap['강사']] || '';
        const classTypeName = row[headerMap['반형태']] || '';
        const schoolLevel = row[headerMap['중등/고등']] || '';
        const gradeStr = row[headerMap['학년']] || '';

        if (!studentName) continue;

        // 학생 ID 및 학교 ID 찾기
        const { studentId, schoolId: studentSchoolId } = await this.findStudentId(connection, studentName, schoolName);

        // 학교 ID (학생 정보에서 못 찾으면 학교명으로 검색 또는 생성)
        let schoolId = studentSchoolId;
        if (!schoolId && schoolName) {
          schoolId = await this.findOrCreateSchoolId(connection, schoolName, newSchools);
        }

        // 강사 ID 찾기
        const teacherId = await this.findTeacherId(connection, teacherName);

        // 반형태 ID 찾기
        const classTypeId = await this.findClassTypeId(connection, classTypeName);

        // 학년 변환
        const grade = parseGrade(gradeStr, schoolLevel);

        // 매칭 통계
        if (studentId) {
          matched++;
        } else if (studentName) {
          if (!notFoundStudents.includes(studentName)) {
            notFoundStudents.push(studentName);
          }
        }

        if (!teacherId && teacherName) {
          if (!notFoundTeachers.includes(teacherName)) {
            notFoundTeachers.push(teacherName);
          }
        }

        // 데이터 삽입
        await connection.query(
          `INSERT INTO mgmt_data
           (year, month, student_id, school_id, grade, enrollment_count, comp_class_type, subject, teacher_id, class_name1, class_type_id)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            year,
            month,
            studentId,
            schoolId,
            grade,
            row[headerMap['수강인원']] || 1,
            row[headerMap['종합반종류']] || null,
            row[headerMap['과목']] || null,
            teacherId,
            row[headerMap['반명/교재명']] || null,
            classTypeId
          ]
        );

        inserted++;
      }

      await connection.commit();

      // 로그 출력
      if (notFoundStudents.length > 0) {
        console.warn(`[MgmtData] User 테이블에서 찾을 수 없는 학생: ${notFoundStudents.join(', ')}`);
      }
      if (notFoundTeachers.length > 0) {
        console.warn(`[MgmtData] User 테이블에서 찾을 수 없는 강사: ${notFoundTeachers.join(', ')}`);
      }
      if (newSchools.length > 0) {
        console.log(`[MgmtData] 새로 추가된 학교: ${newSchools.join(', ')}`);
      }

      return { inserted, matched, notFoundStudents, notFoundTeachers, newSchools };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new MgmtDataService();
