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
}

export default new PromotionController();
