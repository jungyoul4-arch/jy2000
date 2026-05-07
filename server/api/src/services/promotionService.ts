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

  // 설명회 참석자 목록 조회
  async getAttendees(promotionId: number): Promise<any[]> {
    const sql = `
      SELECT
        sp.id,
        sp.student_id,
        u.name as student_name,
        u.phone as student_phone,
        s.school_name,
        u.grade,
        si.status_code,
        cm.code_name as status_name,
        sp.applied_date,
        sp.memo,
        sp.created_at
      FROM student_promotion sp
      JOIN User u ON sp.student_id = u.user_id
      LEFT JOIN student_info si ON sp.student_id = si.student_id
      LEFT JOIN School s ON si.school_id = s.school_id
      LEFT JOIN code_master cm ON si.status_code = cm.code_id
      WHERE sp.promotion_id = ?
      ORDER BY sp.created_at DESC
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [promotionId]);
    return rows;
  }

  // 설명회 참석자 등록 (기존 학생)
  async addAttendee(promotionId: number, studentId: number, userId: number, memo?: string): Promise<any> {
    // 중복 체크
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT id FROM student_promotion WHERE promotion_id = ? AND student_id = ?',
      [promotionId, studentId]
    );

    if (existing.length > 0) {
      throw new AppError('이미 등록된 참석자입니다', 400);
    }

    const sql = `
      INSERT INTO student_promotion (student_id, promotion_id, applied_date, memo, created_by)
      VALUES (?, ?, CURDATE(), ?, ?)
    `;

    const [result] = await pool.query<ResultSetHeader>(sql, [
      studentId,
      promotionId,
      memo || null,
      userId
    ]);

    return { id: result.insertId, student_id: studentId, promotion_id: promotionId };
  }

  // 설명회 참석자 등록 (신규 학생 생성 포함)
  async addNewAttendee(
    promotionId: number,
    studentData: { name: string; phone: string; school_id?: number; grade?: number; memo?: string },
    userId: number
  ): Promise<any> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      let studentId: number;

      // 1. 전화번호로 기존 User 확인
      const [existingUser] = await connection.query<RowDataPacket[]>(
        'SELECT user_id, name FROM User WHERE phone = ?',
        [studentData.phone]
      );

      if (existingUser.length > 0) {
        // 기존 User 사용 (상태 유지)
        studentId = existingUser[0].user_id;

        // 이미 이 설명회에 등록되어 있는지 확인
        const [existingAttendee] = await connection.query<RowDataPacket[]>(
          'SELECT id FROM student_promotion WHERE student_id = ? AND promotion_id = ?',
          [studentId, promotionId]
        );

        if (existingAttendee.length > 0) {
          await connection.rollback();
          throw new AppError('이미 등록된 참석자입니다', 400);
        }

        // 기존 학생: student_info 없으면 생성 (상태는 STATUS_CONTACT)
        const [existingStudentInfo] = await connection.query<RowDataPacket[]>(
          'SELECT student_id FROM student_info WHERE student_id = ?',
          [studentId]
        );

        if (existingStudentInfo.length === 0) {
          await connection.query<ResultSetHeader>(
            `INSERT INTO student_info (student_id, school_id, status_code, created_by, created_at)
             VALUES (?, ?, 'STATUS_CONTACT', ?, NOW())`,
            [studentId, studentData.school_id || null, userId]
          );
        }
      } else {
        // 신규 User 생성 (kind=2: 학생, active_flag=0: 미재원)
        const [userResult] = await connection.query<ResultSetHeader>(
          `INSERT INTO User (name, phone, kind, grade, active_flag, reg_dt) VALUES (?, ?, 2, ?, 0, NOW())`,
          [studentData.name, studentData.phone, studentData.grade || null]
        );
        studentId = userResult.insertId;

        // 신규 학생: student_info 존재 여부 확인 후 생성 (orphan 데이터 대응)
        const [existingInfo] = await connection.query<RowDataPacket[]>(
          'SELECT student_id FROM student_info WHERE student_id = ?',
          [studentId]
        );

        if (existingInfo.length === 0) {
          await connection.query<ResultSetHeader>(
            `INSERT INTO student_info (student_id, school_id, status_code, created_by, created_at)
             VALUES (?, ?, 'STATUS_CONTACT', ?, NOW())`,
            [studentId, studentData.school_id || null, userId]
          );
        }
      }

      // 3. student_promotion 테이블에 등록
      const [spResult] = await connection.query<ResultSetHeader>(
        `INSERT INTO student_promotion (student_id, promotion_id, applied_date, memo, created_by)
         VALUES (?, ?, CURDATE(), ?, ?)`,
        [studentId, promotionId, studentData.memo || null, userId]
      );

      await connection.commit();

      return {
        id: spResult.insertId,
        student_id: studentId,
        promotion_id: promotionId,
        student_name: studentData.name
      };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 설명회 참석자 삭제
  async removeAttendee(promotionId: number, attendeeId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 1. student_promotion에서 student_id 조회
      const [spRecord] = await connection.query<RowDataPacket[]>(
        'SELECT student_id FROM student_promotion WHERE id = ? AND promotion_id = ?',
        [attendeeId, promotionId]
      );

      if (spRecord.length === 0) {
        await connection.rollback();
        return;
      }

      const studentId = spRecord[0].student_id;

      // 2. student_info 상태 확인
      const [studentInfo] = await connection.query<RowDataPacket[]>(
        'SELECT status_code FROM student_info WHERE student_id = ?',
        [studentId]
      );

      // 3. student_promotion에서 삭제
      await connection.query<ResultSetHeader>(
        'DELETE FROM student_promotion WHERE id = ? AND promotion_id = ?',
        [attendeeId, promotionId]
      );

      // 4. STATUS_CONTACT인 경우 관련 테이블 모두 삭제
      if (studentInfo.length > 0 && studentInfo[0].status_code === 'STATUS_CONTACT') {
        // 다른 설명회에 등록되어 있는지 확인
        const [otherPromotions] = await connection.query<RowDataPacket[]>(
          'SELECT id FROM student_promotion WHERE student_id = ?',
          [studentId]
        );

        // 다른 설명회에 없으면 완전 삭제
        if (otherPromotions.length === 0) {
          // ParentPhone 삭제
          await connection.query<ResultSetHeader>(
            'DELETE FROM ParentPhone WHERE student_id = ?',
            [studentId]
          );

          // student_info 삭제
          await connection.query<ResultSetHeader>(
            'DELETE FROM student_info WHERE student_id = ?',
            [studentId]
          );

          // User 삭제
          await connection.query<ResultSetHeader>(
            'DELETE FROM User WHERE user_id = ? AND kind = 2',
            [studentId]
          );
        }
      }

      await connection.commit();
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // User 테이블에서 학생 검색 (이름 또는 전화번호)
  async searchUsers(query: string): Promise<any[]> {
    const searchTerm = `%${query}%`;
    const sql = `
      SELECT
        u.user_id,
        u.name,
        u.phone,
        u.grade,
        s.school_name,
        si.status_code,
        cm.code_name as status_name
      FROM User u
      LEFT JOIN student_info si ON u.user_id = si.student_id AND si.deleted_at IS NULL
      LEFT JOIN School s ON si.school_id = s.school_id
      LEFT JOIN code_master cm ON si.status_code = cm.code_id
      WHERE u.kind = 2
        AND (u.name LIKE ? OR u.phone LIKE ?)
      ORDER BY u.name
      LIMIT 20
    `;
    const [rows] = await pool.query<RowDataPacket[]>(sql, [searchTerm, searchTerm]);
    return rows;
  }

  // 프로모션 수정
  async update(promotionId: number, data: PromotionCreate): Promise<Promotion> {
    // 존재 여부 확인
    await this.getById(promotionId);

    const sql = `
      UPDATE promotion SET
        promotion_name = ?,
        promotion_code = ?,
        promotion_type_code = ?,
        start_date = ?,
        end_date = ?,
        description = ?,
        discount_type_code = ?,
        discount_value = ?,
        target_grade = ?,
        target_subject = ?,
        updated_at = CURRENT_TIMESTAMP
      WHERE promotion_id = ? AND deleted_at IS NULL
    `;

    await pool.query<ResultSetHeader>(sql, [
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
      promotionId
    ]);

    return this.getById(promotionId);
  }
}

export default new PromotionService();
