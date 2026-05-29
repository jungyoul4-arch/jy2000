import { Router } from 'express';
import multer from 'multer';
import * as path from 'path';
import * as fs from 'fs';
import mgmtDataController from '../controllers/mgmtDataController';

const router = Router();

// 업로드 폴더 설정
const uploadDir = path.join(__dirname, '../../uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
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

// POST /mgmt-data/upload - 엑셀 파일 업로드
router.post('/upload', upload.single('file'), mgmtDataController.upload);

// DELETE /mgmt-data/:year/:month - 특정 년월 데이터 삭제
router.delete('/:year/:month', mgmtDataController.deleteByMonth);

export default router;
