import { RowDataPacket } from 'mysql2';

import pool from '../config/database';
import { AppError } from '../middlewares/errorHandler';
import enrollSnapshotService from './enrollSnapshotService';

/**
 * 재원생 경영 대시보드 집계.
 *
 * enroll_snapshot_row 한 테이블만 읽는다. 원본이 엑셀이든 DB든
 * 같은 모양으로 굳혀 두었기 때문에 집계는 출처를 신경 쓰지 않아도 된다.
 *
 * 다만 화면에는 출처를 표시해야 한다. 2~8월(엑셀)과 9월(DB)은 집계
 * 방식이 같아도 원본이 달라 8→9월 변화에 소스 차이가 섞인다.
 * 8월을 양쪽으로 만들어 대조했을 때 재원생 +6.7%, 국어 -10.6%,
 * 과학 -17.9%였다.
 */

const GRADE_NAMES: { [key: number]: string } = {
  1: '초1', 2: '초2', 3: '초3', 4: '초4', 5: '초5', 6: '초6',
  7: '중1', 8: '중2', 9: '중3',
  10: '고1', 11: '고2', 12: '고3',
  13: 'N수',
};

export const gradeName = (grade: number | null): string =>
  grade === null ? '미상' : GRADE_NAMES[grade] ?? `${grade}학년`;

/**
 * DATE 컬럼을 'YYYY-MM-DD'로 만든다.
 *
 * mysql2가 DATE를 Date 객체로 돌려주는데 String()을 씌우면
 * 'Wed Sep 30 …' 꼴이 된다. toISOString은 UTC로 밀려 하루 어긋난다.
 */
const toDateString = (value: unknown): string | null => {
  if (!value) return null;
  if (value instanceof Date) {
    const y = value.getFullYear();
    const m = String(value.getMonth() + 1).padStart(2, '0');
    const d = String(value.getDate()).padStart(2, '0');
    return `${y}-${m}-${d}`;
  }
  return String(value).slice(0, 10);
};

// 과학 세부 과목. 과학 섹션이 이 목록으로 걸린다.
const SCIENCE_SUBJECTS = ['통합과학', '물리', '화학', '생명', '지구과학', '과학'];

/**
 * 종합반 여부.
 *
 * 엑셀분의 '구분'은 단과/종합/약술단과/약술종합 4종이고, DB분은
 * User.is_jonghap을 종합/단과 둘로 적는다. 약술종합도 종합으로 세야 해서
 * 부분 일치로 본다.
 */
const isJonghap = (attendType: unknown): boolean =>
  typeof attendType === 'string' && attendType.includes('종합');

/** 집계가 받는 수강 한 건. 스냅샷 조회분과 '현재' 생성분이 같은 모양이다. */
interface AggRow {
  student_name: string;
  grade: number | null;
  school_name: string | null;
  attend_type: string | null;
  subject: string;
  subject_group: string;
  class_name: string | null;
  class_kind: string;
}

interface AggTeacher {
  teacher_name: string;
  student_name: string;
  class_name: string | null;
}

/** 월별 추이 한 점 */
export interface TrendPoint {
  year: number;
  month: number;
  sourceKind: string;
  students: number;
  jonghapStudents: number | null;
  jonghapChange: number | null;
  enrollments: number;
  subjectsPerStudent: number;
  classes: number;
  newStudents: number | null;
  leftStudents: number | null;
}

/** 월별 추이에서 한 달치를 모으는 자리 */
interface TrendBucket {
  students: Set<string>;
  jonghap: Set<string>;
  /** 그 달에 attend_type이 한 건이라도 있는가 — 없으면 종합반 수를 null로 낸다 */
  hasAttendType: boolean;
  subjects: Set<string>;
  classes: Set<string>;
  rows: number;
}

export interface MonthInfo {
  year: number;
  month: number;
  sourceKind: string;
  sourceNote: string | null;
  asOfDate: string | null;
  studentCount: number;
  rowCount: number;
  /** 굳힐 때 적어 둔 종합반 수. 그 전에 만들어진 달은 null이다. */
  jonghapCount: number | null;
}

export class EnrollDashboardService {
  /** 스냅샷이 있는 년월 목록. 화면의 월 선택기가 쓴다. */
  async getMonths(): Promise<MonthInfo[]> {
    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT year, month, source_kind, source_note, as_of_date,
              student_count, row_count, jonghap_count
       FROM enroll_snapshot
       ORDER BY year, month`
    );

    return rows.map((r) => ({
      year: Number(r.year),
      month: Number(r.month),
      sourceKind: r.source_kind,
      sourceNote: r.source_note,
      asOfDate: toDateString(r.as_of_date),
      studentCount: Number(r.student_count),
      rowCount: Number(r.row_count),
      jonghapCount: r.jonghap_count === null ? null : Number(r.jonghap_count),
    }));
  }

  /**
   * 월별 추이 — 재원생 수, 종합반 수, 수강 건수, 1인당 과목 수, 신규/퇴원.
   *
   * 신규·퇴원은 이름 기준으로 전월과 견준다. 엑셀이 동명이인을
   * '김나경A'/'김나경B'로 구분해 둬 이름이 사실상 유일키 역할을 한다.
   * student_id는 매칭률이 86~88%라 여기 쓰면 이탈이 부풀려진다.
   *
   * 종합반 수는 attend_type이 있는 달만 낸다. 2~8월(엑셀)은 '구분'
   * 칸에서 왔고, DB분은 User.is_jonghap이 생긴 뒤 만들어진 달부터 있다.
   * 값이 없는 달은 0이 아니라 null이라야 차트가 선을 끊는다 —
   * 0으로 내리면 종합반이 전멸한 달처럼 보인다.
   *
   * 맨 뒤에는 '현재' 한 점을 덧붙인다. 월 스냅샷은 전월까지만 있어서
   * 달 중반을 넘기면 마지막 스냅샷과 실제가 꽤 벌어진다.
   */
  async getTrend(): Promise<TrendPoint[]> {
    const months = await this.getMonths();
    if (months.length === 0) return [];

    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT year, month, student_name, subject_group, class_name, attend_type
       FROM enroll_snapshot_row`
    );

    const byMonth = new Map<string, TrendBucket>();

    for (const r of rows) {
      const key = `${r.year}-${r.month}`;
      if (!byMonth.has(key)) {
        byMonth.set(key, {
          students: new Set(),
          jonghap: new Set(),
          hasAttendType: false,
          subjects: new Set(),
          classes: new Set(),
          rows: 0,
        });
      }
      const b = byMonth.get(key)!;
      b.students.add(r.student_name);
      b.subjects.add(`${r.student_name}|${r.subject_group}`);
      if (r.class_name) b.classes.add(r.class_name);
      if (r.attend_type) b.hasAttendType = true;
      if (isJonghap(r.attend_type)) b.jonghap.add(r.student_name);
      b.rows++;
    }

    // 종합반 수는 굳힐 때 적어 둔 값(User 기준)을 먼저 쓴다. 그 컬럼이
    // 생기기 전 달 — 2~8월 엑셀분 — 은 '구분' 칸에서 역산한다.
    // 엑셀분은 구분이 원본 기록이라 그쪽이 오히려 정확하다.
    const jonghapOf = (m: MonthInfo, b?: TrendBucket) =>
      m.jonghapCount ?? (b?.hasAttendType ? b.jonghap.size : null);

    const series: TrendPoint[] = months.map((m, i) => {
      const cur = byMonth.get(`${m.year}-${m.month}`);
      const prev = i > 0 ? byMonth.get(`${months[i - 1].year}-${months[i - 1].month}`) : undefined;

      const students = cur?.students ?? new Set<string>();
      let newStudents: number | null = null;
      let leftStudents: number | null = null;

      if (prev) {
        newStudents = [...students].filter((s) => !prev.students.has(s)).length;
        leftStudents = [...prev.students].filter((s) => !students.has(s)).length;
      }

      const jonghapStudents = jonghapOf(m, cur);
      const prevJonghap = i > 0 ? jonghapOf(months[i - 1], prev) : null;

      return {
        year: m.year,
        month: m.month,
        sourceKind: m.sourceKind,
        students: students.size,
        jonghapStudents,
        // 양쪽 달에 다 값이 있을 때만 증감을 낸다
        jonghapChange:
          jonghapStudents !== null && prevJonghap !== null ? jonghapStudents - prevJonghap : null,
        enrollments: cur?.rows ?? 0,
        subjectsPerStudent:
          students.size > 0 ? Math.round(((cur?.subjects.size ?? 0) / students.size) * 100) / 100 : 0,
        classes: cur?.classes.size ?? 0,
        newStudents,
        leftStudents,
      };
    });

    const last = months[months.length - 1];
    const live = await this.liveTrendPoint(
      byMonth.get(`${last.year}-${last.month}`),
      jonghapOf(last, byMonth.get(`${last.year}-${last.month}`))
    );
    if (live) series.push(live);

    return series;
  }

  /**
   * 추이 맨 뒤에 붙는 '현재' 한 점.
   *
   * 숫자는 '현재' 보기의 상단 카드와 같은 기준으로 맞춘다 — 재원생은
   * 이번 달 수업기록이 있는 반 기준, 종합반은 User 기준. 카드와 차트가
   * 다른 값을 말하면 어느 쪽을 믿어야 할지 알 수 없다.
   *
   * 이번 달 수업기록이 아직 없으면(달 바뀐 직후) 점을 만들지 않는다.
   * 전월로 물러나 붙이면 같은 달이 두 번 찍힌다.
   */
  private async liveTrendPoint(
    prev: TrendBucket | undefined,
    prevJonghap: number | null
  ): Promise<TrendPoint | null> {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth() + 1;

    let built;
    try {
      ({ rows: built } = await enrollSnapshotService.collectFromDb(year, month));
    } catch (error) {
      if (error instanceof AppError && error.statusCode === 404) return null;
      throw error;
    }

    const students = new Set(built.map((r) => r.studentName));
    const subjects = new Set(built.map((r) => `${r.studentName}|${r.subjectGroup}`));
    const classes = new Set(built.filter((r) => r.className).map((r) => r.className));

    const [jonghapRows] = await pool.query<RowDataPacket[]>(
      'SELECT COUNT(*) AS cnt FROM User WHERE kind = 2 AND active_flag = 1 AND is_jonghap = 1'
    );
    const jonghapStudents = Number(jonghapRows[0]?.cnt ?? 0);

    return {
      year,
      month,
      sourceKind: 'live',
      students: students.size,
      jonghapStudents,
      jonghapChange: prevJonghap === null ? null : jonghapStudents - prevJonghap,
      enrollments: built.length,
      subjectsPerStudent:
        students.size > 0 ? Math.round((subjects.size / students.size) * 100) / 100 : 0,
      classes: classes.size,
      newStudents: prev ? [...students].filter((s) => !prev.students.has(s)).length : null,
      leftStudents: prev ? [...prev.students].filter((s) => !students.has(s)).length : null,
    };
  }

  /** 저장된 월 스냅샷 한 달치 대시보드 전체. */
  async getDashboard(
    year: number,
    month: number,
    options: { grade?: number | null } = {}
  ): Promise<Record<string, unknown>> {
    const [head] = await pool.query<RowDataPacket[]>(
      `SELECT year, month, source_kind, source_note, as_of_date,
              student_count, row_count, jonghap_count
       FROM enroll_snapshot WHERE year = ? AND month = ?`,
      [year, month]
    );
    if (head.length === 0) {
      throw new AppError(`${year}년 ${month}월 스냅샷이 없습니다`, 404);
    }

    // 같은 조건을 두 쿼리가 쓰는데 테이블 별칭이 달라 접두사를 받아 만든다.
    const gradeFilter = options.grade ?? null;
    const params: unknown[] = [year, month];
    if (gradeFilter !== null) params.push(gradeFilter);

    const whereFor = (prefix: string) => {
      const p = prefix ? `${prefix}.` : '';
      const parts = [`${p}year = ?`, `${p}month = ?`];
      if (gradeFilter !== null) parts.push(`${p}grade = ?`);
      return parts.join(' AND ');
    };

    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT row_id, student_name, grade, school_name, attend_type,
              subject, subject_group, class_name, class_kind
       FROM enroll_snapshot_row WHERE ${whereFor('')}`,
      params
    );

    const [teachers] = await pool.query<RowDataPacket[]>(
      `SELECT t.teacher_name, r.student_name, r.class_name, r.class_kind
       FROM enroll_snapshot_teacher t
       JOIN enroll_snapshot_row r ON r.row_id = t.row_id
       WHERE ${whereFor('r')}`,
      params
    );

    const h = head[0];

    // 종합반 수.
    //   전체를 볼 때는 굳힐 때 적어 둔 값(User 기준)을 그대로 쓴다.
    //   학년을 좁히면 그 값으로는 쪼갤 수 없어 행에서 센다.
    //   둘 다 없는 달(구분도 없고 집계 전)은 0이 아니라 null — 화면에 '-'.
    const hasAttendType = (rows as AggRow[]).some((r) => r.attend_type);
    const fromRows = hasAttendType
      ? new Set((rows as AggRow[]).filter((r) => isJonghap(r.attend_type)).map((r) => r.student_name))
          .size
      : null;
    const storedCount = h.jonghap_count === null ? null : Number(h.jonghap_count);
    const jonghapStudents = gradeFilter === null ? storedCount ?? fromRows : fromRows;

    return this.aggregate(rows as AggRow[], teachers as AggTeacher[], {
      year: Number(h.year),
      month: Number(h.month),
      sourceKind: h.source_kind,
      sourceNote: h.source_note,
      asOfDate: toDateString(h.as_of_date),
      jonghapStudents,
    });
  }

  /**
   * '현재' 보기 — 저장된 스냅샷 대신 지금 DB 상태로 집계한다.
   *
   * 월 스냅샷은 매월 1일 cron이 전월을 굳히므로 이번 달은 비어 있다.
   * 화면 기본값이 이 보기라 원장이 들어오자마자 오늘 수치를 본다.
   *
   * 집계 함수는 월 스냅샷과 같은 것을 쓴다. 이번 달이 다음 달 1일에
   * 굳으면 같은 값이 그대로 스냅샷이 된다.
   */
  async getCurrent(options: { grade?: number | null } = {}): Promise<Record<string, unknown>> {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth() + 1;
    const gradeFilter = options.grade ?? null;

    // 달이 막 바뀌면 이번 달 수업기록이 아직 없어 집계가 비어 버린다.
    // 그때는 전월 기록으로 물러나고 어느 달을 봤는지 배지에 적는다.
    // 비어 있다고 404를 내면 화면 기본 보기가 통째로 깨진다.
    let sourceNote: string | null = null;
    let built;
    let teachersByGroup;
    try {
      ({ rows: built, teachersByGroup } = await enrollSnapshotService.collectFromDb(year, month));
    } catch (error) {
      if (!(error instanceof AppError) || error.statusCode !== 404) throw error;

      const prevYear = month === 1 ? year - 1 : year;
      const prevMonth = month === 1 ? 12 : month - 1;
      ({ rows: built, teachersByGroup } = await enrollSnapshotService.collectFromDb(
        prevYear,
        prevMonth
      ));
      sourceNote = `${month}월 수업기록이 아직 없어 ${prevMonth}월 기준으로 집계했습니다`;
    }

    const picked = gradeFilter === null ? built : built.filter((r) => r.grade === gradeFilter);

    const rows: AggRow[] = picked.map((r) => ({
      student_name: r.studentName,
      grade: r.grade,
      school_name: r.schoolName,
      attend_type: r.isJonghap ? '종합' : '단과',
      subject: r.subject,
      subject_group: r.subjectGroup,
      class_name: r.className,
      class_kind: r.classKind,
    }));

    // 강사는 반 단위로 붙어 있어 수강 행마다 펴 준다. 스냅샷 테이블이
    // 이미 펴 둔 모양과 같게 맞춘다.
    const teachers: AggTeacher[] = [];
    for (const r of picked) {
      for (const name of teachersByGroup.get(r.groupKey)?.keys() ?? []) {
        teachers.push({
          teacher_name: name,
          student_name: r.studentName,
          class_name: r.className,
        });
      }
    }

    // 종합반 카드만 User를 직접 센다. 재원생 수는 '이번 달 수업기록이
    // 있는 반'에 속한 학생이지만, 종합반은 반 배정과 무관하게
    // 소속 자체를 보는 값이라 원장이 보는 기준과 맞춘다.
    const jonghapParams: unknown[] = [];
    let jonghapSql =
      'SELECT COUNT(*) AS cnt FROM User WHERE kind = 2 AND active_flag = 1 AND is_jonghap = 1';
    if (gradeFilter !== null) {
      jonghapSql += ' AND grade = ?';
      jonghapParams.push(gradeFilter);
    }
    const [jonghapRows] = await pool.query<RowDataPacket[]>(jonghapSql, jonghapParams);

    const pad = (n: number) => String(n).padStart(2, '0');

    return this.aggregate(rows, teachers, {
      year,
      month,
      sourceKind: 'live',
      sourceNote,
      asOfDate: `${year}-${pad(month)}-${pad(now.getDate())}`,
      jonghapStudents: Number(jonghapRows[0]?.cnt ?? 0),
    });
  }

  /**
   * 집계 본체. 월 스냅샷 조회분과 '현재' 생성분이 같이 쓴다.
   *
   * 카드마다 따로 호출하면 왕복이 열 번을 넘는다. 한 달 데이터가
   * 1,000~1,600행이라 한 번에 집계해 내려도 부담이 없다.
   */
  private aggregate(
    rows: AggRow[],
    teachers: AggTeacher[],
    snapshot: {
      year: number;
      month: number;
      sourceKind: string;
      sourceNote: string | null;
      asOfDate: string | null;
      jonghapStudents: number | null;
    }
  ): Record<string, unknown> {
    // ── 학생 단위 집계 ────────────────────────────────────
    const students = new Map<
      string,
      { grade: number | null; school: string | null; subjects: Set<string>; classes: Set<string> }
    >();

    for (const r of rows) {
      if (!students.has(r.student_name)) {
        students.set(r.student_name, {
          grade: r.grade === null ? null : Number(r.grade),
          school: r.school_name,
          subjects: new Set(),
          classes: new Set(),
        });
      }
      const s = students.get(r.student_name)!;
      s.subjects.add(r.subject_group);
      if (r.class_name) s.classes.add(r.class_name);
    }

    const count = <T>(items: T[], key: (t: T) => string) => {
      const m = new Map<string, number>();
      for (const it of items) m.set(key(it), (m.get(key(it)) ?? 0) + 1);
      return m;
    };

    const sortDesc = (m: Map<string, number>) =>
      [...m.entries()].sort((a, b) => b[1] - a[1]).map(([name, value]) => ({ name, value }));

    // 학년별
    const byGrade = [...students.values()].reduce((acc, s) => {
      const k = s.grade ?? -1;
      acc.set(k, (acc.get(k) ?? 0) + 1);
      return acc;
    }, new Map<number, number>());

    // 과목별 — 학생 중복 없이 센다 (한 학생이 같은 과목 반 둘을 들어도 1명)
    const subjectStudents = new Map<string, Set<string>>();
    const groupStudents = new Map<string, Set<string>>();
    for (const r of rows) {
      if (!subjectStudents.has(r.subject)) subjectStudents.set(r.subject, new Set());
      subjectStudents.get(r.subject)!.add(r.student_name);
      if (!groupStudents.has(r.subject_group)) groupStudents.set(r.subject_group, new Set());
      groupStudents.get(r.subject_group)!.add(r.student_name);
    }

    // 1인당 과목 수 분포
    const nsubj = new Map<number, number>();
    for (const s of students.values()) {
      nsubj.set(s.subjects.size, (nsubj.get(s.subjects.size) ?? 0) + 1);
    }

    // 반 — 성격별로 나눈다. 9월부터 학교별 내신대비반이 1~2명씩
    // 대량으로 생겨 정규반과 섞으면 「반 규모 분포」가 뒤덮인다.
    const classes = new Map<string, { kind: string; students: Set<string> }>();
    for (const r of rows) {
      if (!r.class_name) continue;
      if (!classes.has(r.class_name)) {
        classes.set(r.class_name, { kind: r.class_kind, students: new Set() });
      }
      classes.get(r.class_name)!.students.add(r.student_name);
    }

    const sizeBucket = (n: number) =>
      n === 1 ? '1명' : n <= 4 ? '2-4명' : n <= 9 ? '5-9명' : n <= 19 ? '10-19명' : '20명+';

    const classList = [...classes.entries()].map(([name, c]) => ({
      name,
      kind: c.kind,
      size: c.students.size,
    }));

    const regularClasses = classList.filter((c) => c.kind === '정규');

    // 강사별 — 공동 담당은 각 강사에 모두 집계한다(엑셀 대시보드와 동일)
    const teacherMap = new Map<string, { students: Set<string>; classes: Set<string> }>();
    for (const t of teachers) {
      if (!teacherMap.has(t.teacher_name)) {
        teacherMap.set(t.teacher_name, { students: new Set(), classes: new Set() });
      }
      const e = teacherMap.get(t.teacher_name)!;
      e.students.add(t.student_name);
      if (t.class_name) e.classes.add(t.class_name);
    }

    // ── 과학 집중 ─────────────────────────────────────────
    const scienceStudents = new Set(
      rows.filter((r) => SCIENCE_SUBJECTS.includes(r.subject)).map((r) => r.student_name)
    );

    const scienceByGrade = new Map<number, { total: number; science: number }>();
    for (const [name, s] of students) {
      const g = s.grade ?? -1;
      if (!scienceByGrade.has(g)) scienceByGrade.set(g, { total: 0, science: 0 });
      const e = scienceByGrade.get(g)!;
      e.total++;
      if (scienceStudents.has(name)) e.science++;
    }

    const scienceBySubject = new Map<string, Set<string>>();
    for (const r of rows) {
      if (!SCIENCE_SUBJECTS.includes(r.subject)) continue;
      if (!scienceBySubject.has(r.subject)) scienceBySubject.set(r.subject, new Set());
      scienceBySubject.get(r.subject)!.add(r.student_name);
    }

    // ── 업셀 타겟 — 한 과목만 듣는 학생 ─────────────────────
    const upsell = [...students.entries()]
      .filter(([, s]) => s.subjects.size === 1)
      .map(([name, s]) => ({
        name,
        grade: s.grade,
        gradeName: gradeName(s.grade),
        school: s.school,
        subject: [...s.subjects][0],
      }))
      .sort((a, b) => (b.grade ?? 0) - (a.grade ?? 0) || a.name.localeCompare(b.name));

    return {
      snapshot: {
        year: snapshot.year,
        month: snapshot.month,
        sourceKind: snapshot.sourceKind,
        sourceNote: snapshot.sourceNote,
        asOfDate: snapshot.asOfDate,
      },
      kpi: {
        students: students.size,
        jonghapStudents: snapshot.jonghapStudents,
        enrollments: rows.length,
        classes: classes.size,
        regularClasses: regularClasses.length,
        subjectsPerStudent:
          students.size > 0
            ? Math.round(
                ([...students.values()].reduce((a, s) => a + s.subjects.size, 0) / students.size) * 100
              ) / 100
            : 0,
        scienceRate:
          students.size > 0 ? Math.round((scienceStudents.size / students.size) * 1000) / 10 : 0,
        upsellTargets: upsell.length,
      },
      byGrade: [...byGrade.entries()]
        .sort((a, b) => a[0] - b[0])
        .map(([grade, value]) => ({ grade, name: gradeName(grade === -1 ? null : grade), value })),
      bySubject: sortDesc(
        new Map([...subjectStudents].map(([k, v]) => [k, v.size]))
      ),
      bySubjectGroup: sortDesc(new Map([...groupStudents].map(([k, v]) => [k, v.size]))),
      byNsubj: [...nsubj.entries()]
        .sort((a, b) => a[0] - b[0])
        .map(([n, value]) => ({ name: `${n}과목`, value })),
      bySchool: sortDesc(
        count(
          [...students.values()].filter((s) => s.school),
          (s) => s.school as string
        )
      ).slice(0, 18),
      byClassKind: sortDesc(count(classList, (c) => c.kind)),
      byClassSize: ['1명', '2-4명', '5-9명', '10-19명', '20명+'].map((bucket) => ({
        name: bucket,
        value: regularClasses.filter((c) => sizeBucket(c.size) === bucket).length,
      })),
      smallClasses: regularClasses
        .filter((c) => c.size <= 4)
        .sort((a, b) => a.size - b.size || a.name.localeCompare(b.name)),
      byTeacher: [...teacherMap.entries()]
        .map(([name, t]) => ({ name, students: t.students.size, classes: t.classes.size }))
        .sort((a, b) => b.students - a.students),
      science: {
        students: scienceStudents.size,
        byGrade: [...scienceByGrade.entries()]
          .sort((a, b) => a[0] - b[0])
          .map(([grade, e]) => ({
            grade,
            name: gradeName(grade === -1 ? null : grade),
            total: e.total,
            science: e.science,
            rate: e.total > 0 ? Math.round((e.science / e.total) * 1000) / 10 : 0,
          })),
        bySubject: sortDesc(new Map([...scienceBySubject].map(([k, v]) => [k, v.size]))),
      },
      upsell: upsell.slice(0, 200),
    };
  }
}

export default new EnrollDashboardService();
