import { Request, Response } from 'express';
import studentService from '../services/studentService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { StudentListQuery, StudentStateChange, StudentUpdate, StudentCreate } from '../types';

export class StudentController {
  // POST /student - 학생 신규 등록
  create = asyncHandler(async (req: Request, res: Response) => {
    const data: StudentCreate = req.body;
    const userId = (req as any).userId || 1;

    const student = await studentService.create(data, userId);

    return sendSuccess(res, student, 'Student created successfully', 201);
  });

  // GET /student/list
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: StudentListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 20,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      status_code: req.query.status_code as string,
      grade: parseInt(req.query.grade as string) || undefined,
      class_type_code: req.query.class_type_code as string,
      subject_code: req.query.subject_code as string,
      source_code: req.query.source_code as string,
      tc_id: parseInt(req.query.tc_id as string) || undefined,
      school_id: parseInt(req.query.school_id as string) || undefined,
      from_date: req.query.from_date as string,
      to_date: req.query.to_date as string
    };

    const result = await studentService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 20,
      'Student list retrieved successfully'
    );
  });

  // GET /student/:id
  getById = asyncHandler(async (req: Request, res: Response) => {
    const studentId = parseInt(req.params.id);
    const student = await studentService.getById(studentId);

    return sendSuccess(res, student, 'Student retrieved successfully');
  });

  // GET /student/:id/history - 학생 변동 내역 조회
  getHistory = asyncHandler(async (req: Request, res: Response) => {
    const studentId = parseInt(req.params.id);
    const history = await studentService.getHistory(studentId);

    return sendSuccess(res, history, 'Student history retrieved successfully');
  });

  // POST /student/state
  changeState = asyncHandler(async (req: Request, res: Response) => {
    const data: StudentStateChange = req.body;
    // TODO: Get actual user ID from auth middleware
    const userId = (req as any).userId || 1;

    const student = await studentService.changeState(data, userId);

    return sendSuccess(res, student, 'Student status changed successfully');
  });

  // PUT /student/:id - 학생 정보 업데이트
  update = asyncHandler(async (req: Request, res: Response) => {
    const studentId = parseInt(req.params.id);
    const data: StudentUpdate = { ...req.body, student_id: studentId };
    const userId = (req as any).userId || 1;

    const student = await studentService.update(data, userId);

    return sendSuccess(res, student, 'Student updated successfully');
  });

  // DELETE /student/:id/parent/:parentId - 보호자 삭제
  deleteParent = asyncHandler(async (req: Request, res: Response) => {
    const studentId = parseInt(req.params.id);
    const parentId = parseInt(req.params.parentId);

    await studentService.deleteParent(studentId, parentId);

    return sendSuccess(res, null, 'Parent deleted successfully');
  });

  // DELETE /student/:id - 학생 삭제 (관리자만)
  // ?hard=true 쿼리 파라미터로 완전 삭제
  delete = asyncHandler(async (req: Request, res: Response) => {
    const studentId = parseInt(req.params.id);
    const userId = (req as any).userId || 1;
    const userKind = (req as any).userKind;
    const hardDelete = req.query.hard === 'true';

    console.log(`Delete request: studentId=${studentId}, userId=${userId}, userKind=${userKind}, hard=${hardDelete}`);

    // 관리자(kind=1) 권한 체크
    if (userKind !== 1) {
      console.log(`Permission denied: userKind=${userKind} is not admin`);
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    if (hardDelete) {
      await studentService.hardDelete(studentId);
      return sendSuccess(res, null, 'Student permanently deleted');
    } else {
      await studentService.delete(studentId, userId);
      return sendSuccess(res, null, 'Student deleted successfully');
    }
  });
}

export default new StudentController();
