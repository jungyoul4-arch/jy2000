import { Request, Response } from 'express';
import consultService from '../services/consultService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendCreated, sendPaginated } from '../utils/responseHelper';
import { ConsultCreate, ConsultListQuery, NewInquiryCreate } from '../types';

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

  // GET /consult/inquiry-students - 신규생 문의 학생 타입어헤드 (active_flag 무관)
  lookupInquiryStudents = asyncHandler(async (req: Request, res: Response) => {
    const search = (req.query.search as string) || '';

    if (search.trim().length === 0) {
      return sendSuccess(res, [], 'Inquiry student lookup retrieved successfully');
    }

    const students = await consultService.lookupInquiryStudents(search.trim());

    return sendSuccess(res, students, 'Inquiry student lookup retrieved successfully');
  });

  // POST /consult/new-inquiry - 신규생 문의 등록 (신규 학생/학부모 자동 생성)
  createNewInquiry = asyncHandler(async (req: Request, res: Response) => {
    const data: NewInquiryCreate = {
      consult_date: req.body.consult_date,
      student_id: req.body.student_id,
      student_name: req.body.student_name,
      gender_code: req.body.gender_code,
      school_id: req.body.school_id,
      school_name: req.body.school_name,
      grade: req.body.grade,
      inquiry_source_code: req.body.inquiry_source_code,
      subject_code: req.body.subject_code,
      interest_subject: req.body.interest_subject,
      student_phone: req.body.student_phone,
      guardian_phone: req.body.guardian_phone,
      selector_name: req.body.selector_name,
      content: req.body.content,
    };

    const userId = (req as any).userId || 1;
    const result = await consultService.createNewInquiry(data, userId);

    return sendCreated(res, result, 'New inquiry created successfully');
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
