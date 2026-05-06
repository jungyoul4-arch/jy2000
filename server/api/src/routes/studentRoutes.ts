import { Router } from 'express';
import studentController from '../controllers/studentController';
import { validate } from '../middlewares/validate';
import {
  validateId,
  validateStudentListQuery,
  validateStudentStateChange,
  validateStudentCreate,
  validateStudentUpdate
} from '../validators';

const router = Router();

// POST /student - 학생 신규 등록
router.post(
  '/',
  validate(validateStudentCreate),
  studentController.create
);

// GET /student/list - 학생 목록 조회
router.get(
  '/list',
  validate(validateStudentListQuery),
  studentController.getList
);

// GET /student/:id/history - 학생 변동 내역 조회 (/:id 보다 먼저 정의해야 함)
router.get(
  '/:id/history',
  validate([validateId('id')]),
  studentController.getHistory
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

// DELETE /student/:id - 학생 삭제 (관리자만)
router.delete(
  '/:id',
  validate([validateId('id')]),
  studentController.delete
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
