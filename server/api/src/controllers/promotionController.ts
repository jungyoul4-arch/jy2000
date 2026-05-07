import { Request, Response } from 'express';
import promotionService from '../services/promotionService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendCreated, sendPaginated } from '../utils/responseHelper';
import { PromotionCreate, ListQueryParams } from '../types';

export class PromotionController {
  // GET /promotion/list
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: ListQueryParams = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 20,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string
    };

    const result = await promotionService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 20,
      'Promotion list retrieved successfully'
    );
  });

  // POST /promotion
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: PromotionCreate = req.body;
    // TODO: Get actual user ID from auth middleware
    const userId = (req as any).userId || 1;

    const promotion = await promotionService.create(data, userId);

    return sendCreated(res, promotion, 'Promotion created successfully');
  });

  // GET /promotion/:id
  getById = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const promotion = await promotionService.getById(promotionId);

    return sendSuccess(res, promotion, 'Promotion retrieved successfully');
  });

  // PUT /promotion/:id
  update = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const data: PromotionCreate = req.body;

    const promotion = await promotionService.update(promotionId, data);

    return sendSuccess(res, promotion, 'Promotion updated successfully');
  });

  // GET /promotion/:id/attendees - 참석자 목록
  getAttendees = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const attendees = await promotionService.getAttendees(promotionId);

    return sendSuccess(res, attendees, 'Attendees retrieved successfully');
  });

  // POST /promotion/:id/attendees - 기존 학생 참석자 등록
  addAttendee = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const { student_id, memo } = req.body;
    const userId = (req as any).userId || 1;

    const result = await promotionService.addAttendee(promotionId, student_id, userId, memo);

    return sendCreated(res, result, 'Attendee added successfully');
  });

  // POST /promotion/:id/attendees/new - 신규 학생 생성 및 참석자 등록
  addNewAttendee = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const studentData = req.body;
    const userId = (req as any).userId || 1;

    const result = await promotionService.addNewAttendee(promotionId, studentData, userId);

    return sendCreated(res, result, 'New attendee added successfully');
  });

  // DELETE /promotion/:id/attendees/:attendeeId - 참석자 삭제
  removeAttendee = asyncHandler(async (req: Request, res: Response) => {
    const promotionId = parseInt(req.params.id);
    const attendeeId = parseInt(req.params.attendeeId);

    await promotionService.removeAttendee(promotionId, attendeeId);

    return sendSuccess(res, null, 'Attendee removed successfully');
  });

  // GET /promotion/search-users - User 테이블에서 학생 검색
  searchUsers = asyncHandler(async (req: Request, res: Response) => {
    const query = (req.query.q as string) || '';

    if (query.length < 2) {
      return sendSuccess(res, [], 'Query too short');
    }

    const users = await promotionService.searchUsers(query);
    return sendSuccess(res, users);
  });
}

export default new PromotionController();
