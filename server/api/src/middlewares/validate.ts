import { Request, Response, NextFunction } from 'express';
import { validationResult, ValidationChain } from 'express-validator';
import { sendError } from '../utils/responseHelper';

export const validate = (validations: ValidationChain[]) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    // Run all validations
    await Promise.all(validations.map(validation => validation.run(req)));

    const errors = validationResult(req);

    if (errors.isEmpty()) {
      return next();
    }

    const extractedErrors = errors.array().map(err => ({
      field: (err as any).path || (err as any).param || 'unknown',
      message: err.msg
    }));

    // 디버그 로그
    console.log('Validation Error - URL:', req.originalUrl);
    console.log('Validation Error - Body:', JSON.stringify(req.body));
    console.log('Validation Error - Errors:', JSON.stringify(extractedErrors));

    return sendError(res, 'Validation Error', 400, extractedErrors);
  };
};
