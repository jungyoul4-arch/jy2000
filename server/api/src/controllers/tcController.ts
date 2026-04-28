import { Request, Response } from 'express';
import tcService from '../services/tcService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendCreated } from '../utils/responseHelper';
import { TCCreate } from '../types';

export class TCController {
  // POST /tc
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: TCCreate = req.body;
    // TODO: Get actual user ID from auth middleware
    const userId = (req as any).userId || 1;

    const tc = await tcService.create(data, userId);

    return sendCreated(res, tc, 'TC created successfully');
  });

  // GET /tc/list (bonus endpoint)
  getList = asyncHandler(async (req: Request, res: Response) => {
    const tcList = await tcService.getList();

    return sendSuccess(res, tcList, 'TC list retrieved successfully');
  });
}

export default new TCController();
