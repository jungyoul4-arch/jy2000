import { Request, Response, NextFunction } from 'express';

// 요청 헤더에서 사용자 정보 추출
export const extractUserInfo = (req: Request, res: Response, next: NextFunction) => {
  const userId = req.headers['x-user-id'];
  const userKind = req.headers['x-user-kind'];

  if (userId) {
    (req as any).userId = parseInt(userId as string, 10);
  }
  if (userKind) {
    (req as any).userKind = parseInt(userKind as string, 10);
  }

  next();
};
