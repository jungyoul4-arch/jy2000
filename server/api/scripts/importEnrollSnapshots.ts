/**
 * 재원생 DB 엑셀 일괄 적재 (1회성)
 *
 * 실행: npx ts-node scripts/importEnrollSnapshots.ts [엑셀폴더]
 *       기본 폴더: <repo>/document/acadata
 *
 * 7월은 원본이 없다. 6월과 7월 파일이 md5까지 동일해 실제로는 같은
 * 파일이 두 번 받아진 것이라, 6월 스냅샷을 7월로 복제하고 그 사실을
 * source_note에 남긴다. 나중에 진짜 7월 파일을 구하면 그때 덮어쓰면 된다.
 */

import * as dotenv from 'dotenv';
import * as path from 'path';
import * as fs from 'fs';

dotenv.config({ path: path.join(__dirname, '..', '.env') });

import pool from '../src/config/database';
import enrollSnapshotService from '../src/services/enrollSnapshotService';

const YEAR = 2026;

// 2~8월만 엑셀로 백필한다. 9월부터는 DB에서 직접 스냅샷을 만들므로
// (enrollSnapshotCron) 여기서 넣으면 나중에 덮어써야 한다.
// 7월은 6월 복제로 처리하므로 파일 목록에서 뺀다.
const MONTHS = [2, 3, 4, 5, 6, 8];

const CARRIED_OVER = {
  from: { year: YEAR, month: 6 },
  to: { year: YEAR, month: 7 },
  note: '6월 데이터 재사용 — 7월 원본 미확보(6월 파일과 내용 동일)',
};

const PARTIAL_MONTHS: { [month: number]: string } = {};

const lastDayOf = (year: number, month: number): string => {
  const d = new Date(Date.UTC(year, month, 0));
  return d.toISOString().slice(0, 10);
};

async function main() {
  const dir = process.argv[2]
    ? path.resolve(process.argv[2])
    : path.join(__dirname, '..', '..', '..', 'document', 'acadata');

  if (!fs.existsSync(dir)) {
    console.error(`엑셀 폴더가 없습니다: ${dir}`);
    process.exit(1);
  }

  console.log(`엑셀 폴더: ${dir}\n`);

  let ok = 0;
  let failed = 0;

  for (const month of MONTHS) {
    const file = path.join(dir, `재원생 DB_${month}월.xlsx`);

    if (!fs.existsSync(file)) {
      console.warn(`  ${month}월  건너뜀 — 파일 없음 (${path.basename(file)})`);
      failed++;
      continue;
    }

    try {
      const result = await enrollSnapshotService.importFile(file, YEAR, month, {
        asOfDate: lastDayOf(YEAR, month),
      });

      const note = PARTIAL_MONTHS[month] ? `  ※ ${PARTIAL_MONTHS[month]}` : '';
      console.log(
        `  ${String(month).padStart(2)}월  재원생 ${String(result.studentCount).padStart(3)}명  ` +
          `수강 ${String(result.rowCount).padStart(4)}건${note}`
      );
      ok++;

      if (PARTIAL_MONTHS[month]) {
        await pool.query('UPDATE enroll_snapshot SET source_note = ? WHERE snapshot_id = ?', [
          PARTIAL_MONTHS[month],
          result.snapshotId,
        ]);
      }
    } catch (error) {
      console.error(`  ${month}월  실패 — ${(error as Error).message}`);
      failed++;
    }
  }

  // 7월 복제는 6월 적재가 끝난 뒤라야 한다.
  try {
    const copied = await enrollSnapshotService.copyMonth(
      CARRIED_OVER.from,
      CARRIED_OVER.to,
      CARRIED_OVER.note
    );
    console.log(`   7월  6월 복제  수강 ${String(copied.rowCount).padStart(4)}건  ※ ${CARRIED_OVER.note}`);
    ok++;
  } catch (error) {
    console.error(`   7월  복제 실패 — ${(error as Error).message}`);
    failed++;
  }

  // 적재 결과 확인
  const [summary] = await pool.query(
    `SELECT s.year, s.month, s.student_count AS 재원생, s.row_count AS 수강건,
            SUM(r.class_kind = '정규') AS 정규,
            SUM(r.class_kind = '내신') AS 내신,
            SUM(r.class_kind = '특강') AS 특강,
            SUM(r.student_id IS NOT NULL) AS 학생매칭,
            s.source_note AS 비고
     FROM enroll_snapshot s
     LEFT JOIN enroll_snapshot_row r ON r.snapshot_id = s.snapshot_id
     GROUP BY s.snapshot_id
     ORDER BY s.year, s.month`
  );

  console.log('\n── 적재 결과 ────────────────────────────────────────');
  console.table(summary);
  console.log(`\n성공 ${ok}건 / 실패 ${failed}건`);

  await pool.end();
  process.exit(failed > 0 ? 1 : 0);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
