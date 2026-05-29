import { Request, Response } from 'express';
import mgmtDataService from '../services/mgmtDataService';
import { asyncHandler } from '../middlewares/errorHandler';
import { sendSuccess, sendPaginated } from '../utils/responseHelper';
import { MgmtDataListQuery } from '../types';
import * as fs from 'fs';

export class MgmtDataController {
  // GET /mgmt-data/list - 경영 데이터 목록 조회
  getList = asyncHandler(async (req: Request, res: Response) => {
    const query: MgmtDataListQuery = {
      page: parseInt(req.query.page as string) || 1,
      perPage: parseInt(req.query.perPage as string) || 100,
      search: req.query.search as string,
      year: req.query.year ? parseInt(req.query.year as string) : undefined,
      month: req.query.month ? parseInt(req.query.month as string) : undefined,
    };

    const result = await mgmtDataService.getList(query);

    return res.json({
      success: true,
      code: 200,
      message: 'Mgmt data list retrieved successfully',
      data: result.data,
      meta: {
        total: result.total,
        page: query.page || 1,
        perPage: query.perPage || 100,
        totalPages: Math.ceil(result.total / (query.perPage || 100)),
        availableMonths: result.availableMonths
      }
    });
  });

  // DELETE /mgmt-data/:year/:month - 특정 년월 데이터 삭제
  deleteByMonth = asyncHandler(async (req: Request, res: Response) => {
    const year = parseInt(req.params.year);
    const month = parseInt(req.params.month);

    const deletedCount = await mgmtDataService.deleteByMonth(year, month);

    return sendSuccess(res, { deletedCount }, `${year}년 ${month}월 데이터 ${deletedCount}건이 삭제되었습니다`);
  });

  // POST /mgmt-data/upload - 엑셀 파일 업로드
  upload = asyncHandler(async (req: Request, res: Response) => {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        code: 400,
        message: '파일이 없습니다'
      });
    }

    const year = parseInt(req.body.year);
    const month = parseInt(req.body.month);

    if (!year || !month) {
      // 업로드된 파일 삭제
      fs.unlinkSync(req.file.path);
      return res.status(400).json({
        success: false,
        code: 400,
        message: '년도와 월을 지정해주세요'
      });
    }

    try {
      const result = await mgmtDataService.uploadFromExcel(req.file.path, year, month);

      // 업로드된 파일 삭제
      fs.unlinkSync(req.file.path);

      return sendSuccess(res, result, `${result.inserted}건 업로드 완료 (학생 매칭: ${result.matched}건)`, 201);
    } catch (error) {
      // 업로드된 파일 삭제
      if (req.file && fs.existsSync(req.file.path)) {
        fs.unlinkSync(req.file.path);
      }
      throw error;
    }
  });
}

export default new MgmtDataController();
