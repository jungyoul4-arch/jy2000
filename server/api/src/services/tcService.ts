import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { TC, TCCreate } from '../types';
import { AppError } from '../middlewares/errorHandler';

export class TCService {
  // TC 등록
  async create(data: TCCreate, userId: number): Promise<TC> {
    // Check for duplicate tc_code
    if (data.tc_code) {
      const [existing] = await pool.query<RowDataPacket[]>(
        'SELECT tc_id FROM tc_info WHERE tc_code = ? AND deleted_at IS NULL',
        [data.tc_code]
      );

      if (existing.length > 0) {
        throw new AppError('TC code already exists', 400);
      }
    }

    const sql = `
      INSERT INTO tc_info (
        user_id,
        tc_name,
        tc_code,
        phone,
        email,
        tc_type_code,
        branch_code,
        hire_date
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(sql, [
      data.user_id || null,
      data.tc_name,
      data.tc_code || null,
      data.phone || null,
      data.email || null,
      data.tc_type_code || null,
      data.branch_code || null,
      data.hire_date || null
    ]);

    return this.getById(result.insertId);
  }

  // TC 상세 조회
  async getById(tcId: number): Promise<TC> {
    const sql = `
      SELECT
        t.*,
        tt.code_name as tc_type_name,
        b.code_name as branch_name,
        u.user_name,
        u.login_id
      FROM tc_info t
      LEFT JOIN code_master tt ON t.tc_type_code = tt.code_id
      LEFT JOIN code_master b ON t.branch_code = b.code_id
      LEFT JOIN users u ON t.user_id = u.user_id
      WHERE t.tc_id = ? AND t.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [tcId]);

    if (rows.length === 0) {
      throw new AppError('TC not found', 404);
    }

    return rows[0] as TC;
  }

  // TC 목록 조회
  async getList(): Promise<TC[]> {
    const sql = `
      SELECT
        t.*,
        tt.code_name as tc_type_name,
        b.code_name as branch_name
      FROM tc_info t
      LEFT JOIN code_master tt ON t.tc_type_code = tt.code_id
      LEFT JOIN code_master b ON t.branch_code = b.code_id
      WHERE t.deleted_at IS NULL AND t.is_active = 1
      ORDER BY t.tc_name
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql);

    return rows as TC[];
  }
}

export default new TCService();
