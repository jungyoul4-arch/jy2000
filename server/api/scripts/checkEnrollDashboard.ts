/**
 * 대시보드 집계 점검 — API를 띄우지 않고 서비스만 직접 돌려 본다.
 *
 * 실행: npx ts-node scripts/checkEnrollDashboard.ts [YYYY-MM]
 */

import * as dotenv from 'dotenv';
import * as path from 'path';

dotenv.config({ path: path.join(__dirname, '..', '.env') });

import pool from '../src/config/database';
import svc from '../src/services/enrollDashboardService';

async function main() {
  const arg = process.argv.slice(2).find((a) => /^\d{4}-\d{1,2}$/.test(a));
  const months = await svc.getMonths();

  console.log('── 스냅샷 목록 ' + '─'.repeat(46));
  for (const m of months) {
    console.log(
      `  ${m.year}-${String(m.month).padStart(2, '0')}  ${m.sourceKind.padEnd(5)}  ` +
        `재원생 ${String(m.studentCount).padStart(3)}  수강 ${String(m.rowCount).padStart(4)}` +
        (m.sourceNote ? `  ※ ${m.sourceNote}` : '')
    );
  }

  console.log('\n── 월별 추이 ' + '─'.repeat(48));
  console.log('   월    출처   재원생  수강   반   1인당  신규  퇴원');
  for (const t of await svc.getTrend()) {
    console.log(
      `  ${String(t.month).padStart(2)}월  ${t.sourceKind.padEnd(5)}  ` +
        `${String(t.students).padStart(5)}  ${String(t.enrollments).padStart(5)}  ` +
        `${String(t.classes).padStart(4)}  ${t.subjectsPerStudent.toFixed(2).padStart(5)}  ` +
        `${String(t.newStudents ?? '-').padStart(4)}  ${String(t.leftStudents ?? '-').padStart(4)}`
    );
  }

  const [y, m] = arg ? arg.split('-').map(Number) : [months.at(-1)!.year, months.at(-1)!.month];
  const d = (await svc.getDashboard(y, m)) as any;

  console.log(`\n── ${y}년 ${m}월 대시보드 ` + '─'.repeat(38));
  console.log('  KPI:', JSON.stringify(d.kpi));
  console.log('  출처:', JSON.stringify(d.snapshot));

  const brief = (label: string, arr: any[], n = 8) =>
    console.log(
      `  ${label}: ` +
        arr
          .slice(0, n)
          .map((x) => `${x.name}=${x.value ?? x.students ?? x.size ?? ''}`)
          .join('  ')
    );

  brief('학년별', d.byGrade);
  brief('과목별', d.bySubject, 12);
  brief('대분류', d.bySubjectGroup);
  brief('1인당 과목', d.byNsubj);
  brief('학교별', d.bySchool, 6);
  brief('반 성격', d.byClassKind);
  brief('반 규모', d.byClassSize);
  console.log(`  소인수 반(4명 이하): ${d.smallClasses.length}개`);
  console.log(
    '  강사별 상위: ' +
      d.byTeacher
        .slice(0, 6)
        .map((t: any) => `${t.name}(${t.students}명/${t.classes}반)`)
        .join('  ')
  );
  console.log(`  과학 수강 ${d.science.students}명`);
  console.log(
    '  학년별 과학 침투율: ' +
      d.science.byGrade.map((g: any) => `${g.name} ${g.rate}%(${g.science}/${g.total})`).join('  ')
  );
  brief('과학 세부', d.science.bySubject);
  console.log(`  업셀 타겟(1과목): ${d.kpi.upsellTargets}명`);

  await pool.end();
}

main().catch(async (e) => {
  console.error(e);
  process.exit(1);
});
