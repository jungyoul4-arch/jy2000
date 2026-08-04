import { Router } from 'express';
import consultController from '../controllers/consultController';
import { validate } from '../middlewares/validate';
import {
  validateId,
  validateConsultCreate,
  validateConsultListQuery
} from '../validators';

const router = Router();

// GET /consult/list - 상담 목록 조회
router.get(
  '/list',
  validate(validateConsultListQuery),
  consultController.getList
);

// POST /consult - 상담 등록
router.post(
  '/',
  validate(validateConsultCreate),
  consultController.create
);

// GET /consult/:id - 상담 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  consultController.getById
);

// PUT /consult/:id - 상담 수정
router.put(
  '/:id',
  validate([validateId('id')]),
  consultController.update
);

// DELETE /consult/:id - 상담 삭제 (연동 일정도 함께 삭제)
router.delete(
  '/:id',
  validate([validateId('id')]),
  consultController.delete
);

export default router;
