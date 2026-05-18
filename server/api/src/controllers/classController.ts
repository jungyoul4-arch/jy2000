import { Request, Response } from 'express';
import classService from '../services/classService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { ClassListQuery, ClassCreate, ClassUpdate } from '../types';

export class ClassController {
  // GET /class/list - 반 목록 조회
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: ClassListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 50,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      genre_id: parseInt(req.query.genre_id as string) || undefined,
      grade: parseInt(req.query.grade as string) || undefined,
      level: parseInt(req.query.level as string) || undefined,
      year: parseInt(req.query.year as string) || undefined,
      is_active: parseInt(req.query.is_active as string) || undefined
    };

    const result = await classService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 50,
      'Class list retrieved successfully'
    );
  });

  // GET /class/teachers - 선생님 목록 조회
  getTeachers = asyncHandler(async (req: Request, res: Response) => {
    const search = req.query.search as string;
    const teachers = await classService.getTeachers(search);

    return sendSuccess(res, teachers, 'Teachers retrieved successfully');
  });

  // GET /class/search-users - 사용자 검색 (학생/선생님)
  searchUsers = asyncHandler(async (req: Request, res: Response) => {
    const search = req.query.search as string;
    const kind = parseInt(req.query.kind as string) || undefined;

    const users = await classService.searchUsers(search, kind);

    return sendSuccess(res, users, 'Users retrieved successfully');
  });

  // GET /class/:id - 반 상세 조회
  getById = asyncHandler(async (req: Request, res: Response) => {
    const classId = parseInt(req.params.id);
    const classDetail = await classService.getById(classId);

    return sendSuccess(res, classDetail, 'Class retrieved successfully');
  });

  // POST /class - 반 등록
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: ClassCreate = req.body;
    const userId = (req as any).userId || 1;

    const classDetail = await classService.create(data, userId);

    return sendSuccess(res, classDetail, 'Class created successfully', 201);
  });

  // PUT /class/:id - 반 수정
  update = asyncHandler(async (req: Request, res: Response) => {
    const classId = parseInt(req.params.id);
    const data: ClassUpdate = req.body;

    const classDetail = await classService.update(classId, data);

    return sendSuccess(res, classDetail, 'Class updated successfully');
  });

  // DELETE /class/:id - 반 삭제
  delete = asyncHandler(async (req: Request, res: Response) => {
    const classId = parseInt(req.params.id);
    const userKind = (req as any).userKind;

    // 관리자(kind=1) 권한 체크
    if (userKind !== 1) {
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    await classService.delete(classId);

    return sendSuccess(res, null, 'Class deleted successfully');
  });

  // POST /class/:id/member - 멤버 추가
  addMember = asyncHandler(async (req: Request, res: Response) => {
    const classId = parseInt(req.params.id);
    const { user_id, kind } = req.body;

    await classService.addMember(classId, user_id, kind);

    return sendSuccess(res, null, 'Member added successfully');
  });

  // DELETE /class/:id/member/:userId - 멤버 제거
  removeMember = asyncHandler(async (req: Request, res: Response) => {
    const classId = parseInt(req.params.id);
    const userId = parseInt(req.params.userId);

    await classService.removeMember(classId, userId);

    return sendSuccess(res, null, 'Member removed successfully');
  });
}

export default new ClassController();
