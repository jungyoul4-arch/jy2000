import { Router } from 'express';
import classTypeController from '../controllers/classTypeController';
import { validate } from '../middlewares/validate';
import { validateId } from '../validators';

const router = Router();

// GET /class-type/list - 반 형태 목록 조회
router.get('/list', classTypeController.getList);

// GET /class-type/find-by-name - 반 형태명으로 검색
router.get('/find-by-name', classTypeController.findByName);

// POST /class-type/init - 엑셀에서 반 형태 초기화
router.post('/init', classTypeController.initFromExcel);

// GET /class-type/:id - 반 형태 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  classTypeController.getById
);

// POST /class-type - 반 형태 생성
router.post('/', classTypeController.create);

// PUT /class-type/:id - 반 형태 수정
router.put(
  '/:id',
  validate([validateId('id')]),
  classTypeController.update
);

// DELETE /class-type/:id - 반 형태 삭제
router.delete(
  '/:id',
  validate([validateId('id')]),
  classTypeController.delete
);

export default router;
