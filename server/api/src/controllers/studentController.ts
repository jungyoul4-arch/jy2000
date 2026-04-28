import { Request, Response } from 'express';
import studentService from '../services/studentService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { StudentListQuery, StudentStateChange } from '../types';

export class StudentController {
  // GET /student/list
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: StudentListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 20,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string,
      status_code: req.query.status_code as string,
      grade_code: req.query.grade_code as string,
      tc_id: parseInt(req.query.tc_id as string) || undefined,
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

  // POST /student/state
  changeState = asyncHandler(async (req: Request, res: Response) => {
    const data: StudentStateChange = req.body;
    // TODO: Get actual user ID from auth middleware
    const userId = (req as any).userId || 1;

    const student = await studentService.changeState(data, userId);

    return sendSuccess(res, student, 'Student status changed successfully');
  });
}

export default new StudentController();
