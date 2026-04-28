import { Response } from 'express';
import { ApiResponse, PaginationMeta } from '../types';

export const sendSuccess = <T>(
  res: Response,
  data: T,
  message: string = 'Success',
  statusCode: number = 200,
  meta?: PaginationMeta
): Response => {
  const response: ApiResponse<T> = {
    success: true,
    code: statusCode,
    message,
    data
  };

  if (meta) {
    response.meta = meta;
  }

  return res.status(statusCode).json(response);
};

export const sendCreated = <T>(
  res: Response,
  data: T,
  message: string = 'Created successfully'
): Response => {
  return sendSuccess(res, data, message, 201);
};

export const sendError = (
  res: Response,
  message: string,
  statusCode: number = 400,
  errors?: { field: string; message: string }[]
): Response => {
  const response: ApiResponse = {
    success: false,
    code: statusCode,
    message
  };

  if (errors) {
    response.errors = errors;
  }

  return res.status(statusCode).json(response);
};

export const sendPaginated = <T>(
  res: Response,
  data: T[],
  total: number,
  page: number,
  perPage: number,
  message: string = 'Success'
): Response => {
  const meta: PaginationMeta = {
    total,
    page,
    perPage,
    totalPages: Math.ceil(total / perPage)
  };

  return sendSuccess(res, data, message, 200, meta);
};
