import { Router } from 'express';
import authController from '../controllers/authController';

const router = Router();

// POST /auth/request-code - 인증 코드 요청
router.post('/request-code', authController.requestCode);

// POST /auth/verify-code - 인증 코드 확인 및 로그인
router.post('/verify-code', authController.verifyCode);

// POST /auth/login - ID/PW 로그인
router.post('/login', authController.login);

export default router;
