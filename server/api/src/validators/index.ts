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
    .isInt({ min: 1, max: 100 })
    .withMessage('perPage must be between 1 and 100'),
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
  query('tc_id')
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
