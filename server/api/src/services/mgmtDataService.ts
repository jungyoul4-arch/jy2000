import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { MgmtData, MgmtDataListQuery, RegionReport, RegionMonthlyStat, RegionGradeMonthlyStat, SchoolRegionMonthlyStat } from '../types';
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

// 과목 문자열을 숫자로 변환
// 1=국어, 2=수학, 3=영어, 4=과학
function parseSubject(subjectStr: string | null | undefined): number | null {
  if (!subjectStr) return null;

  const subject = subjectStr.trim();

  // 국어 계열
  if (['국어', '극어', '국모', '국어(특)', '국어(윈특)'].includes(subject)) {
    return 1;
  }
  // 수학 계열
  if (['수학', '숳가', '수모', '수학(특)', '수학(윈특)', '수리논술'].includes(subject)) {
    return 2;
  }
  // 영어 계열
  if (['영어', '영모', '영어(특)', '영어(윈특)'].includes(subject)) {
    return 3;
  }
  // 과학 계열
  if (['과학', '과학(윈특)'].includes(subject)) {
    return 4;
  }

  return null;
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
        ct.unit_price,
        m.price,
        m.student_name_orig,
        m.teacher_name_orig,
        m.class_type_name_orig,
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

  // 경영 데이터 단일 항목 수정
  async update(mgmtDataId: number, data: { studentId?: number | null; teacherId?: number | null; schoolId?: number | null; classTypeId?: number | null }): Promise<MgmtData | null> {
    const updates: string[] = [];
    const params: any[] = [];

    if (data.studentId !== undefined) {
      updates.push('student_id = ?');
      params.push(data.studentId);
    }
    if (data.teacherId !== undefined) {
      updates.push('teacher_id = ?');
      params.push(data.teacherId);
    }
    if (data.schoolId !== undefined) {
      updates.push('school_id = ?');
      params.push(data.schoolId);
    }
    if (data.classTypeId !== undefined) {
      updates.push('class_type_id = ?');
      params.push(data.classTypeId);

      // classTypeId 변경 시 price도 재계산
      if (data.classTypeId !== null) {
        // 1. 해당 class_type의 unit_price 조회
        const [classTypeRows] = await pool.query<RowDataPacket[]>(
          'SELECT unit_price FROM class_type WHERE class_type_id = ?',
          [data.classTypeId]
        );
        const unitPrice = classTypeRows.length > 0 ? (classTypeRows[0].unit_price || 0) : 0;

        // 2. 해당 mgmt_data의 enrollment_count 조회
        const [mgmtDataRows] = await pool.query<RowDataPacket[]>(
          'SELECT enrollment_count FROM mgmt_data WHERE mgmt_data_id = ?',
          [mgmtDataId]
        );
        const enrollmentCount = mgmtDataRows.length > 0 ? (mgmtDataRows[0].enrollment_count || 1) : 1;

        // 3. price = unit_price × enrollment_count
        const price = Math.round(unitPrice * enrollmentCount);
        updates.push('price = ?');
        params.push(price);
      } else {
        // classTypeId가 null이면 price도 0으로
        updates.push('price = ?');
        params.push(0);
      }
    }

    if (updates.length === 0) {
      throw new AppError('수정할 데이터가 없습니다', 400);
    }

    params.push(mgmtDataId);

    await pool.query<ResultSetHeader>(
      `UPDATE mgmt_data SET ${updates.join(', ')} WHERE mgmt_data_id = ?`,
      params
    );

    // 수정된 데이터 조회
    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT
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
        ct.unit_price,
        m.price,
        m.student_name_orig,
        m.teacher_name_orig,
        m.class_type_name_orig,
        m.created_at
      FROM mgmt_data m
      LEFT JOIN User u_student ON m.student_id = u_student.user_id
      LEFT JOIN School s ON m.school_id = s.school_id
      LEFT JOIN User u_teacher ON m.teacher_id = u_teacher.user_id
      LEFT JOIN class_type ct ON m.class_type_id = ct.class_type_id
      WHERE m.mgmt_data_id = ?`,
      [mgmtDataId]
    );

    return rows.length > 0 ? rows[0] as MgmtData : null;
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

  // 반형태 ID 및 단가 찾기 (반형태명 + 학년 + 과목으로 매칭)
  private async findClassTypeWithPrice(
    connection: any,
    classTypeName: string,
    grade: number | null,
    subjectCode: number | null
  ): Promise<{ classTypeId: number | null; unitPrice: number }> {
    if (!classTypeName || grade === null || subjectCode === null) {
      return { classTypeId: null, unitPrice: 0 };
    }

    const [classTypes] = await connection.query(
      `SELECT class_type_id, unit_price
       FROM class_type
       WHERE class_type_name = ? AND grade = ? AND subject = ? AND deleted_at IS NULL
       LIMIT 1`,
      [classTypeName, grade, subjectCode]
    ) as [RowDataPacket[], any];

    if (classTypes.length > 0) {
      return {
        classTypeId: classTypes[0].class_type_id,
        unitPrice: classTypes[0].unit_price || 0
      };
    }

    return { classTypeId: null, unitPrice: 0 };
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
        const subjectStr = row[headerMap['과목']] || '';
        const enrollmentCount = parseFloat(row[headerMap['수강인원']]) || 1;

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

        // 학년 변환
        const grade = parseGrade(gradeStr, schoolLevel);

        // 과목 코드 변환
        const subjectCode = parseSubject(subjectStr);

        // 반형태 ID 및 단가 찾기 (반형태 + 학년 + 과목으로 매칭)
        const { classTypeId, unitPrice } = await this.findClassTypeWithPrice(
          connection,
          classTypeName,
          grade,
          subjectCode
        );

        // 가격 계산: unit_price × enrollment_count
        const price = Math.round(unitPrice * enrollmentCount);

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
           (year, month, student_id, school_id, grade, enrollment_count, comp_class_type, subject, teacher_id, class_name1, class_type_id, price, student_name_orig, teacher_name_orig, class_type_name_orig)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            year,
            month,
            studentId,
            schoolId,
            grade,
            enrollmentCount,
            row[headerMap['종합반종류']] || null,
            subjectStr || null,
            teacherId,
            row[headerMap['반명/교재명']] || null,
            classTypeId,
            price,
            studentName || null,
            teacherName || null,
            classTypeName || null
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

  // 경영 보고서 데이터 조회 (집계)
  async getReport(startYear: number, startMonth: number, endYear: number, endMonth: number): Promise<{
    summary: { totalRevenue: number; totalEnrollments: number; studentCount: number; avgUnitPrice: number };
    monthlyTrend: { year: number; month: number; revenue: number; enrollments: number; studentCount: number }[];
    bySubject: { subject: string; revenue: number; enrollments: number; percentage: number }[];
    byGrade: { grade: number; gradeName: string; revenue: number; studentCount: number }[];
    byTeacher: { teacherId: number | null; teacherName: string; revenue: number; enrollments: number; studentCount: number }[];
    bySchool: { schoolId: number | null; schoolName: string; revenue: number; studentCount: number }[];
    byClassType: { classTypeId: number | null; classTypeName: string; revenue: number; enrollments: number }[];
  }> {
    // 기간 조건 생성 (시작월 ~ 종료월)
    const periodCondition = `
      ((m.year > ? OR (m.year = ? AND m.month >= ?))
      AND (m.year < ? OR (m.year = ? AND m.month <= ?)))
    `;
    const periodParams = [startYear, startYear, startMonth, endYear, endYear, endMonth];

    // 1. 요약 KPI
    const [summaryResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        COALESCE(SUM(m.price), 0) as total_revenue,
        COALESCE(SUM(m.enrollment_count), 0) as total_enrollments,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      WHERE ${periodCondition}
    `, periodParams);

    const summary = {
      totalRevenue: Number(summaryResult[0].total_revenue) || 0,
      totalEnrollments: Number(summaryResult[0].total_enrollments) || 0,
      studentCount: Number(summaryResult[0].student_count) || 0,
      avgUnitPrice: Number(summaryResult[0].total_enrollments) > 0
        ? Math.round(Number(summaryResult[0].total_revenue) / Number(summaryResult[0].total_enrollments))
        : 0
    };

    // 2. 월별 추이
    const [monthlyResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.year,
        m.month,
        COALESCE(SUM(m.price), 0) as revenue,
        COALESCE(SUM(m.enrollment_count), 0) as enrollments,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      WHERE ${periodCondition}
      GROUP BY m.year, m.month
      ORDER BY m.year, m.month
    `, periodParams);

    const monthlyTrend = monthlyResult.map(row => ({
      year: Number(row.year),
      month: Number(row.month),
      revenue: Number(row.revenue) || 0,
      enrollments: Number(row.enrollments) || 0,
      studentCount: Number(row.student_count) || 0
    }));

    // 3. 과목별 집계
    const [subjectResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        COALESCE(m.subject, '미지정') as subject,
        COALESCE(SUM(m.price), 0) as revenue,
        COALESCE(SUM(m.enrollment_count), 0) as enrollments
      FROM mgmt_data m
      WHERE ${periodCondition}
      GROUP BY m.subject
      ORDER BY revenue DESC
    `, periodParams);

    const totalSubjectRevenue = subjectResult.reduce((sum, row) => sum + Number(row.revenue || 0), 0);
    const bySubject = subjectResult.map(row => ({
      subject: row.subject || '미지정',
      revenue: Number(row.revenue) || 0,
      enrollments: Number(row.enrollments) || 0,
      percentage: totalSubjectRevenue > 0 ? Math.round((Number(row.revenue) / totalSubjectRevenue) * 1000) / 10 : 0
    }));

    // 4. 학년별 집계
    const [gradeResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.grade,
        COALESCE(SUM(m.price), 0) as revenue,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      WHERE ${periodCondition}
      GROUP BY m.grade
      ORDER BY m.grade
    `, periodParams);

    const gradeNames: { [key: number]: string } = {
      1: '초1', 2: '초2', 3: '초3', 4: '초4', 5: '초5', 6: '초6',
      7: '중1', 8: '중2', 9: '중3',
      10: '고1', 11: '고2', 12: '고3'
    };

    const byGrade = gradeResult.map(row => ({
      grade: Number(row.grade) || 0,
      gradeName: row.grade ? (gradeNames[row.grade] || `${row.grade}학년`) : '미지정',
      revenue: Number(row.revenue) || 0,
      studentCount: Number(row.student_count) || 0
    }));

    // 5. 강사별 집계
    const [teacherResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.teacher_id,
        COALESCE(MAX(u.name), MAX(m.teacher_name_orig), '미지정') as teacher_name,
        COALESCE(SUM(m.price), 0) as revenue,
        COALESCE(SUM(m.enrollment_count), 0) as enrollments,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      LEFT JOIN User u ON m.teacher_id = u.user_id
      WHERE ${periodCondition}
      GROUP BY m.teacher_id
      ORDER BY revenue DESC
    `, periodParams);

    const byTeacher = teacherResult.map(row => ({
      teacherId: row.teacher_id,
      teacherName: row.teacher_name || '미지정',
      revenue: Number(row.revenue) || 0,
      enrollments: Number(row.enrollments) || 0,
      studentCount: Number(row.student_count) || 0
    }));

    // 6. 학교별 집계
    const [schoolResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.school_id,
        COALESCE(MAX(s.school_name), '미지정') as school_name,
        COALESCE(SUM(m.price), 0) as revenue,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      LEFT JOIN School s ON m.school_id = s.school_id
      WHERE ${periodCondition}
      GROUP BY m.school_id
      ORDER BY revenue DESC
    `, periodParams);

    const bySchool = schoolResult.map(row => ({
      schoolId: row.school_id,
      schoolName: row.school_name || '미지정',
      revenue: Number(row.revenue) || 0,
      studentCount: Number(row.student_count) || 0
    }));

    // 7. 반형태별 집계
    const [classTypeResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.class_type_id,
        COALESCE(MAX(ct.class_type_name), MAX(m.class_type_name_orig), '미지정') as class_type_name,
        COALESCE(SUM(m.price), 0) as revenue,
        COALESCE(SUM(m.enrollment_count), 0) as enrollments
      FROM mgmt_data m
      LEFT JOIN class_type ct ON m.class_type_id = ct.class_type_id
      WHERE ${periodCondition}
      GROUP BY m.class_type_id
      ORDER BY revenue DESC
    `, periodParams);

    const byClassType = classTypeResult.map(row => ({
      classTypeId: row.class_type_id,
      classTypeName: row.class_type_name || '미지정',
      revenue: Number(row.revenue) || 0,
      enrollments: Number(row.enrollments) || 0
    }));

    return {
      summary,
      monthlyTrend,
      bySubject,
      byGrade,
      byTeacher,
      bySchool,
      byClassType
    };
  }

  // 지역별 보고서 데이터 조회
  async getRegionReport(startYear: number, startMonth: number, endYear: number, endMonth: number): Promise<RegionReport> {
    // 기간 조건 생성 (시작월 ~ 종료월)
    const periodCondition = `
      ((m.year > ? OR (m.year = ? AND m.month >= ?))
      AND (m.year < ? OR (m.year = ? AND m.month <= ?)))
    `;
    const periodParams = [startYear, startYear, startMonth, endYear, endYear, endMonth];

    // 학년명 매핑
    const gradeNames: { [key: number]: string } = {
      1: '초1', 2: '초2', 3: '초3', 4: '초4', 5: '초5', 6: '초6',
      7: '중1', 8: '중2', 9: '중3',
      10: '고1', 11: '고2', 12: '고3'
    };

    // 1. 지역별 월별 학생수
    const [regionMonthlyResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        COALESCE(s.region_name, '미지정') as region_name,
        m.year,
        m.month,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      LEFT JOIN School s ON m.school_id = s.school_id
      WHERE ${periodCondition}
      GROUP BY s.region_name, m.year, m.month
      ORDER BY s.region_name, m.year, m.month
    `, periodParams);

    const byRegionMonthly: RegionMonthlyStat[] = regionMonthlyResult.map(row => ({
      regionName: row.region_name || '미지정',
      year: Number(row.year),
      month: Number(row.month),
      studentCount: Number(row.student_count) || 0
    }));

    // 2. 지역별 월별 학년별 학생수
    const [regionGradeResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        COALESCE(s.region_name, '미지정') as region_name,
        m.year,
        m.month,
        m.grade,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      LEFT JOIN School s ON m.school_id = s.school_id
      WHERE ${periodCondition}
      GROUP BY s.region_name, m.year, m.month, m.grade
      ORDER BY s.region_name, m.year, m.month, m.grade
    `, periodParams);

    const byRegionGradeMonthly: RegionGradeMonthlyStat[] = regionGradeResult.map(row => ({
      regionName: row.region_name || '미지정',
      year: Number(row.year),
      month: Number(row.month),
      grade: Number(row.grade) || 0,
      gradeName: row.grade ? (gradeNames[row.grade] || `${row.grade}학년`) : '미지정',
      studentCount: Number(row.student_count) || 0
    }));

    // 3. 학교별 지역별 월별 학생수
    const [schoolRegionResult] = await pool.query<RowDataPacket[]>(`
      SELECT
        m.school_id,
        COALESCE(MAX(s.school_name), '미지정') as school_name,
        COALESCE(MAX(s.region_name), '미지정') as region_name,
        m.year,
        m.month,
        COUNT(DISTINCT m.student_id) as student_count
      FROM mgmt_data m
      LEFT JOIN School s ON m.school_id = s.school_id
      WHERE ${periodCondition}
      GROUP BY m.school_id, m.year, m.month
      ORDER BY region_name, school_name, m.year, m.month
    `, periodParams);

    const bySchoolRegionMonthly: SchoolRegionMonthlyStat[] = schoolRegionResult.map(row => ({
      schoolId: row.school_id,
      schoolName: row.school_name || '미지정',
      regionName: row.region_name || '미지정',
      year: Number(row.year),
      month: Number(row.month),
      studentCount: Number(row.student_count) || 0
    }));

    return {
      byRegionMonthly,
      byRegionGradeMonthly,
      bySchoolRegionMonthly
    };
  }
}

export default new MgmtDataService();
