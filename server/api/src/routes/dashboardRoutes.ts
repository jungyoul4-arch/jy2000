import { Router } from 'express';
import dashboardController from '../controllers/dashboardController';

const router = Router();

// GET /dashboard/kpi - KPI 데이터 조회
router.get('/kpi', dashboardController.getKPI);

// GET /dashboard/funnel - 퍼널 데이터 조회
router.get('/funnel', dashboardController.getFunnel);

// GET /dashboard/tc-performance - TC별 실적 조회
router.get('/tc-performance', dashboardController.getTCPerformance);

// GET /dashboard/monthly-trend - 월별 등록 추이
router.get('/monthly-trend', dashboardController.getMonthlyTrend);

export default router;
