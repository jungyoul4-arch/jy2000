import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { PoolConnection } from 'mysql2/promise';
import {
  ScheduleCategory,
  ScheduleEventType,
  ScheduleEvent,
  ScheduleEventCreate,
  ScheduleEventUpdate,
  ScheduleEventListQuery,
} from '../types';
import { AppError } from '../middlewares/errorHandler';

// 상담자가 될 수 없는 사용자 유형 (2=학생, 4=학부모)
const TC_BLOCKED_KINDS = [2, 4];

// 상담 유형 미지정 시 기본값 (code_master: CONSULT_TYPE 그룹)
const DEFAULT_CONSULT_TYPE_CODE = 'CONSULT_TYPE_INITIAL';

// 시각(시/분)을 사용하는 카테고리 유형
// TIME_SLOT: 카테고리명(10-11 등)에서 시를 유도, CONSULT(전화상담): event_hour에 직접 저장
const TIME_AWARE_CATEGORY_TYPES = ['TIME_SLOT', 'CONSULT'];

/**
 * 카테고리와 요청값으로 일정의 시(hour, 24시간제)를 결정한다.
 * 시각 개념이 없는 카테고리면 null.
 */
function resolveEventHour(
  category: RowDataPacket | undefined,
  requestedHour?: number | null
): number | null {
  if (!category) return null;

  if (category.category_type === 'TIME_SLOT') {
    // "2-3" -> 14시, "10-11" -> 10시
    const timeMatch = String(category.category_name).match(/^(\d+)-/);
    if (!timeMatch) return null;

    const startHour = parseInt(timeMatch[1], 10);
    return startHour < 10 ? startHour + 12 : startHour;
  }

  if (category.category_type === 'CONSULT') {
    return requestedHour ?? null;
  }

  return null;
}

const pad2 = (value: number) => value.toString().padStart(2, '0');

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
  /**
   * 상담자 검증 및 기본값 처리.
   * 학생(kind=2) / 학부모(kind=4)는 상담자가 될 수 없고, 지정이 없으면 요청 사용자를 사용한다.
   */
  private async resolveTcId(
    connection: { query: PoolConnection['query'] },
    tcId: number | undefined | null,
    fallbackUserId: number
  ): Promise<number> {
    if (!tcId) {
      return fallbackUserId;
    }

    const [rows] = await connection.query<RowDataPacket[]>(
      'SELECT user_id, kind FROM User WHERE user_id = ? AND active_flag = 1',
      [tcId]
    );

    const user = rows[0];

    if (!user) {
      throw new AppError('상담자를 찾을 수 없습니다', 400);
    }

    if (TC_BLOCKED_KINDS.includes(Number(user.kind))) {
      throw new AppError('학생/학부모는 상담자로 지정할 수 없습니다', 400);
    }

    return Number(user.user_id);
  }

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
        event_hour,
        event_minute,
        content,
        is_important,
        student_id,
        student_name,
        student_phone,
        student_grade,
        grade_name,
        school_name,
        tc_id,
        tc_name,
        consult_id,
        DATE_FORMAT(consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
        consult_type_code,
        consult_type_name,
        created_by,
        created_by_name,
        updated_by,
        updated_by_name,
        created_at,
        updated_at
      FROM v_schedule_event_detail
      ${whereClause}
      ORDER BY event_date ASC, category_id ASC, event_hour ASC, event_minute ASC
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
        event_hour,
        event_minute,
        content,
        is_important,
        student_id,
        student_name,
        student_phone,
        student_grade,
        grade_name,
        school_name,
        tc_id,
        tc_name,
        consult_id,
        DATE_FORMAT(consult_date, '%Y-%m-%d %H:%i:%s') as consult_date,
        consult_type_code,
        consult_type_name,
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

      const categoryType = category?.category_type;
      const isTimeAware = TIME_AWARE_CATEGORY_TYPES.includes(categoryType);

      // 분 지정은 시각을 쓰는 카테고리(시간대 슬롯, 전화상담)에서만 유효
      const eventMinute = isTimeAware ? data.event_minute || 0 : 0;

      // 전화상담 등 카테고리명에 시각이 없는 경우만 event_hour를 저장한다
      const eventHour = categoryType === 'CONSULT' ? data.event_hour ?? null : null;
      const resolvedHour = resolveEventHour(category, eventHour);

      // 상담자: 지정하지 않으면 등록한 사용자
      const tcId = await this.resolveTcId(connection, data.tc_id, userId);

      // 학생 연동이 있으면 상담 기록 자동 생성
      if (data.student_id) {
        // 시각을 알 수 있으면 상담일시에 반영 (예: "2-3" -> 14:00)
        let consultDateTime = data.event_date; // 기본값: 날짜만 (00:00:00)

        if (resolvedHour !== null) {
          consultDateTime = `${data.event_date} ${pad2(resolvedHour)}:${pad2(eventMinute)}:00`;
        }

        // 상담 유형: 일정 등록 화면에서 선택한 값 (미지정 시 초기상담)
        const consultTypeCode = data.consult_type_code || DEFAULT_CONSULT_TYPE_CODE;

        // 상담 채널: 전화상담 카테고리는 전화, 시간대 슬롯은 방문
        const channelCode = categoryType === 'CONSULT' ? 'CHANNEL_PHONE' : 'CHANNEL_VISIT';

        const consultSql = `
          INSERT INTO consult (
            student_id, consult_type_code, consult_date, channel_code, tc_id, content, created_by
          ) VALUES (?, ?, ?, ?, ?, ?, ?)
        `;
        const [consultResult] = await connection.query<ResultSetHeader>(consultSql, [
          data.student_id,
          consultTypeCode,
          consultDateTime,
          channelCode,
          tcId,
          data.content || '(캘린더에서 자동 생성)',
          userId,
        ]);
        consultId = consultResult.insertId;
      }

      // 일정 등록
      const eventSql = `
        INSERT INTO schedule_event (
          category_id, event_type_id, event_date, event_hour, event_minute, content, is_important,
          student_id, tc_id, consult_id, created_by
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;
      const [eventResult] = await connection.query<ResultSetHeader>(eventSql, [
        data.category_id,
        data.event_type_id,
        data.event_date,
        eventHour,
        eventMinute,
        data.content,
        data.is_important ? 1 : 0,
        data.student_id || null,
        tcId,
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
      const categoryType = category?.category_type;
      const isTimeAware = TIME_AWARE_CATEGORY_TYPES.includes(categoryType);

      // 분 지정은 시각을 쓰는 카테고리(시간대 슬롯, 전화상담)에서만 유효
      const eventMinute = isTimeAware
        ? data.event_minute !== undefined
          ? data.event_minute
          : existing.event_minute || 0
        : 0;

      // 전화상담 등 카테고리명에 시각이 없는 경우만 event_hour를 저장한다
      const eventHour = categoryType === 'CONSULT'
        ? data.event_hour !== undefined
          ? data.event_hour
          : existing.event_hour ?? null
        : null;
      const resolvedHour = resolveEventHour(category, eventHour);

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
      // 카테고리가 바뀌면 시각을 쓰지 않는 카테고리의 시/분은 정리
      if (data.event_minute !== undefined || data.category_id !== undefined) {
        updateFields.push('event_minute = ?');
        updateValues.push(eventMinute);
      }
      if (data.event_hour !== undefined || data.category_id !== undefined) {
        updateFields.push('event_hour = ?');
        updateValues.push(eventHour);
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

      // 상담자 변경
      let tcId: number | null = null;
      if (data.tc_id !== undefined) {
        tcId = await this.resolveTcId(connection, data.tc_id, userId);
        updateFields.push('tc_id = ?');
        updateValues.push(tcId);
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

        if (
          data.event_date !== undefined ||
          data.event_minute !== undefined ||
          data.event_hour !== undefined
        ) {
          const eventDate =
            data.event_date !== undefined ? data.event_date : toDateString(existing.event_date);
          let consultDateTime = eventDate;

          // 시각을 알 수 있으면 상담일시에 반영
          if (resolvedHour !== null) {
            consultDateTime = `${eventDate} ${pad2(resolvedHour)}:${pad2(eventMinute)}:00`;
          }

          consultUpdateFields.push('consult_date = ?');
          consultUpdateValues.push(consultDateTime);
        }
        if (data.content !== undefined) {
          consultUpdateFields.push('content = ?');
          consultUpdateValues.push(data.content);
        }
        if (tcId !== null) {
          consultUpdateFields.push('tc_id = ?');
          consultUpdateValues.push(tcId);
        }
        if (data.consult_type_code !== undefined) {
          consultUpdateFields.push('consult_type_code = ?');
          consultUpdateValues.push(data.consult_type_code);
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
