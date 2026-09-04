import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import {
  Consult,
  ConsultCreate,
  ConsultListQuery,
  InquiryStudentLookup,
  NewInquiryCreate,
  NewInquiryResult,
  NEW_INQUIRY_CONSULT_TYPE_CODE,
} from '../types';
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

// 전화번호에서 '-' 제거
const cleanPhone = (phone: string | undefined | null): string | null => {
  if (!phone) return null;
  const cleaned = phone.replace(/-/g, '').trim();
  return cleaned.length > 0 ? cleaned : null;
};

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
        c.inquiry_source_code,
        isc.code_name as inquiry_source_name,
        c.tc_id,
        tc.name as tc_name,
        c.selector_name,
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
      LEFT JOIN code_master isc ON c.inquiry_source_code = isc.code_id
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
        inquiry_source_code,
        tc_id,
        selector_name,
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
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(sql, [
      data.student_id,
      data.consult_type_code,
      data.consult_date,
      data.consult_duration || null,
      data.channel_code || null,
      data.inquiry_source_code || null,
      data.tc_id || null,
      data.selector_name || null,
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
        c.inquiry_source_code,
        isc.code_name as inquiry_source_name,
        c.tc_id,
        tc.name as tc_name,
        c.selector_name,
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
      LEFT JOIN code_master isc ON c.inquiry_source_code = isc.code_id
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
    if (data.inquiry_source_code !== undefined) {
      updateFields.push('inquiry_source_code = ?');
      updateValues.push(data.inquiry_source_code);
    }
    if (data.tc_id !== undefined) {
      updateFields.push('tc_id = ?');
      updateValues.push(data.tc_id);
    }
    if (data.selector_name !== undefined) {
      updateFields.push('selector_name = ?');
      updateValues.push(data.selector_name);
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

  // ============================================================
  // 신규생 문의 (상담 유형 CONSULT_TYPE_INITIAL)
  // ============================================================

  /**
   * 신규생 문의 작성 화면의 학생 타입어헤드.
   *
   * kind=2(학생)를 active_flag 상관없이 찾는다. 아직 등록 전인 문의 학생은
   * active_flag=0으로 저장되므로 이 조건이 없으면 재문의 시 찾을 수 없다.
   * 화면 자동 채움에 필요한 학교/학년/성별/과목/학부모 연락처를 함께 반환한다.
   */
  async lookupInquiryStudents(search: string): Promise<InquiryStudentLookup[]> {
    const searchTerm = `%${search}%`;

    const sql = `
      SELECT
        u.user_id AS student_id,
        u.name AS student_name,
        u.phone,
        u.active_flag,
        u.grade,
        s.gender_code,
        s.school_id,
        COALESCE(sch.school_name, s.school_name) AS school_name,
        s.subject_code,
        pp.phone AS guardian_phone
      FROM User u
      LEFT JOIN student_info s ON s.student_id = u.user_id AND s.deleted_at IS NULL
      LEFT JOIN School sch ON s.school_id = sch.school_id
      LEFT JOIN ParentPhone pp ON pp.student_id = u.user_id AND pp.seq = 1
      WHERE u.kind = 2
        AND u.deleted_at IS NULL
        AND (u.name LIKE ? OR u.phone LIKE ?)
      ORDER BY u.active_flag DESC, u.name ASC
      LIMIT 30
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [searchTerm, searchTerm]);
    return rows as InquiryStudentLookup[];
  }

  /**
   * 신규생 문의 등록.
   *
   * 기존 학생이 아니면 User(kind=2, active_flag=0)를 만들고,
   * 학부모 연락처가 있으면 User(kind=4, active_flag=0) + ParentPhone도 만든다.
   * 상담 유형은 항상 '신규생 문의'(CONSULT_TYPE_INITIAL)로 기록한다.
   */
  async createNewInquiry(
    data: NewInquiryCreate,
    userId: number
  ): Promise<NewInquiryResult> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      const studentPhone = cleanPhone(data.student_phone);
      const guardianPhone = cleanPhone(data.guardian_phone);

      let studentId = data.student_id ?? null;
      let isNewStudent = false;

      // User.phone은 NOT NULL UNIQUE(로그인 ID)다
      if (!studentPhone) {
        throw new AppError('학생 연락처를 입력해 주세요.', 400);
      }

      if (studentId === null) {
        // 같은 번호의 User가 이미 있으면 INSERT가 중복키로 실패한다.
        // 원인을 알 수 있게 미리 막는다.
        const [dup] = await connection.query<RowDataPacket[]>(
          'SELECT u.user_id, u.name, u.kind FROM User u WHERE u.phone = ? LIMIT 1',
          [studentPhone]
        );
        if (dup.length > 0) {
          throw new AppError(
            `이미 등록된 연락처입니다 (${dup[0].name}). 학생 이름 칸에서 검색해 선택해 주세요.`,
            409
          );
        }

        // 신규 학생: 아직 등록 전이므로 active_flag=0.
        // 트리거(trg_user_student_insert)가 student_info를 자동 생성한다.
        const [userResult] = await connection.query<ResultSetHeader>(
          `INSERT INTO User (name, kind, grade, phone, user_pw_hash, active_flag, reg_dt)
           VALUES (?, 2, ?, ?, '', 0, NOW())`,
          [data.student_name, data.grade ?? null, studentPhone]
        );
        studentId = userResult.insertId;
        isNewStudent = true;
      } else {
        // 기존 학생: 화면에서 고친 이름/학년/연락처를 반영한다.
        // active_flag는 재원 상태이므로 문의 등록으로 바꾸지 않는다.
        const userFields: string[] = ['name = ?'];
        const userValues: any[] = [data.student_name];

        if (data.grade !== undefined) {
          userFields.push('grade = ?');
          userValues.push(data.grade ?? null);
        }
        // 다른 사람이 쓰는 번호로는 바꿀 수 없다 (UNIQUE). 그럴 땐 번호만 두고 넘어간다.
        const [phoneOwner] = await connection.query<RowDataPacket[]>(
          'SELECT user_id FROM User WHERE phone = ? AND user_id <> ? LIMIT 1',
          [studentPhone, studentId]
        );
        if (phoneOwner.length === 0) {
          userFields.push('phone = ?');
          userValues.push(studentPhone);
        }

        userValues.push(studentId);
        await connection.query(
          `UPDATE User SET ${userFields.join(', ')} WHERE user_id = ?`,
          userValues
        );
      }

      // student_info 보강 (트리거가 만든 레코드 또는 기존 레코드를 갱신)
      const infoFields: string[] = [];
      const infoValues: any[] = [];

      if (data.gender_code) {
        infoFields.push('gender_code = ?');
        infoValues.push(data.gender_code);
      }
      if (data.school_id) {
        infoFields.push('school_id = ?');
        infoValues.push(data.school_id);
      } else if (data.school_name) {
        // 학교 목록에 없는 학교는 이름만 저장
        infoFields.push('school_name = ?');
        infoValues.push(data.school_name);
      }
      if (data.subject_code) {
        infoFields.push('subject_code = ?');
        infoValues.push(data.subject_code);
      }
      if (userId && userId > 1) {
        infoFields.push(isNewStudent ? 'created_by = ?' : 'updated_by = ?');
        infoValues.push(userId);
      }

      if (infoFields.length > 0) {
        infoValues.push(studentId);
        await connection.query(
          `UPDATE student_info SET ${infoFields.join(', ')} WHERE student_id = ?`,
          infoValues
        );
      }

      // 학부모: 같은 번호가 이미 연결돼 있으면 다시 만들지 않는다
      let guardianCreated = false;
      if (guardianPhone) {
        const [existing] = await connection.query<RowDataPacket[]>(
          'SELECT parent_id FROM ParentPhone WHERE student_id = ? AND phone = ?',
          [studentId, guardianPhone]
        );

        if (existing.length === 0) {
          // User.phone은 UNIQUE다. 형제자매가 이미 등록돼 있으면 같은 번호의
          // 학부모 User가 존재하므로 새로 만들지 않고 그 User를 재사용한다.
          const [existingUser] = await connection.query<RowDataPacket[]>(
            'SELECT user_id FROM User WHERE phone = ? LIMIT 1',
            [guardianPhone]
          );

          let parentId: number;
          if (existingUser.length > 0) {
            parentId = existingUser[0].user_id;
          } else {
            const [parentResult] = await connection.query<ResultSetHeader>(
              `INSERT INTO User (name, kind, phone, user_pw_hash, active_flag, reg_dt)
               VALUES (?, 4, ?, '', 0, NOW())`,
              [`${data.student_name} 학부모`, guardianPhone]
            );
            parentId = parentResult.insertId;
            guardianCreated = true;
          }

          const [seqRow] = await connection.query<RowDataPacket[]>(
            'SELECT COALESCE(MAX(seq), 0) + 1 AS next_seq FROM ParentPhone WHERE student_id = ?',
            [studentId]
          );

          await connection.query(
            `INSERT INTO ParentPhone (parent_id, student_id, phone, seq, parent_kind, reg_dt)
             VALUES (?, ?, ?, ?, 2, NOW())`,
            [parentId, studentId, guardianPhone, seqRow[0].next_seq]
          );
        }
      }

      // 상담 등록. 문의 날짜만 받으므로 시각은 00:00:00으로 저장한다.
      const [consultResult] = await connection.query<ResultSetHeader>(
        `INSERT INTO consult (
           student_id, consult_type_code, consult_date, inquiry_source_code,
           tc_id, selector_name, content, interest_subject, created_by
         ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          studentId,
          NEW_INQUIRY_CONSULT_TYPE_CODE,
          `${data.consult_date} 00:00:00`,
          data.inquiry_source_code || null,
          userId || null,
          data.selector_name || null,
          data.content || null,
          data.interest_subject || null,
          userId || null,
        ]
      );

      await connection.commit();

      return {
        consult_id: consultResult.insertId,
        student_id: studentId,
        student_name: data.student_name,
        is_new_student: isNewStudent,
        guardian_created: guardianCreated,
      };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new ConsultService();
