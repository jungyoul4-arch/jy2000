import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { Promotion, PromotionCreate, ListQueryParams } from '../types';
import { AppError } from '../middlewares/errorHandler';

export class PromotionService {
  // 프로모션 목록 조회
  async getList(query: ListQueryParams): Promise<{ data: Promotion[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 20;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'created_at';
    const order = query.order || 'desc';

    // Build WHERE clause
    const conditions: string[] = ['p.deleted_at IS NULL'];
    const params: any[] = [];

    if (query.search) {
      conditions.push('(p.promotion_name LIKE ? OR p.promotion_code LIKE ?)');
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    const whereClause = conditions.join(' AND ');

    // Allowed sort columns
    const allowedSorts = ['promotion_id', 'promotion_name', 'start_date', 'end_date', 'created_at'];
    const sortColumn = allowedSorts.includes(sort) ? sort : 'created_at';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM promotion p
      WHERE ${whereClause}
    `;

    // Data query
    const dataSql = `
      SELECT
        p.promotion_id,
        p.promotion_name,
        p.promotion_code,
        p.promotion_type_code,
        pt.code_name as promotion_type_name,
        p.start_date,
        p.end_date,
        p.description,
        p.discount_type_code,
        dt.code_name as discount_type_name,
        p.discount_value,
        p.target_grade,
        p.target_subject,
        p.is_active,
        p.created_at,
        p.updated_at
      FROM promotion p
      LEFT JOIN code_master pt ON p.promotion_type_code = pt.code_id
      LEFT JOIN code_master dt ON p.discount_type_code = dt.code_id
      WHERE ${whereClause}
      ORDER BY p.${sortColumn} ${sortOrder}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as Promotion[],
      total
    };
  }

  // 프로모션 등록
  async create(data: PromotionCreate, userId: number): Promise<Promotion> {
    // Check for duplicate promotion_code
    if (data.promotion_code) {
      const [existing] = await pool.query<RowDataPacket[]>(
        'SELECT promotion_id FROM promotion WHERE promotion_code = ? AND deleted_at IS NULL',
        [data.promotion_code]
      );

      if (existing.length > 0) {
        throw new AppError('Promotion code already exists', 400);
      }
    }

    const sql = `
      INSERT INTO promotion (
        promotion_name,
        promotion_code,
        promotion_type_code,
        start_date,
        end_date,
        description,
        discount_type_code,
        discount_value,
        target_grade,
        target_subject,
        created_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(sql, [
      data.promotion_name,
      data.promotion_code || null,
      data.promotion_type_code || null,
      data.start_date,
      data.end_date || null,
      data.description || null,
      data.discount_type_code || null,
      data.discount_value || null,
      data.target_grade || null,
      data.target_subject || null,
      userId
    ]);

    return this.getById(result.insertId);
  }

  // 프로모션 상세 조회
  async getById(promotionId: number): Promise<Promotion> {
    const sql = `
      SELECT
        p.*,
        pt.code_name as promotion_type_name,
        dt.code_name as discount_type_name
      FROM promotion p
      LEFT JOIN code_master pt ON p.promotion_type_code = pt.code_id
      LEFT JOIN code_master dt ON p.discount_type_code = dt.code_id
      WHERE p.promotion_id = ? AND p.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [promotionId]);

    if (rows.length === 0) {
      throw new AppError('Promotion not found', 404);
    }

    return rows[0] as Promotion;
  }
}

export default new PromotionService();
