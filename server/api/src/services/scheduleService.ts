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

/**
 * DB에서 읽은 DATE 값(Date 객체 또는 문자열)을 'YYYY-MM-DD' 문자열로 정규화
 */
function toDateString(value: any): string {
  if (value instanceof Date) {
    const year = value.getFullYear();
    const month = (value.getMonth() + 1).toString().padStart(2, '0');
    const day = value.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  return String(value).substring(0, 10);
}

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
        DATE_FORMAT(event_date, '%Y-%m-%d') as event_date,
        event_minute,
        content,
        is_important,
        student_id,
        student_name,
        student_phone,
        student_grade,
        grade_name,
        school_name,
        consult_id,
        DATE_FORMAT(consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
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
        DATE_FORMAT(event_date, '%Y-%m-%d') as event_date,
        event_minute,
        content,
        is_important,
        student_id,
        student_name,
        student_phone,
        student_grade,
        grade_name,
        school_name,
        consult_id,
        DATE_FORMAT(consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
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

      // 카테고리 정보 조회 (분 허용 여부 / 시간대 추출용)
      const [categoryRows] = await connection.query<RowDataPacket[]>(
        'SELECT category_name, category_type FROM schedule_category WHERE category_id = ?',
        [data.category_id]
      );
      const category = categoryRows[0];

      // 분 지정은 시간대(TIME_SLOT) 카테고리에서만 유효
      const eventMinute =
        category && category.category_type === 'TIME_SLOT' ? data.event_minute || 0 : 0;

      // 학생 연동이 있으면 상담 기록 자동 생성
      if (data.student_id) {
        // 시간대 카테고리인 경우 시간 추출 (예: "2-3" -> 14:00)
        let consultDateTime = data.event_date; // 기본값: 날짜만 (00:00:00)

        if (category && category.category_type === 'TIME_SLOT') {
          const categoryName = category.category_name; // "2-3", "10-11" 등
          const timeMatch = categoryName.match(/^(\d+)-/);

          if (timeMatch) {
            const startHour = parseInt(timeMatch[1], 10);
            // 오후 시간대 처리 (10-11은 그대로, 2-3은 14시)
            const hour24 = startHour < 10 ? startHour + 12 : startHour;
            consultDateTime = `${data.event_date} ${hour24.toString().padStart(2, '0')}:${eventMinute.toString().padStart(2, '0')}:00`;
          }
        }

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
          consultDateTime,
          userId,
          data.content || '(캘린더에서 자동 생성)',
          userId,
        ]);
        consultId = consultResult.insertId;
      }

      // 일정 등록
      const eventSql = `
        INSERT INTO schedule_event (
          category_id, event_type_id, event_date, event_minute, content, is_important,
          student_id, consult_id, created_by
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;
      const [eventResult] = await connection.query<ResultSetHeader>(eventSql, [
        data.category_id,
        data.event_type_id,
        data.event_date,
        eventMinute,
        data.content,
        data.is_important ? 1 : 0,
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

      // 카테고리 정보 조회 (분 허용 여부 / 시간대 추출용)
      const categoryId = data.category_id !== undefined ? data.category_id : existing.category_id;
      const [categoryRows] = await connection.query<RowDataPacket[]>(
        'SELECT category_name, category_type FROM schedule_category WHERE category_id = ?',
        [categoryId]
      );
      const category = categoryRows[0];
      const isTimeSlot = !!category && category.category_type === 'TIME_SLOT';

      // 분 지정은 시간대(TIME_SLOT) 카테고리에서만 유효
      const eventMinute = isTimeSlot
        ? data.event_minute !== undefined
          ? data.event_minute
          : existing.event_minute || 0
        : 0;

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
      // 카테고리가 바뀌면 시간대 외 카테고리의 분은 0으로 정리
      if (data.event_minute !== undefined || data.category_id !== undefined) {
        updateFields.push('event_minute = ?');
        updateValues.push(eventMinute);
      }
      if (data.content !== undefined) {
        updateFields.push('content = ?');
        updateValues.push(data.content);
      }
      if (data.is_important !== undefined) {
        updateFields.push('is_important = ?');
        updateValues.push(data.is_important ? 1 : 0);
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

        if (data.event_date !== undefined || data.event_minute !== undefined) {
          // 시간대 카테고리인 경우 시간 추출
          const eventDate =
            data.event_date !== undefined ? data.event_date : toDateString(existing.event_date);
          let consultDateTime = eventDate;

          if (isTimeSlot) {
            const categoryName = category.category_name;
            const timeMatch = categoryName.match(/^(\d+)-/);

            if (timeMatch) {
              const startHour = parseInt(timeMatch[1], 10);
              const hour24 = startHour < 10 ? startHour + 12 : startHour;
              consultDateTime = `${eventDate} ${hour24.toString().padStart(2, '0')}:${eventMinute.toString().padStart(2, '0')}:00`;
            }
          }

          consultUpdateFields.push('consult_date = ?');
          consultUpdateValues.push(consultDateTime);
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
