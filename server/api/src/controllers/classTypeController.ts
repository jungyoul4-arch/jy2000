import { Request, Response } from 'express';
import classTypeService from '../services/classTypeService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { ClassTypeListQuery, ClassTypeCreate } from '../types';

export class ClassTypeController {
  // GET /class-type/list - 반 형태 목록 조회
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: ClassTypeListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 100,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      grade: req.query.grade ? parseInt(req.query.grade as string) : undefined,
      subject: req.query.subject ? parseInt(req.query.subject as string) : undefined,
    };

    const result = await classTypeService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 100,
      'Class type list retrieved successfully'
    );
  });

  // GET /class-type/:id - 반 형태 상세 조회
  getById = asyncHandler(async (req: Request, res: Response) => {
    const classTypeId = parseInt(req.params.id);
    const classType = await classTypeService.getById(classTypeId);

    return sendSuccess(res, classType, 'Class type retrieved successfully');
  });

  // POST /class-type - 반 형태 생성
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: ClassTypeCreate = req.body;
    const classType = await classTypeService.create(data);

    return sendSuccess(res, classType, 'Class type created successfully', 201);
  });

  // PUT /class-type/:id - 반 형태 수정
  update = asyncHandler(async (req: Request, res: Response) => {
    const classTypeId = parseInt(req.params.id);
    const data: Partial<ClassTypeCreate> = req.body;
    const classType = await classTypeService.update(classTypeId, data);

    return sendSuccess(res, classType, 'Class type updated successfully');
  });

  // DELETE /class-type/:id - 반 형태 삭제
  delete = asyncHandler(async (req: Request, res: Response) => {
    const classTypeId = parseInt(req.params.id);
    await classTypeService.delete(classTypeId);

    return sendSuccess(res, null, 'Class type deleted successfully');
  });

  // POST /class-type/init - 엑셀에서 반 형태 초기화 (기존 데이터 삭제 후 재생성)
  initFromExcel = asyncHandler(async (req: Request, res: Response) => {
    const { filePath } = req.body;

    if (!filePath) {
      return sendSuccess(res, null, '파일 경로가 필요합니다', 400);
    }

    const result = await classTypeService.initFromExcel(filePath);

    return sendSuccess(res, result, `반 형태 초기화 완료: ${result.inserted}건 삽입, ${result.skipped}건 스킵`);
  });
}

export default new ClassTypeController();
