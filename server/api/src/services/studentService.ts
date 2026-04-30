import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { Student, StudentListQuery, StudentStateChange } from '../types';
import { AppError } from '../middlewares/errorHandler';

export class StudentService {
  // 학생 목록 조회
  async getList(query: StudentListQuery): Promise<{ data: Student[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 20;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'created_at';
    const order = query.order || 'desc';

    // Build WHERE clause
    const conditions: string[] = ['s.deleted_at IS NULL'];
    const params: any[] = [];

    if (query.status_code) {
      conditions.push('s.status_code = ?');
      params.push(query.status_code);
    }

    if (query.grade) {
      conditions.push('u.grade = ?');
      params.push(query.grade);
    }

    if (query.tc_id) {
      conditions.push('s.tc_id = ?');
      params.push(query.tc_id);
    }

    if (query.search) {
      conditions.push('(u.name LIKE ? OR u.phone LIKE ?)');
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    if (query.from_date) {
      conditions.push('s.first_contact_date >= ?');
      params.push(query.from_date);
    }

    if (query.to_date) {
      conditions.push('s.first_contact_date <= ?');
      params.push(query.to_date);
    }

    const whereClause = conditions.join(' AND ');

    // Allowed sort columns
    const allowedSorts = ['student_id', 'student_name', 'status_code', 'created_at', 'first_contact_date', 'register_date'];
    const sortColumn = allowedSorts.includes(sort) ? sort : 'created_at';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      WHERE ${whereClause}
    `;

    // Data query
    const dataSql = `
      SELECT
        s.student_id,
        u.name as student_name,
        u.phone,
        u.email,
        s.birth_date,
        s.gender_code,
        g.code_name as gender_name,
        s.school_id,
        s.school_name,
        u.grade,
        CASE u.grade
          WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
          WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
          WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
          WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
          WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
          ELSE NULL
        END as grade_name,
        p.name as guardian_name,
        pp.phone as guardian_phone,
        CASE pp.parent_kind
          WHEN 1 THEN '부' WHEN 2 THEN '모' WHEN 3 THEN '친척' WHEN 99 THEN '기타'
          ELSE NULL
        END as guardian_relation,
        s.status_code,
        st.code_name as status_name,
        s.sub_status_code,
        sub.code_name as sub_status_name,
        s.source_code,
        src.code_name as source_name,
        s.tc_id,
        tc.name as tc_name,
        s.first_contact_date,
        s.consult_date,
        s.register_date,
        s.enroll_date,
        s.withdraw_date,
        s.memo,
        s.created_at,
        s.updated_at
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN code_master g ON s.gender_code = g.code_id
      LEFT JOIN code_master st ON s.status_code = st.code_id
      LEFT JOIN code_master sub ON s.sub_status_code = sub.code_id
      LEFT JOIN code_master src ON s.source_code = src.code_id
      LEFT JOIN User tc ON s.tc_id = tc.user_id
      LEFT JOIN ParentPhone pp ON pp.student_id = s.student_id AND pp.seq = 1
      LEFT JOIN User p ON pp.parent_id = p.user_id
      WHERE ${whereClause}
      ORDER BY s.${sortColumn} ${sortOrder}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as Student[],
      total
    };
  }

  // 학생 상세 조회
  async getById(studentId: number): Promise<Student> {
    const sql = `
      SELECT
        s.student_id,
        u.name as student_name,
        u.phone,
        s.phone_sub,
        u.email,
        s.birth_date,
        s.gender_code,
        g.code_name as gender_name,
        s.school_id,
        s.school_name,
        u.grade,
        CASE u.grade
          WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
          WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
          WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
          WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
          WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
          ELSE NULL
        END as grade_name,
        p.name as guardian_name,
        pp.phone as guardian_phone,
        pp.parent_kind as guardian_relation,
        CASE pp.parent_kind
          WHEN 1 THEN '부' WHEN 2 THEN '모' WHEN 3 THEN '친척' WHEN 99 THEN '기타'
          ELSE NULL
        END as relation_name,
        s.zip_code,
        s.address,
        s.address_detail,
        s.status_code,
        st.code_name as status_name,
        s.sub_status_code,
        sub.code_name as sub_status_name,
        s.source_code,
        src.code_name as source_name,
        s.source_detail,
        s.tc_id,
        tc.name as tc_name,
        s.first_contact_date,
        s.consult_date,
        s.register_date,
        s.enroll_date,
        s.withdraw_date,
        s.memo,
        s.created_at,
        s.updated_at
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN code_master g ON s.gender_code = g.code_id
      LEFT JOIN code_master st ON s.status_code = st.code_id
      LEFT JOIN code_master sub ON s.sub_status_code = sub.code_id
      LEFT JOIN code_master src ON s.source_code = src.code_id
      LEFT JOIN User tc ON s.tc_id = tc.user_id
      LEFT JOIN ParentPhone pp ON pp.student_id = s.student_id AND pp.seq = 1
      LEFT JOIN User p ON pp.parent_id = p.user_id
      WHERE s.student_id = ? AND s.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [studentId]);

    if (rows.length === 0) {
      throw new AppError('Student not found', 404);
    }

    return rows[0] as Student;
  }

  // 학생 상태 변경
  async changeState(data: StudentStateChange, userId: number): Promise<Student> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // Check if student exists
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT student_id, status_code, sub_status_code, tc_id FROM student_info WHERE student_id = ? AND deleted_at IS NULL',
        [data.student_id]
      );

      if (existing.length === 0) {
        throw new AppError('Student not found', 404);
      }

      const currentStudent = existing[0];

      // Update student status
      const updateSql = `
        UPDATE student_info
        SET
          status_code = ?,
          sub_status_code = ?,
          tc_id = COALESCE(?, tc_id),
          updated_by = ?,
          updated_at = NOW()
        WHERE student_id = ?
      `;

      await connection.query<ResultSetHeader>(updateSql, [
        data.new_status_code,
        data.new_sub_status_code || null,
        data.new_tc_id || null,
        userId,
        data.student_id
      ]);

      // Insert history (trigger handles status change, but we add reason here)
      if (data.change_reason) {
        const historySql = `
          UPDATE student_history
          SET change_reason = ?
          WHERE student_id = ?
          AND changed_at = (
            SELECT MAX(changed_at) FROM (
              SELECT changed_at FROM student_history WHERE student_id = ?
            ) as t
          )
        `;
        await connection.query(historySql, [data.change_reason, data.student_id, data.student_id]);
      }

      await connection.commit();

      // Return updated student
      return this.getById(data.student_id);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new StudentService();
