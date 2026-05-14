import { Request, Response } from 'express';
import calendarService from '../services/calendarService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess } from '../utils/responseHelper';

export class CalendarController {
  // GET /calendar/monthly - 월별 캘린더 이벤트 조회
  getMonthlyEvents = asyncHandler(async (req: Request, res: Response) => {
    const year = parseInt(req.query.year as string) || new Date().getFullYear();
    const month = parseInt(req.query.month as string) || new Date().getMonth() + 1;

    const events = await calendarService.getMonthlyEvents(year, month);

    return sendSuccess(res, events, 'Monthly events retrieved successfully');
  });

  // GET /calendar/daily - 특정 날짜 이벤트 조회
  getDailyEvents = asyncHandler(async (req: Request, res: Response) => {
    const date = req.query.date as string;

    if (!date) {
      return sendSuccess(res, [], 'Date is required');
    }

    const events = await calendarService.getDailyEvents(date);

    return sendSuccess(res, events, 'Daily events retrieved successfully');
  });
}

export default new CalendarController();
