import { Router } from 'express';
import tcController from '../controllers/tcController';
import { validate } from '../middlewares/validate';
import { validateTCCreate, validateTCUserCreate } from '../validators';

const router = Router();

// GET /tc/list - TC 목록 조회
router.get('/list', tcController.getList);

// POST /tc - TC 등록
router.post(
  '/',
  validate(validateTCCreate),
  tcController.create
);

// POST /tc/user - User 테이블에 상담자(TC) 직접 등록
router.post(
  '/user',
  validate(validateTCUserCreate),
  tcController.createTcUser
);

export default router;
