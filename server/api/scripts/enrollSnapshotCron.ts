/**
 * 재원생 스냅샷 자동 생성 (crontab용)
 *
 * 실행: npx ts-node scripts/enrollSnapshotCron.ts [--force] [YYYY-MM]
 *
 * 인자가 없으면 전월을 대상으로 한다. 매월 1일에 돌리면 방금 끝난
 * 달이 통째로 굳는다.
 *
 * crontab 예 (매월 1일 새벽 2시)
 *   0 2 1 * * cd /srv/jy2000/server/api && \
 *     /usr/bin/npx ts-node scripts/enrollSnapshotCron.ts >> /var/log/jy2000/enroll-snapshot.log 2>&1
 *
 * 2026년 2~8월은 엑셀에서 백필했고(importEnrollSnapshots), 9월부터
 * 이 스크립트가 DB에서 직접 만든다. 이미 있는 달은 건너뛰므로 여러 번
 * 돌려도 안전하다. 다시 만들려면 --force를 준다.
 */

import * as dotenv from 'dotenv';
import * as path from 'path';

// 서버에는 .env가 있고 로컬에는 .env.local만 둔다. dotenv는 이미 설정된
// 값을 덮지 않으므로 .env가 있으면 그쪽이 이긴다.
// (로컬 .env를 FTP로 올려 서버 설정을 덮어쓴 사고가 세 번 있었다)
for (const file of ['.env', '.env.local']) {
  dotenv.config({ path: path.join(__dirname, '..', file) });
}

import { RowDataPacket } from 'mysql2';
import pool from '../src/config/database';
import enrollSnapshotService from '../src/services/enrollSnapshotService';

// toISOString은 UTC라 '10/1 02:00 KST'가 '9/30 17:00'으로 찍혀 cron이
// 엉뚱한 날 돈 것처럼 보였다. 이 시스템은 전부 KST 기준이다.
const stamp = () =>
  new Date().toLocaleString('sv-SE', { timeZone: 'Asia/Seoul' }).slice(0, 19);
const log = (msg: string) => console.log(`[${stamp()}] ${msg}`);

/** 인자가 없으면 전월. 있으면 'YYYY-MM'. */
function targetMonth(): { year: number; month: number } {
  const arg = process.argv.slice(2).find((a) => /^\d{4}-\d{1,2}$/.test(a));
  if (arg) {
    const [y, m] = arg.split('-').map(Number);
    return { year: y, month: m };
  }

  const now = new Date();
  const prev = new Date(now.getFullYear(), now.getMonth() - 1, 1);
  return { year: prev.getFullYear(), month: prev.getMonth() + 1 };
}

/** 그 달의 말일. 스냅샷 기준일로 남긴다. */
const lastDayOf = (year: number, month: number): string =>
  new Date(Date.UTC(year, month, 0)).toISOString().slice(0, 10);

async function main() {
  const { year, month } = targetMonth();
  const force = process.argv.includes('--force');

  log(`대상: ${year}년 ${month}월${force ? ' (강제 재생성)' : ''}`);

  const [existing] = await pool.query<RowDataPacket[]>(
    'SELECT source_kind, student_count, row_count FROM enroll_snapshot WHERE year = ? AND month = ?',
    [year, month]
  );

  // 엑셀로 넣은 달(2~8월 백필)은 건드리지 않는다. 사람이 받은 원본이 우선이다.
  if (existing.length > 0 && existing[0].source_kind === 'excel' && !force) {
    const e = existing[0];
    log(`엑셀 스냅샷이 있습니다 (재원생 ${e.student_count}명, 수강 ${e.row_count}건). 건너뜁니다.`);
    log('덮어쓰려면 --force를 주세요.');
    await pool.end();
    process.exit(0);
  }

  // DB로 만든 달은 다시 만든다. 월 중간에 미리 만들어 둔 스냅샷이 있으면
  // 수업기록이 덜 쌓인 상태로 굳어 있다 — 실제로 9월이 10일치로 남아
  // 수강이 4%, 국어가 8% 적게 잡혀 있었다. 월말 실행이 정본이다.
  if (existing.length > 0) {
    const e = existing[0];
    log(`기존 스냅샷을 다시 만듭니다 (재원생 ${e.student_count}명, 수강 ${e.row_count}건 → 갱신)`);
  }

  try {
    const result = await enrollSnapshotService.snapshotFromDb(year, month, {
      asOfDate: lastDayOf(year, month),
    });

    log(
      `생성 완료 — 반 ${result.classCount}개 · 수강 ${result.rowCount}건 · ` +
        `재원생 ${result.studentCount}명`
    );

    // 전월과 견줘 급격한 변동이 있으면 눈에 띄게 남긴다.
    // 수업기록이 덜 쌓인 시점에 돌면 반이 통째로 빠져 조용히 틀린 값이 굳는다.
    const prevMonth = month === 1 ? 12 : month - 1;
    const prevYear = month === 1 ? year - 1 : year;
    const [prev] = await pool.query<RowDataPacket[]>(
      'SELECT student_count FROM enroll_snapshot WHERE year = ? AND month = ?',
      [prevYear, prevMonth]
    );

    if (prev.length > 0 && prev[0].student_count > 0) {
      const diff = ((result.studentCount - prev[0].student_count) / prev[0].student_count) * 100;
      const line = `전월 대비 재원생 ${diff >= 0 ? '+' : ''}${diff.toFixed(1)}% (${prev[0].student_count} → ${result.studentCount})`;
      if (Math.abs(diff) >= 15) {
        log(`⚠ ${line} — 변동이 큽니다. 수업기록이 다 쌓인 뒤인지 확인하세요`);
      } else {
        log(line);
      }
    }

    await pool.end();
    process.exit(0);
  } catch (error) {
    log(`실패 — ${(error as Error).message}`);
    await pool.end();
    process.exit(1);
  }
}

main().catch(async (error) => {
  console.error(error);
  process.exit(1);
});
