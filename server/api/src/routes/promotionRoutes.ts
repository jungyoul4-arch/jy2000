import { Router } from 'express';
import promotionController from '../controllers/promotionController';
import { validate } from '../middlewares/validate';
import {
  validatePromotionCreate,
  validatePagination,
  validateId
} from '../validators';

const router = Router();

// GET /promotion/list - 프로모션 목록 조회
router.get(
  '/list',
  validate(validatePagination),
  promotionController.getList
);

// GET /promotion/search-users - User 테이블에서 학생 검색
router.get(
  '/search-users',
  promotionController.searchUsers
);

// GET /promotion/:id - 프로모션 상세 조회
router.get(
  '/:id',
  validate([validateId()]),
  promotionController.getById
);

// POST /promotion - 프로모션 등록
router.post(
  '/',
  validate(validatePromotionCreate),
  promotionController.create
);

// PUT /promotion/:id - 프로모션 수정
router.put(
  '/:id',
  validate([validateId(), ...validatePromotionCreate]),
  promotionController.update
);

// GET /promotion/:id/attendees - 참석자 목록
router.get(
  '/:id/attendees',
  validate([validateId()]),
  promotionController.getAttendees
);

// POST /promotion/:id/attendees - 기존 학생 참석자 등록
router.post(
  '/:id/attendees',
  validate([validateId()]),
  promotionController.addAttendee
);

// POST /promotion/:id/attendees/new - 신규 학생 생성 및 참석자 등록
router.post(
  '/:id/attendees/new',
  validate([validateId()]),
  promotionController.addNewAttendee
);

// PATCH /promotion/:id/attendees/:attendeeId - 참석자 정보 수정
router.patch(
  '/:id/attendees/:attendeeId',
  promotionController.updateAttendee
);

// DELETE /promotion/:id/attendees/:attendeeId - 참석자 삭제
router.delete(
  '/:id/attendees/:attendeeId',
  promotionController.removeAttendee
);

export default router;
