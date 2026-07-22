import { Request, Response } from 'express';
import authService from '../services/authService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess } from '../utils/responseHelper';

export class AuthController {
  // POST /auth/request-code - 인증 코드 요청
  requestCode = asyncHandler(async (req: Request, res: Response) => {
    const { phone } = req.body;

    if (!phone) {
      return res.status(400).json({
        success: false,
        code: 400,
        message: '전화번호를 입력해주세요.'
      });
    }

    const result = await authService.requestCode(phone);

    return sendSuccess(res, {
      userId: result.userId,
      userName: result.userName,
      message: '인증 코드가 발송되었습니다.'
    }, '인증 코드가 발송되었습니다.');
  });

  // POST /auth/verify-code - 인증 코드 확인 및 로그인
  verifyCode = asyncHandler(async (req: Request, res: Response) => {
    const { phone, code } = req.body;

    if (!phone || !code) {
      return res.status(400).json({
        success: false,
        code: 400,
        message: '전화번호와 인증 코드를 입력해주세요.'
      });
    }

    const user = await authService.verifyCode(phone, code);

    return sendSuccess(res, {
      user,
      message: '로그인 성공'
    }, '로그인되었습니다.');
  });

  // POST /auth/login - ID/PW 로그인
  login = asyncHandler(async (req: Request, res: Response) => {
    const { loginId, password } = req.body;

    if (!loginId || !password) {
      return res.status(400).json({
        success: false,
        code: 400,
        message: '아이디와 비밀번호를 입력해주세요.'
      });
    }

    const user = await authService.loginWithCredentials(loginId, password);

    return sendSuccess(res, {
      user,
      message: '로그인 성공'
    }, '로그인되었습니다.');
  });
}

export default new AuthController();
