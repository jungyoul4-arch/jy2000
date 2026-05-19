import pool from '../config/database';
import { RowDataPacket, ResultSetHeader } from 'mysql2';
import { AppError } from '../middlewares/errorHandler';

export interface Staff {
  user_id: number;
  name: string;
  kind: number;
  kind_name: string;
  phone: string;
  email?: string;
  first_contact_date?: string;
  reg_dt: string;
  last_login_dt?: string;
  active_flag: number;
}

export interface StaffListQuery {
  page?: number;
  perPage?: number;
  sort?: string;
  order?: 'asc' | 'desc';
  search?: string;
}

export interface StaffCreate {
  name: string;
  phone: string;
  kind: number;
  email?: string;
}

// 전화번호에서 '-' 제거
const cleanPhone = (phone: string | undefined | null): string | null => {
  if (!phone) return null;
  return phone.replace(/-/g, '');
};

// kind 값을 역할명으로 변환
const getKindName = (kind: number): string => {
  switch (kind) {
    case 1: return '관리자';
    case 3: return '선생님';
    case 5: return '상담원';
    case 6: return '사감';
    case 7: return '일반직원';
    default: return '알 수 없음';
  }
};

export class StaffService {
  // 직원 목록 조회 (kind IN (1, 3, 5, 6, 7))
  async getList(query: StaffListQuery): Promise<{ data: Staff[]; total: number }> {
    const page = query.page || 1;
    const perPage = query.perPage || 20;
    const offset = (page - 1) * perPage;
    const sort = query.sort || 'name';
    const order = query.order || 'asc';

    // Build WHERE clause
    const conditions: string[] = [
      'kind IN (1, 3, 5, 6, 7)'
    ];
    const params: any[] = [];

    if (query.search) {
      conditions.push('(name LIKE ? OR phone LIKE ?)');
      const searchTerm = `%${query.search}%`;
      params.push(searchTerm, searchTerm);
    }

    const whereClause = conditions.join(' AND ');

    // Sort column mapping
    const sortColumnMap: Record<string, string> = {
      'name': 'name',
      'kind': 'kind',
      'reg_dt': 'reg_dt',
      'last_login_dt': 'last_login_dt'
    };
    const sortColumn = sortColumnMap[sort] || 'name';
    const sortOrder = order === 'desc' ? 'DESC' : 'ASC';

    // 역할순 정렬 시 같은 역할 내에서 이름순으로 2차 정렬
    const orderByClause = sort === 'kind'
      ? `${sortColumn} ${sortOrder}, name ASC`
      : `${sortColumn} ${sortOrder}`;

    // Count query
    const countSql = `
      SELECT COUNT(*) as total
      FROM User
      WHERE ${whereClause}
    `;

    // Data query
    const dataSql = `
      SELECT
        user_id,
        name,
        kind,
        phone,
        email,
        reg_dt,
        last_login_dt,
        active_flag
      FROM User
      WHERE ${whereClause}
      ORDER BY ${orderByClause}
      LIMIT ? OFFSET ?
    `;

    const [countResult] = await pool.query<RowDataPacket[]>(countSql, params);
    const total = countResult[0].total;

    const [rows] = await pool.query<RowDataPacket[]>(dataSql, [...params, perPage, offset]);

    // kind_name 추가
    const data = rows.map(row => ({
      ...row,
      kind_name: getKindName(row.kind)
    })) as Staff[];

    return { data, total };
  }

  // 직원 상세 조회
  async getById(userId: number): Promise<Staff> {
    const sql = `
      SELECT
        user_id,
        name,
        kind,
        phone,
        email,
        reg_dt,
        last_login_dt,
        active_flag
      FROM User
      WHERE user_id = ? AND kind IN (1, 3, 5, 6, 7)
    `;

    const [rows] = await pool.query<RowDataPacket[]>(sql, [userId]);

    if (rows.length === 0) {
      throw new AppError('Staff not found', 404);
    }

    const staff = rows[0] as Staff;
    staff.kind_name = getKindName(staff.kind);

    return staff;
  }

  // 직원 등록
  async create(data: StaffCreate): Promise<Staff> {
    // 전화번호 중복 확인
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT user_id FROM User WHERE phone = ?',
      [cleanPhone(data.phone)]
    );

    if (existing.length > 0) {
      throw new AppError('Phone number already exists', 400);
    }

    const [result] = await pool.query<ResultSetHeader>(
      `INSERT INTO User (name, kind, phone, email, user_pw_hash, active_flag, reg_dt)
       VALUES (?, ?, ?, '', '', 1, NOW())`,
      [data.name, data.kind, cleanPhone(data.phone)]
    );

    return this.getById(result.insertId);
  }

  // 직원 수정
  async update(userId: number, data: Partial<StaffCreate>): Promise<Staff> {
    // 직원 존재 확인
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT user_id FROM User WHERE user_id = ? AND kind IN (1, 3, 5, 6, 7)',
      [userId]
    );

    if (existing.length === 0) {
      throw new AppError('Staff not found', 404);
    }

    // 전화번호 중복 확인 (자신 제외)
    if (data.phone) {
      const [phoneExists] = await pool.query<RowDataPacket[]>(
        'SELECT user_id FROM User WHERE phone = ? AND user_id != ?',
        [cleanPhone(data.phone), userId]
      );

      if (phoneExists.length > 0) {
        throw new AppError('Phone number already exists', 400);
      }
    }

    const updates: string[] = ['updated_at = NOW()'];
    const params: any[] = [];

    if (data.name) {
      updates.push('name = ?');
      params.push(data.name);
    }
    if (data.phone) {
      updates.push('phone = ?');
      params.push(cleanPhone(data.phone));
    }
    if (data.kind) {
      updates.push('kind = ?');
      params.push(data.kind);
    }

    params.push(userId);

    await pool.query(
      `UPDATE User SET ${updates.join(', ')} WHERE user_id = ?`,
      params
    );

    return this.getById(userId);
  }

  // 직원 활성/비활성 토글
  async toggleActive(userId: number): Promise<Staff> {
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT user_id, active_flag FROM User WHERE user_id = ? AND kind IN (1, 3, 5, 6, 7)',
      [userId]
    );

    if (existing.length === 0) {
      throw new AppError('Staff not found', 404);
    }

    const newActiveFlag = existing[0].active_flag === 1 ? 0 : 1;

    await pool.query(
      'UPDATE User SET active_flag = ?, updated_at = NOW() WHERE user_id = ?',
      [newActiveFlag, userId]
    );

    return this.getById(userId);
  }

  // 직원 삭제 (hard delete)
  async delete(userId: number): Promise<void> {
    const [existing] = await pool.query<RowDataPacket[]>(
      'SELECT user_id FROM User WHERE user_id = ? AND kind IN (1, 3, 5, 6, 7)',
      [userId]
    );

    if (existing.length === 0) {
      throw new AppError('Staff not found', 404);
    }

    await pool.query(
      'DELETE FROM User WHERE user_id = ?',
      [userId]
    );
  }
}

export default new StaffService();
