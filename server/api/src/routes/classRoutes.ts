import { Router } from 'express';
import classController from '../controllers/classController';
import { validate } from '../middlewares/validate';
import {
  validateId,
  validateClassListQuery,
  validateClassCreate,
  validateClassUpdate,
  validateClassMember,
  validateSearchUsers
} from '../validators';

const router = Router();

// GET /class/list - 반 목록 조회
router.get(
  '/list',
  validate(validateClassListQuery),
  classController.getList
);

// GET /class/teachers - 선생님 목록 조회 (/:id 보다 먼저 정의)
router.get(
  '/teachers',
  classController.getTeachers
);

// GET /class/search-users - 사용자 검색 (/:id 보다 먼저 정의)
router.get(
  '/search-users',
  validate(validateSearchUsers),
  classController.searchUsers
);

// GET /class/:id - 반 상세 조회
router.get(
  '/:id',
  validate([validateId('id')]),
  classController.getById
);

// POST /class - 반 등록
router.post(
  '/',
  validate(validateClassCreate),
  classController.create
);

// PUT /class/:id - 반 수정
router.put(
  '/:id',
  validate([validateId('id'), ...validateClassUpdate]),
  classController.update
);

// DELETE /class/:id - 반 삭제
router.delete(
  '/:id',
  validate([validateId('id')]),
  classController.delete
);

// POST /class/:id/member - 멤버 추가
router.post(
  '/:id/member',
  validate([validateId('id'), ...validateClassMember]),
  classController.addMember
);

// DELETE /class/:id/member/:userId - 멤버 제거
router.delete(
  '/:id/member/:userId',
  validate([validateId('id'), validateId('userId')]),
  classController.removeMember
);

export default router;
