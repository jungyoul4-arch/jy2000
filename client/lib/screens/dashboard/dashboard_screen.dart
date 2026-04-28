import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../config/theme.dart';
import '../../providers/dashboard_provider.dart';
import '../../models/dashboard.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardProvider.notifier).loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('대시보드'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(dashboardProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: dashboardState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardState.error != null
              ? Center(child: Text('오류: ${dashboardState.error}'))
              : RefreshIndicator(
                  onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KPI Cards
                        if (dashboardState.kpi != null)
                          _buildKPISection(dashboardState.kpi!),

                        const SizedBox(height: 24),

                        // Charts Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 퍼널 차트
                            Expanded(
                              child: _buildFunnelChart(dashboardState.funnel),
                            ),
                            const SizedBox(width: 16),
                            // 월별 추이
                            Expanded(
                              child: _buildMonthlyTrendChart(dashboardState.monthlyTrend),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // TC 실적
                        _buildTCPerformanceTable(dashboardState.tcPerformance),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildKPISection(DashboardKPI kpi) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildKPICard(
          title: '전체 학생',
          value: '${kpi.totalStudents}',
          icon: Icons.people,
          color: Colors.blue,
        ),
        _buildKPICard(
          title: '이번 달 신규',
          value: '${kpi.newStudentsThisMonth}',
          icon: Icons.person_add,
          color: Colors.green,
        ),
        _buildKPICard(
          title: '이번 달 상담',
          value: '${kpi.consultsThisMonth}',
          icon: Icons.chat,
          color: Colors.orange,
        ),
        _buildKPICard(
          title: '이번 달 등록',
          value: '${kpi.registersThisMonth}',
          icon: Icons.how_to_reg,
          color: Colors.purple,
        ),
        _buildKPICard(
          title: '현재 재원',
          value: '${kpi.enrolledCount}',
          icon: Icons.school,
          color: Colors.teal,
        ),
        _buildKPICard(
          title: '전환율',
          value: '${kpi.conversionRate}%',
          icon: Icons.trending_up,
          color: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 24),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFunnelChart(List<FunnelData> funnel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '상태별 현황',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: funnel.isEmpty
                  ? const Center(child: Text('데이터 없음'))
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: funnel
                                .map((e) => e.count.toDouble())
                                .reduce((a, b) => a > b ? a : b) *
                            1.2,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${funnel[groupIndex].statusName}\n${funnel[groupIndex].count}명',
                                const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 && index < funnel.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      funnel[index].statusName,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: funnel.asMap().entries.map((entry) {
                          final index = entry.key;
                          final data = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: data.count.toDouble(),
                                color: AppTheme.getStatusColor(data.statusCode),
                                width: 30,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTrendChart(List<MonthlyTrend> trends) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '월별 등록 추이',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: trends.isEmpty
                  ? const Center(child: Text('데이터 없음'))
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 && index < trends.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      trends[index].month.substring(5),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: trends.asMap().entries.map((entry) {
                              return FlSpot(
                                entry.key.toDouble(),
                                entry.value.registerCount.toDouble(),
                              );
                            }).toList(),
                            isCurved: true,
                            color: AppTheme.primaryColor,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppTheme.primaryColor.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTCPerformanceTable(List<TCPerformance> performances) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TC별 실적',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            performances.isEmpty
                ? const Center(child: Text('데이터 없음'))
                : DataTable(
                    columns: const [
                      DataColumn(label: Text('TC')),
                      DataColumn(label: Text('담당 학생'), numeric: true),
                      DataColumn(label: Text('상담 완료'), numeric: true),
                      DataColumn(label: Text('등록'), numeric: true),
                      DataColumn(label: Text('총 상담'), numeric: true),
                    ],
                    rows: performances
                        .map(
                          (p) => DataRow(
                            cells: [
                              DataCell(Text(p.tcName)),
                              DataCell(Text('${p.totalStudents}')),
                              DataCell(Text('${p.consultCount}')),
                              DataCell(Text('${p.registerCount}')),
                              DataCell(Text('${p.consultTotal}')),
                            ],
                          ),
                        )
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
