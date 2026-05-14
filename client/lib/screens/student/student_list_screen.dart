import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes.dart';
import '../../providers/student_provider.dart';
import '../../providers/code_provider.dart';
import '../../models/student.dart';
import '../../widgets/common/status_badge.dart';
import '../../utils/formatters.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  final int? initialSchoolId;
  final String? initialSchoolName;

  const StudentListScreen({
    super.key,
    this.initialSchoolId,
    this.initialSchoolName,
  });

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

// 학년 필터용 아이템
class _GradeFilterItem {
  final int value;
  final String label;
  const _GradeFilterItem(this.value, this.label);
}

const _gradeFilterItems = [
  _GradeFilterItem(7, '중1'), _GradeFilterItem(8, '중2'), _GradeFilterItem(9, '중3'),
  _GradeFilterItem(10, '고1'), _GradeFilterItem(11, '고2'), _GradeFilterItem(12, '고3'),
  _GradeFilterItem(13, 'N수생'), _GradeFilterItem(14, '성인'),
];

// 반 유형 필터용 아이템
class _ClassTypeFilterItem {
  final String code;
  final String label;
  const _ClassTypeFilterItem(this.code, this.label);
}

const _classTypeFilterItems = [
  _ClassTypeFilterItem('CLASS_COMP', '종합반'),
  _ClassTypeFilterItem('CLASS_SINGLE', '단과반'),
  _ClassTypeFilterItem('CLASS_SPECIAL', '특강'),
  _ClassTypeFilterItem('CLASS_ETC', '기타'),
];

// 유입 경로 필터용 아이템
class _SourceFilterItem {
  final String code;
  final String label;
  const _SourceFilterItem(this.code, this.label);
}

const _sourceFilterItems = [
  _SourceFilterItem('SOURCE_WEB', '홈페이지'),
  _SourceFilterItem('SOURCE_FRIEND', '친구 추천'),
  _SourceFilterItem('SOURCE_PARENT', '학부모지인 추천'),
  _SourceFilterItem('SOURCE_FAMILY', '재원/졸업생 가족 추천'),
  _SourceFilterItem('SOURCE_INTERNET', '인터넷'),
  _SourceFilterItem('SOURCE_PROMO', '설명회'),
  _SourceFilterItem('SOURCE_ETC', '기타'),
];

// 과목 필터용 아이템 (비트마스크)
class _SubjectFilterItem {
  final int value;
  final String label;
  const _SubjectFilterItem(this.value, this.label);
}

const _subjectFilterItems = [
  _SubjectFilterItem(1, '국어'),
  _SubjectFilterItem(2, '수학'),
  _SubjectFilterItem(4, '영어'),
  _SubjectFilterItem(8, '과학'),
  _SubjectFilterItem(16, '사회'),
  _SubjectFilterItem(32, '기타'),
];

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  static const _sortPrefKey = 'student_list_sort_by_recent';

  final _searchController = TextEditingController();
  String? _selectedStatus;
  int? _selectedGrade;
  String? _selectedClassType;
  int? _selectedSubject;
  String? _selectedSource;
  int? _selectedSchoolId;
  String? _selectedSchoolName;
  bool _sortByRecent = false; // false: 이름순, true: 최근등록순

  @override
  void initState() {
    super.initState();
    _selectedSchoolId = widget.initialSchoolId;
    _selectedSchoolName = widget.initialSchoolName;
    _loadSortPreference();
  }

  @override
  void didUpdateWidget(covariant StudentListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 학교 필터가 변경되면 다시 로드
    if (oldWidget.initialSchoolId != widget.initialSchoolId) {
      _selectedSchoolId = widget.initialSchoolId;
      _selectedSchoolName = widget.initialSchoolName;
      _loadData();
    }
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
    ref.read(studentListProvider.notifier).fetchList(
      params: StudentListParams(
        sort: _sortByRecent ? 'student_id' : 'student_name',
        order: _sortByRecent ? 'desc' : 'asc',
        schoolId: _selectedSchoolId,
      ),
      refresh: true,
    );
  }

  Future<void> _saveSortPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sortPrefKey, value);
  }

  void _clearSchoolFilter() {
    setState(() {
      _selectedSchoolId = null;
      _selectedSchoolName = null;
    });
    _search();
    // URL에서 쿼리 파라미터 제거
    context.go('/students');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentListProvider);
    final statusCodes = ref.watch(statusCodesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: _selectedSchoolId != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/schools'),
              )
            : null,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('학생 관리'),
            if (_selectedSchoolName != null) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSchoolName!,
                      style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
                    ),
                    if (studentState.meta != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${studentState.meta!.total}명',
                        style: TextStyle(fontSize: 12, color: Colors.blue.shade600, fontWeight: FontWeight.bold),
                      ),
                    ],
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: _clearSchoolFilter,
                      child: Icon(Icons.close, size: 16, color: Colors.blue.shade700),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(studentListProvider.notifier).refresh();
            },
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.studentCreate),
            icon: const Icon(Icons.add),
            label: const Text('학생 등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 필터 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                // 검색
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '이름, 전화번호 검색',
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
                    ),
                    onSubmitted: _onSearch,
                  ),
                ),
                const SizedBox(width: 16),

                // 상태 필터
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: '상태',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('전체'),
                      ),
                      ...statusCodes.map(
                        (code) => DropdownMenuItem(
                          value: code.codeId,
                          child: Text(code.codeName),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedStatus = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 16),

                // 학년 필터
                SizedBox(
                  width: 90,
                  child: DropdownButtonFormField<int>(
                    value: _selectedGrade,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '학년',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem<int>(
                        value: null,
                        child: Text('전체'),
                      ),
                      ..._gradeFilterItems.map(
                        (item) => DropdownMenuItem(
                          value: item.value,
                          child: Text(item.label),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedGrade = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // 반 유형 필터
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    value: _selectedClassType,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '반 유형',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('전체'),
                      ),
                      ..._classTypeFilterItems.map(
                        (item) => DropdownMenuItem(
                          value: item.code,
                          child: Text(item.label),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedClassType = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // 과목 필터
                SizedBox(
                  width: 90,
                  child: DropdownButtonFormField<int>(
                    value: _selectedSubject,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '과목',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem<int>(
                        value: null,
                        child: Text('전체'),
                      ),
                      ..._subjectFilterItems.map(
                        (item) => DropdownMenuItem(
                          value: item.value,
                          child: Text(item.label),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedSubject = value);
                      _applyFilter();
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // 유입 경로 필터
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField<String>(
                    value: _selectedSource,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '유입경로',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('전체'),
                      ),
                      ..._sourceFilterItems.map(
                        (item) => DropdownMenuItem(
                          value: item.code,
                          child: Text(item.label),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedSource = value);
                      _applyFilter();
                    },
                  ),
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
                if (studentState.meta != null)
                  Text(
                    '총 ${studentState.meta!.total}명',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 테이블
          Expanded(
            child: studentState.isLoading && studentState.students.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : studentState.error != null
                    ? Center(child: Text('오류: ${studentState.error}'))
                    : studentState.students.isEmpty
                        ? const Center(child: Text('데이터가 없습니다'))
                        : _buildDataTable(studentState.students),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Student> students) {
    return PaginatedDataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1200,
      rowsPerPage: 100,
      availableRowsPerPage: const [20, 50, 100],
      source: _StudentDataSource(
        students: students,
        onTap: (student) => context.push('/students/${student.studentId}'),
      ),
      columns: const [
        DataColumn2(label: Text('No.'), fixedWidth: 60),
        DataColumn2(label: Text('이름'), size: ColumnSize.S),
        DataColumn2(label: Text('ID'), fixedWidth: 60),
        DataColumn2(label: Text('전화번호'), size: ColumnSize.M),
        DataColumn2(label: Text('학교'), size: ColumnSize.M),
        DataColumn2(label: Text('학년'), size: ColumnSize.S),
        DataColumn2(label: Text('상태'), size: ColumnSize.S),
        DataColumn2(label: Text('담당TC'), size: ColumnSize.S),
        DataColumn2(label: Text('최초접촉'), size: ColumnSize.S),
        DataColumn2(label: Text('등록일'), size: ColumnSize.S),
        DataColumn2(label: Text(''), fixedWidth: 50),
      ],
    );
  }

  void _onSearch(String value) {
    ref.read(studentListProvider.notifier).updateFilter(
      search: value,
      schoolId: _selectedSchoolId,
    );
  }

  void _applyFilter() {
    ref.read(studentListProvider.notifier).updateFilter(
          statusCode: _selectedStatus,
          grade: _selectedGrade,
          classTypeCode: _selectedClassType,
          subjectCode: _selectedSubject,
          sourceCode: _selectedSource,
          schoolId: _selectedSchoolId,
          sort: _sortByRecent ? 'student_id' : 'student_name',
          order: _sortByRecent ? 'desc' : 'asc',
        );
  }

  void _search() {
    ref.read(studentListProvider.notifier).updateFilter(
          statusCode: _selectedStatus,
          grade: _selectedGrade,
          classTypeCode: _selectedClassType,
          subjectCode: _selectedSubject,
          sourceCode: _selectedSource,
          schoolId: _selectedSchoolId,
          search: _searchController.text,
          sort: _sortByRecent ? 'student_id' : 'student_name',
          order: _sortByRecent ? 'desc' : 'asc',
        );
  }
}

class _StudentDataSource extends DataTableSource {
  final List<Student> students;
  final void Function(Student student) onTap;

  _StudentDataSource({
    required this.students,
    required this.onTap,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= students.length) return null;
    final student = students[index];

    // 재원/퇴원 상태에서는 담당TC 표시 안함
    final isEnrolledOrWithdrawn = student.statusCode == 'STATUS_ENROLLED' ||
        student.statusCode == 'STATUS_WITHDRAW';

    return DataRow2(
      onTap: () => onTap(student),
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(student.studentName)),
        DataCell(Text('${student.studentId}')),
        DataCell(Text(formatPhone(student.phone))),
        DataCell(Text(student.schoolName ?? '-')),
        DataCell(Text(student.gradeName ?? '-')),
        DataCell(
          StatusBadge(
            statusCode: student.statusCode,
            statusName: student.statusName ?? '',
          ),
        ),
        DataCell(Text(isEnrolledOrWithdrawn ? '-' : (student.tcName ?? '-'))),
        DataCell(Text(formatDateTime(student.firstContactDate))),
        DataCell(Text(formatDate(student.registerDate))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => onTap(student),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
