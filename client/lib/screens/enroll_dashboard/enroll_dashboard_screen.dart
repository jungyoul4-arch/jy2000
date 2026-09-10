import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../../models/enroll_dashboard.dart';
import '../../providers/enroll_dashboard_provider.dart';
import '../../widgets/logout_button.dart';

/// 재원생 경영 대시보드
///
/// 2~8월은 aca2000 엑셀을 적재한 값이고, 9월부터는 매월 1일 cron이
/// DB에서 직접 만든다. 두 소스는 집계 방식이 같아도 원본이 달라
/// 8→9월 변화에 소스 차이가 섞인다(재원생 +6.7%, 국어 -10.6%,
/// 과학 -17.9%). 그래서 월 선택기와 헤더에 출처를 표시한다.
class EnrollDashboardScreen extends ConsumerWidget {
  const EnrollDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(enrollDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('재원생 경영 대시보드'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
            onPressed: () {
              ref.invalidate(enrollMonthsProvider);
              ref.invalidate(enrollTrendProvider);
              ref.invalidate(enrollDashboardProvider);
            },
          ),
          const SizedBox(width: 8),
          const LogoutButton(),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SelectableText(
              '대시보드를 불러오지 못했습니다\n\n$error',
              style: const TextStyle(color: AppTheme.errorColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (dashboard) {
          if (dashboard == null) {
            return const Center(
              child: Text('스냅샷이 아직 없습니다. 재원생 데이터를 먼저 적재하세요.'),
            );
          }
          return _Body(dashboard: dashboard);
        },
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final EnrollDashboard dashboard;

  const _Body({required this.dashboard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wide = MediaQuery.of(context).size.width > 1000;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MonthPicker(current: dashboard.snapshot),
          const SizedBox(height: 16),
          _KpiRow(kpi: dashboard.kpi, snapshot: dashboard.snapshot),
          const SizedBox(height: 24),

          const _SectionTitle('월별 추이', '이름 기준 월간 연결 · 학년 필터 미적용'),
          const _TrendSection(),
          const SizedBox(height: 24),

          _GradeFilter(grades: dashboard.byGrade),
          const SizedBox(height: 16),

          const _SectionTitle('학생 구성 · 과목', '아래 카드는 학년 필터가 적용됩니다'),
          _Grid(wide: wide, children: [
            _BarCard(
              title: '학년별 재원생',
              note: '명',
              items: dashboard.byGrade
                  .map((g) => NamedValue(name: g.name, value: g.value))
                  .toList(),
            ),
            _BarCard(
              title: '과목별 수강 인원',
              note: '명 (한 학생이 여러 과목 수강 가능)',
              items: dashboard.bySubject,
            ),
            _BarCard(
              title: '1인당 수강 과목 수',
              note: '학생 수 · 대분류 기준',
              items: dashboard.byNsubj,
              sorted: false,
            ),
            _BarCard(
              title: '학교별 재원생',
              note: '상위 18개교',
              items: dashboard.bySchool,
            ),
          ]),
          const SizedBox(height: 24),

          const _SectionTitle('과학 집중 분석', '중점 개발 과목 · 어느 학년에서 끊기는지'),
          _Grid(wide: wide, children: [
            _ScienceFunnelCard(science: dashboard.science),
            _BarCard(
              title: '과학 세부 과목',
              note: '수강 인원',
              items: dashboard.science.bySubject,
            ),
          ]),
          const SizedBox(height: 24),

          const _SectionTitle('반 운영', '정규반 기준 · 내신대비반은 따로 셉니다'),
          _Grid(wide: wide, children: [
            _BarCard(
              title: '반 성격',
              note: '반 수 · 정규 / 내신대비 / 특강',
              items: dashboard.byClassKind,
              sorted: false,
            ),
            _BarCard(
              title: '반 규모 분포',
              note: '정규반 수 · 인원 구간별',
              items: dashboard.byClassSize,
              sorted: false,
            ),
            _SmallClassCard(classes: dashboard.smallClasses),
            _TeacherCard(teachers: dashboard.byTeacher),
          ]),
          const SizedBox(height: 24),

          const _SectionTitle('업셀 타겟', '한 과목만 듣는 학생 · 추가 과목 상담 우선순위'),
          _UpsellCard(targets: dashboard.upsell, total: dashboard.kpi.upsellTargets),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ============================================================
// 월 선택 · 출처 표시
// ============================================================

class _MonthPicker extends ConsumerWidget {
  final SnapshotInfo current;

  const _MonthPicker({required this.current});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthsAsync = ref.watch(enrollMonthsProvider);

    return monthsAsync.when(
      loading: () => const SizedBox(height: 40),
      error: (_, _) => const SizedBox(height: 40),
      data: (months) => Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final m in months)
            ChoiceChip(
              label: Text(m.label),
              selected: m.year == current.year && m.month == current.month,
              // DB 자동 생성분은 테두리로 구분한다. 엑셀분과 원본이 달라
              // 수치를 견줄 때 알고 있어야 한다.
              avatar: m.isFromDb
                  ? const Icon(Icons.storage, size: 14)
                  : const Icon(Icons.table_view, size: 14),
              onSelected: (_) {
                ref.read(enrollPeriodProvider.notifier).state =
                    EnrollPeriod(year: m.year, month: m.month);
              },
            ),
          const SizedBox(width: 8),
          _SourceBadge(snapshot: current),
        ],
      ),
    );
  }
}

class _SourceBadge extends StatelessWidget {
  final SnapshotInfo snapshot;

  const _SourceBadge({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final parts = <String>[
      '출처: ${snapshot.sourceLabel}',
      if (snapshot.asOfDate != null) '기준 ${snapshot.asOfDate}',
    ];

    return Tooltip(
      message: snapshot.sourceNote ??
          (snapshot.isFromDb
              ? '수업기록이 있는 반을 그 달의 운영 반으로 보고 DB에서 집계했습니다'
              : 'aca2000 재원생 DB 엑셀을 적재한 값입니다'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: snapshot.isFromDb
              ? AppTheme.accentColor.withValues(alpha: 0.10)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          parts.join(' · '),
          style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
        ),
      ),
    );
  }
}

// ============================================================
// KPI
// ============================================================

class _KpiRow extends StatelessWidget {
  final EnrollKpi kpi;
  final SnapshotInfo snapshot;

  const _KpiRow({required this.kpi, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _KpiTile(label: '재원생', value: '${kpi.students}', unit: '명'),
        _KpiTile(label: '수강 건수', value: '${kpi.enrollments}', unit: '건'),
        _KpiTile(
          label: '1인당 과목',
          value: kpi.subjectsPerStudent.toStringAsFixed(2),
          unit: '과목',
        ),
        _KpiTile(
          label: '정규반',
          value: '${kpi.regularClasses}',
          unit: '반',
          note: '전체 ${kpi.classes}반',
        ),
        _KpiTile(
          label: '과학 수강률',
          value: kpi.scienceRate.toStringAsFixed(1),
          unit: '%',
        ),
        _KpiTile(
          label: '업셀 타겟',
          value: '${kpi.upsellTargets}',
          unit: '명',
          note: '1과목 수강생',
          alert: true,
        ),
      ],
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String? note;
  final bool alert;

  const _KpiTile({
    required this.label,
    required this.value,
    required this.unit,
    this.note,
    this.alert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: alert ? AppTheme.warningColor : Colors.black87,
                ),
              ),
              const SizedBox(width: 3),
              Text(unit, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
          if (note != null)
            Text(note!, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}

// ============================================================
// 월별 추이
// ============================================================

class _TrendSection extends ConsumerWidget {
  const _TrendSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(enrollTrendProvider);
    final wide = MediaQuery.of(context).size.width > 1000;

    return trendAsync.when(
      loading: () => const SizedBox(height: 240, child: Center(child: CircularProgressIndicator())),
      error: (e, _) => _CardShell(
        title: '월별 추이',
        note: '불러오지 못했습니다',
        child: SelectableText('$e', style: const TextStyle(color: AppTheme.errorColor)),
      ),
      data: (points) {
        if (points.isEmpty) {
          return const _CardShell(title: '월별 추이', note: '', child: Text('데이터 없음'));
        }
        return _Grid(wide: wide, children: [
          _CardShell(
            title: '재원생 수 추이',
            note: '월말 기준 명',
            child: SizedBox(height: 200, child: _TrendChart(points: points)),
          ),
          _CardShell(
            title: '월별 신규 · 퇴원',
            note: '전월 대비 등록/이탈 학생 수',
            child: _FlowTable(points: points),
          ),
        ]);
      },
    );
  }
}

class _TrendChart extends StatelessWidget {
  final List<EnrollTrendPoint> points;

  const _TrendChart({required this.points});

  @override
  Widget build(BuildContext context) {
    final maxY = points.map((p) => p.students).reduce((a, b) => a > b ? a : b).toDouble();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY * 1.15,
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                value.toInt().toString(),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= points.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    points[i].label,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < points.length; i++)
                FlSpot(i.toDouble(), points[i].students.toDouble()),
            ],
            isCurved: false,
            barWidth: 2,
            color: AppTheme.primaryColor,
            // DB 자동 생성분은 점을 채워 구분한다.
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, _, _, index) => FlDotCirclePainter(
                radius: 3.5,
                color: points[index].isFromDb ? AppTheme.accentColor : Colors.white,
                strokeColor: AppTheme.primaryColor,
                strokeWidth: 2,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppTheme.primaryColor.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowTable extends StatelessWidget {
  final List<EnrollTrendPoint> points;

  const _FlowTable({required this.points});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 22,
        headingRowHeight: 34,
        dataRowMinHeight: 32,
        dataRowMaxHeight: 38,
        columns: const [
          DataColumn(label: Text('월')),
          DataColumn(label: Text('재원생'), numeric: true),
          DataColumn(label: Text('신규'), numeric: true),
          DataColumn(label: Text('퇴원'), numeric: true),
          DataColumn(label: Text('1인당'), numeric: true),
          DataColumn(label: Text('출처')),
        ],
        rows: [
          for (final p in points)
            DataRow(cells: [
              DataCell(Text(p.label)),
              DataCell(Text('${p.students}')),
              DataCell(Text(
                p.newStudents == null ? '-' : '+${p.newStudents}',
                style: const TextStyle(color: AppTheme.successColor),
              )),
              DataCell(Text(
                p.leftStudents == null ? '-' : '-${p.leftStudents}',
                style: const TextStyle(color: AppTheme.errorColor),
              )),
              DataCell(Text(p.subjectsPerStudent.toStringAsFixed(2))),
              DataCell(Text(
                p.isFromDb ? 'DB' : '엑셀',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              )),
            ]),
        ],
      ),
    );
  }
}

// ============================================================
// 학년 필터
// ============================================================

class _GradeFilter extends ConsumerWidget {
  final List<GradeCount> grades;

  const _GradeFilter({required this.grades});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(enrollGradeFilterProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          label: const Text('전체'),
          selected: selected == null,
          onSelected: (_) => ref.read(enrollGradeFilterProvider.notifier).state = null,
        ),
        for (final g in grades)
          if (g.grade > 0)
            ChoiceChip(
              label: Text('${g.name} ${g.value}'),
              selected: selected == g.grade,
              onSelected: (_) =>
                  ref.read(enrollGradeFilterProvider.notifier).state =
                      selected == g.grade ? null : g.grade,
            ),
      ],
    );
  }
}

// ============================================================
// 공용 위젯
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String note;

  const _SectionTitle(this.title, this.note);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (note.isNotEmpty)
            Text(note, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

/// 넓으면 2열, 좁으면 1열
class _Grid extends StatelessWidget {
  final bool wide;
  final List<Widget> children;

  const _Grid({required this.wide, required this.children});

  @override
  Widget build(BuildContext context) {
    if (!wide) {
      return Column(
        children: [
          for (final c in children)
            Padding(padding: const EdgeInsets.only(bottom: 14), child: c),
        ],
      );
    }

    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += 2) {
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: children[i]),
            const SizedBox(width: 14),
            Expanded(
              child: i + 1 < children.length ? children[i + 1] : const SizedBox.shrink(),
            ),
          ],
        ),
      ));
    }
    return Column(children: rows);
  }
}

class _CardShell extends StatelessWidget {
  final String title;
  final String note;
  final Widget child;

  const _CardShell({required this.title, required this.note, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
          if (note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 1, bottom: 12),
              child: Text(note, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            )
          else
            const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// 가로 막대 목록
class _BarCard extends StatelessWidget {
  final String title;
  final String note;
  final List<NamedValue> items;

  /// false면 서버가 준 순서를 유지한다(과목 수 분포처럼 순서 자체가 의미인 경우).
  final bool sorted;

  const _BarCard({
    required this.title,
    required this.note,
    required this.items,
    this.sorted = true,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _CardShell(title: title, note: note, child: const Text('데이터 없음'));
    }

    final list = sorted ? ([...items]..sort((a, b) => b.value.compareTo(a.value))) : items;
    final max = list.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return _CardShell(
      title: title,
      note: note,
      child: Column(
        children: [
          for (final item in list)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      item.name,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) => Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 16,
                          width: max == 0 ? 2 : (c.maxWidth * item.value / max).clamp(2, c.maxWidth),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${item.value}',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// 개별 카드
// ============================================================

class _ScienceFunnelCard extends StatelessWidget {
  final ScienceSection science;

  const _ScienceFunnelCard({required this.science});

  @override
  Widget build(BuildContext context) {
    final rows = science.byGrade.where((g) => g.total > 0).toList();

    return _CardShell(
      title: '학년별 과학 침투율',
      note: '각 학년 재원생 중 과학 수강 비율 — 어디서 끊기는지',
      child: Column(
        children: [
          for (final g in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: Text(
                      g.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) => Stack(
                        children: [
                          Container(height: 16, color: Colors.grey.shade200),
                          Container(
                            height: 16,
                            width: (c.maxWidth * g.rate / 100).clamp(0, c.maxWidth),
                            color: AppTheme.successColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 92,
                    child: Text(
                      '${g.rate.toStringAsFixed(0)}%  (${g.science}/${g.total})',
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SmallClassCard extends StatelessWidget {
  final List<ClassInfoItem> classes;

  const _SmallClassCard({required this.classes});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: '소인수 반 (4명 이하)',
      note: '정규반 기준 · 통폐합·증원 검토 대상 ${classes.length}개',
      child: classes.isEmpty
          ? const Text('없습니다')
          : ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          classes[i].name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12.5),
                        ),
                      ),
                      Text(
                        '${classes[i].size}명',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  final List<TeacherLoad> teachers;

  const _TeacherCard({required this.teachers});

  @override
  Widget build(BuildContext context) {
    final list = teachers.take(20).toList();
    if (list.isEmpty) {
      return const _CardShell(title: '강사별 담당', note: '', child: Text('데이터 없음'));
    }
    final max = list.map((t) => t.students).reduce((a, b) => a > b ? a : b);

    return _CardShell(
      title: '강사별 담당 현황',
      note: '담당 학생 수 · 괄호는 반 수 (공동 담당은 각 강사에 모두 집계)',
      child: Column(
        children: [
          for (final t in list)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: Text(
                      t.name,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) => Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 16,
                          width: (c.maxWidth * t.students / max).clamp(2, c.maxWidth),
                          decoration: const BoxDecoration(
                            color: AppTheme.accentColor,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 66,
                    child: Text(
                      '${t.students}명 (${t.classes})',
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _UpsellCard extends StatelessWidget {
  final List<UpsellTarget> targets;
  final int total;

  const _UpsellCard({required this.targets, required this.total});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: '업셀 타겟 — 1과목 수강생',
      note: total > targets.length
          ? '전체 $total명 중 상위 ${targets.length}명'
          : '$total명',
      child: targets.isEmpty
          ? const Text('없습니다')
          : ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 420),
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 28,
                  headingRowHeight: 34,
                  dataRowMinHeight: 32,
                  dataRowMaxHeight: 38,
                  columns: const [
                    DataColumn(label: Text('이름')),
                    DataColumn(label: Text('학년')),
                    DataColumn(label: Text('학교')),
                    DataColumn(label: Text('수강 과목')),
                  ],
                  rows: [
                    for (final t in targets)
                      DataRow(cells: [
                        DataCell(Text(t.name)),
                        DataCell(Text(t.gradeName)),
                        DataCell(Text(t.school ?? '-')),
                        DataCell(Text(t.subject)),
                      ]),
                  ],
                ),
              ),
            ),
    );
  }
}
