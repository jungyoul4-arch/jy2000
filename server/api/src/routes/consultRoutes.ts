import { Router } from 'express';
import consultController from '../controllers/consultController';
import { validate } from '../middlewares/validate';
import {
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

export default router;
