import { Request, Response } from 'express';
import schoolService from '../services/schoolService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { SchoolListQuery, SchoolCreate } from '../types';

export class SchoolController {
  // GET /school/list - 학교 목록 조회
  getList = asyncHandler(async (req: Request, res: Response) => {
    const regionKindStr = req.query.region_kind as string;
    const query: SchoolListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 100,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      school_kind: parseInt(req.query.school_kind as string) || undefined,
      region_kind: regionKindStr ? parseInt(regionKindStr) : undefined
    };

    const result = await schoolService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 100,
      'School list retrieved successfully'
    );
  });

  // GET /school/:id - 학교 상세 조회
  getById = asyncHandler(async (req: Request, res: Response) => {
    const schoolId = parseInt(req.params.id);
    const school = await schoolService.getById(schoolId);

    return sendSuccess(res, school, 'School retrieved successfully');
  });

  // POST /school - 학교 생성
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: SchoolCreate = req.body;
    const school = await schoolService.create(data);

    return sendSuccess(res, school, 'School created successfully', 201);
  });

  // PUT /school/:id - 학교 수정
  update = asyncHandler(async (req: Request, res: Response) => {
    const schoolId = parseInt(req.params.id);
    const data: Partial<SchoolCreate> = req.body;
    const school = await schoolService.update(schoolId, data);

    return sendSuccess(res, school, 'School updated successfully');
  });

  // DELETE /school/:id - 학교 삭제
  delete = asyncHandler(async (req: Request, res: Response) => {
    const schoolId = parseInt(req.params.id);
    await schoolService.delete(schoolId);

    return sendSuccess(res, null, 'School deleted successfully');
  });
}

export default new SchoolController();
