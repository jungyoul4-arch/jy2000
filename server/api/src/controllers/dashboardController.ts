import { Request, Response } from 'express';
import dashboardService from '../services/dashboardService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess } from '../utils/responseHelper';

export class DashboardController {
  // GET /dashboard/kpi
  getKPI = asyncHandler(async (req: Request, res: Response) => {
    const kpi = await dashboardService.getKPI();

    return sendSuccess(res, kpi, 'KPI data retrieved successfully');
  });

  // GET /dashboard/funnel
  getFunnel = asyncHandler(async (req: Request, res: Response) => {
    const funnel = await dashboardService.getFunnel();

    return sendSuccess(res, funnel, 'Funnel data retrieved successfully');
  });

  // GET /dashboard/tc-performance
  getTCPerformance = asyncHandler(async (req: Request, res: Response) => {
    const performance = await dashboardService.getTCPerformance();

    return sendSuccess(res, performance, 'TC performance data retrieved successfully');
  });

  // GET /dashboard/monthly-trend
  getMonthlyTrend = asyncHandler(async (req: Request, res: Response) => {
    const months = parseInt(req.query.months as string) || 6;
    const trend = await dashboardService.getMonthlyTrend(months);

    return sendSuccess(res, trend, 'Monthly trend data retrieved successfully');
  });
}

export default new DashboardController();
