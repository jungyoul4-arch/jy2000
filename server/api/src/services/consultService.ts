import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { Consult, ConsultCreate, ConsultListQuery } from '../types';
import { AppError } from '../middlewares/errorHandler';

// 일정 캘린더 연동 대상 채널
// 전화(CHANNEL_PHONE) -> '전화상담' 카테고리, 방문(CHANNEL_VISIT) -> 시간대 슬롯
const CHANNEL_PHONE = 'CHANNEL_PHONE';
const CHANNEL_VISIT = 'CHANNEL_VISIT';

// 캘린더에 표시되는 상담 시각 범위 (시간대 슬롯 10-11 ~ 9-10)
const CALENDAR_MIN_HOUR = 10;
const CALENDAR_MAX_HOUR = 21;

// 연동 일정의 일정 유형: 1 = 상담 (노란색)
const CONSULT_EVENT_TYPE_ID = 1;

const pad2 = (value: number) => value.toString().padStart(2, '0');

export class ConsultService {
  // ============================================================
  // 일정 캘린더 연동
  // ============================================================

  /**
   * 상담 채널/시각에 해당하는 일정 캘린더 카테고리를 찾는다.
   *
   * - 전화상담: '전화상담' 카테고리 (CONSULT)
   * - 방문상담: 상담 시각에 해당하는 시간대 슬롯 (10-11 ~ 9-10)
   * - 그 외 채널이거나 시각이 10~21시를 벗어나면 null (캘린더에 표시하지 않음)
   */
  private async findCalendarCategory(
    channelCode: string | null | undefined,
    hour: number
  ): Promise<{ category_id: number; category_type: string } | null> {
    if (hour < CALENDAR_MIN_HOUR || hour > CALENDAR_MAX_HOUR) {
      return null;
    }

    if (channelCode === CHANNEL_PHONE) {
      const [rows] = await pool.query<RowDataPacket[]>(
        `SELECT category_id, category_type FROM schedule_category
         WHERE category_type = 'CONSULT' AND deleted_at IS NULL AND is_active = 1
         ORDER BY sort_order ASC LIMIT 1`
      );
      return rows.length > 0 ? (rows[0] as any) : null;
    }

    if (channelCode === CHANNEL_VISIT) {
      // 시간대 슬롯 카테고리에서 시작 시각이 일치하는 것을 찾는다 ("2-3" -> 14시)
      const [rows] = await pool.query<RowDataPacket[]>(
        `SELECT category_id, category_name, category_type FROM schedule_category
         WHERE category_type = 'TIME_SLOT' AND deleted_at IS NULL AND is_active = 1
         ORDER BY sort_order ASC`
      );

      for (const row of rows) {
        const timeMatch = String(row.category_name).match(/^(\d+)-/);
        if (!timeMatch) continue;

        const startHour = parseInt(timeMatch[1], 10);
        const hour24 = startHour < 10 ? startHour + 12 : startHour;

        if (hour24 === hour) {
          return { category_id: row.category_id, category_type: row.category_type };
        }
      }
    }

    return null;
  }

  /**
   * 상담 기록을 일정 캘린더에 반영한다 (등록/수정 공용).
   *
   * 이미 연동된 일정이 있으면 갱신하고, 없으면 새로 만든다.
   * 캘린더 대상이 아닌 상담(채널 미지정, 시각 범위 밖)이면 기존 연동 일정을 삭제한다.
   */
  private async syncToCalendar(consultId: number, userId: number): Promise<void> {
    const [consultRows] = await pool.query<RowDataPacket[]>(
      `SELECT consult_id, student_id, consult_date, channel_code, tc_id, content
       FROM consult WHERE consult_id = ? AND deleted_at IS NULL`,
      [consultId]
    );

    const consult = consultRows[0];
    if (!consult) return;

    const consultDate: Date = consult.consult_date instanceof Date
      ? consult.consult_date
      : new Date(consult.consult_date);

    if (Number.isNaN(consultDate.getTime())) return;

    const hour = consultDate.getHours();
    const minute = consultDate.getMinutes();
    const eventDate = `${consultDate.getFullYear()}-${pad2(consultDate.getMonth() + 1)}-${pad2(consultDate.getDate())}`;

    const category = await this.findCalendarCategory(consult.channel_code, hour);

    // 기존 연동 일정 조회
    const [eventRows] = await pool.query<RowDataPacket[]>(
      'SELECT event_id FROM schedule_event WHERE consult_id = ? AND deleted_at IS NULL',
      [consultId]
    );
    const existingEventId = eventRows[0]?.event_id as number | undefined;

    // 캘린더 대상이 아니면 기존 연동 일정을 정리
    if (!category) {
      if (existingEventId) {
        await pool.query(
          'UPDATE schedule_event SET deleted_at = NOW(), updated_by = ? WHERE event_id = ?',
          [userId, existingEventId]
        );
      }
      return;
    }

    // 전화상담 카테고리는 카테고리명에 시각이 없으므로 event_hour에 저장
    const eventHour = category.category_type === 'CONSULT' ? hour : null;

    if (existingEventId) {
      await pool.query(
        `UPDATE schedule_event
         SET category_id = ?, event_date = ?, event_hour = ?, event_minute = ?,
             content = ?, student_id = ?, tc_id = ?, updated_by = ?
         WHERE event_id = ?`,
        [
          category.category_id,
          eventDate,
          eventHour,
          minute,
          consult.content,
          consult.student_id,
          consult.tc_id,
          userId,
          existingEventId,
        ]
      );
      return;
    }

    await pool.query(
      `INSERT INTO schedule_event (
         category_id, event_type_id, event_date, event_hour, event_minute,
         content, student_id, tc_id, consult_id, created_by
       ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        category.category_id,
        CONSULT_EVENT_TYPE_ID,
        eventDate,
        eventHour,
        minute,
        consult.content,
        consult.student_id,
        consult.tc_id,
        consultId,
        userId,
      ]
    );
  }

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

    // 일정 캘린더에 반영 (전화상담 -> 전화상담 행, 방문상담 -> 시간대 슬롯)
    await this.syncToCalendar(result.insertId, userId);

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

    // 연동된 일정도 함께 갱신
    await this.syncToCalendar(consultId, userId);

    return this.getById(consultId);
  }

  // 상담 삭제 (soft delete, 연동된 일정도 함께 삭제)
  async delete(consultId: number, userId: number): Promise<void> {
    const [consultCheck] = await pool.query<RowDataPacket[]>(
      'SELECT consult_id FROM consult WHERE consult_id = ? AND deleted_at IS NULL',
      [consultId]
    );

    if (consultCheck.length === 0) {
      throw new AppError('Consult not found', 404);
    }

    await pool.query(
      'UPDATE consult SET deleted_at = NOW(), updated_by = ? WHERE consult_id = ?',
      [userId, consultId]
    );

    // 연동된 일정도 soft delete
    await pool.query(
      'UPDATE schedule_event SET deleted_at = NOW(), updated_by = ? WHERE consult_id = ? AND deleted_at IS NULL',
      [userId, consultId]
    );
  }
}

export default new ConsultService();
