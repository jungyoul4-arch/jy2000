import { Router } from 'express';
import schoolController from '../controllers/schoolController';
import { validate } from '../middlewares/validate';
import {
  validateId,
  validateSchoolCreate,
  validateSchoolListQuery
} from '../validators';

const router = Router();

// GET /school/list - 학교 목록 조회
router.get(
  '/list',
  validate(validateSchoolListQuery),
  schoolController.getList
);

// GET /school/:id - 학교 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  schoolController.getById
);

// POST /school - 학교 생성
router.post(
  '/',
  validate(validateSchoolCreate),
  schoolController.create
);

// PUT /school/:id - 학교 수정
router.put(
  '/:id',
  validate([validateId('id')]),
  schoolController.update
);

// DELETE /school/:id - 학교 삭제
router.delete(
  '/:id',
  validate([validateId('id')]),
  schoolController.delete
);

export default router;
