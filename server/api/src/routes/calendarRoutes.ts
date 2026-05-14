import { Router } from 'express';
import calendarController from '../controllers/calendarController';
import { validate } from '../middlewares/validate';
import { query } from 'express-validator';

const router = Router();

// GET /calendar/monthly - 월별 캘린더 이벤트 조회
router.get(
  '/monthly',
  validate([
    query('year').optional().isInt({ min: 2000, max: 2100 }),
    query('month').optional().isInt({ min: 1, max: 12 }),
  ]),
  calendarController.getMonthlyEvents
);

// GET /calendar/daily - 특정 날짜 이벤트 조회
router.get(
  '/daily',
  validate([
    query('date').optional().isISO8601(),
  ]),
  calendarController.getDailyEvents
);

export default router;
