import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import {
  ScheduleCategory,
  ScheduleEventType,
  ScheduleEvent,
  ScheduleEventCreate,
  ScheduleEventUpdate,
  ScheduleEventListQuery,
} from '../types';
import { AppError } from '../middlewares/errorHandler';

export class ScheduleService {
  // ============================================================
  // 카테고리 관련
  // ============================================================

  /**
   * 카테고리 목록 조회
   */
  async getCategories(): Promise<ScheduleCategory[]> {
    const sql = `
      SELECT
        category_id,
        category_name,
        category_type,
        sort_order,
        is_active
      FROM schedule_category
      WHERE deleted_at IS NULL AND is_active = 1
      ORDER BY sort_order ASC
    `;
    const [rows] = await pool.query<RowDataPacket[]>(sql);
    return rows as ScheduleCategory[];
  }

  // ============================================================
  // 일정 유형 관련
  // ============================================================

  /**
   * 일정 유형 목록 조회
   */
  async getEventTypes(): Promise<ScheduleEventType[]> {
    const sql = `
      SELECT
        event_type_id,
        event_type_name,
        color_code,
        sort_order,
        is_active
      FROM schedule_event_type
      WHERE is_active = 1
      ORDER BY sort_order ASC
    `;
    const [rows] = await pool.query<RowDataPacket[]>(sql);
    return rows as ScheduleEventType[];
  }

  // ============================================================
  // 일정 이벤트 관련
  // ============================================================

  /**
   * 일정 목록 조회 (뷰 사용)
   */
  async getEvents(query: ScheduleEventListQuery): Promise<{ data: ScheduleEvent[]; total: number }> {
    const conditions: string[] = [];
    const params: any[] = [];

    // 날짜 범위 필터 (필수)
    if (query.from_date) {
      conditions.push('event_date >= ?');
      params.push(query.from_date);
    }
    if (query.to_date) {
      conditions.push('event_date <= ?');
      params.push(query.to_date);
    }

    // 선택적 필터
    if (query.category_id) {
      conditions.push('category_id = ?');
      params.push(query.category_id);
    }
    if (query.event_type_id) {
      conditions.push('event_type_id = ?');
      params.push(query.event_type_id);
    }
    if (query.student_id) {
      conditions.push('student_id = ?');
      params.push(query.student_id);
    }
    if (query.created_by) {
      conditions.push('created_by = ?');
      params.push(query.created_by);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // 전체 개수 조회
    const countSql = `SELECT COUNT(*) as total FROM v_schedule_event_detail ${whereClause}`;
    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    // 데이터 조회
    const page = query.page || 1;
    const perPage = query.perPage || 1000; // 캘린더이므로 기본값 높게
    const offset = (page - 1) * perPage;

    const dataSql = `
      SELECT
        event_id,
        category_id,
        category_name,
        category_type,
        event_type_id,
        event_type_name,
        color_code,
        event_date,
        content,
        student_id,
        student_name,
        student_phone,
        consult_id,
        created_by,
        created_by_name,
        updated_by,
        updated_by_name,
        created_at,
        updated_at
      FROM v_schedule_event_detail
      ${whereClause}
      ORDER BY event_date ASC, category_id ASC
      LIMIT ? OFFSET ?
    `;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);
    return { data: rows as ScheduleEvent[], total };
  }

  /**
   * 일정 상세 조회
   */
  async getEventById(eventId: number): Promise<ScheduleEvent> {
    const sql = `
      SELECT
        event_id,
        category_id,
        category_name,
        category_type,
        event_type_id,
        event_type_name,
        color_code,
        event_date,
        content,
        student_id,
        student_name,
        student_phone,
        consult_id,
        created_by,
        created_by_name,
        updated_by,
        updated_by_name,
        created_at,
        updated_at
      FROM v_schedule_event_detail
      WHERE event_id = ?
    `;
    const [rows] = await pool.query<RowDataPacket[]>(sql, [eventId]);

    if (rows.length === 0) {
      throw new AppError('일정을 찾을 수 없습니다', 404);
    }

    return rows[0] as ScheduleEvent;
  }

  /**
   * 일정 등록 (학생 연동 시 상담 기록도 자동 생성)
   */
  async createEvent(data: ScheduleEventCreate, userId: number): Promise<ScheduleEvent> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      let consultId: number | null = null;

      // 학생 연동이 있으면 상담 기록 자동 생성
      if (data.student_id) {
        // 일정 유형에 따른 상담 유형 매핑
        const eventTypeToConsultType: { [key: number]: string } = {
          1: 'CONSULT_PHONE',    // 상담 -> 전화상담
          2: 'CONSULT_VISIT',    // 설명회 -> 방문상담
          3: 'CONSULT_PHONE',    // 수납/결제 -> 전화상담
          4: 'CONSULT_PHONE',    // 행정 -> 전화상담
          5: 'CONSULT_PHONE',    // 기타 -> 전화상담
        };

        const consultTypeCode = eventTypeToConsultType[data.event_type_id] || 'CONSULT_PHONE';

        const consultSql = `
          INSERT INTO consult (
            student_id, consult_type_code, consult_date, tc_id, content, created_by
          ) VALUES (?, ?, ?, ?, ?, ?)
        `;
        const [consultResult] = await connection.query<ResultSetHeader>(consultSql, [
          data.student_id,
          consultTypeCode,
          data.event_date,
          userId,
          data.content || '(캘린더에서 자동 생성)',
          userId,
        ]);
        consultId = consultResult.insertId;
      }

      // 일정 등록
      const eventSql = `
        INSERT INTO schedule_event (
          category_id, event_type_id, event_date, content, student_id, consult_id, created_by
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
      `;
      const [eventResult] = await connection.query<ResultSetHeader>(eventSql, [
        data.category_id,
        data.event_type_id,
        data.event_date,
        data.content,
        data.student_id || null,
        consultId,
        userId,
      ]);

      await connection.commit();

      // 생성된 일정 조회 후 반환
      return this.getEventById(eventResult.insertId);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * 일정 수정 (학생 연동 상담 기록도 함께 수정)
   */
  async updateEvent(eventId: number, data: ScheduleEventUpdate, userId: number): Promise<ScheduleEvent> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 기존 일정 조회
      const [existingRows] = await connection.query<RowDataPacket[]>(
        'SELECT * FROM schedule_event WHERE event_id = ? AND deleted_at IS NULL',
        [eventId]
      );

      if (existingRows.length === 0) {
        throw new AppError('일정을 찾을 수 없습니다', 404);
      }

      const existing = existingRows[0];

      // 일정 업데이트
      const updateFields: string[] = [];
      const updateValues: any[] = [];

      if (data.category_id !== undefined) {
        updateFields.push('category_id = ?');
        updateValues.push(data.category_id);
      }
      if (data.event_type_id !== undefined) {
        updateFields.push('event_type_id = ?');
        updateValues.push(data.event_type_id);
      }
      if (data.event_date !== undefined) {
        updateFields.push('event_date = ?');
        updateValues.push(data.event_date);
      }
      if (data.content !== undefined) {
        updateFields.push('content = ?');
        updateValues.push(data.content);
      }
      if (data.student_id !== undefined) {
        updateFields.push('student_id = ?');
        updateValues.push(data.student_id || null);
      }

      updateFields.push('updated_by = ?');
      updateValues.push(userId);

      if (updateFields.length > 1) {
        const updateSql = `UPDATE schedule_event SET ${updateFields.join(', ')} WHERE event_id = ?`;
        await connection.query(updateSql, [...updateValues, eventId]);
      }

      // 연동된 상담 기록 업데이트
      if (existing.consult_id) {
        const consultUpdateFields: string[] = [];
        const consultUpdateValues: any[] = [];

        if (data.event_date !== undefined) {
          consultUpdateFields.push('consult_date = ?');
          consultUpdateValues.push(data.event_date);
        }
        if (data.content !== undefined) {
          consultUpdateFields.push('content = ?');
          consultUpdateValues.push(data.content);
        }

        if (consultUpdateFields.length > 0) {
          consultUpdateFields.push('updated_by = ?');
          consultUpdateValues.push(userId);

          const consultUpdateSql = `UPDATE consult SET ${consultUpdateFields.join(', ')} WHERE consult_id = ?`;
          await connection.query(consultUpdateSql, [...consultUpdateValues, existing.consult_id]);
        }
      }

      await connection.commit();

      return this.getEventById(eventId);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * 일정 삭제 (soft delete, 연동된 상담 기록도 함께 삭제)
   */
  async deleteEvent(eventId: number, userId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 기존 일정 조회
      const [existingRows] = await connection.query<RowDataPacket[]>(
        'SELECT * FROM schedule_event WHERE event_id = ? AND deleted_at IS NULL',
        [eventId]
      );

      if (existingRows.length === 0) {
        throw new AppError('일정을 찾을 수 없습니다', 404);
      }

      const existing = existingRows[0];

      // 일정 soft delete
      await connection.query(
        'UPDATE schedule_event SET deleted_at = NOW(), updated_by = ? WHERE event_id = ?',
        [userId, eventId]
      );

      // 연동된 상담 기록도 soft delete
      if (existing.consult_id) {
        await connection.query(
          'UPDATE consult SET deleted_at = NOW(), updated_by = ? WHERE consult_id = ?',
          [userId, existing.consult_id]
        );
      }

      await connection.commit();
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new ScheduleService();
