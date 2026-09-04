import { Router } from 'express';
import { body, query } from 'express-validator';
import scheduleController from '../controllers/scheduleController';
import { validate } from '../middlewares/validate';
import { SCHEDULE_EVENT_STATUSES } from '../types';
import { validateId } from '../validators';

const router = Router();

// ============================================================
// 카테고리 관련
// ============================================================

// GET /schedule/categories - 카테고리 목록 조회
router.get('/categories', scheduleController.getCategories);

// ============================================================
// 일정 유형 관련
// ============================================================

// GET /schedule/event-types - 일정 유형 목록 조회
router.get('/event-types', scheduleController.getEventTypes);

// ============================================================
// 일정 이벤트 관련
// ============================================================

// 일정 목록 조회 검증
const validateEventListQuery = [
  query('from_date').optional().isISO8601().withMessage('from_date must be a valid date'),
  query('to_date').optional().isISO8601().withMessage('to_date must be a valid date'),
  query('category_id').optional().isInt({ min: 1 }).withMessage('category_id must be a positive integer'),
  query('event_type_id').optional().isInt({ min: 1 }).withMessage('event_type_id must be a positive integer'),
  query('student_id').optional().isInt({ min: 1 }).withMessage('student_id must be a positive integer'),
  query('created_by').optional().isInt({ min: 1 }).withMessage('created_by must be a positive integer'),
  query('page').optional().isInt({ min: 1 }).withMessage('page must be a positive integer'),
  query('perPage').optional().isInt({ min: 1, max: 10000 }).withMessage('perPage must be between 1 and 10000'),
];

// 일정 생성 검증
const validateEventCreate = [
  body('category_id')
    .isInt({ min: 1 })
    .withMessage('category_id is required and must be a positive integer'),
  body('event_type_id')
    .isInt({ min: 1 })
    .withMessage('event_type_id is required and must be a positive integer'),
  body('event_date')
    .isISO8601()
    .withMessage('event_date is required and must be a valid date'),
  body('content')
    .optional({ nullable: true })
    .isString()
    .withMessage('content must be a string'),
  body('student_id')
    .optional({ nullable: true })
    .isInt({ min: 1 })
    .withMessage('student_id must be a positive integer'),
  body('event_status')
    .optional({ nullable: true })
    .isIn(SCHEDULE_EVENT_STATUSES)
    .withMessage(`event_status must be one of ${SCHEDULE_EVENT_STATUSES.join(', ')}`),
];

// 일정 수정 검증
const validateEventUpdate = [
  body('category_id')
    .optional()
    .isInt({ min: 1 })
    .withMessage('category_id must be a positive integer'),
  body('event_type_id')
    .optional()
    .isInt({ min: 1 })
    .withMessage('event_type_id must be a positive integer'),
  body('event_date')
    .optional()
    .isISO8601()
    .withMessage('event_date must be a valid date'),
  body('content')
    .optional({ nullable: true })
    .isString()
    .withMessage('content must be a string'),
  body('student_id')
    .optional({ nullable: true })
    .isInt({ min: 1 })
    .withMessage('student_id must be a positive integer'),
  body('event_status')
    .optional({ nullable: true })
    .isIn(SCHEDULE_EVENT_STATUSES)
    .withMessage(`event_status must be one of ${SCHEDULE_EVENT_STATUSES.join(', ')}`),
];

// GET /schedule/events - 일정 목록 조회
router.get(
  '/events',
  validate(validateEventListQuery),
  scheduleController.getEvents
);

// GET /schedule/events/:id - 일정 상세 조회
router.get(
  '/events/:id',
  validate([validateId('id')]),
  scheduleController.getEventById
);

// POST /schedule/events - 일정 등록
router.post(
  '/events',
  validate(validateEventCreate),
  scheduleController.createEvent
);

// PUT /schedule/events/:id - 일정 수정
router.put(
  '/events/:id',
  validate([validateId('id'), ...validateEventUpdate]),
  scheduleController.updateEvent
);

// DELETE /schedule/events/:id - 일정 삭제
router.delete(
  '/events/:id',
  validate([validateId('id')]),
  scheduleController.deleteEvent
);

export default router;
