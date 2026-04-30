import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { School, SchoolCreate, SchoolListQuery } from '../types';
import { AppError } from '../middlewares/errorHandler';

export class SchoolService {
  // 학교 목록 조회
  async getList(query: SchoolListQuery): Promise<{ data: School[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 100;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'school_name';
    const order = query.order || 'asc';

    // Build WHERE clause
    const conditions: string[] = ['deleted_at IS NULL', 'is_active = 1'];
    const params: any[] = [];

    if (query.school_kind) {
      conditions.push('school_kind = ?');
      params.push(query.school_kind);
    }

    if (query.region_kind !== undefined) {
      conditions.push('region_kind = ?');
      params.push(query.region_kind);
    }

    if (query.search) {
      conditions.push('school_name LIKE ?');
      params.push(`%${query.search}%`);
    }

    const whereClause = conditions.join(' AND ');

    // Allowed sort columns
    const allowedSorts = ['school_id', 'school_name', 'school_kind', 'region_kind', 'created_at'];
    const sortColumn = allowedSorts.includes(sort) ? sort : 'school_name';
    const sortOrder = order === 'desc' ? 'DESC' : 'ASC';

    // Count query
    const countSql = `SELECT COUNT(*) as total FROM School WHERE ${whereClause}`;

    // Data query
    const dataSql = `
      SELECT
        school_id,
        school_name,
        school_kind,
        region_kind,
        is_active,
        created_at,
        updated_at
      FROM School
      WHERE ${whereClause}
      ORDER BY ${sortColumn} ${sortOrder}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as School[],
      total
    };
  }

  // 학교 상세 조회
  async getById(schoolId: number): Promise<School> {
    const sql = `
      SELECT
        school_id,
        school_name,
        school_kind,
        region_kind,
        is_active,
        created_at,
        updated_at
      FROM School
      WHERE school_id = ? AND deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [schoolId]);

    if (rows.length === 0) {
      throw new AppError('School not found', 404);
    }

    return rows[0] as School;
  }

  // 학교 생성
  async create(data: SchoolCreate): Promise<School> {
    // 학교명 검증: '중' 또는 '고'로 끝나야 함
    if (!data.school_name.endsWith('중') && !data.school_name.endsWith('고')) {
      throw new AppError('학교명은 "중" 또는 "고"로 끝나야 합니다', 400);
    }

    // 중복 체크
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT school_id FROM School WHERE school_name = ? AND deleted_at IS NULL',
      [data.school_name]
    );

    if (existing.length > 0) {
      throw new AppError('이미 등록된 학교명입니다', 400);
    }

    const insertSql = `
      INSERT INTO School (school_name, school_kind, region_kind)
      VALUES (?, ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(insertSql, [
      data.school_name,
      data.school_kind,
      data.region_kind
    ]);

    return this.getById(result.insertId);
  }

  // 학교 수정
  async update(schoolId: number, data: Partial<SchoolCreate>): Promise<School> {
    // 학교명 검증: '중' 또는 '고'로 끝나야 함
    if (data.school_name && !data.school_name.endsWith('중') && !data.school_name.endsWith('고')) {
      throw new AppError('학교명은 "중" 또는 "고"로 끝나야 합니다', 400);
    }

    // 존재 여부 확인
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT school_id FROM School WHERE school_id = ? AND deleted_at IS NULL',
      [schoolId]
    );

    if (existing.length === 0) {
      throw new AppError('School not found', 404);
    }

    // 중복 체크 (자신 제외)
    if (data.school_name) {
      const [duplicate] = await pool.query<RowDataPacket[]>(
        'SELECT school_id FROM School WHERE school_name = ? AND school_id != ? AND deleted_at IS NULL',
        [data.school_name, schoolId]
      );

      if (duplicate.length > 0) {
        throw new AppError('이미 등록된 학교명입니다', 400);
      }
    }

    const updates: string[] = [];
    const params: any[] = [];

    if (data.school_name !== undefined) {
      updates.push('school_name = ?');
      params.push(data.school_name);
    }
    if (data.school_kind !== undefined) {
      updates.push('school_kind = ?');
      params.push(data.school_kind);
    }
    if (data.region_kind !== undefined) {
      updates.push('region_kind = ?');
      params.push(data.region_kind);
    }

    if (updates.length === 0) {
      return this.getById(schoolId);
    }

    params.push(schoolId);

    const updateSql = `UPDATE School SET ${updates.join(', ')} WHERE school_id = ?`;
    await pool.query<ResultSetHeader>(updateSql, params);

    return this.getById(schoolId);
  }

  // 학교 삭제 (soft delete)
  async delete(schoolId: number): Promise<void> {
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT school_id FROM School WHERE school_id = ? AND deleted_at IS NULL',
      [schoolId]
    );

    if (existing.length === 0) {
      throw new AppError('School not found', 404);
    }

    // 해당 학교를 사용하는 학생이 있는지 확인
    const [students] = await pool.query<RowDataPacket[]>(
      'SELECT COUNT(*) as count FROM student_info WHERE school_id = ? AND deleted_at IS NULL',
      [schoolId]
    );

    if (students[0].count > 0) {
      throw new AppError('이 학교에 등록된 학생이 있어 삭제할 수 없습니다', 400);
    }

    await pool.query<ResultSetHeader>(
      'UPDATE School SET deleted_at = NOW(), is_active = 0 WHERE school_id = ?',
      [schoolId]
    );
  }
}

export default new SchoolService();
