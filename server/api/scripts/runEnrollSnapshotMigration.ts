/**
 * enroll_snapshot 마이그레이션 실행
 *
 * 실행: npx ts-node scripts/runEnrollSnapshotMigration.ts
 *
 * server/database/enroll_snapshot.sql을 읽어 문장 단위로 실행한다.
 * CREATE TABLE IF NOT EXISTS만 들어 있어 여러 번 돌려도 안전하다.
 */

import * as dotenv from 'dotenv';
import * as path from 'path';
import * as fs from 'fs';

dotenv.config({ path: path.join(__dirname, '..', '.env') });

import { RowDataPacket } from 'mysql2';
import pool from '../src/config/database';

const SQL_PATH = path.join(__dirname, '..', '..', 'database', 'enroll_snapshot.sql');

async function main() {
  if (!fs.existsSync(SQL_PATH)) {
    console.error(`마이그레이션 파일이 없습니다: ${SQL_PATH}`);
    process.exit(1);
  }

  // --recreate: 기존 테이블을 지우고 다시 만든다.
  // CREATE TABLE IF NOT EXISTS라 콜레이션 같은 정의 변경은 재생성해야 반영된다.
  if (process.argv.includes('--recreate')) {
    for (const t of ['enroll_snapshot_teacher', 'enroll_snapshot_row', 'enroll_snapshot']) {
      await pool.query(`DROP TABLE IF EXISTS ${t}`);
      console.log(`  DROP  ${t}`);
    }
  }

  const raw = fs.readFileSync(SQL_PATH, 'utf8');

  // 줄 주석을 걷어낸 뒤 문장 단위로 자른다. 프로시저가 없어 ';' 분리로 충분하다.
  const body = raw
    .split('\n')
    .filter((line) => !line.trim().startsWith('--'))
    .join('\n');

  const statements = body
    .split(';')
    .map((s) => s.trim())
    .filter(Boolean);

  let failed = 0;
  for (const st of statements) {
    const head = st.replace(/\s+/g, ' ').slice(0, 64);
    try {
      await pool.query(st);
      console.log(`  OK    ${head}`);
    } catch (error) {
      console.error(`  FAIL  ${head}\n        ${(error as Error).message}`);
      failed++;
    }
  }

  const [tables] = await pool.query<RowDataPacket[]>("SHOW TABLES LIKE 'enroll_snapshot%'");
  const names = tables.map((r) => Object.values(r)[0]);
  console.log(`\n생성된 테이블 (${names.length}개): ${names.join(', ')}`);

  await pool.end();
  process.exit(failed > 0 ? 1 : 0);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
