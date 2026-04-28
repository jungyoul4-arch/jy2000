import { Router } from 'express';
import tcController from '../controllers/tcController';
import { validate } from '../middlewares/validate';
import { validateTCCreate } from '../validators';

const router = Router();

// GET /tc/list - TC 목록 조회
router.get('/list', tcController.getList);

// POST /tc - TC 등록
router.post(
  '/',
  validate(validateTCCreate),
  tcController.create
);

export default router;
