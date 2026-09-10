/**
 * DB 스냅샷 검증 — 엑셀 백필분과 대조한다.
 *
 * 실행: npx ts-node scripts/verifyDbSnapshot.ts [월]   (기본 8)
 *
 * 8월을 쓰는 이유: 완전한 한 달이고 엑셀 대조값이 있다.
 * 9월로 재면 아직 열흘치뿐이라 주 1~2회 수업하는 반이 누락돼
 * 국어가 80명쯤 적게 나온다.
 *
 * DB 스냅샷을 임시 년월(9000+월)로 만들어 비교하므로 실제 8월
 * 엑셀 스냅샷은 건드리지 않는다.
 */

import * as dotenv from 'dotenv';
import * as path from 'path';

dotenv.config({ path: path.join(__dirname, '..', '.env') });

import { RowDataPacket } from 'mysql2';
import pool from '../src/config/database';
import enrollSnapshotService from '../src/services/enrollSnapshotService';

const YEAR = 2026;
const TEMP_YEAR = 9000; // 검증용 임시 자리. 실제 스냅샷과 섞이지 않는다.

async function summarize(year: number, month: number) {
  const [[head]] = await pool.query<RowDataPacket[]>(
    'SELECT student_count, row_count FROM enroll_snapshot WHERE year = ? AND month = ?',
    [year, month]
  );
  if (!head) return null;

  const [bySubject] = await pool.query<RowDataPacket[]>(
    `SELECT subject_group, COUNT(DISTINCT student_name) AS 인원
     FROM enroll_snapshot_row WHERE year = ? AND month = ?
     GROUP BY subject_group ORDER BY 인원 DESC`,
    [year, month]
  );

  const [byKind] = await pool.query<RowDataPacket[]>(
    `SELECT class_kind, COUNT(*) AS 건수
     FROM enroll_snapshot_row WHERE year = ? AND month = ?
     GROUP BY class_kind`,
    [year, month]
  );

  const [[classes]] = await pool.query<RowDataPacket[]>(
    `SELECT COUNT(DISTINCT class_name) AS 반수
     FROM enroll_snapshot_row WHERE year = ? AND month = ?`,
    [year, month]
  );

  return {
    students: head.student_count,
    rows: head.row_count,
    classes: classes.반수,
    bySubject: Object.fromEntries(bySubject.map((r) => [r.subject_group, r.인원])),
    byKind: Object.fromEntries(byKind.map((r) => [r.class_kind, r.건수])),
  };
}

async function main() {
  const month = Number(process.argv[2]) || 8;

  const excel = await summarize(YEAR, month);
  if (!excel) {
    console.error(`${YEAR}년 ${month}월 엑셀 스냅샷이 없습니다. 먼저 백필하세요.`);
    process.exit(1);
  }

  console.log(`${YEAR}년 ${month}월 · DB 스냅샷 생성 중...`);
  const built = await enrollSnapshotService.snapshotFromDb(YEAR, month, {
    note: '검증용 임시 스냅샷',
    storeAs: { year: TEMP_YEAR, month },
  });
  console.log(`  생성 완료 — 반 ${built.classCount}개 · 수강 ${built.rowCount}건 · 학생 ${built.studentCount}명\n`);

  const db = await summarize(TEMP_YEAR, month);
  if (!db) {
    console.error('DB 스냅샷 조회 실패');
    process.exit(1);
  }

  const pct = (a: number, b: number) => (b === 0 ? '—' : `${(((a - b) / b) * 100).toFixed(1)}%`);
  const line = (label: string, d: number, e: number) =>
    console.log(`  ${label.padEnd(12)} DB ${String(d).padStart(6)}   엑셀 ${String(e).padStart(6)}   ${pct(d, e).padStart(7)}`);

  console.log('── 총계 ' + '─'.repeat(48));
  line('학생', db.students, excel.students);
  line('수강 건수', db.rows, excel.rows);
  line('반 수', db.classes, excel.classes);

  console.log('\n── 과목별 수강 인원 ' + '─'.repeat(36));
  const groups = new Set([...Object.keys(db.bySubject), ...Object.keys(excel.bySubject)]);
  for (const g of groups) {
    line(g, db.bySubject[g] ?? 0, excel.bySubject[g] ?? 0);
  }

  console.log('\n── 반 성격 ' + '─'.repeat(45));
  const kinds = new Set([...Object.keys(db.byKind), ...Object.keys(excel.byKind)]);
  for (const k of kinds) {
    line(k, db.byKind[k] ?? 0, excel.byKind[k] ?? 0);
  }

  // 임시 스냅샷 정리
  await pool.query('DELETE FROM enroll_snapshot WHERE year = ?', [TEMP_YEAR]);
  console.log('\n임시 스냅샷을 지웠습니다.');

  await pool.end();
}

main().catch(async (error) => {
  console.error(error);
  try {
    await pool.query('DELETE FROM enroll_snapshot WHERE year = ?', [TEMP_YEAR]);
  } catch {
    /* 정리 실패는 무시 */
  }
  process.exit(1);
});
