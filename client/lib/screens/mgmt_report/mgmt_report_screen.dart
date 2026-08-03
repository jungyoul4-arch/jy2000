import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/routes.dart';
import '../../models/mgmt_report.dart';
import '../../providers/mgmt_data_provider.dart';
import '../../widgets/logout_button.dart';

class MgmtReportScreen extends ConsumerStatefulWidget {
  const MgmtReportScreen({super.key});

  @override
  ConsumerState<MgmtReportScreen> createState() => _MgmtReportScreenState();
}

class _MgmtReportScreenState extends ConsumerState<MgmtReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _numberFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    Future.microtask(() {
      ref.read(mgmtReportProvider.notifier).loadReport();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mgmtReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('경영 보고서'),
        actions: const [LogoutButton()],
      ),
      body: Column(
        children: [
          // 기간 선택 영역
          _buildPeriodSelector(state),
          const Divider(height: 1),

          // 본문 영역
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 48),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(horizontal: 32),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: SelectableText(
                                '오류: ${state.error}',
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () {
                                ref.read(mgmtReportProvider.notifier).loadReport();
                              },
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : state.report == null
                        ? const Center(child: Text('데이터가 없습니다'))
                        : _buildReportContent(state.report!),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(MgmtReportState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.date_range, size: 20),
              const SizedBox(width: 8),
              const Text('기간: ', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              // 시작 년월
              _buildYearMonthDropdown(
                state.startYear,
                state.startMonth,
                (year, month) {
                  ref.read(mgmtReportProvider.notifier).changePeriod(
                        startYear: year,
                        startMonth: month,
                        endYear: state.endYear,
                        endMonth: state.endMonth,
                      );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('~'),
              ),
              // 종료 년월
              _buildYearMonthDropdown(
                state.endYear,
                state.endMonth,
                (year, month) {
                  ref.read(mgmtReportProvider.notifier).changePeriod(
                        startYear: state.startYear,
                        startMonth: state.startMonth,
                        endYear: year,
                        endMonth: month,
                      );
                },
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () {
                  ref.read(mgmtReportProvider.notifier).loadReport();
                },
                child: const Text('조회'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('빠른 선택: ', style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(mgmtReportProvider.notifier).selectThisMonth();
                },
                child: const Text('이번 달'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(mgmtReportProvider.notifier).selectLast3Months();
                },
                child: const Text('최근 3개월'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(mgmtReportProvider.notifier).selectLast6Months();
                },
                child: const Text('최근 6개월'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(mgmtReportProvider.notifier).selectThisYear();
                },
                child: const Text('올해 전체'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYearMonthDropdown(int year, int month, Function(int, int) onChanged) {
    final now = DateTime.now();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<int>(
          value: year,
          items: List.generate(5, (i) => now.year - 2 + i)
              .map((y) => DropdownMenuItem(value: y, child: Text('$y년')))
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(value, month);
          },
        ),
        const SizedBox(width: 8),
        DropdownButton<int>(
          value: month,
          items: List.generate(12, (i) => i + 1)
              .map((m) => DropdownMenuItem(value: m, child: Text('$m월')))
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(year, value);
          },
        ),
      ],
    );
  }

  Widget _buildReportContent(MgmtReport report) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI 카드
          _buildKpiCards(report.summary),
          const SizedBox(height: 16),

          // 지역별 분석 버튼
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.mgmtReportRegion),
                icon: const Icon(Icons.map_outlined),
                label: const Text('지역별 분석'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 차트 영역
          _buildChartsSection(report),
          const SizedBox(height: 24),

          // 상세 테이블
          _buildDetailTables(report),
        ],
      ),
    );
  }

  Widget _buildKpiCards(MgmtReportSummary summary) {
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            '총 매출',
            '${_numberFormat.format(summary.totalRevenue)}원',
            Icons.attach_money,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            '총 수강건수',
            '${summary.totalEnrollments.toStringAsFixed(1)}건',
            Icons.school,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            '학생 수',
            '${summary.studentCount}명',
            Icons.people,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            '평균 단가',
            '${_numberFormat.format(summary.avgUnitPrice)}원',
            Icons.trending_up,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection(MgmtReport report) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 월별 매출 추이 (Line Chart)
        Expanded(
          child: _buildChartCard(
            '월별 매출 추이',
            SizedBox(
              height: 250,
              child: report.monthlyTrend.isEmpty
                  ? const Center(child: Text('데이터 없음'))
                  : _buildMonthlyTrendChart(report.monthlyTrend),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // 과목별 매출 비중 (Pie Chart)
        Expanded(
          child: _buildChartCard(
            '과목별 매출 비중',
            SizedBox(
              height: 250,
              child: report.bySubject.isEmpty
                  ? const Center(child: Text('데이터 없음'))
                  : _buildSubjectPieChart(report.bySubject),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTrendChart(List<MonthlyTrend> data) {
    if (data.isEmpty) return const SizedBox();

    final maxY = data.map((e) => e.revenue.toDouble()).reduce((a, b) => a > b ? a : b);
    final spots = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.revenue.toDouble());
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY > 0 ? maxY / 4 : 1,
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value == meta.min) return const SizedBox();
                return Text(
                  _formatNumber(value),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= data.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${data[index].month}월',
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 4,
                color: Colors.blue,
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.spotIndex;
                if (index < 0 || index >= data.length) return null;
                return LineTooltipItem(
                  '${data[index].year}년 ${data[index].month}월\n${_numberFormat.format(data[index].revenue)}원',
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectPieChart(List<SubjectStat> data) {
    if (data.isEmpty) return const SizedBox();

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
      Colors.deepPurple,
      Colors.lightGreen,
    ];

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return PieChartSectionData(
                  value: item.revenue.toDouble(),
                  title: item.percentage >= 5 ? '${item.percentage}%' : '',
                  color: colors[index % colors.length],
                  radius: 60,
                  titleStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${item.subject} (${item.percentage}%)',
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailTables(MgmtReport report) {
    return Card(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: '강사별'),
              Tab(text: '과목별'),
              Tab(text: '학년별'),
              Tab(text: '학교별'),
              Tab(text: '반형태별'),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTeacherTable(report.byTeacher),
                _buildSubjectTable(report.bySubject),
                _buildGradeTable(report.byGrade),
                _buildSchoolTable(report.bySchool),
                _buildClassTypeTable(report.byClassType),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherTable(List<TeacherStat> data) {
    final totalRevenue = data.fold<int>(0, (sum, e) => sum + e.revenue);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('강사')),
          DataColumn(label: Text('수강건'), numeric: true),
          DataColumn(label: Text('학생수'), numeric: true),
          DataColumn(label: Text('매출'), numeric: true),
          DataColumn(label: Text('비중'), numeric: true),
        ],
        rows: [
          ...data.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.teacherName)),
                  DataCell(Text(item.enrollments.toStringAsFixed(1))),
                  DataCell(Text(item.studentCount.toString())),
                  DataCell(Text(_numberFormat.format(item.revenue))),
                  DataCell(Text('${(item.revenue / (totalRevenue > 0 ? totalRevenue : 1) * 100).toStringAsFixed(1)}%')),
                ],
              )),
          DataRow(
            color: WidgetStateProperty.all(Colors.grey.shade100),
            cells: [
              const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<double>(0, (sum, e) => sum + e.enrollments).toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<int>(0, (sum, e) => sum + e.studentCount).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_numberFormat.format(totalRevenue),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              const DataCell(Text('100%', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectTable(List<SubjectStat> data) {
    final totalRevenue = data.fold<int>(0, (sum, e) => sum + e.revenue);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('과목')),
          DataColumn(label: Text('수강건'), numeric: true),
          DataColumn(label: Text('매출'), numeric: true),
          DataColumn(label: Text('비중'), numeric: true),
        ],
        rows: [
          ...data.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.subject)),
                  DataCell(Text(item.enrollments.toStringAsFixed(1))),
                  DataCell(Text(_numberFormat.format(item.revenue))),
                  DataCell(Text('${item.percentage}%')),
                ],
              )),
          DataRow(
            color: WidgetStateProperty.all(Colors.grey.shade100),
            cells: [
              const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<double>(0, (sum, e) => sum + e.enrollments).toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_numberFormat.format(totalRevenue),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              const DataCell(Text('100%', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeTable(List<GradeStat> data) {
    final totalRevenue = data.fold<int>(0, (sum, e) => sum + e.revenue);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('학년')),
          DataColumn(label: Text('학생수'), numeric: true),
          DataColumn(label: Text('매출'), numeric: true),
          DataColumn(label: Text('비중'), numeric: true),
        ],
        rows: [
          ...data.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.gradeName)),
                  DataCell(Text(item.studentCount.toString())),
                  DataCell(Text(_numberFormat.format(item.revenue))),
                  DataCell(Text('${(item.revenue / (totalRevenue > 0 ? totalRevenue : 1) * 100).toStringAsFixed(1)}%')),
                ],
              )),
          DataRow(
            color: WidgetStateProperty.all(Colors.grey.shade100),
            cells: [
              const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<int>(0, (sum, e) => sum + e.studentCount).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_numberFormat.format(totalRevenue),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              const DataCell(Text('100%', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolTable(List<SchoolStat> data) {
    final totalRevenue = data.fold<int>(0, (sum, e) => sum + e.revenue);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('학교')),
          DataColumn(label: Text('학생수'), numeric: true),
          DataColumn(label: Text('매출'), numeric: true),
          DataColumn(label: Text('비중'), numeric: true),
        ],
        rows: [
          ...data.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.schoolName)),
                  DataCell(Text(item.studentCount.toString())),
                  DataCell(Text(_numberFormat.format(item.revenue))),
                  DataCell(Text('${(item.revenue / (totalRevenue > 0 ? totalRevenue : 1) * 100).toStringAsFixed(1)}%')),
                ],
              )),
          DataRow(
            color: WidgetStateProperty.all(Colors.grey.shade100),
            cells: [
              const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<int>(0, (sum, e) => sum + e.studentCount).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_numberFormat.format(totalRevenue),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              const DataCell(Text('100%', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassTypeTable(List<ClassTypeStat> data) {
    final totalRevenue = data.fold<int>(0, (sum, e) => sum + e.revenue);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('반형태')),
          DataColumn(label: Text('수강건'), numeric: true),
          DataColumn(label: Text('매출'), numeric: true),
          DataColumn(label: Text('비중'), numeric: true),
        ],
        rows: [
          ...data.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.classTypeName)),
                  DataCell(Text(item.enrollments.toStringAsFixed(1))),
                  DataCell(Text(_numberFormat.format(item.revenue))),
                  DataCell(Text('${(item.revenue / (totalRevenue > 0 ? totalRevenue : 1) * 100).toStringAsFixed(1)}%')),
                ],
              )),
          DataRow(
            color: WidgetStateProperty.all(Colors.grey.shade100),
            cells: [
              const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(data.fold<double>(0, (sum, e) => sum + e.enrollments).toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_numberFormat.format(totalRevenue),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              const DataCell(Text('100%', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(double value) {
    if (value >= 10000000) {
      return '${(value / 10000000).toStringAsFixed(1)}천만';
    } else if (value >= 10000) {
      return '${(value / 10000).toStringAsFixed(0)}만';
    } else {
      return _numberFormat.format(value.toInt());
    }
  }
}
