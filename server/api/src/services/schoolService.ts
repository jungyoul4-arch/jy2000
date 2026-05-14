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

    // Build WHERE clause (삭제된 학교도 포함)
    const conditions: string[] = [];
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

    const whereClause = conditions.length > 0 ? conditions.join(' AND ') : '1=1';

    // Allowed sort columns
    const allowedSorts = ['school_id', 'school_name', 'school_kind', 'region_kind', 'created_at'];
    const sortColumn = allowedSorts.includes(sort) ? sort : 'school_name';
    const sortOrder = order === 'desc' ? 'DESC' : 'ASC';

    // Count query
    const countSql = `SELECT COUNT(*) as total FROM School s WHERE ${whereClause.replace(/school_kind/g, 's.school_kind').replace(/region_kind/g, 's.region_kind').replace(/school_name/g, 's.school_name')}`;

    // Data query (is_active=1인 것 먼저, 그 다음 이름순) + 학생 수 포함
    const dataSql = `
      SELECT
        s.school_id,
        s.school_name,
        s.school_kind,
        s.region_kind,
        s.is_active,
        s.deleted_at,
        s.created_at,
        s.updated_at,
        COALESCE(sc.student_count, 0) as student_count
      FROM School s
      LEFT JOIN (
        SELECT school_id, COUNT(*) as student_count
        FROM student_info
        WHERE deleted_at IS NULL
        GROUP BY school_id
      ) sc ON s.school_id = sc.school_id
      WHERE ${whereClause.replace(/school_kind/g, 's.school_kind').replace(/region_kind/g, 's.region_kind').replace(/school_name/g, 's.school_name')}
      ORDER BY s.is_active DESC, s.${sortColumn} ${sortOrder}
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

  // 학교 삭제 (soft delete - 학생 유무와 관계없이)
  async delete(schoolId: number): Promise<void> {
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT school_id FROM School WHERE school_id = ? AND deleted_at IS NULL',
      [schoolId]
    );

    if (existing.length === 0) {
      throw new AppError('School not found', 404);
    }

    await pool.query<ResultSetHeader>(
      'UPDATE School SET deleted_at = NOW(), is_active = 0 WHERE school_id = ?',
      [schoolId]
    );
  }
}

export default new SchoolService();
