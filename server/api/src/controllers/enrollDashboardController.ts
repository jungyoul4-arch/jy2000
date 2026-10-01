import { Request, Response } from 'express';

import enrollDashboardService from '../services/enrollDashboardService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess } from '../utils/responseHelper';

export class EnrollDashboardController {
  // GET /enroll-dashboard/months - 스냅샷이 있는 년월 목록
  getMonths = asyncHandler(async (_req: Request, res: Response) => {
    const months = await enrollDashboardService.getMonths();

    return sendSuccess(res, months, 'Enroll snapshot months retrieved successfully');
  });

  // GET /enroll-dashboard/trend - 월별 추이 (전 기간)
  getTrend = asyncHandler(async (_req: Request, res: Response) => {
    const trend = await enrollDashboardService.getTrend();

    return sendSuccess(res, trend, 'Enroll trend retrieved successfully');
  });

  // GET /enroll-dashboard?year=&month=&grade=&current= - 한 달치 대시보드 전체
  //
  // current=1이면 저장된 스냅샷 대신 지금 DB 상태로 집계한다 (화면 기본값).
  // 년월을 안 주면 가장 최근 달을 쓴다. 화면 첫 진입에서 월 목록을
  // 먼저 받아 오는 왕복을 아끼려는 것이다.
  getDashboard = asyncHandler(async (req: Request, res: Response) => {
    const gradeRaw = req.query.grade ? parseInt(req.query.grade as string, 10) : null;
    const gradeParam = Number.isNaN(gradeRaw as number) ? null : gradeRaw;

    if (req.query.current === '1' || req.query.current === 'true') {
      const current = await enrollDashboardService.getCurrent({ grade: gradeParam });

      return sendSuccess(res, current, 'Current enroll dashboard retrieved successfully');
    }

    let year = req.query.year ? parseInt(req.query.year as string, 10) : null;
    let month = req.query.month ? parseInt(req.query.month as string, 10) : null;

    if (!year || !month) {
      const months = await enrollDashboardService.getMonths();
      if (months.length === 0) {
        return sendSuccess(res, null, 'No enroll snapshot available');
      }
      const latest = months[months.length - 1];
      year = latest.year;
      month = latest.month;
    }

    const data = await enrollDashboardService.getDashboard(year, month, { grade: gradeParam });

    return sendSuccess(res, data, 'Enroll dashboard retrieved successfully');
  });
}

export default new EnrollDashboardController();
