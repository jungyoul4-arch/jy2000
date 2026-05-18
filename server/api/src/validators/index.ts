import { body, param, query, ValidationChain } from 'express-validator';

// Common Validators
export const validateId = (paramName: string = 'id'): ValidationChain => {
  return param(paramName)
    .isInt({ min: 1 })
    .withMessage(`${paramName} must be a positive integer`);
};

export const validatePagination: ValidationChain[] = [
  query('page')
    .optional()
    .isInt({ min: 1 })
    .withMessage('page must be a positive integer'),
  query('perPage')
    .optional()
    .isInt({ min: 1, max: 1000 })
    .withMessage('perPage must be between 1 and 1000'),
  query('sort')
    .optional()
    .isString()
    .trim(),
  query('order')
    .optional()
    .isIn(['asc', 'desc'])
    .withMessage('order must be asc or desc')
];

// Student Validators
export const validateStudentStateChange: ValidationChain[] = [
  body('student_id')
    .isInt({ min: 1 })
    .withMessage('student_id is required and must be a positive integer'),
  body('new_status_code')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('new_status_code is required'),
  body('new_sub_status_code')
    .optional()
    .isString()
    .trim(),
  body('change_reason')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 1000 })
    .withMessage('change_reason must be less than 1000 characters'),
  body('new_tc_id')
    .optional()
    .isInt({ min: 1 })
    .withMessage('new_tc_id must be a positive integer')
];

export const validateStudentListQuery: ValidationChain[] = [
  ...validatePagination,
  query('status_code')
    .optional()
    .isString()
    .trim(),
  query('grade')
    .optional()
    .isInt({ min: 1, max: 14 })
    .withMessage('grade must be between 1 and 14'),
  query('class_type_code')
    .optional()
    .isString()
    .trim(),
  query('subject_code')
    .optional()
    .isInt({ min: 0 })
    .withMessage('subject_code must be an integer'),
  query('source_code')
    .optional()
    .isString()
    .trim(),
  query('tc_id')
    .optional()
    .isInt({ min: 1 }),
  query('school_id')
    .optional()
    .isInt({ min: 1 }),
  query('search')
    .optional()
    .isString()
    .trim(),
  query('from_date')
    .optional()
    .isISO8601()
    .withMessage('from_date must be a valid date'),
  query('to_date')
    .optional()
    .isISO8601()
    .withMessage('to_date must be a valid date')
];

export const validateStudentCreate: ValidationChain[] = [
  body('student_name')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('student_name is required')
    .isLength({ min: 1, max: 50 }),
  body('phone')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('phone is required'),
  body('email')
    .optional({ nullable: true })
    .isEmail()
    .withMessage('email must be a valid email'),
  body('birth_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('birth_date must be a valid date'),
  body('gender_code')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('school_id')
    .optional({ nullable: true })
    .isInt({ min: 1 }),
  body('school_name')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('grade')
    .optional({ nullable: true })
    .isInt({ min: 1, max: 14 }),
  body('status_code')
    .optional()
    .isString()
    .trim(),
  body('source_code')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('class_type_code')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('subject_code')
    .optional({ nullable: true })
    .isInt({ min: 0 }),
  body('enroll_start_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('enroll_start_date must be a valid date'),
  body('enroll_end_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('enroll_end_date must be a valid date'),
  body('tc_id')
    .optional({ nullable: true })
    .isInt({ min: 1 }),
  body('memo')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('guardian_name')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('guardian_phone')
    .optional({ nullable: true })
    .isString()
    .trim(),
  body('parent_kind')
    .optional({ nullable: true })
    .isInt({ min: 1, max: 99 })
];

export const validateStudentUpdate: ValidationChain[] = [
  body('student_name')
    .optional()
    .isString()
    .trim()
    .isLength({ min: 1, max: 50 }),
  body('phone')
    .optional()
    .isString()
    .trim(),
  body('email')
    .optional()
    .isEmail()
    .withMessage('email must be a valid email'),
  body('birth_date')
    .optional()
    .isISO8601()
    .withMessage('birth_date must be a valid date'),
  body('gender_code')
    .optional()
    .isString()
    .trim(),
  body('school_id')
    .optional()
    .isInt({ min: 1 }),
  body('school_name')
    .optional()
    .isString()
    .trim(),
  body('grade')
    .optional()
    .isInt({ min: 1, max: 14 }),
  body('class_type_code')
    .optional()
    .isString()
    .trim(),
  body('subject_code')
    .optional()
    .isInt({ min: 0 })
    .withMessage('subject_code must be an integer'),
  body('source_code')
    .optional()
    .isString()
    .trim(),
  body('enroll_start_date')
    .optional()
    .isISO8601()
    .withMessage('enroll_start_date must be a valid date'),
  body('enroll_end_date')
    .optional()
    .isISO8601()
    .withMessage('enroll_end_date must be a valid date'),
  body('zip_code')
    .optional()
    .isString()
    .trim(),
  body('address')
    .optional()
    .isString()
    .trim(),
  body('address_detail')
    .optional()
    .isString()
    .trim(),
  body('memo')
    .optional()
    .isString()
    .trim(),
  body('parents')
    .optional()
    .isArray()
    .withMessage('parents must be an array'),
  body('parents.*.phone')
    .optional()
    .isString()
    .trim(),
  body('parents.*.seq')
    .optional()
    .isInt({ min: 1, max: 2 }),
  body('parents.*.parent_kind')
    .optional()
    .isInt({ min: 1, max: 99 })
];

// Consult Validators
export const validateConsultCreate: ValidationChain[] = [
  body('student_id')
    .isInt({ min: 1 })
    .withMessage('student_id is required'),
  body('consult_type_code')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('consult_type_code is required'),
  body('consult_date')
    .isISO8601()
    .withMessage('consult_date must be a valid datetime'),
  body('consult_duration')
    .optional()
    .isInt({ min: 1, max: 480 })
    .withMessage('consult_duration must be between 1 and 480 minutes'),
  body('channel_code')
    .optional()
    .isString()
    .trim(),
  body('tc_id')
    .optional()
    .isInt({ min: 1 }),
  body('content')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 5000 }),
  body('student_needs')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 2000 }),
  body('consult_result_code')
    .optional()
    .isString()
    .trim(),
  body('next_action_code')
    .optional()
    .isString()
    .trim(),
  body('next_consult_date')
    .optional()
    .isISO8601()
    .withMessage('next_consult_date must be a valid datetime'),
  body('interest_subject')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 200 })
];

export const validateConsultListQuery: ValidationChain[] = [
  ...validatePagination,
  query('student_id')
    .optional()
    .isInt({ min: 1 }),
  query('tc_id')
    .optional()
    .isInt({ min: 1 }),
  query('consult_type_code')
    .optional()
    .isString()
    .trim(),
  query('consult_result_code')
    .optional()
    .isString()
    .trim(),
  query('from_date')
    .optional()
    .isISO8601(),
  query('to_date')
    .optional()
    .isISO8601()
];

// Promotion Validators
export const validatePromotionCreate: ValidationChain[] = [
  body('promotion_name')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('promotion_name is required')
    .isLength({ max: 200 }),
  body('promotion_code')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 50 }),
  body('promotion_type_code')
    .optional()
    .isString()
    .trim(),
  body('start_date')
    .isISO8601()
    .withMessage('start_date is required and must be a valid date'),
  body('end_date')
    .optional()
    .isISO8601()
    .withMessage('end_date must be a valid date'),
  body('description')
    .optional()
    .isString()
    .trim(),
  body('discount_type_code')
    .optional()
    .isString()
    .trim(),
  body('discount_value')
    .optional()
    .isFloat({ min: 0 })
    .withMessage('discount_value must be a positive number'),
  body('target_grade')
    .optional()
    .isString()
    .trim(),
  body('target_subject')
    .optional()
    .isString()
    .trim()
];

// School Validators
export const validateSchoolCreate: ValidationChain[] = [
  body('school_name')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('school_name is required')
    .isLength({ max: 100 })
    .custom((value) => {
      if (!value.endsWith('중') && !value.endsWith('고')) {
        throw new Error('학교명은 "중" 또는 "고"로 끝나야 합니다');
      }
      return true;
    }),
  body('school_kind')
    .isInt({ min: 1, max: 2 })
    .withMessage('school_kind must be 1 (중학교) or 2 (고등학교)'),
  body('region_kind')
    .isInt({ min: 1, max: 99 })
    .withMessage('region_kind is required (1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타)')
];

export const validateSchoolListQuery: ValidationChain[] = [
  query('page')
    .optional()
    .isInt({ min: 1 })
    .withMessage('page must be a positive integer'),
  query('perPage')
    .optional()
    .isInt({ min: 1, max: 2000 })
    .withMessage('perPage must be between 1 and 2000'),
  query('sort')
    .optional()
    .isString()
    .trim(),
  query('order')
    .optional()
    .isIn(['asc', 'desc'])
    .withMessage('order must be asc or desc'),
  query('school_kind')
    .optional()
    .isInt({ min: 1, max: 2 }),
  query('region_kind')
    .optional()
    .isInt({ min: 1, max: 99 }),
  query('search')
    .optional()
    .isString()
    .trim()
];

// TC Validators
export const validateTCCreate: ValidationChain[] = [
  body('tc_name')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('tc_name is required')
    .isLength({ max: 50 }),
  body('user_id')
    .optional()
    .isInt({ min: 1 }),
  body('tc_code')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 20 }),
  body('phone')
    .optional()
    .isString()
    .trim()
    .matches(/^[0-9-]+$/)
    .withMessage('phone must contain only numbers and dashes'),
  body('email')
    .optional()
    .isEmail()
    .withMessage('email must be a valid email address'),
  body('tc_type_code')
    .optional()
    .isString()
    .trim(),
  body('branch_code')
    .optional()
    .isString()
    .trim(),
  body('hire_date')
    .optional()
    .isISO8601()
    .withMessage('hire_date must be a valid date')
];

// TC User 등록 (User 테이블에 직접 등록)
export const validateTCUserCreate: ValidationChain[] = [
  body('phone')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('phone is required')
    .matches(/^[0-9-]+$/)
    .withMessage('phone must contain only numbers and dashes'),
  body('name')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('name is required')
    .isLength({ max: 50 })
];

// Class Validators (반 관리)
export const validateClassCreate: ValidationChain[] = [
  body('genre_id')
    .isInt({ min: 1 })
    .withMessage('genre_id is required'),
  body('grade')
    .isInt({ min: 7, max: 99 })
    .withMessage('grade must be between 7 and 99'),
  body('curriculum')
    .isInt({ min: 1, max: 2 })
    .withMessage('curriculum must be 1 or 2'),
  body('level')
    .isInt({ min: 1, max: 99 })
    .withMessage('level is required'),
  body('year')
    .isInt({ min: 2020, max: 2100 })
    .withMessage('year is required'),
  body('teacher_ids')
    .isArray({ min: 1 })
    .withMessage('at least one teacher is required'),
  body('teacher_ids.*')
    .isInt({ min: 1 }),
  body('lecture_dates')
    .isArray({ min: 1 })
    .withMessage('at least one lecture date is required'),
  body('lecture_dates.*.day')
    .isString()
    .isIn(['일', '월', '화', '수', '목', '금', '토']),
  body('lecture_dates.*.start_time')
    .isInt({ min: 0, max: 12 }),
  body('lecture_dates.*.end_time')
    .optional()
    .isInt({ min: 0, max: 12 }),
  body('monthly_fee')
    .optional()
    .isInt({ min: 0 }),
  body('term_start')
    .optional()
    .isISO8601(),
  body('term_end')
    .optional()
    .isISO8601(),
  body('class_name')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 100 })
];

export const validateClassUpdate: ValidationChain[] = [
  body('genre_id')
    .optional()
    .isInt({ min: 1 }),
  body('grade')
    .optional()
    .isInt({ min: 7, max: 99 }),
  body('curriculum')
    .optional()
    .isInt({ min: 1, max: 2 }),
  body('level')
    .optional()
    .isInt({ min: 1, max: 99 }),
  body('year')
    .optional()
    .isInt({ min: 2020, max: 2100 }),
  body('teacher_ids')
    .optional()
    .isArray(),
  body('teacher_ids.*')
    .optional()
    .isInt({ min: 1 }),
  body('student_ids')
    .optional()
    .isArray(),
  body('student_ids.*')
    .optional()
    .isInt({ min: 1 }),
  body('lecture_dates')
    .optional()
    .isArray(),
  body('lecture_dates.*.day')
    .optional()
    .isString()
    .isIn(['일', '월', '화', '수', '목', '금', '토']),
  body('lecture_dates.*.start_time')
    .optional()
    .isInt({ min: 0, max: 12 }),
  body('monthly_fee')
    .optional()
    .isInt({ min: 0 }),
  body('is_active')
    .optional()
    .isInt({ min: 0, max: 1 }),
  body('class_name')
    .optional()
    .isString()
    .trim()
    .isLength({ max: 100 })
];

export const validateClassListQuery: ValidationChain[] = [
  ...validatePagination,
  query('genre_id')
    .optional()
    .isInt({ min: 1 }),
  query('grade')
    .optional()
    .isInt({ min: 7, max: 99 }),
  query('level')
    .optional()
    .isInt({ min: 1, max: 99 }),
  query('year')
    .optional()
    .isInt({ min: 2020, max: 2100 }),
  query('is_active')
    .optional()
    .isInt({ min: 0, max: 1 }),
  query('search')
    .optional()
    .isString()
    .trim()
];

export const validateClassMember: ValidationChain[] = [
  body('user_id')
    .isInt({ min: 1 })
    .withMessage('user_id is required'),
  body('kind')
    .isInt()
    .isIn([2, 3])
    .withMessage('kind must be 2 (student) or 3 (teacher)')
];

export const validateSearchUsers: ValidationChain[] = [
  query('search')
    .isString()
    .trim()
    .notEmpty()
    .withMessage('search is required'),
  query('kind')
    .optional()
    .isInt({ min: 2, max: 3 })
];
