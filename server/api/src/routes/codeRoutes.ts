import { Router, Request, Response } from 'express';
import pool from '../config/database';
import { RowDataPacket } from 'mysql2';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess } from '../utils/responseHelper';

const router = Router();

// GET /code - 전체 코드 목록 조회
router.get('/', asyncHandler(async (req: Request, res: Response) => {
  const sql = `
    SELECT
      code_id,
      code_group,
      code_value,
      code_name,
      code_name_en,
      parent_code_id,
      sort_order
    FROM code_master
    WHERE is_active = 1 AND deleted_at IS NULL
    ORDER BY code_group, sort_order
  `;

  const [rows] = await pool.query<RowDataPacket[]>(sql);

  // Group by code_group
  const grouped = rows.reduce((acc: any, row) => {
    if (!acc[row.code_group]) {
      acc[row.code_group] = [];
    }
    acc[row.code_group].push(row);
    return acc;
  }, {});

  return sendSuccess(res, grouped, 'Code list retrieved successfully');
}));

// GET /code/:group - 그룹별 코드 조회
router.get('/:group', asyncHandler(async (req: Request, res: Response) => {
  const { group } = req.params;

  const sql = `
    SELECT
      code_id,
      code_group,
      code_value,
      code_name,
      code_name_en,
      parent_code_id,
      sort_order
    FROM code_master
    WHERE code_group = ? AND is_active = 1 AND deleted_at IS NULL
    ORDER BY sort_order
  `;

  const [rows] = await pool.query<RowDataPacket[]>(sql, [group.toUpperCase()]);

  return sendSuccess(res, rows, `Code group '${group}' retrieved successfully`);
}));

export default router;
