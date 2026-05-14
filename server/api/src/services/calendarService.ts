import pool from '../config/database';
import { RowDataPacket } from 'mysql2';

export interface CalendarEvent {
  id: number;
  type: 'consult' | 'next_consult' | 'promotion';
  date: string;
  title: string;
  student_id?: number;
  student_name?: string;
  tc_id?: number;
  tc_name?: string;
  promotion_id?: number;
  promotion_name?: string;
}

export class CalendarService {
  // 월별 캘린더 이벤트 조회
  async getMonthlyEvents(year: number, month: number): Promise<CalendarEvent[]> {
    const startDate = `${year}-${String(month).padStart(2, '0')}-01`;
    // 해당 월의 마지막 날 계산 (다음 달 1일에서 하루 빼기)
    const lastDay = new Date(year, month, 0).getDate();
    const endDate = `${year}-${String(month).padStart(2, '0')}-${String(lastDay).padStart(2, '0')}`;

    const events: CalendarEvent[] = [];

    // 1. 상담 일정 조회 (consult_date 기준)
    // tc_id가 없으면 created_by(등록자)를 표시
    const consultSql = `
      SELECT
        c.consult_id as id,
        'consult' as type,
        DATE_FORMAT(c.consult_date, '%Y-%m-%d') as date,
        c.student_id,
        u.name as student_name,
        COALESCE(c.tc_id, c.created_by) as tc_id,
        COALESCE(tc.name, cb.name) as tc_name
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      LEFT JOIN User cb ON c.created_by = cb.user_id
      WHERE c.deleted_at IS NULL
        AND DATE(c.consult_date) >= ?
        AND DATE(c.consult_date) <= ?
      ORDER BY c.consult_date
    `;
    const [consultRows] = await pool.query<RowDataPacket[]>(consultSql, [startDate, endDate]);

    for (const row of consultRows) {
      events.push({
        id: row.id,
        type: 'consult',
        date: row.date,
        title: `${row.student_name}-${row.tc_name}`,
        student_id: row.student_id,
        student_name: row.student_name,
        tc_id: row.tc_id,
        tc_name: row.tc_name,
      });
    }

    // 2. 다음 상담 일정 조회 (next_consult_date 기준)
    // tc_id가 없으면 created_by(등록자)를 표시
    const nextConsultSql = `
      SELECT
        c.consult_id as id,
        'next_consult' as type,
        DATE_FORMAT(c.next_consult_date, '%Y-%m-%d') as date,
        c.student_id,
        u.name as student_name,
        COALESCE(c.tc_id, c.created_by) as tc_id,
        COALESCE(tc.name, cb.name) as tc_name
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      LEFT JOIN User cb ON c.created_by = cb.user_id
      WHERE c.deleted_at IS NULL
        AND c.next_consult_date IS NOT NULL
        AND DATE(c.next_consult_date) >= ?
        AND DATE(c.next_consult_date) <= ?
      ORDER BY c.next_consult_date
    `;
    const [nextConsultRows] = await pool.query<RowDataPacket[]>(nextConsultSql, [startDate, endDate]);

    for (const row of nextConsultRows) {
      events.push({
        id: row.id,
        type: 'next_consult',
        date: row.date,
        title: `${row.student_name}-${row.tc_name}`,
        student_id: row.student_id,
        student_name: row.student_name,
        tc_id: row.tc_id,
        tc_name: row.tc_name,
      });
    }

    // 3. 설명회 일정 조회 (start_date 기준)
    const promotionSql = `
      SELECT
        p.promotion_id as id,
        'promotion' as type,
        DATE_FORMAT(p.start_date, '%Y-%m-%d') as date,
        p.promotion_name
      FROM promotion p
      WHERE p.deleted_at IS NULL
        AND DATE(p.start_date) >= ?
        AND DATE(p.start_date) <= ?
      ORDER BY p.start_date
    `;
    const [promotionRows] = await pool.query<RowDataPacket[]>(promotionSql, [startDate, endDate]);

    for (const row of promotionRows) {
      events.push({
        id: row.id,
        type: 'promotion',
        date: row.date,
        title: '설명회',
        promotion_id: row.id,
        promotion_name: row.promotion_name,
      });
    }

    return events;
  }

  // 특정 날짜의 이벤트 조회
  async getDailyEvents(date: string): Promise<CalendarEvent[]> {
    const events: CalendarEvent[] = [];

    // 1. 상담 일정
    // tc_id가 없으면 created_by(등록자)를 표시
    const consultSql = `
      SELECT
        c.consult_id as id,
        'consult' as type,
        DATE_FORMAT(c.consult_date, '%Y-%m-%d') as date,
        c.student_id,
        u.name as student_name,
        COALESCE(c.tc_id, c.created_by) as tc_id,
        COALESCE(tc.name, cb.name) as tc_name,
        c.consult_type_code,
        ct.code_name as consult_type_name
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      LEFT JOIN User cb ON c.created_by = cb.user_id
      LEFT JOIN code_master ct ON c.consult_type_code = ct.code_id
      WHERE c.deleted_at IS NULL
        AND DATE(c.consult_date) = ?
      ORDER BY c.consult_date
    `;
    const [consultRows] = await pool.query<RowDataPacket[]>(consultSql, [date]);

    for (const row of consultRows) {
      events.push({
        id: row.id,
        type: 'consult',
        date: row.date,
        title: `${row.student_name}-${row.tc_name}`,
        student_id: row.student_id,
        student_name: row.student_name,
        tc_id: row.tc_id,
        tc_name: row.tc_name,
      });
    }

    // 2. 다음 상담 일정
    // tc_id가 없으면 created_by(등록자)를 표시
    const nextConsultSql = `
      SELECT
        c.consult_id as id,
        'next_consult' as type,
        DATE_FORMAT(c.next_consult_date, '%Y-%m-%d') as date,
        c.student_id,
        u.name as student_name,
        COALESCE(c.tc_id, c.created_by) as tc_id,
        COALESCE(tc.name, cb.name) as tc_name
      FROM consult c
      JOIN student_info s ON c.student_id = s.student_id
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN User tc ON c.tc_id = tc.user_id
      LEFT JOIN User cb ON c.created_by = cb.user_id
      WHERE c.deleted_at IS NULL
        AND c.next_consult_date IS NOT NULL
        AND DATE(c.next_consult_date) = ?
      ORDER BY c.next_consult_date
    `;
    const [nextConsultRows] = await pool.query<RowDataPacket[]>(nextConsultSql, [date]);

    for (const row of nextConsultRows) {
      events.push({
        id: row.id,
        type: 'next_consult',
        date: row.date,
        title: `${row.student_name}-${row.tc_name}`,
        student_id: row.student_id,
        student_name: row.student_name,
        tc_id: row.tc_id,
        tc_name: row.tc_name,
      });
    }

    // 3. 설명회 일정
    const promotionSql = `
      SELECT
        p.promotion_id as id,
        'promotion' as type,
        DATE_FORMAT(p.start_date, '%Y-%m-%d') as date,
        p.promotion_name
      FROM promotion p
      WHERE p.deleted_at IS NULL
        AND DATE(p.start_date) = ?
      ORDER BY p.start_date
    `;
    const [promotionRows] = await pool.query<RowDataPacket[]>(promotionSql, [date]);

    for (const row of promotionRows) {
      events.push({
        id: row.id,
        type: 'promotion',
        date: row.date,
        title: '설명회',
        promotion_id: row.id,
        promotion_name: row.promotion_name,
      });
    }

    return events;
  }
}

export default new CalendarService();
