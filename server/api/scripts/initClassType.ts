/**
 * class_type 테이블 초기화 스크립트
 * 실행: npx ts-node scripts/initClassType.ts
 */

import * as dotenv from 'dotenv';
import * as path from 'path';

// .env 파일 로드
dotenv.config({ path: path.join(__dirname, '..', '.env') });

import classTypeService from '../src/services/classTypeService';

const EXCEL_PATH = 'C:/jy2000/document/단가입력양식_2026.01.xlsx';

async function main() {
  console.log('='.repeat(50));
  console.log('class_type 테이블 초기화 시작');
  console.log('엑셀 파일:', EXCEL_PATH);
  console.log('='.repeat(50));

  try {
    const result = await classTypeService.initFromExcel(EXCEL_PATH);

    console.log('\n✅ 초기화 완료!');
    console.log(`   - 삽입: ${result.inserted}건`);
    console.log(`   - 스킵: ${result.skipped}건`);

    if (result.notFoundTeachers.length > 0) {
      console.log(`\n⚠️  User 테이블에서 찾을 수 없는 강사:`);
      result.notFoundTeachers.forEach(t => console.log(`   - ${t}`));
    }

    console.log('\n');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ 초기화 실패:', error);
    process.exit(1);
  }
}

main();
