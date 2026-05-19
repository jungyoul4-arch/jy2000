import { Request, Response } from 'express';
import staffService, { StaffListQuery, StaffCreate } from '../services/staffService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';

export class StaffController {
  // GET /staff/list - 직원 목록 조회 (모든 로그인 사용자 가능)
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: StaffListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 20,
      sort: req.query.sort as string,
      order: req.query.order as 'asc' | 'desc',
      search: req.query.search as string
    };

    const result = await staffService.getList(query);

    return sendPaginated(
      res,
      result.data,
      result.total,
      query.page || 1,
      query.perPage || 20,
      'Staff list retrieved successfully'
    );
  });

  // GET /staff/:id - 직원 상세 조회 (모든 로그인 사용자 가능)
  getById = asyncHandler(async (req: Request, res: Response) => {
    const userId = parseInt(req.params.id);
    const staff = await staffService.getById(userId);

    return sendSuccess(res, staff, 'Staff retrieved successfully');
  });

  // POST /staff - 직원 등록
  create = asyncHandler(async (req: Request, res: Response) => {
    const userKind = (req as any).userKind;

    if (userKind !== 1) {
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    const data: StaffCreate = req.body;
    const staff = await staffService.create(data);

    return sendSuccess(res, staff, 'Staff created successfully', 201);
  });

  // PUT /staff/:id - 직원 수정
  update = asyncHandler(async (req: Request, res: Response) => {
    const userKind = (req as any).userKind;

    if (userKind !== 1) {
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    const userId = parseInt(req.params.id);
    const data: Partial<StaffCreate> = req.body;
    const staff = await staffService.update(userId, data);

    return sendSuccess(res, staff, 'Staff updated successfully');
  });

  // PATCH /staff/:id/toggle-active - 직원 활성/비활성 토글
  toggleActive = asyncHandler(async (req: Request, res: Response) => {
    const userKind = (req as any).userKind;

    if (userKind !== 1) {
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    const userId = parseInt(req.params.id);
    const staff = await staffService.toggleActive(userId);

    return sendSuccess(res, staff, 'Staff active status toggled successfully');
  });

  // DELETE /staff/:id - 직원 삭제
  delete = asyncHandler(async (req: Request, res: Response) => {
    const userKind = (req as any).userKind;

    if (userKind !== 1) {
      return sendSuccess(res, null, 'Permission denied: Admin only', 403);
    }

    const userId = parseInt(req.params.id);
    await staffService.delete(userId);

    return sendSuccess(res, null, 'Staff deleted successfully');
  });
}

export default new StaffController();
