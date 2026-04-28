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
  school_name?: string;
  grade_code?: string;
  guardian_name?: string;
  guardian_phone?: string;
  guardian_relation?: string;
  address?: string;
  address_detail?: string;
  status_code: string;
  sub_status_code?: string;
  source_code?: string;
  source_detail?: string;
  tc_id?: number;
  first_contact_date?: string;
  consult_date?: string;
  register_date?: string;
  enroll_date?: string;
  withdraw_date?: string;
  memo?: string;
  created_at?: string;
  updated_at?: string;
}

export interface StudentListQuery extends ListQueryParams {
  status_code?: string;
  grade_code?: string;
  tc_id?: number;
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
