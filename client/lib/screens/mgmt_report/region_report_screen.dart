import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../models/mgmt_report.dart';
import '../../providers/mgmt_data_provider.dart';
import '../../widgets/logout_button.dart';

class RegionReportScreen extends ConsumerStatefulWidget {
  const RegionReportScreen({super.key});

  @override
  ConsumerState<RegionReportScreen> createState() => _RegionReportScreenState();
}

class _RegionReportScreenState extends ConsumerState<RegionReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _numberFormat = NumberFormat('#,###');

  // 탭2: 선택된 지역
  String? _selectedRegionForGrade;
  // 탭3: 선택된 지역
  String? _selectedRegionForSchool;

  // 차트 색상
  final _chartColors = [
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
  ];

  // '기타', '미지정'을 맨 뒤로 보내는 정렬
  void _sortWithEtcLast(List<String> list) {
    list.sort((a, b) {
      final aIsEtc = a == '기타' || a == '미지정';
      final bIsEtc = b == '기타' || b == '미지정';
      if (aIsEtc && !bIsEtc) return 1;
      if (!aIsEtc && bIsEtc) return -1;
      return a.compareTo(b);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(() {
      ref.read(regionReportProvider.notifier).loadReport();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(regionReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('지역별 학생수 분석'),
        actions: const [LogoutButton()],
      ),
      body: Column(
        children: [
          // 기간 선택 영역
          _buildPeriodSelector(state),
          const Divider(height: 1),

          // 탭 바
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: '지역별 추이'),
              Tab(text: '학년별'),
              Tab(text: '학교별'),
            ],
          ),

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
                                ref.read(regionReportProvider.notifier).loadReport();
                              },
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : state.report == null
                        ? const Center(child: Text('데이터가 없습니다'))
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              _buildRegionMonthlyTab(state.report!),
                              _buildRegionGradeTab(state.report!),
                              _buildSchoolTab(state.report!),
                            ],
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(RegionReportState state) {
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
                  ref.read(regionReportProvider.notifier).changePeriod(
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
                  ref.read(regionReportProvider.notifier).changePeriod(
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
                  ref.read(regionReportProvider.notifier).loadReport();
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
                  ref.read(regionReportProvider.notifier).selectThisMonth();
                },
                child: const Text('이번 달'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(regionReportProvider.notifier).selectLast3Months();
                },
                child: const Text('최근 3개월'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(regionReportProvider.notifier).selectLast6Months();
                },
                child: const Text('최근 6개월'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(regionReportProvider.notifier).selectThisYear();
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

  // ============================================================
  // 탭 1: 지역별 월별 추이
  // ============================================================
  Widget _buildRegionMonthlyTab(RegionReport report) {
    final data = report.byRegionMonthly;
    if (data.isEmpty) {
      return const Center(child: Text('데이터가 없습니다'));
    }

    // 지역 목록 추출 (기타는 맨 뒤로)
    final regions = data.map((e) => e.regionName).toSet().toList();
    _sortWithEtcLast(regions);
    // 월 목록 추출
    final months = data.map((e) => '${e.year}.${e.month}').toSet().toList();
    months.sort();

    // 피벗 데이터 생성: region -> month -> count
    final pivotData = <String, Map<String, int>>{};
    for (final item in data) {
      final monthKey = '${item.year}.${item.month}';
      pivotData.putIfAbsent(item.regionName, () => {});
      pivotData[item.regionName]![monthKey] = item.studentCount;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 차트
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '지역별 월별 학생수 추이',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: _buildMultiLineChart(regions, months, pivotData),
                  ),
                  const SizedBox(height: 16),
                  // 범례
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: regions.asMap().entries.map((entry) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _chartColors[entry.key % _chartColors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(entry.value, style: const TextStyle(fontSize: 12)),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 테이블
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '지역별 월별 학생수',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildPivotTable(regions, months, pivotData),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLineChart(
    List<String> regions,
    List<String> months,
    Map<String, Map<String, int>> pivotData,
  ) {
    if (months.isEmpty) return const SizedBox();

    // 최대값 계산
    int maxY = 0;
    for (final regionData in pivotData.values) {
      for (final count in regionData.values) {
        if (count > maxY) maxY = count;
      }
    }
    maxY = ((maxY / 10).ceil() * 10) + 10; // 여유 공간

    final lineBarsData = <LineChartBarData>[];
    for (var i = 0; i < regions.length; i++) {
      final region = regions[i];
      final spots = <FlSpot>[];
      for (var j = 0; j < months.length; j++) {
        final count = pivotData[region]?[months[j]] ?? 0;
        spots.add(FlSpot(j.toDouble(), count.toDouble()));
      }
      lineBarsData.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: _chartColors[i % _chartColors.length],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      );
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY > 0 ? maxY / 5 : 1,
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value == meta.min) return const SizedBox();
                return Text(
                  value.toInt().toString(),
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
                if (index < 0 || index >= months.length) return const SizedBox();
                final parts = months[index].split('.');
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${parts[1]}월',
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
        lineBarsData: lineBarsData,
        minY: 0,
        maxY: maxY.toDouble(),
      ),
    );
  }

  Widget _buildPivotTable(
    List<String> regions,
    List<String> months,
    Map<String, Map<String, int>> pivotData,
  ) {
    // 열: 지역, 월1, 월2, ..., 합계
    final columns = <DataColumn>[
      const DataColumn(label: Text('지역')),
      ...months.map((m) {
        final parts = m.split('.');
        return DataColumn(label: Text('${parts[1]}월'), numeric: true);
      }),
      const DataColumn(label: Text('합계'), numeric: true),
    ];

    // 행
    final rows = <DataRow>[];
    final monthTotals = <String, int>{};
    int grandTotal = 0;

    for (final region in regions) {
      int rowTotal = 0;
      final cells = <DataCell>[
        DataCell(Text(region)),
      ];

      for (final month in months) {
        final count = pivotData[region]?[month] ?? 0;
        rowTotal += count;
        monthTotals[month] = (monthTotals[month] ?? 0) + count;
        cells.add(DataCell(Text(count.toString())));
      }

      grandTotal += rowTotal;
      cells.add(DataCell(Text(
        rowTotal.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));

      rows.add(DataRow(cells: cells));
    }

    // 합계 행
    final totalCells = <DataCell>[
      const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
    for (final month in months) {
      totalCells.add(DataCell(Text(
        (monthTotals[month] ?? 0).toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));
    }
    totalCells.add(DataCell(Text(
      grandTotal.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    )));

    rows.add(DataRow(
      color: WidgetStateProperty.all(Colors.grey.shade100),
      cells: totalCells,
    ));

    return DataTable(
      columnSpacing: 24,
      columns: columns,
      rows: rows,
    );
  }

  // ============================================================
  // 탭 2: 지역별 학년별 추이
  // ============================================================
  Widget _buildRegionGradeTab(RegionReport report) {
    final data = report.byRegionGradeMonthly;
    if (data.isEmpty) {
      return const Center(child: Text('데이터가 없습니다'));
    }

    // 지역 목록 추출 (기타는 맨 뒤로)
    final regions = data.map((e) => e.regionName).toSet().toList();
    _sortWithEtcLast(regions);

    // 선택된 지역이 없거나 유효하지 않으면 '부천 원미구' 또는 첫 번째 지역 선택
    if (_selectedRegionForGrade == null || !regions.contains(_selectedRegionForGrade)) {
      _selectedRegionForGrade = regions.contains('부천 원미구') ? '부천 원미구' : regions.first;
    }

    // 선택된 지역의 데이터 필터링
    final filteredData = data.where((e) => e.regionName == _selectedRegionForGrade).toList();

    // 학년 목록 추출 (미지정은 맨 뒤로)
    final grades = filteredData.map((e) => e.gradeName).toSet().toList();
    grades.sort((a, b) {
      // 학년 정렬 (중1, 중2, 중3, 고1, 고2, 고3, 미지정 순)
      final order = ['중1', '중2', '중3', '고1', '고2', '고3'];
      final aIndex = order.indexOf(a);
      final bIndex = order.indexOf(b);
      if (aIndex == -1 && bIndex == -1) return a.compareTo(b);
      if (aIndex == -1) return 1;
      if (bIndex == -1) return -1;
      return aIndex.compareTo(bIndex);
    });

    // 월 목록 추출
    final months = filteredData.map((e) => '${e.year}.${e.month}').toSet().toList();
    months.sort();

    // 피벗 데이터: grade -> month -> count
    final pivotData = <String, Map<String, int>>{};
    for (final item in filteredData) {
      final monthKey = '${item.year}.${item.month}';
      pivotData.putIfAbsent(item.gradeName, () => {});
      pivotData[item.gradeName]![monthKey] = item.studentCount;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 지역 선택 드롭다운
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('지역 선택: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedRegionForGrade,
                    items: regions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRegionForGrade = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 차트
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_selectedRegionForGrade - 학년별 월별 학생수 추이',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: _buildMultiLineChart(grades, months, pivotData),
                  ),
                  const SizedBox(height: 16),
                  // 범례
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: grades.asMap().entries.map((entry) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _chartColors[entry.key % _chartColors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(entry.value, style: const TextStyle(fontSize: 12)),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 테이블
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_selectedRegionForGrade - 학년별 월별 학생수',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildGradePivotTable(grades, months, pivotData),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradePivotTable(
    List<String> grades,
    List<String> months,
    Map<String, Map<String, int>> pivotData,
  ) {
    // 열: 학년, 월1, 월2, ..., 합계
    final columns = <DataColumn>[
      const DataColumn(label: Text('학년')),
      ...months.map((m) {
        final parts = m.split('.');
        return DataColumn(label: Text('${parts[1]}월'), numeric: true);
      }),
      const DataColumn(label: Text('합계'), numeric: true),
    ];

    // 행
    final rows = <DataRow>[];
    final monthTotals = <String, int>{};
    int grandTotal = 0;

    for (final grade in grades) {
      int rowTotal = 0;
      final cells = <DataCell>[
        DataCell(Text(grade)),
      ];

      for (final month in months) {
        final count = pivotData[grade]?[month] ?? 0;
        rowTotal += count;
        monthTotals[month] = (monthTotals[month] ?? 0) + count;
        cells.add(DataCell(Text(count.toString())));
      }

      grandTotal += rowTotal;
      cells.add(DataCell(Text(
        rowTotal.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));

      rows.add(DataRow(cells: cells));
    }

    // 합계 행
    final totalCells = <DataCell>[
      const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
    for (final month in months) {
      totalCells.add(DataCell(Text(
        (monthTotals[month] ?? 0).toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));
    }
    totalCells.add(DataCell(Text(
      grandTotal.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    )));

    rows.add(DataRow(
      color: WidgetStateProperty.all(Colors.grey.shade100),
      cells: totalCells,
    ));

    return DataTable(
      columnSpacing: 24,
      columns: columns,
      rows: rows,
    );
  }

  // ============================================================
  // 탭 3: 학교별 상세
  // ============================================================
  Widget _buildSchoolTab(RegionReport report) {
    final data = report.bySchoolRegionMonthly;
    if (data.isEmpty) {
      return const Center(child: Text('데이터가 없습니다'));
    }

    // 지역 목록 추출 (기타는 맨 뒤로)
    final regions = data.map((e) => e.regionName).toSet().toList();
    _sortWithEtcLast(regions);

    // 선택된 지역이 없거나 유효하지 않으면 '부천 원미구' 또는 첫 번째 지역 선택
    if (_selectedRegionForSchool == null || !regions.contains(_selectedRegionForSchool)) {
      _selectedRegionForSchool = regions.contains('부천 원미구') ? '부천 원미구' : regions.first;
    }

    // 선택된 지역의 데이터 필터링
    final filteredData = data.where((e) => e.regionName == _selectedRegionForSchool).toList();

    // 학교 목록 추출 (학생수 합계 기준 정렬, 미지정은 맨 뒤로)
    final schoolTotals = <String, int>{};
    for (final item in filteredData) {
      schoolTotals[item.schoolName] = (schoolTotals[item.schoolName] ?? 0) + item.studentCount;
    }
    final schools = schoolTotals.keys.toList();
    schools.sort((a, b) => (schoolTotals[b] ?? 0).compareTo(schoolTotals[a] ?? 0));

    // 월 목록 추출
    final months = filteredData.map((e) => '${e.year}.${e.month}').toSet().toList();
    months.sort();

    // 피벗 데이터: school -> month -> count
    final pivotData = <String, Map<String, int>>{};
    for (final item in filteredData) {
      final monthKey = '${item.year}.${item.month}';
      pivotData.putIfAbsent(item.schoolName, () => {});
      pivotData[item.schoolName]![monthKey] = item.studentCount;
    }

    // 차트용 상위 학교 (최대 5개)
    final topSchools = schools.take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 지역 선택 드롭다운
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('지역 선택: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedRegionForSchool,
                    items: regions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRegionForSchool = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 차트 (상위 5개 학교)
          if (topSchools.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_selectedRegionForSchool - 상위 학교 월별 학생수 추이',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: _buildMultiLineChart(topSchools, months, pivotData),
                    ),
                    const SizedBox(height: 16),
                    // 범례
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: topSchools.asMap().entries.map((entry) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _chartColors[entry.key % _chartColors.length],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(entry.value, style: const TextStyle(fontSize: 12)),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),

          // 테이블 (전체 학교)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_selectedRegionForSchool - 학교별 월별 학생수 (${schools.length}개 학교)',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildSchoolPivotTable(schools, months, pivotData),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolPivotTable(
    List<String> schools,
    List<String> months,
    Map<String, Map<String, int>> pivotData,
  ) {
    // 열: 학교, 월1, 월2, ..., 합계
    final columns = <DataColumn>[
      const DataColumn(label: Text('학교')),
      ...months.map((m) {
        final parts = m.split('.');
        return DataColumn(label: Text('${parts[1]}월'), numeric: true);
      }),
      const DataColumn(label: Text('합계'), numeric: true),
    ];

    // 행
    final rows = <DataRow>[];
    final monthTotals = <String, int>{};
    int grandTotal = 0;

    for (final school in schools) {
      int rowTotal = 0;
      final cells = <DataCell>[
        DataCell(Text(school)),
      ];

      for (final month in months) {
        final count = pivotData[school]?[month] ?? 0;
        rowTotal += count;
        monthTotals[month] = (monthTotals[month] ?? 0) + count;
        cells.add(DataCell(Text(count.toString())));
      }

      grandTotal += rowTotal;
      cells.add(DataCell(Text(
        rowTotal.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));

      rows.add(DataRow(cells: cells));
    }

    // 합계 행
    final totalCells = <DataCell>[
      const DataCell(Text('합계', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
    for (final month in months) {
      totalCells.add(DataCell(Text(
        (monthTotals[month] ?? 0).toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));
    }
    totalCells.add(DataCell(Text(
      grandTotal.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    )));

    rows.add(DataRow(
      color: WidgetStateProperty.all(Colors.grey.shade100),
      cells: totalCells,
    ));

    return DataTable(
      columnSpacing: 24,
      columns: columns,
      rows: rows,
    );
  }
}
