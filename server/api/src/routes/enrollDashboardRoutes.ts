import { Router } from 'express';

import enrollDashboardController from '../controllers/enrollDashboardController';

const router = Router();

// GET /enroll-dashboard/months - 스냅샷이 있는 년월 목록
router.get('/months', enrollDashboardController.getMonths);

// GET /enroll-dashboard/trend - 월별 추이 (전 기간)
router.get('/trend', enrollDashboardController.getTrend);

// GET /enroll-dashboard - 한 달치 대시보드 (년월 생략 시 최근 달)
router.get('/', enrollDashboardController.getDashboard);

export default router;
