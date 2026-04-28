import { Router } from 'express';
import promotionController from '../controllers/promotionController';
import { validate } from '../middlewares/validate';
import {
  validatePromotionCreate,
  validatePagination
} from '../validators';

const router = Router();

// GET /promotion/list - 프로모션 목록 조회
router.get(
  '/list',
  validate(validatePagination),
  promotionController.getList
);

// POST /promotion - 프로모션 등록
router.post(
  '/',
  validate(validatePromotionCreate),
  promotionController.create
);

export default router;
