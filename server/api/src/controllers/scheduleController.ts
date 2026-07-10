import { Request, Response } from 'express';
import scheduleService from '../services/scheduleService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated, sendCreated } from '../utils/responseHelper';
import {
  ScheduleEventCreate,
  ScheduleEventUpdate,
  ScheduleEventListQuery,
} from '../types';

export class ScheduleController {
  /**
   * 카테고리 목록 조회
   * GET /schedule/categories
   */
  getCategories = asyncHandler(async (req: Request, res: Response) => {
    const categories = await scheduleService.getCategories();
    return sendSuccess(res, categories, '카테고리 목록 조회 성공');
  });

  /**
   * 일정 유형 목록 조회
   * GET /schedule/event-types
   */
  getEventTypes = asyncHandler(async (req: Request, res: Response) => {
    const eventTypes = await scheduleService.getEventTypes();
    return sendSuccess(res, eventTypes, '일정 유형 목록 조회 성공');
  });

  /**
   * 일정 목록 조회
   * GET /schedule/events
   */
  getEvents = asyncHandler(async (req: Request, res: Response) => {
    const query: ScheduleEventListQuery = {
      from_date: req.query.from_date as string,
      to_date: req.query.to_date as string,
      category_id: req.query.category_id ? parseInt(req.query.category_id as string) : undefined,
      event_type_id: req.query.event_type_id ? parseInt(req.query.event_type_id as string) : undefined,
      student_id: req.query.student_id ? parseInt(req.query.student_id as string) : undefined,
      created_by: req.query.created_by ? parseInt(req.query.created_by as string) : undefined,
      page: req.query.page ? parseInt(req.query.page as string) : 1,
      perPage: req.query.perPage ? parseInt(req.query.perPage as string) : 1000,
    };

    const result = await scheduleService.getEvents(query);
    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 1000,
      '일정 목록 조회 성공'
    );
  });

  /**
   * 일정 상세 조회
   * GET /schedule/events/:id
   */
  getEventById = asyncHandler(async (req: Request, res: Response) => {
    const eventId = parseInt(req.params.id);
    const event = await scheduleService.getEventById(eventId);
    return sendSuccess(res, event, '일정 상세 조회 성공');
  });

  /**
   * 일정 등록
   * POST /schedule/events
   */
  createEvent = asyncHandler(async (req: Request, res: Response) => {
    const data: ScheduleEventCreate = {
      category_id: req.body.category_id,
      event_type_id: req.body.event_type_id,
      event_date: req.body.event_date,
      content: req.body.content,
      student_id: req.body.student_id,
    };

    const userId = (req as any).userId || 1;
    const event = await scheduleService.createEvent(data, userId);
    return sendCreated(res, event, '일정 등록 성공');
  });

  /**
   * 일정 수정
   * PUT /schedule/events/:id
   */
  updateEvent = asyncHandler(async (req: Request, res: Response) => {
    const eventId = parseInt(req.params.id);
    const data: ScheduleEventUpdate = {
      category_id: req.body.category_id,
      event_type_id: req.body.event_type_id,
      event_date: req.body.event_date,
      content: req.body.content,
      student_id: req.body.student_id,
    };

    const userId = (req as any).userId || 1;
    const event = await scheduleService.updateEvent(eventId, data, userId);
    return sendSuccess(res, event, '일정 수정 성공');
  });

  /**
   * 일정 삭제
   * DELETE /schedule/events/:id
   */
  deleteEvent = asyncHandler(async (req: Request, res: Response) => {
    const eventId = parseInt(req.params.id);
    const userId = (req as any).userId || 1;
    await scheduleService.deleteEvent(eventId, userId);
    return sendSuccess(res, null, '일정 삭제 성공');
  });
}

export default new ScheduleController();
