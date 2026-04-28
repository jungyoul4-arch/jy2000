import pool from '../config/database';
import { RowDataPacket } from 'mysql2';
import { DashboardKPI, FunnelData } from '../types';

export class DashboardService {
  // KPI 데이터 조회
  async getKPI(): Promise<DashboardKPI> {
    const currentMonth = new Date().toISOString().slice(0, 7); // YYYY-MM

    // Total students
    const [totalResult] = await pool.query<RowDataPacket[]>(
      'SELECT COUNT(*) as count FROM student_info WHERE deleted_at IS NULL'
    );

    // New students this month
    const [newStudentsResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM student_info
       WHERE deleted_at IS NULL
       AND DATE_FORMAT(created_at, '%Y-%m') = ?`,
      [currentMonth]
    );

    // Consults this month
    const [consultsResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM consult
       WHERE deleted_at IS NULL
       AND DATE_FORMAT(consult_date, '%Y-%m') = ?`,
      [currentMonth]
    );

    // Registers this month
    const [registersResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM student_info
       WHERE deleted_at IS NULL
       AND DATE_FORMAT(register_date, '%Y-%m') = ?`,
      [currentMonth]
    );

    // Currently enrolled
    const [enrolledResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM student_info
       WHERE deleted_at IS NULL
       AND status_code = 'STATUS_ENROLLED'`
    );

    // Conversion rate (consult_done -> registered)
    const [consultDoneResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM student_info
       WHERE deleted_at IS NULL
       AND status_code IN ('STATUS_CONSULT_DONE', 'STATUS_REGISTER', 'STATUS_ENROLLED', 'STATUS_WITHDRAW', 'STATUS_LOST')`
    );

    const [convertedResult] = await pool.query<RowDataPacket[]>(
      `SELECT COUNT(*) as count FROM student_info
       WHERE deleted_at IS NULL
       AND status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED', 'STATUS_WITHDRAW')`
    );

    const consultDoneCount = consultDoneResult[0].count || 0;
    const convertedCount = convertedResult[0].count || 0;
    const conversionRate = consultDoneCount > 0
      ? Math.round((convertedCount / consultDoneCount) * 100 * 10) / 10
      : 0;

    return {
      total_students: totalResult[0].count,
      new_students_this_month: newStudentsResult[0].count,
      consults_this_month: consultsResult[0].count,
      registers_this_month: registersResult[0].count,
      enrolled_count: enrolledResult[0].count,
      conversion_rate: conversionRate
    };
  }

  // 퍼널 데이터 조회
  async getFunnel(): Promise<FunnelData[]> {
    const sql = `
      SELECT
        s.status_code,
        cm.code_name as status_name,
        cm.sort_order,
        COUNT(*) as count
      FROM student_info s
      JOIN code_master cm ON s.status_code = cm.code_id
      WHERE s.deleted_at IS NULL
        AND cm.code_group = 'STATUS'
      GROUP BY s.status_code, cm.code_name, cm.sort_order
      ORDER BY cm.sort_order
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql);

    // Calculate total for percentage
    const total = rows.reduce((sum, row) => sum + Number(row.count), 0);

    return rows.map(row => ({
      status_code: row.status_code,
      status_name: row.status_name,
      count: Number(row.count),
      percentage: total > 0 ? Math.round((Number(row.count) / total) * 100 * 10) / 10 : 0
    }));
  }

  // TC별 실적 조회
  async getTCPerformance(): Promise<any[]> {
    const sql = `
      SELECT
        tc.tc_id,
        tc.tc_name,
        COUNT(DISTINCT s.student_id) as total_students,
        SUM(CASE WHEN s.status_code = 'STATUS_PROSPECT' THEN 1 ELSE 0 END) as prospect_count,
        SUM(CASE WHEN s.status_code = 'STATUS_CONSULT_DONE' THEN 1 ELSE 0 END) as consult_count,
        SUM(CASE WHEN s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED') THEN 1 ELSE 0 END) as register_count,
        COUNT(DISTINCT c.consult_id) as consult_total
      FROM tc_info tc
      LEFT JOIN student_info s ON tc.tc_id = s.tc_id AND s.deleted_at IS NULL
      LEFT JOIN consult c ON tc.tc_id = c.tc_id AND c.deleted_at IS NULL
      WHERE tc.deleted_at IS NULL AND tc.is_active = 1
      GROUP BY tc.tc_id, tc.tc_name
      ORDER BY register_count DESC
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql);

    return rows;
  }

  // 월별 등록 추이
  async getMonthlyTrend(months: number = 6): Promise<any[]> {
    const sql = `
      SELECT
        DATE_FORMAT(register_date, '%Y-%m') as month,
        COUNT(*) as register_count
      FROM student_info
      WHERE deleted_at IS NULL
        AND register_date IS NOT NULL
        AND register_date >= DATE_SUB(CURDATE(), INTERVAL ? MONTH)
      GROUP BY DATE_FORMAT(register_date, '%Y-%m')
      ORDER BY month
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [months]);

    return rows;
  }
}

export default new DashboardService();
