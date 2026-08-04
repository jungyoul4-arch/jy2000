import { Request, Response } from 'express';
import consultService from '../services/consultService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendCreated, sendPaginated } from '../utils/responseHelper';
import { ConsultCreate, ConsultListQuery } from '../types';

export class ConsultController {
  // GET /consult/list
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: ConsultListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 20,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      student_id: parseInt(req.query.student_id as string) || undefined,
      tc_id: parseInt(req.query.tc_id as string) || undefined,
      consult_type_code: req.query.consult_type_code as string,
      consult_result_code: req.query.consult_result_code as string,
      from_date: req.query.from_date as string,
      to_date: req.query.to_date as string
    };

    const result = await consultService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 20,
      'Consult list retrieved successfully'
    );
  });

  // POST /consult
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: ConsultCreate = req.body;
    const userId = (req as any).userId || 1;

    const consult = await consultService.create(data, userId);

    return sendCreated(res, consult, 'Consult created successfully');
  });

  // GET /consult/:id
  getById = asyncHandler(async (req: Request, res: Response) => {
    const consultId = parseInt(req.params.id);
    const consult = await consultService.getById(consultId);

    return sendSuccess(res, consult, 'Consult retrieved successfully');
  });

  // PUT /consult/:id
  update = asyncHandler(async (req: Request, res: Response) => {
    const consultId = parseInt(req.params.id);
    const data = req.body;
    const userId = (req as any).userId || 1;

    const consult = await consultService.update(consultId, data, userId);

    return sendSuccess(res, consult, 'Consult updated successfully');
  });

  // DELETE /consult/:id
  delete = asyncHandler(async (req: Request, res: Response) => {
    const consultId = parseInt(req.params.id);
    const userId = (req as any).userId || 1;

    await consultService.delete(consultId, userId);

    return sendSuccess(res, null, 'Consult deleted successfully');
  });
}

export default new ConsultController();
