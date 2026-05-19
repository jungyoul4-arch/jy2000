import { Router } from 'express';
import staffController from '../controllers/staffController';
import { validate } from '../middlewares/validate';
import { validateId, validateStaffListQuery, validateStaffCreate, validateStaffUpdate } from '../validators';

const router = Router();

// GET /staff/list - 직원 목록 조회
router.get(
  '/list',
  validate(validateStaffListQuery),
  staffController.getList
);

// GET /staff/:id - 직원 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  staffController.getById
);

// POST /staff - 직원 등록
router.post(
  '/',
  validate(validateStaffCreate),
  staffController.create
);

// PUT /staff/:id - 직원 수정
router.put(
  '/:id',
  validate([validateId('id'), ...validateStaffUpdate]),
  staffController.update
);

// PATCH /staff/:id/toggle-active - 직원 활성/비활성 토글
router.patch(
  '/:id/toggle-active',
  validate([validateId('id')]),
  staffController.toggleActive
);

// DELETE /staff/:id - 직원 삭제
router.delete(
  '/:id',
  validate([validateId('id')]),
  staffController.delete
);

export default router;
