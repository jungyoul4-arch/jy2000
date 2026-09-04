import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { Student, StudentDetail, StudentListQuery, StudentStateChange, StudentUpdate, StudentCreate, ParentInfo } from '../types';
import { AppError } from '../middlewares/errorHandler';

// 전화번호에서 '-' 제거
const cleanPhone = (phone: string | undefined | null): string | null => {
  if (!phone) return null;
  return phone.replace(/-/g, '');
};

export class StudentService {
  // 학생 신규 등록
  async create(data: StudentCreate, userId: number): Promise<StudentDetail> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 1. User 테이블에 학생 추가 (kind=2, active_flag=0)
      // 트리거가 자동으로 student_info 생성
      const userColumns = ['name', 'kind', 'phone', 'user_pw_hash', 'active_flag', 'reg_dt'];
      const userValues = [data.student_name, 2, cleanPhone(data.phone), '', 0];
      const userPlaceholders = ['?', '?', '?', '?', '?', 'NOW()'];

      if (data.grade) {
        userColumns.splice(3, 0, 'grade');
        userValues.splice(3, 0, data.grade);
        userPlaceholders.splice(3, 0, '?');
      }

      const [userResult] = await connection.query<ResultSetHeader>(
        `INSERT INTO User (${userColumns.join(', ')}) VALUES (${userPlaceholders.join(', ')})`,
        userValues
      );

      const studentId = userResult.insertId;

      // 2. student_info 추가 정보 업데이트 (트리거가 기본 레코드 생성)
      const updateFields: string[] = [];
      const updateParams: any[] = [];

      if (data.status_code && data.status_code !== 'STATUS_PROSPECT') {
        updateFields.push('status_code = ?');
        updateParams.push(data.status_code);
      }
      if (data.gender_code) {
        updateFields.push('gender_code = ?');
        updateParams.push(data.gender_code);
      }
      if (data.birth_date) {
        updateFields.push('birth_date = ?');
        updateParams.push(data.birth_date);
      }
      if (data.school_id) {
        updateFields.push('school_id = ?');
        updateParams.push(data.school_id);
      }
      if (data.source_code) {
        updateFields.push('source_code = ?');
        updateParams.push(data.source_code);
      }
      if (data.source_detail) {
        updateFields.push('source_detail = ?');
        updateParams.push(data.source_detail);
      }
      if (data.tc_id) {
        updateFields.push('tc_id = ?');
        updateParams.push(data.tc_id);
      }
      if (data.memo) {
        updateFields.push('memo = ?');
        updateParams.push(data.memo);
      }
      if (data.class_type_code) {
        updateFields.push('class_type_code = ?');
        updateParams.push(data.class_type_code);
      }
      if (data.subject_code) {
        updateFields.push('subject_code = ?');
        updateParams.push(data.subject_code);
      }
      if (data.enroll_start_date) {
        updateFields.push('enroll_start_date = ?');
        updateParams.push(data.enroll_start_date);
      }
      if (data.enroll_end_date) {
        updateFields.push('enroll_end_date = ?');
        updateParams.push(data.enroll_end_date);
      }

      // created_by는 유효한 userId가 있을 때만 설정
      if (userId && userId > 1) {
        updateFields.push('created_by = ?');
        updateParams.push(userId);
      }

      if (updateFields.length > 0) {
        updateParams.push(studentId);
        await connection.query(
          `UPDATE student_info SET ${updateFields.join(', ')} WHERE student_id = ?`,
          updateParams
        );
      }

      // 3. 보호자 정보 추가
      if (data.guardian_phone) {
        const guardianPhoneClean = cleanPhone(data.guardian_phone);

        // 보호자 User 생성 (kind=4)
        const [parentResult] = await connection.query<ResultSetHeader>(
          `INSERT INTO User (name, kind, phone, user_pw_hash, reg_dt)
           VALUES (?, 4, ?, '', NOW())`,
          [data.guardian_name || data.student_name, guardianPhoneClean]
        );

        const parentId = parentResult.insertId;

        // ParentPhone 연결
        await connection.query(
          `INSERT INTO ParentPhone (parent_id, student_id, phone, seq, parent_kind, reg_dt)
           VALUES (?, ?, ?, 1, ?, NOW())`,
          [parentId, studentId, guardianPhoneClean, data.parent_kind || 2]
        );
      }

      await connection.commit();

      return this.getById(studentId);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 학생 목록 조회
  async getList(query: StudentListQuery): Promise<{ data: Student[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 20;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'created_at';
    const order = query.order || 'desc';

    // Build WHERE clause
    const conditions: string[] = ['s.deleted_at IS NULL'];
    const params: any[] = [];

    if (query.status_code) {
      conditions.push('s.status_code = ?');
      params.push(query.status_code);
    }

    if (query.grade) {
      conditions.push('u.grade = ?');
      params.push(query.grade);
    }

    if (query.tc_id) {
      conditions.push('s.tc_id = ?');
      params.push(query.tc_id);
    }

    if (query.school_id) {
      conditions.push('s.school_id = ?');
      params.push(query.school_id);
    }

    if (query.class_type_code) {
      conditions.push('s.class_type_code = ?');
      params.push(query.class_type_code);
    }

    if (query.subject_code) {
      // 비트마스크 필터링: 해당 과목을 포함하는 학생 검색
      conditions.push('(s.subject_code & ?) > 0');
      params.push(query.subject_code);
    }

    if (query.source_code) {
      conditions.push('s.source_code = ?');
      params.push(query.source_code);
    }

    if (query.search) {
      conditions.push('(u.name LIKE ? OR u.phone LIKE ?)');
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    if (query.from_date) {
      conditions.push('s.first_contact_date >= ?');
      params.push(query.from_date);
    }

    if (query.to_date) {
      conditions.push('s.first_contact_date <= ?');
      params.push(query.to_date);
    }

    const whereClause = conditions.join(' AND ');

    // Sort column mapping (API name -> actual column)
    const sortColumnMap: Record<string, string> = {
      'student_id': 's.student_id',
      'student_name': 'u.name',
      'status_code': 's.status_code',
      'created_at': 's.created_at',
      'first_contact_date': 's.first_contact_date',
      'register_date': 's.register_date'
    };
    const sortColumn = sortColumnMap[sort] || 's.created_at';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      WHERE ${whereClause}
    `;

    // Data query
    const dataSql = `
      SELECT
        s.student_id,
        u.name as student_name,
        u.phone,
        u.email,
        s.birth_date,
        s.gender_code,
        g.code_name as gender_name,
        s.school_id,
        sch.school_name,
        u.grade,
        CASE u.grade
          WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
          WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
          WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
          WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
          WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
          ELSE NULL
        END as grade_name,
        p.name as guardian_name,
        pp.phone as guardian_phone,
        CASE pp.parent_kind
          WHEN 1 THEN '부' WHEN 2 THEN '모' WHEN 3 THEN '친척' WHEN 99 THEN '기타'
          ELSE NULL
        END as guardian_relation,
        s.status_code,
        st.code_name as status_name,
        s.sub_status_code,
        sub.code_name as sub_status_name,
        s.class_type_code,
        ct.code_name as class_type_name,
        s.subject_code,
        s.source_code,
        src.code_name as source_name,
        s.tc_id,
        tc.name as tc_name,
        s.first_contact_date,
        s.consult_date,
        s.register_date,
        s.enroll_date,
        s.enroll_start_date,
        s.enroll_end_date,
        s.withdraw_date,
        s.memo,
        s.created_at,
        s.updated_at
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN School sch ON s.school_id = sch.school_id
      LEFT JOIN code_master g ON s.gender_code = g.code_id
      LEFT JOIN code_master st ON s.status_code = st.code_id
      LEFT JOIN code_master sub ON s.sub_status_code = sub.code_id
      LEFT JOIN code_master ct ON s.class_type_code = ct.code_id
      LEFT JOIN code_master src ON s.source_code = src.code_id
      LEFT JOIN User tc ON s.tc_id = tc.user_id
      LEFT JOIN ParentPhone pp ON pp.student_id = s.student_id AND pp.seq = 1
      LEFT JOIN User p ON pp.parent_id = p.user_id
      WHERE ${whereClause}
      ORDER BY ${sortColumn} ${sortOrder}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    return {
      data: rows as Student[],
      total
    };
  }

  // 학생 상세 조회 (보호자 2명 포함)
  async getById(studentId: number): Promise<StudentDetail> {
    const sql = `
      SELECT
        s.student_id,
        u.name as student_name,
        u.phone,
        s.phone_sub,
        u.email,
        s.birth_date,
        s.gender_code,
        g.code_name as gender_name,
        s.school_id,
        sch.school_name,
        u.grade,
        CASE u.grade
          WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
          WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
          WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
          WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
          WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
          ELSE NULL
        END as grade_name,
        s.zip_code,
        s.address,
        s.address_detail,
        s.status_code,
        st.code_name as status_name,
        s.sub_status_code,
        sub.code_name as sub_status_name,
        s.class_type_code,
        ct.code_name as class_type_name,
        s.subject_code,
        s.source_code,
        src.code_name as source_name,
        s.source_detail,
        s.tc_id,
        tc.name as tc_name,
        s.first_contact_date,
        s.consult_date,
        s.register_date,
        s.enroll_date,
        s.enroll_start_date,
        s.enroll_end_date,
        s.withdraw_date,
        s.memo,
        s.created_at,
        s.updated_at
      FROM student_info s
      JOIN User u ON s.student_id = u.user_id
      LEFT JOIN School sch ON s.school_id = sch.school_id
      LEFT JOIN code_master g ON s.gender_code = g.code_id
      LEFT JOIN code_master st ON s.status_code = st.code_id
      LEFT JOIN code_master sub ON s.sub_status_code = sub.code_id
      LEFT JOIN code_master ct ON s.class_type_code = ct.code_id
      LEFT JOIN code_master src ON s.source_code = src.code_id
      LEFT JOIN User tc ON s.tc_id = tc.user_id
      WHERE s.student_id = ? AND s.deleted_at IS NULL
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [studentId]);

    if (rows.length === 0) {
      throw new AppError('Student not found', 404);
    }

    const student = rows[0] as StudentDetail;

    // 보호자 정보 조회 (최대 2명)
    const parentSql = `
      SELECT
        pp.parent_id,
        pp.phone,
        pp.seq,
        pp.parent_kind,
        p.name
      FROM ParentPhone pp
      JOIN User p ON pp.parent_id = p.user_id
      WHERE pp.student_id = ?
      ORDER BY pp.seq
      LIMIT 2
    `;
    const [parentRows] = await pool.query<RowDataPacket[]>(parentSql, [studentId]);
    student.parents = parentRows as ParentInfo[];

    // 기존 호환성을 위해 첫 번째 보호자 정보도 설정
    if (student.parents && student.parents.length > 0) {
      const firstParent = student.parents[0];
      student.guardian_name = firstParent.name;
      student.guardian_phone = firstParent.phone;
      student.guardian_relation = ['', '부', '모', '친척'][firstParent.parent_kind] || '기타';
    }

    return student;
  }

  // 학생 정보 업데이트
  async update(data: StudentUpdate, userId: number): Promise<StudentDetail> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 학생 존재 확인
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT student_id FROM student_info WHERE student_id = ? AND deleted_at IS NULL',
        [data.student_id]
      );

      if (existing.length === 0) {
        throw new AppError('Student not found', 404);
      }

      // User 테이블 업데이트 (이름, 전화번호, 이메일, 학년)
      if (data.student_name || data.phone || data.email !== undefined || data.grade !== undefined) {
        const userUpdates: string[] = [];
        const userParams: any[] = [];

        if (data.student_name) {
          userUpdates.push('name = ?');
          userParams.push(data.student_name);
        }
        if (data.phone) {
          userUpdates.push('phone = ?');
          userParams.push(cleanPhone(data.phone));
        }
        if (data.email !== undefined) {
          userUpdates.push('email = ?');
          userParams.push(data.email || null);
        }
        if (data.grade !== undefined) {
          userUpdates.push('grade = ?');
          userParams.push(data.grade);
        }

        if (userUpdates.length > 0) {
          userParams.push(data.student_id);
          await connection.query(
            `UPDATE User SET ${userUpdates.join(', ')}, updated_at = NOW() WHERE user_id = ?`,
            userParams
          );
        }
      }

      // student_info 테이블 업데이트
      const infoUpdates: string[] = ['updated_at = NOW()'];
      const infoParams: any[] = [];

      // updated_by는 유효한 userId가 있을 때만 설정
      if (userId && userId > 1) {
        infoUpdates.push('updated_by = ?');
        infoParams.push(userId);
      }

      if (data.birth_date !== undefined) {
        infoUpdates.push('birth_date = ?');
        infoParams.push(data.birth_date || null);
      }
      if (data.gender_code !== undefined) {
        infoUpdates.push('gender_code = ?');
        infoParams.push(data.gender_code || null);
      }
      if (data.school_id !== undefined) {
        infoUpdates.push('school_id = ?');
        infoParams.push(data.school_id || null);
      }
      if (data.zip_code !== undefined) {
        infoUpdates.push('zip_code = ?');
        infoParams.push(data.zip_code || null);
      }
      if (data.address !== undefined) {
        infoUpdates.push('address = ?');
        infoParams.push(data.address || null);
      }
      if (data.address_detail !== undefined) {
        infoUpdates.push('address_detail = ?');
        infoParams.push(data.address_detail || null);
      }
      if (data.memo !== undefined) {
        infoUpdates.push('memo = ?');
        infoParams.push(data.memo || null);
      }
      if (data.class_type_code !== undefined) {
        infoUpdates.push('class_type_code = ?');
        infoParams.push(data.class_type_code || null);
      }
      if (data.subject_code !== undefined) {
        infoUpdates.push('subject_code = ?');
        infoParams.push(data.subject_code || null);
      }
      if (data.source_code !== undefined) {
        infoUpdates.push('source_code = ?');
        infoParams.push(data.source_code || null);
      }
      if (data.enroll_start_date !== undefined) {
        infoUpdates.push('enroll_start_date = ?');
        infoParams.push(data.enroll_start_date || null);
      }
      if (data.enroll_end_date !== undefined) {
        infoUpdates.push('enroll_end_date = ?');
        infoParams.push(data.enroll_end_date || null);
      }

      infoParams.push(data.student_id);
      await connection.query(
        `UPDATE student_info SET ${infoUpdates.join(', ')} WHERE student_id = ?`,
        infoParams
      );

      // 보호자 정보 업데이트
      if (data.parents && data.parents.length > 0) {
        // 학생 이름 조회 (보호자 User 생성 시 사용)
        const [studentUser] = await connection.query<RowDataPacket[]>(
          'SELECT name FROM User WHERE user_id = ?',
          [data.student_id]
        );
        const studentName = studentUser[0]?.name || '학생';

        for (const parent of data.parents) {
          if (!parent.phone) continue; // 전화번호 필수

          const parentPhoneClean = cleanPhone(parent.phone);

          if (parent.parent_id) {
            // 기존 보호자 업데이트
            await connection.query(
              `UPDATE ParentPhone SET phone = ?, parent_kind = ? WHERE parent_id = ? AND student_id = ?`,
              [parentPhoneClean, parent.parent_kind, parent.parent_id, data.student_id]
            );
            // User 테이블의 전화번호도 업데이트
            await connection.query(
              `UPDATE User SET phone = ?, updated_at = NOW() WHERE user_id = ?`,
              [parentPhoneClean, parent.parent_id]
            );
          } else {
            // 새 보호자 추가
            // 먼저 해당 전화번호로 기존 User가 있는지 확인
            const [existingUser] = await connection.query<RowDataPacket[]>(
              'SELECT user_id FROM User WHERE phone = ?',
              [parentPhoneClean]
            );

            let newParentId: number;

            if (existingUser.length > 0) {
              // 기존 User 사용
              newParentId = existingUser[0].user_id;
            } else {
              // 1. User 테이블에 추가 (kind=4: 학부모)
              const [userResult] = await connection.query<ResultSetHeader>(
                `INSERT INTO User (name, kind, phone, user_pw_hash, reg_dt) VALUES (?, 4, ?, '', NOW())`,
                [studentName, parentPhoneClean]
              );
              newParentId = userResult.insertId;
            }

            // 2. ParentPhone 테이블에 추가 (이미 존재하면 업데이트)
            await connection.query(
              `INSERT INTO ParentPhone (parent_id, student_id, phone, seq, parent_kind, reg_dt)
               VALUES (?, ?, ?, ?, ?, NOW())
               ON DUPLICATE KEY UPDATE phone = VALUES(phone), seq = VALUES(seq), parent_kind = VALUES(parent_kind)`,
              [newParentId, data.student_id, parentPhoneClean, parent.seq, parent.parent_kind]
            );
          }
        }
      }

      await connection.commit();

      return this.getById(data.student_id);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 보호자 삭제
  async deleteParent(studentId: number, parentId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // ParentPhone에서 삭제
      await connection.query(
        'DELETE FROM ParentPhone WHERE parent_id = ? AND student_id = ?',
        [parentId, studentId]
      );

      // User 테이블에서도 삭제 (해당 보호자가 다른 학생과 연결되어 있지 않은 경우)
      const [otherLinks] = await connection.query<RowDataPacket[]>(
        'SELECT COUNT(*) as cnt FROM ParentPhone WHERE parent_id = ?',
        [parentId]
      );

      if (otherLinks[0].cnt === 0) {
        await connection.query('DELETE FROM User WHERE user_id = ? AND kind = 4', [parentId]);
      }

      await connection.commit();
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 학생 상태 변경
  async changeState(data: StudentStateChange, userId: number): Promise<Student> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // Check if student exists
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT student_id, status_code, sub_status_code, tc_id FROM student_info WHERE student_id = ? AND deleted_at IS NULL',
        [data.student_id]
      );

      if (existing.length === 0) {
        throw new AppError('Student not found', 404);
      }

      const currentStudent = existing[0];

      // Update student status
      const updateSql = `
        UPDATE student_info
        SET
          status_code = ?,
          sub_status_code = ?,
          tc_id = COALESCE(?, tc_id),
          updated_by = ?,
          updated_at = NOW()
        WHERE student_id = ?
      `;

      await connection.query<ResultSetHeader>(updateSql, [
        data.new_status_code,
        data.new_sub_status_code || null,
        data.new_tc_id || null,
        userId,
        data.student_id
      ]);

      // Insert history (trigger handles status change, but we add reason here)
      if (data.change_reason) {
        const historySql = `
          UPDATE student_history
          SET change_reason = ?
          WHERE student_id = ?
          AND changed_at = (
            SELECT MAX(changed_at) FROM (
              SELECT changed_at FROM student_history WHERE student_id = ?
            ) as t
          )
        `;
        await connection.query(historySql, [data.change_reason, data.student_id, data.student_id]);
      }

      await connection.commit();

      // Return updated student
      return this.getById(data.student_id);

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 학생 삭제 (soft delete)
  async delete(studentId: number, userId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 학생 존재 확인
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT student_id FROM student_info WHERE student_id = ? AND deleted_at IS NULL',
        [studentId]
      );

      if (existing.length === 0) {
        throw new AppError('Student not found', 404);
      }

      // student_info soft delete
      await connection.query(
        'UPDATE student_info SET deleted_at = NOW(), updated_by = ? WHERE student_id = ?',
        [userId, studentId]
      );

      // User 테이블도 삭제
      await connection.query(
        'DELETE FROM User WHERE user_id = ? AND kind = 2',
        [studentId]
      );

      // 연관된 보호자 연결 삭제 (ParentPhone)
      await connection.query(
        'DELETE FROM ParentPhone WHERE student_id = ?',
        [studentId]
      );

      await connection.commit();

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  // 학생 변동 내역 조회
  async getHistory(studentId: number): Promise<any[]> {
    const sql = `
      SELECT
        h.history_id,
        h.student_id,
        h.prev_status_code,
        ps.code_name as prev_status_name,
        h.new_status_code,
        ns.code_name as new_status_name,
        h.prev_sub_status,
        pss.code_name as prev_sub_status_name,
        h.new_sub_status,
        nss.code_name as new_sub_status_name,
        h.change_type_code,
        ct.code_name as change_type_name,
        h.change_reason_code,
        cr.code_name as change_reason_name,
        h.change_reason,
        h.prev_tc_id,
        ptc.name as prev_tc_name,
        h.new_tc_id,
        ntc.name as new_tc_name,
        h.changed_by,
        cb.name as changed_by_name,
        h.changed_at
      FROM student_history h
      LEFT JOIN code_master ps ON h.prev_status_code = ps.code_id
      LEFT JOIN code_master ns ON h.new_status_code = ns.code_id
      LEFT JOIN code_master pss ON h.prev_sub_status = pss.code_id
      LEFT JOIN code_master nss ON h.new_sub_status = nss.code_id
      LEFT JOIN code_master ct ON h.change_type_code = ct.code_id
      LEFT JOIN code_master cr ON h.change_reason_code = cr.code_id
      LEFT JOIN User ptc ON h.prev_tc_id = ptc.user_id
      LEFT JOIN User ntc ON h.new_tc_id = ntc.user_id
      LEFT JOIN User cb ON h.changed_by = cb.user_id
      WHERE h.student_id = ?
      ORDER BY h.changed_at DESC
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [studentId]);
    return rows;
  }

  // 학생 완전 삭제 (hard delete) - 관리자 전용
  async hardDelete(studentId: number): Promise<void> {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // 학생 존재 확인 (soft deleted 포함)
      const [existing] = await connection.query<RowDataPacket[]>(
        'SELECT student_id FROM student_info WHERE student_id = ?',
        [studentId]
      );

      if (existing.length === 0) {
        throw new AppError('Student not found', 404);
      }

      // 1. 상담 첨부파일 삭제
      await connection.query(
        'DELETE ca FROM consult_attachment ca JOIN consult c ON ca.consult_id = c.consult_id WHERE c.student_id = ?',
        [studentId]
      );

      // 2. 상담 기록 삭제
      await connection.query(
        'DELETE FROM consult WHERE student_id = ?',
        [studentId]
      );

      // 3. 학생 상태 변경 이력 삭제
      await connection.query(
        'DELETE FROM student_history WHERE student_id = ?',
        [studentId]
      );

      // 4. 학생-프로모션 연결 삭제
      await connection.query(
        'DELETE FROM student_promotion WHERE student_id = ?',
        [studentId]
      );

      // 5. 이전 학원 정보 삭제
      await connection.query(
        'DELETE FROM former_academy WHERE student_id = ?',
        [studentId]
      );

      // 6. 보호자 연결 삭제 및 고아 보호자 정리
      const [parents] = await connection.query<RowDataPacket[]>(
        'SELECT parent_id FROM ParentPhone WHERE student_id = ?',
        [studentId]
      );

      await connection.query(
        'DELETE FROM ParentPhone WHERE student_id = ?',
        [studentId]
      );

      // 다른 학생과 연결되지 않은 보호자 삭제
      for (const parent of parents) {
        const [otherLinks] = await connection.query<RowDataPacket[]>(
          'SELECT COUNT(*) as cnt FROM ParentPhone WHERE parent_id = ?',
          [parent.parent_id]
        );
        if (otherLinks[0].cnt === 0) {
          await connection.query(
            'DELETE FROM User WHERE user_id = ? AND kind = 4',
            [parent.parent_id]
          );
        }
      }

      // 7. student_info 삭제
      await connection.query(
        'DELETE FROM student_info WHERE student_id = ?',
        [studentId]
      );

      // 8. User 삭제
      await connection.query(
        'DELETE FROM User WHERE user_id = ? AND kind = 2',
        [studentId]
      );

      await connection.commit();

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

export default new StudentService();
