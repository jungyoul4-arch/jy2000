import { Request, Response, NextFunction } from 'express';
import { ApiResponse } from '../types';

// Custom Error Class
export class AppError extends Error {
  statusCode: number;
  isOperational: boolean;

  constructor(message: string, statusCode: number) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = true;

    Error.captureStackTrace(this, this.constructor);
  }
}

// Not Found Handler
export const notFoundHandler = (req: Request, res: Response, next: NextFunction) => {
  const response: ApiResponse = {
    success: false,
    code: 404,
    message: `Cannot ${req.method} ${req.originalUrl}`
  };
  res.status(404).json(response);
};

// Global Error Handler
export const errorHandler = (
  err: Error | AppError,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let statusCode = 500;
  let message = 'Internal Server Error';

  if (err instanceof AppError) {
    statusCode = err.statusCode;
    message = err.message;
  } else if (err.name === 'ValidationError') {
    statusCode = 400;
    message = err.message;
  } else if (err.name === 'JsonWebTokenError') {
    statusCode = 401;
    message = 'Invalid token';
  } else if (err.name === 'TokenExpiredError') {
    statusCode = 401;
    message = 'Token expired';
  }

  // Always log error for debugging
  console.error('Error:', err.message);
  console.error('Stack:', err.stack);

  const response: ApiResponse = {
    success: false,
    code: statusCode,
    message: message
  };

  // Include stack trace in development
  if (process.env.NODE_ENV === 'development' && !(err instanceof AppError)) {
    (response as any).stack = err.stack;
  }

  res.status(statusCode).json(response);
};

// Async Handler Wrapper
export const asyncHandler = (fn: Function) => {
  return (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};
