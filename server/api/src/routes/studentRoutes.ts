import { Router } from 'express';
import studentController from '../controllers/studentController';
import { validate } from '../middlewares/validate';
import {
  validateId,
  validateStudentListQuery,
  validateStudentStateChange,
  validateStudentUpdate
} from '../validators';

const router = Router();

// GET /student/list - 학생 목록 조회
router.get(
  '/list',
  validate(validateStudentListQuery),
  studentController.getList
);

// GET /student/:id - 학생 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  studentController.getById
);

// PUT /student/:id - 학생 정보 업데이트
router.put(
  '/:id',
  validate([validateId('id'), ...validateStudentUpdate]),
  studentController.update
);

// DELETE /student/:id/parent/:parentId - 보호자 삭제
router.delete(
  '/:id/parent/:parentId',
  validate([validateId('id'), validateId('parentId')]),
  studentController.deleteParent
);

// POST /student/state - 학생 상태 변경
router.post(
  '/state',
  validate(validateStudentStateChange),
  studentController.changeState
);

export default router;
