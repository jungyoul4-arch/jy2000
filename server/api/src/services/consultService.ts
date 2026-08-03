import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { Consult, ConsultCreate, ConsultListQuery } from '../types';
import { AppError } from '../middlewares/errorHandler';

export class ConsultService {
  // 상담 목록 조회
  async getList(query: ConsultListQuery): Promise<{ data: Consult[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 20;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'consult_date';
    const order = query.order || 'desc';

    // Build WHERE clause
    const conditions: string[] = ['c.deleted_at IS NULL'];
    const params: any[] = [];

    if (query.student_id) {
      conditions.push('c.student_id = ?');
      params.push(query.student_id);
    }

    if (query.tc_id) {
      conditions.push('c.tc_id = ?');
      params.push(query.tc_id);
    }

    if (query.consult_type_code) {
      conditions.push('c.consult_type_code = ?');
      params.push(query.consult_type_code);
    }

    if (query.consult_result_code) {
      conditions.push('c.consult_result_code = ?');
      params.push(query.consult_result_code);
    }

    if (query.from_date) {
      conditions.push('DATE(c.consult_date) >= ?');
      params.push(query.from_date);
    }

    if (query.to_date) {
      conditions.push('DATE(c.consult_date) <= ?');
      params.push(query.to_date);
    }

    if (query.search) {
      conditions.push('(u.name LIKE ? OR u.phone LIKE ?)');
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    const whereClause = conditions.join(' AND ');

    // Allowed sort columns
    const allowedSorts = ['consult_id', 'consult_date', 'created_at', 'next_consult_date'];
    const sortColumn = allowedSorts.includes(sort) ? sort : 'consult_date';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      WHERE ${whereClause}
    `;

    // Data query
    const dataSql = `
      SELECT
        c.consult_id,
        c.student_id,
        u.name as student_name,
        u.phone as student_phone,
        c.consult_type_code,
        ct.code_name as consult_type_name,
        DATE_FORMAT(c.consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
        c.consult_duration,
        c.channel_code,
        ch.code_name as channel_name,
        c.tc_id,
        tc.name as tc_name,
        c.content,
        c.student_needs,
        c.consult_result_code,
        cr.code_name as consult_result_name,
        c.result_detail,
        c.next_action_code,
        na.code_name as next_action_name,
        c.next_action_detail,
        DATE_FORMAT(c.next_consult_date, '%Y-%m-%d %H:%i:%s') as next_consult_date,
        c.interest_subject,
        c.interest_program,
        c.created_at,
        c.updated_at
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN code_master ct ON c.consult_type_code = ct.code_id
      LEFT JOIN code_master ch ON c.channel_code = ch.code_id
      LEFT JOIN code_master cr ON c.consult_result_code = cr.code_id
      LEFT JOIN code_master na ON c.next_action_code = na.code_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      WHERE ${whereClause}
      ORDER BY c.${sortColumn} ${sortOrder}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as Consult[],
      total
    };
  }

  // 상담 등록
  async create(data: ConsultCreate, userId: number): Promise<Consult> {
    // Check if student exists
    const [studentCheck] = await pool.query<RowDataPacket[]>(
      'SELECT student_id FROM student_info WHERE student_id = ? AND deleted_at IS NULL',
      [data.student_id]
    );

    if (studentCheck.length === 0) {
      throw new AppError('Student not found', 404);
    }

    const sql = `
      INSERT INTO consult (
        student_id,
        consult_type_code,
        consult_date,
        consult_duration,
        channel_code,
        tc_id,
        content,
        student_needs,
        consult_result_code,
        result_detail,
        next_action_code,
        next_action_detail,
        next_consult_date,
        interest_subject,
        interest_program,
        created_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(sql, [
      data.student_id,
      data.consult_type_code,
      data.consult_date,
      data.consult_duration || null,
      data.channel_code || null,
      data.tc_id || null,
      data.content || null,
      data.student_needs || null,
      data.consult_result_code || null,
      data.result_detail || null,
      data.next_action_code || null,
      data.next_action_detail || null,
      data.next_consult_date || null,
      data.interest_subject || null,
      data.interest_program || null,
      userId
    ]);

    return this.getById(result.insertId);
  }

  // 상담 상세 조회
  async getById(consultId: number): Promise<Consult> {
    const sql = `
      SELECT
        c.consult_id,
        c.student_id,
        u.name as student_name,
        u.phone as student_phone,
        c.consult_type_code,
        ct.code_name as consult_type_name,
        DATE_FORMAT(c.consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
        c.consult_duration,
        c.channel_code,
        ch.code_name as channel_name,
        c.tc_id,
        tc.name as tc_name,
        c.content,
        c.student_needs,
        c.consult_result_code,
        cr.code_name as consult_result_name,
        c.result_detail,
        c.next_action_code,
        na.code_name as next_action_name,
        c.next_action_detail,
        DATE_FORMAT(c.next_consult_date, '%Y-%m-%d %H:%i:%s') as next_consult_date,
        c.interest_subject,
        c.interest_program,
        c.created_at,
        c.updated_at
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN code_master ct ON c.consult_type_code = ct.code_id
      LEFT JOIN code_master ch ON c.channel_code = ch.code_id
      LEFT JOIN code_master cr ON c.consult_result_code = cr.code_id
      LEFT JOIN code_master na ON c.next_action_code = na.code_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      WHERE c.consult_id = ? AND c.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [consultId]);

    if (rows.length === 0) {
      throw new AppError('Consult not found', 404);
    }

    return rows[0] as Consult;
  }

  // 상담 수정
  async update(consultId: number, data: Partial<ConsultCreate>, userId: number): Promise<Consult> {
    // Check if consult exists
    const [consultCheck] = await pool.query<RowDataPacket[]>(
      'SELECT consult_id FROM consult WHERE consult_id = ? AND deleted_at IS NULL',
      [consultId]
    );

    if (consultCheck.length === 0) {
      throw new AppError('Consult not found', 404);
    }

    // ISO8601 날짜를 MySQL DATETIME 형식으로 변환하는 헬퍼 함수
    const formatDateForMySQL = (isoDate: string | undefined | null): string | null => {
      if (!isoDate) return null;
      try {
        const date = new Date(isoDate);
        return date.toISOString().slice(0, 19).replace('T', ' ');
      } catch {
        return isoDate;
      }
    };

    const updateFields: string[] = [];
    const updateValues: any[] = [];

    if (data.consult_type_code !== undefined) {
      updateFields.push('consult_type_code = ?');
      updateValues.push(data.consult_type_code);
    }
    if (data.consult_date !== undefined) {
      updateFields.push('consult_date = ?');
      updateValues.push(formatDateForMySQL(data.consult_date));
    }
    if (data.consult_duration !== undefined) {
      updateFields.push('consult_duration = ?');
      updateValues.push(data.consult_duration);
    }
    if (data.channel_code !== undefined) {
      updateFields.push('channel_code = ?');
      updateValues.push(data.channel_code);
    }
    if (data.tc_id !== undefined) {
      updateFields.push('tc_id = ?');
      updateValues.push(data.tc_id);
    }
    if (data.content !== undefined) {
      updateFields.push('content = ?');
      updateValues.push(data.content);
    }
    if (data.student_needs !== undefined) {
      updateFields.push('student_needs = ?');
      updateValues.push(data.student_needs);
    }
    if (data.consult_result_code !== undefined) {
      updateFields.push('consult_result_code = ?');
      updateValues.push(data.consult_result_code);
    }
    if (data.result_detail !== undefined) {
      updateFields.push('result_detail = ?');
      updateValues.push(data.result_detail);
    }
    if (data.next_action_code !== undefined) {
      updateFields.push('next_action_code = ?');
      updateValues.push(data.next_action_code);
    }
    if (data.next_action_detail !== undefined) {
      updateFields.push('next_action_detail = ?');
      updateValues.push(data.next_action_detail);
    }
    if (data.next_consult_date !== undefined) {
      updateFields.push('next_consult_date = ?');
      updateValues.push(formatDateForMySQL(data.next_consult_date));
    }
    if (data.interest_subject !== undefined) {
      updateFields.push('interest_subject = ?');
      updateValues.push(data.interest_subject);
    }
    if (data.interest_program !== undefined) {
      updateFields.push('interest_program = ?');
      updateValues.push(data.interest_program);
    }

    if (updateFields.length === 0) {
      return this.getById(consultId);
    }

    updateFields.push('updated_by = ?');
    updateValues.push(userId);
    updateFields.push('updated_at = NOW()');

    const sql = `UPDATE consult SET ${updateFields.join(', ')} WHERE consult_id = ?`;
    updateValues.push(consultId);

    await pool.query(sql, updateValues);

    return this.getById(consultId);
  }
}

export default new ConsultService();
