import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/class_model.dart';
import '../../providers/class_provider.dart';

// 과목 필터 항목
const _genreFilterItems = [
  (1, '국어'),
  (2, '수학'),
  (3, '영어'),
  (4, '과학'),
  (5, '사회'),
  (99, '기타'),
];

// 학년 필터 항목
const _gradeFilterItems = [
  (7, '중1'),
  (8, '중2'),
  (9, '중3'),
  (10, '고1'),
  (11, '고2'),
  (12, '고3'),
  (14, '성인'),
  (99, '기타'),
];

// 수준 필터 항목
const _levelFilterItems = [
  (1, '최상위'),
  (2, '상위'),
  (3, '중위'),
  (4, '기초'),
  (99, '기타'),
];

class ClassListScreen extends ConsumerStatefulWidget {
  const ClassListScreen({super.key});

  @override
  ConsumerState<ClassListScreen> createState() => _ClassListScreenState();
}

class _ClassListScreenState extends ConsumerState<ClassListScreen> {
  static const _sortPrefKey = 'class_list_sort_by_recent';

  final _searchController = TextEditingController();
  int? _selectedGenreId;
  int? _selectedGrade;
  int? _selectedLevel;
  bool _sortByRecent = false; // false: 이름순, true: 최근등록순

  @override
  void initState() {
    super.initState();
    _loadSortPreference();
  }

  Future<void> _loadSortPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSort = prefs.getBool(_sortPrefKey) ?? false;
    if (mounted) {
      setState(() => _sortByRecent = savedSort);
    }
    _loadData();
  }

  void _loadData() {
    ref.read(classListProvider.notifier).fetchList(
      params: ClassListParams(
        sort: _sortByRecent ? 'class_id' : 'class_name',
        order: _sortByRecent ? 'desc' : 'asc',
      ),
      refresh: true,
    );
  }

  Future<void> _saveSortPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sortPrefKey, value);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    ref.read(classListProvider.notifier).updateFilter(
          search: value,
          genreId: _selectedGenreId,
          grade: _selectedGrade,
          level: _selectedLevel,
          sort: _sortByRecent ? 'class_id' : 'class_name',
          order: _sortByRecent ? 'desc' : 'asc',
        );
  }

  void _applyFilter() {
    ref.read(classListProvider.notifier).updateFilter(
          genreId: _selectedGenreId,
          grade: _selectedGrade,
          level: _selectedLevel,
          sort: _sortByRecent ? 'class_id' : 'class_name',
          order: _sortByRecent ? 'desc' : 'asc',
        );
  }

  void _clearFilters() {
    setState(() {
      _selectedGenreId = null;
      _selectedGrade = null;
      _selectedLevel = null;
      _searchController.clear();
    });
    ref.read(classListProvider.notifier).fetchList(
          params: ClassListParams(
            sort: _sortByRecent ? 'class_id' : 'class_name',
            order: _sortByRecent ? 'desc' : 'asc',
          ),
          refresh: true,
        );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatFee(int? fee) {
    if (fee == null) return '-';
    final formatter = NumberFormat('#,###');
    return '${formatter.format(fee)}원';
  }

  @override
  Widget build(BuildContext context) {
    final classState = ref.watch(classListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('반 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(classListProvider.notifier).refresh();
            },
            tooltip: '새로고침',
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () => context.push('/classes/create'),
            icon: const Icon(Icons.add),
            label: const Text('반 등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 필터 영역
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                // 검색
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '반 이름, 선생님, 학생 검색',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearch('');
                              },
                            )
                          : null,
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: _onSearch,
                  ),
                ),
                const SizedBox(width: 16),
                // 과목 필터
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField<int>(
                    value: _selectedGenreId,
                    decoration: const InputDecoration(
                      labelText: '과목',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('전체')),
                      ..._genreFilterItems.map((e) => DropdownMenuItem(
                            value: e.$1,
                            child: Text(e.$2),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedGenreId = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // 학년 필터
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField<int>(
                    value: _selectedGrade,
                    decoration: const InputDecoration(
                      labelText: '학년',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('전체')),
                      ..._gradeFilterItems.map((e) => DropdownMenuItem(
                            value: e.$1,
                            child: Text(e.$2),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedGrade = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // 수준 필터
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField<int>(
                    value: _selectedLevel,
                    decoration: const InputDecoration(
                      labelText: '수준',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('전체')),
                      ..._levelFilterItems.map((e) => DropdownMenuItem(
                            value: e.$1,
                            child: Text(e.$2),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedLevel = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // 필터 초기화
                if (_selectedGenreId != null ||
                    _selectedGrade != null ||
                    _selectedLevel != null ||
                    _searchController.text.isNotEmpty)
                  TextButton.icon(
                    onPressed: _clearFilters,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('초기화'),
                  ),
                const SizedBox(width: 16),
                // 정렬 토글
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('이름순'),
                      icon: Icon(Icons.sort_by_alpha),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('최근등록순'),
                      icon: Icon(Icons.access_time),
                    ),
                  ],
                  selected: {_sortByRecent},
                  onSelectionChanged: (selected) {
                    setState(() => _sortByRecent = selected.first);
                    _saveSortPreference(selected.first);
                    _applyFilter();
                  },
                ),
                const Spacer(),
                // 결과 수
                if (classState.meta != null)
                  Text(
                    '총 ${classState.meta!.total}개',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          // 목록
          Expanded(
            child: classState.isLoading && classState.classes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : classState.error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text('오류: ${classState.error}'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  ref.read(classListProvider.notifier).refresh(),
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : classState.classes.isEmpty
                        ? const Center(child: Text('등록된 반이 없습니다.'))
                        : PaginatedDataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 16,
                            minWidth: 900,
                            rowsPerPage: 50,
                            availableRowsPerPage: const [20, 50, 100],
                            source: _ClassDataSource(
                              classes: classState.classes,
                              onTap: (cls) =>
                                  context.push('/classes/${cls.classId}'),
                              formatDate: _formatDate,
                              formatFee: _formatFee,
                            ),
                            columns: const [
                              DataColumn2(label: Text('No.'), fixedWidth: 60),
                              DataColumn2(label: Text('반 이름'), size: ColumnSize.L),
                              DataColumn2(label: Text('ID'), fixedWidth: 60),
                              DataColumn2(label: Text('생성일'), size: ColumnSize.S),
                              DataColumn2(label: Text('선생님'), size: ColumnSize.M),
                              DataColumn2(label: Text('강의일시'), size: ColumnSize.M),
                              DataColumn2(label: Text('수강료'), size: ColumnSize.S),
                              DataColumn2(label: Text(''), fixedWidth: 50),
                            ],
                          ),
          ),
        ],
      ),
    );
  }
}

class _ClassDataSource extends DataTableSource {
  final List<ClassModel> classes;
  final void Function(ClassModel cls) onTap;
  final String Function(String?) formatDate;
  final String Function(int?) formatFee;

  _ClassDataSource({
    required this.classes,
    required this.onTap,
    required this.formatDate,
    required this.formatFee,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= classes.length) return null;
    final cls = classes[index];

    // 선생님 이름들
    final teacherNames =
        cls.teachers?.map((t) => t.name).join(', ') ?? '-';

    return DataRow2(
      onTap: () => onTap(cls),
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(cls.className)),
        DataCell(Text('${cls.classId}')),
        DataCell(Text(formatDate(cls.regDt))),
        DataCell(Text(teacherNames)),
        DataCell(Text(cls.lectureDates ?? '-')),
        DataCell(Text(formatFee(cls.monthlyFee))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => onTap(cls),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => classes.length;

  @override
  int get selectedRowCount => 0;
}
