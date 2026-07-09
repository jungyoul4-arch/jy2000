import { Router } from 'express';
import multer from 'multer';
import * as path from 'path';
import * as fs from 'fs';
import mgmtDataController from '../controllers/mgmtDataController';

const router = Router();

// 업로드 폴더 설정
const uploadDir = path.join(__dirname, '../../uploads');
try {
  if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
  }
} catch (err) {
  console.warn(`[MgmtData] uploads 디렉토리 생성 실패 (수동 생성 필요): ${uploadDir}`);
}

// Multer 설정
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'mgmt-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const allowedTypes = [
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.ms-excel'
    ];
    if (allowedTypes.includes(file.mimetype) || file.originalname.endsWith('.xlsx') || file.originalname.endsWith('.xls')) {
      cb(null, true);
    } else {
      cb(new Error('엑셀 파일만 업로드 가능합니다 (.xlsx, .xls)'));
    }
  },
  limits: {
    fileSize: 10 * 1024 * 1024 // 10MB
  }
});

// GET /mgmt-data/list - 경영 데이터 목록 조회
router.get('/list', mgmtDataController.getList);

// GET /mgmt-data/report - 경영 보고서 데이터 조회
router.get('/report', mgmtDataController.getReport);

// GET /mgmt-data/region-report - 지역별 보고서 데이터 조회
router.get('/region-report', mgmtDataController.getRegionReport);

// POST /mgmt-data/upload - 엑셀 파일 업로드
router.post('/upload', upload.single('file'), mgmtDataController.upload);

// DELETE /mgmt-data/:year/:month - 특정 년월 데이터 삭제
router.delete('/:year/:month', mgmtDataController.deleteByMonth);

// PATCH /mgmt-data/:id - 경영 데이터 수정 (관리자만)
router.patch('/:id', mgmtDataController.update);

export default router;
