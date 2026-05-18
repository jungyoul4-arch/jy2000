// API Response Types
export interface ApiResponse<T = any> {
  success: boolean;
  code: number;
  message: string;
  data?: T;
  meta?: PaginationMeta;
  errors?: ValidationError[];
}

export interface PaginationMeta {
  total: number;
  page: number;
  perPage: number;
  totalPages: number;
}

export interface ValidationError {
  field: string;
  message: string;
}

// Query Parameters
export interface ListQueryParams {
  page?: number;
  perPage?: number;
  sort?: string;
  order?: 'asc' | 'desc';
  search?: string;
}

// Student Types
export interface Student {
  student_id: number;
  student_name: string;
  phone: string;
  phone_sub?: string;
  email?: string;
  birth_date?: string;
  gender_code?: string;
  school_id?: number;
  school_name?: string;
  grade?: number; // 1-6:초, 7-9:중, 10-12:고, 13:N수생, 14:성인
  guardian_name?: string;
  guardian_phone?: string;
  guardian_relation?: string;
  address?: string;
  address_detail?: string;
  status_code: string;
  sub_status_code?: string;
  class_type_code?: string; // 반 유형: CLASS_COMP(종합반), CLASS_SINGLE(단과반), CLASS_SPECIAL(특강), CLASS_ETC(기타)
  class_type_name?: string;
  subject_code?: string; // 과목
  subject_name?: string;
  source_code?: string;
  source_detail?: string;
  tc_id?: number;
  first_contact_date?: string;
  consult_date?: string;
  register_date?: string;
  enroll_date?: string;
  enroll_start_date?: string; // 수강 시작일
  enroll_end_date?: string; // 수강 종료일
  withdraw_date?: string;
  memo?: string;
  created_at?: string;
  updated_at?: string;
}

export interface StudentListQuery extends ListQueryParams {
  status_code?: string;
  grade?: number;
  class_type_code?: string;
  subject_code?: string;
  source_code?: string;
  tc_id?: number;
  school_id?: number;
  from_date?: string;
  to_date?: string;
}

export interface StudentStateChange {
  student_id: number;
  new_status_code: string;
  new_sub_status_code?: string;
  change_reason?: string;
  new_tc_id?: number;
}

// 보호자 정보
export interface ParentInfo {
  parent_id?: number;
  phone: string;
  seq: number;
  parent_kind: number; // 1=부, 2=모, 3=친척, 99=기타
  name?: string;
}

// 학생 상세 (보호자 포함)
export interface StudentDetail extends Student {
  zip_code?: string;
  parents?: ParentInfo[];
}

// 학생 정보 업데이트
export interface StudentUpdate {
  student_id: number;
  student_name?: string;
  phone?: string;
  email?: string;
  birth_date?: string;
  gender_code?: string;
  school_id?: number;
  school_name?: string;
  grade?: number;
  class_type_code?: string;
  subject_code?: string;
  source_code?: string;
  enroll_start_date?: string;
  enroll_end_date?: string;
  zip_code?: string;
  address?: string;
  address_detail?: string;
  memo?: string;
  parents?: ParentInfo[];
}

// 학생 신규 등록
export interface StudentCreate {
  student_name: string;
  phone: string;
  email?: string;
  birth_date?: string;
  gender_code?: string;
  school_id?: number;
  school_name?: string;
  grade?: number;
  class_type_code?: string;
  subject_code?: string;
  status_code?: string;
  source_code?: string;
  source_detail?: string;
  enroll_start_date?: string;
  enroll_end_date?: string;
  tc_id?: number;
  memo?: string;
  guardian_name?: string;
  guardian_phone?: string;
  parent_kind?: number;
}

// Consult Types
export interface Consult {
  consult_id: number;
  student_id: number;
  consult_type_code: string;
  consult_date: string;
  consult_duration?: number;
  channel_code?: string;
  tc_id?: number;
  content?: string;
  student_needs?: string;
  consult_result_code?: string;
  result_detail?: string;
  next_action_code?: string;
  next_action_detail?: string;
  next_consult_date?: string;
  interest_subject?: string;
  interest_program?: string;
}

export interface ConsultCreate {
  student_id: number;
  consult_type_code: string;
  consult_date: string;
  consult_duration?: number;
  channel_code?: string;
  tc_id?: number;
  content?: string;
  student_needs?: string;
  consult_result_code?: string;
  result_detail?: string;
  next_action_code?: string;
  next_action_detail?: string;
  next_consult_date?: string;
  interest_subject?: string;
  interest_program?: string;
}

export interface ConsultListQuery extends ListQueryParams {
  student_id?: number;
  tc_id?: number;
  consult_type_code?: string;
  consult_result_code?: string;
  from_date?: string;
  to_date?: string;
}

// Promotion Types
export interface Promotion {
  promotion_id: number;
  promotion_name: string;
  promotion_code?: string;
  promotion_type_code?: string;
  start_date: string;
  end_date?: string;
  description?: string;
  discount_type_code?: string;
  discount_value?: number;
  target_grade?: string;
  target_subject?: string;
  is_active: boolean;
}

export interface PromotionCreate {
  promotion_name: string;
  promotion_code?: string;
  promotion_type_code?: string;
  start_date: string;
  end_date?: string;
  description?: string;
  discount_type_code?: string;
  discount_value?: number;
  target_grade?: string;
  target_subject?: string;
}

// TC Types
export interface TC {
  tc_id: number;
  user_id?: number;
  tc_name: string;
  tc_code?: string;
  phone?: string;
  email?: string;
  tc_type_code?: string;
  branch_code?: string;
  hire_date?: string;
  is_active: boolean;
}

export interface TCCreate {
  user_id?: number;
  tc_name: string;
  tc_code?: string;
  phone?: string;
  email?: string;
  tc_type_code?: string;
  branch_code?: string;
  hire_date?: string;
}

// TC User 등록 (User 테이블에 직접 등록)
export interface TCUserCreate {
  phone: string;
  name: string;
}

// Dashboard Types
export interface DashboardKPI {
  total_students: number;
  new_students_this_month: number;
  consults_this_month: number;
  registers_this_month: number;
  enrolled_count: number;
  conversion_rate: number;
}

export interface FunnelData {
  status_code: string;
  status_name: string;
  count: number;
  percentage: number;
}

// Code Master
export interface CodeMaster {
  code_id: string;
  code_group: string;
  code_value: string;
  code_name: string;
  code_name_en?: string;
  parent_code_id?: string;
  sort_order: number;
  is_active: boolean;
}

// School Types
export interface School {
  school_id: number;
  school_name: string;
  school_kind: number; // 1=중학교, 2=고등학교
  region_kind: number; // 1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타
  is_active: boolean;
  created_at?: string;
  updated_at?: string;
}

export interface SchoolCreate {
  school_name: string;
  school_kind: number;
  region_kind: number;
}

export interface SchoolListQuery extends ListQueryParams {
  school_kind?: number;
  region_kind?: number;
}

// Class Types (반 관리)
export interface Class {
  class_id: number;
  class_name: string;
  is_active: number;
  genre_id: number; // 1=국어, 2=수학, 3=영어, 4=과학, 5=사회, 99=기타
  genre_name?: string;
  reg_dt: string;
}

export interface ClassInfo {
  class_id: number;
  grade: number; // 7~12=중1~고3, 14=성인, 99=기타
  curriculum: number; // 1=정시반, 2=특별반
  level: number; // 1=최상위, 2=상위, 3=중위, 4=기초, 99=기타
  year: number;
  term_start?: string;
  term_end?: string;
  lecture_date1?: string;
  lecture_date2?: string;
  lecture_date3?: string;
  lecture_date4?: string;
  lecture_date5?: string;
  monthly_fee?: number;
}

export interface ClassMember {
  user_id: number;
  class_id: number;
  kind: number; // 2=학생, 3=선생님
  active_flag: number;
  user_name?: string;
  phone?: string;
}

export interface ClassListItem extends Class {
  grade?: number;
  grade_name?: string;
  curriculum?: number;
  level?: number;
  level_name?: string;
  year?: number;
  monthly_fee?: number;
  lecture_dates?: string;
  teachers?: { user_id: number; name: string }[];
}

export interface ClassDetail extends Class {
  info: ClassInfo;
  teachers: ClassMember[];
  students: ClassMember[];
}

export interface LectureDate {
  day: string; // 월, 화, 수, 목, 금, 토, 일
  start_time: number; // 0~12
  end_time?: number;
}

export interface ClassCreate {
  genre_id: number;
  grade: number;
  curriculum: number;
  level: number;
  year: number;
  term_start?: string;
  term_end?: string;
  lecture_dates: LectureDate[];
  teacher_ids: number[];
  monthly_fee?: number;
  class_name?: string;
}

export interface ClassUpdate {
  genre_id?: number;
  grade?: number;
  curriculum?: number;
  level?: number;
  year?: number;
  term_start?: string;
  term_end?: string;
  lecture_dates?: LectureDate[];
  teacher_ids?: number[];
  student_ids?: number[];
  monthly_fee?: number;
  is_active?: number;
  class_name?: string;
}

export interface ClassListQuery extends ListQueryParams {
  genre_id?: number;
  grade?: number;
  level?: number;
  year?: number;
  is_active?: number;
}
