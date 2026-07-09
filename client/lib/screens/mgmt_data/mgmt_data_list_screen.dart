import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import '../../models/mgmt_data.dart';
import '../../models/student.dart';
import '../../models/staff.dart';
import '../../models/class_type.dart';
import '../../providers/mgmt_data_provider.dart';
import '../../providers/auth_provider.dart';
import '../../repositories/student_repository.dart';
import '../../repositories/staff_repository.dart';
import '../../repositories/class_type_repository.dart';

class MgmtDataListScreen extends ConsumerStatefulWidget {
  const MgmtDataListScreen({super.key});

  @override
  ConsumerState<MgmtDataListScreen> createState() => _MgmtDataListScreenState();
}

class _MgmtDataListScreenState extends ConsumerState<MgmtDataListScreen> {
  final _filePathController = TextEditingController();
  final _searchController = TextEditingController();
  String _searchText = '';
  int _currentPage = 1;
  static const int _itemsPerPage = 500;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(mgmtDataListProvider.notifier).loadData();
    });
  }

  @override
  void dispose() {
    _filePathController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<MgmtData> _filterData(List<MgmtData> data) {
    if (_searchText.isEmpty) return data;
    return data.where((d) {
      return (d.studentName?.toLowerCase().contains(_searchText.toLowerCase()) ?? false) ||
          (d.schoolName?.toLowerCase().contains(_searchText.toLowerCase()) ?? false) ||
          (d.teacherName?.toLowerCase().contains(_searchText.toLowerCase()) ?? false) ||
          (d.className1?.toLowerCase().contains(_searchText.toLowerCase()) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mgmtDataState = ref.watch(mgmtDataListProvider);
    final authState = ref.watch(authProvider);
    final isAdmin = authState.user?.isAdmin ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('경영 데이터'),
            const SizedBox(width: 16),
            // 년월 선택
            _buildYearMonthSelector(mgmtDataState),
            if (isAdmin && mgmtDataState.selectedYear != null && mgmtDataState.selectedMonth != null) ...[
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => _confirmDeleteMonth(context, mgmtDataState.selectedYear!, mgmtDataState.selectedMonth!),
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                label: const Text('삭제', style: TextStyle(color: Colors.red)),
              ),
            ],
          ],
        ),
      ),
      body: Column(
        children: [
          // 엑셀 업로드 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Text('경영데이터 업로드: '),
                const SizedBox(width: 8),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _filePathController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '엑셀 파일 경로',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.folder_open),
                        onPressed: _selectFile,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: mgmtDataState.isLoading ? null : _uploadFile,
                  icon: mgmtDataState.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.upload),
                  label: Text('${mgmtDataState.selectedYear ?? DateTime.now().year}년 ${mgmtDataState.selectedMonth ?? DateTime.now().month}월 업로드'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 검색 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '학생, 학교, 강사, 반명 검색',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchText = '');
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                        _currentPage = 1;
                      });
                    },
                  ),
                ),
                const Spacer(),
                if (!mgmtDataState.isLoading)
                  Text(
                    '총 ${_filterData(mgmtDataState.data).length}건',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 데이터 테이블
          Expanded(
            child: mgmtDataState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : mgmtDataState.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              '오류: ${mgmtDataState.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () {
                                ref.read(mgmtDataListProvider.notifier).loadData();
                              },
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : mgmtDataState.data.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.info_outline, size: 48, color: Colors.grey),
                                const SizedBox(height: 16),
                                Text(
                                  mgmtDataState.selectedYear != null && mgmtDataState.selectedMonth != null
                                      ? '${mgmtDataState.selectedYear}년 ${mgmtDataState.selectedMonth}월 데이터가 없습니다'
                                      : '데이터가 없습니다',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : _buildPaginatedTable(_filterData(mgmtDataState.data), isAdmin),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginatedTable(List<MgmtData> allData, bool isAdmin) {
    final totalPages = (allData.length / _itemsPerPage).ceil();
    if (_currentPage > totalPages && totalPages > 0) {
      _currentPage = totalPages;
    }

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, allData.length);
    final pageData = allData.sublist(startIndex, endIndex);

    return Column(
      children: [
        Expanded(
          child: _buildDataTable(pageData, isAdmin, startIndex),
        ),
        if (totalPages > 1)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _currentPage > 1
                      ? () => setState(() => _currentPage = 1)
                      : null,
                  icon: const Icon(Icons.first_page),
                  tooltip: '첫 페이지',
                ),
                IconButton(
                  onPressed: _currentPage > 1
                      ? () => setState(() => _currentPage--)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                  tooltip: '이전 페이지',
                ),
                const SizedBox(width: 16),
                Text(
                  '$_currentPage / $totalPages 페이지',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _currentPage < totalPages
                      ? () => setState(() => _currentPage++)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                  tooltip: '다음 페이지',
                ),
                IconButton(
                  onPressed: _currentPage < totalPages
                      ? () => setState(() => _currentPage = totalPages)
                      : null,
                  icon: const Icon(Icons.last_page),
                  tooltip: '마지막 페이지',
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildYearMonthSelector(MgmtDataListState state) {
    final now = DateTime.now();
    final displayYear = state.selectedYear ?? now.year;
    final displayMonth = state.selectedMonth ?? now.month;

    return InkWell(
      onTap: () => _selectYearMonth(displayYear, displayMonth),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              '$displayYear년 $displayMonth월',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  Future<void> _selectYearMonth(int currentYear, int currentMonth) async {
    final now = DateTime.now();
    int selectedYear = currentYear;
    int selectedMonth = currentMonth;

    final result = await showDialog<YearMonth>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('년월 선택'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: selectedYear,
                items: List.generate(5, (i) => now.year - 2 + i)
                    .map((y) => DropdownMenuItem(value: y, child: Text('$y년')))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => selectedYear = value);
                },
              ),
              const SizedBox(width: 16),
              DropdownButton<int>(
                value: selectedMonth,
                items: List.generate(12, (i) => i + 1)
                    .map((m) => DropdownMenuItem(value: m, child: Text('$m월')))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => selectedMonth = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, YearMonth(year: selectedYear, month: selectedMonth));
              },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      ref.read(mgmtDataListProvider.notifier).changeYearMonth(result.year, result.month);
    }
  }

  Widget _buildDataTable(List<MgmtData> data, bool isAdmin, int startIndex) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text('No'), numeric: true),
            DataColumn(label: Text('학생이름')),
            DataColumn(label: Text('학교')),
            DataColumn(label: Text('학년')),
            DataColumn(label: Text('수강인원'), numeric: true),
            DataColumn(label: Text('종합반종류')),
            DataColumn(label: Text('과목')),
            DataColumn(label: Text('강사')),
            DataColumn(label: Text('반명/교재명')),
            DataColumn(label: Text('반형태')),
            DataColumn(label: Text('가격'), numeric: true),
          ],
          rows: data.asMap().entries.map((entry) {
            final index = entry.key;
            final d = entry.value;
            return DataRow(
              cells: [
                DataCell(Text('${startIndex + index + 1}')),
                // 학생이름 - 관리자만 수정 가능 (미지정시 원본 이름 표시)
                DataCell(
                  _buildEditableCell(
                    text: d.studentId != null ? (d.studentName ?? '') : (d.studentNameOrig ?? ''),
                    isEditable: isAdmin,
                    hasValue: d.studentId != null,
                    onTap: () => _showStudentSearchDialog(d),
                  ),
                ),
                DataCell(Text(d.schoolName ?? '')),
                DataCell(Text(d.gradeString)),
                DataCell(Text(d.enrollmentCount.toString())),
                DataCell(Text(d.compClassType ?? '')),
                DataCell(Text(d.subject ?? '')),
                // 강사 - 관리자만 수정 가능 (미지정시 원본 이름 표시)
                DataCell(
                  _buildEditableCell(
                    text: d.teacherId != null ? (d.teacherName ?? '') : (d.teacherNameOrig ?? ''),
                    isEditable: isAdmin,
                    hasValue: d.teacherId != null,
                    onTap: () => _showTeacherSearchDialog(d),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      d.className1 ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // 반형태 - 관리자만 수정 가능 (미지정시 원본 이름 표시)
                DataCell(
                  _buildEditableCell(
                    text: d.classTypeId != null ? (d.classTypeName ?? '') : (d.classTypeNameOrig ?? ''),
                    isEditable: isAdmin,
                    hasValue: d.classTypeId != null,
                    onTap: () => _showClassTypeSearchDialog(d),
                    width: 150,
                  ),
                ),
                DataCell(Text(d.price > 0 ? '${d.price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}' : '')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEditableCell({
    required String text,
    required bool isEditable,
    required bool hasValue,
    required VoidCallback onTap,
    double? width,
  }) {
    if (!isEditable) {
      final textWidget = Text(
        text,
        style: TextStyle(color: hasValue ? null : Colors.red),
        overflow: width != null ? TextOverflow.ellipsis : null,
      );
      return width != null ? SizedBox(width: width, child: textWidget) : textWidget;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: hasValue ? Colors.blue.shade200 : Colors.red.shade200),
          borderRadius: BorderRadius.circular(4),
          color: hasValue ? Colors.blue.shade50 : Colors.red.shade50,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text.isEmpty ? '(미지정)' : text,
                style: TextStyle(color: hasValue ? Colors.blue.shade700 : Colors.red.shade700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.edit, size: 14, color: hasValue ? Colors.blue.shade400 : Colors.red.shade400),
          ],
        ),
      ),
    );
  }

  // 학생 검색 다이얼로그
  Future<void> _showStudentSearchDialog(MgmtData mgmtData) async {
    final result = await showDialog<Student?>(
      context: context,
      builder: (context) => _StudentSearchDialog(),
    );

    if (result != null && mounted) {
      final updated = await ref.read(mgmtDataListProvider.notifier).update(
        mgmtData.mgmtDataId,
        studentId: result.studentId,
      );

      if (updated != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('학생이 "${result.studentName}"(으)로 변경되었습니다'), backgroundColor: Colors.green),
        );
      }
    }
  }

  // 강사 검색 다이얼로그
  Future<void> _showTeacherSearchDialog(MgmtData mgmtData) async {
    final result = await showDialog<Staff?>(
      context: context,
      builder: (context) => _TeacherSearchDialog(),
    );

    if (result != null && mounted) {
      final updated = await ref.read(mgmtDataListProvider.notifier).update(
        mgmtData.mgmtDataId,
        teacherId: result.userId,
      );

      if (updated != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('강사가 "${result.name}"(으)로 변경되었습니다'), backgroundColor: Colors.green),
        );
      }
    }
  }

  // 반형태 검색 다이얼로그
  Future<void> _showClassTypeSearchDialog(MgmtData mgmtData) async {
    final result = await showDialog<ClassType?>(
      context: context,
      builder: (context) => _ClassTypeSearchDialog(),
    );

    if (result != null && mounted) {
      final updated = await ref.read(mgmtDataListProvider.notifier).update(
        mgmtData.mgmtDataId,
        classTypeId: result.classTypeId,
      );

      if (updated != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('반형태가 "${result.classTypeName}"(으)로 변경되었습니다'), backgroundColor: Colors.green),
        );
      }
    }
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null && result.files.single.path != null) {
      _filePathController.text = result.files.single.path!;
    }
  }

  Future<void> _uploadFile() async {
    if (_filePathController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('엑셀 파일을 선택해주세요'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 현재 선택된 년월 사용
    final state = ref.read(mgmtDataListProvider);
    final now = DateTime.now();
    final year = state.selectedYear ?? now.year;
    final month = state.selectedMonth ?? now.month;

    final result = await ref.read(mgmtDataListProvider.notifier).uploadExcel(
      _filePathController.text,
      year,
      month,
    );

    if (mounted) {
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.inserted}건 업로드 완료 (학생 매칭: ${result.matched}건)'),
            backgroundColor: Colors.green,
          ),
        );
        _filePathController.clear();
      } else {
        final error = ref.read(mgmtDataListProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('업로드 실패: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _confirmDeleteMonth(BuildContext context, int year, int month) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('데이터 삭제'),
        content: Text('$year년 $month월 경영 데이터를 모두 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await ref.read(mgmtDataListProvider.notifier).deleteByMonth(year, month);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? '$year년 $month월 데이터가 삭제되었습니다' : '삭제 실패'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}

// 학생 검색 다이얼로그
class _StudentSearchDialog extends StatefulWidget {
  @override
  State<_StudentSearchDialog> createState() => _StudentSearchDialogState();
}

class _StudentSearchDialogState extends State<_StudentSearchDialog> {
  final _searchController = TextEditingController();
  final _repository = StudentRepository();
  List<Student> _students = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (_searchController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final result = await _repository.getList(
        StudentListParams(page: 1, perPage: 50, search: _searchController.text),
      );
      setState(() => _students = result.data);
    } catch (e) {
      // ignore
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('학생 검색'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '학생 이름으로 검색',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _students.isEmpty
                      ? const Center(child: Text('검색 결과가 없습니다'))
                      : ListView.builder(
                          itemCount: _students.length,
                          itemBuilder: (context, index) {
                            final student = _students[index];
                            return ListTile(
                              title: Text(student.studentName),
                              subtitle: Text(student.schoolName ?? '학교 정보 없음'),
                              onTap: () => Navigator.pop(context, student),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ],
    );
  }
}

// 강사 검색 다이얼로그
class _TeacherSearchDialog extends StatefulWidget {
  @override
  State<_TeacherSearchDialog> createState() => _TeacherSearchDialogState();
}

class _TeacherSearchDialogState extends State<_TeacherSearchDialog> {
  final _searchController = TextEditingController();
  final _repository = StaffRepository();
  List<Staff> _teachers = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (_searchController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final result = await _repository.getList(
        StaffListParams(page: 1, perPage: 50, search: _searchController.text),
      );
      setState(() => _teachers = result.data);
    } catch (e) {
      // ignore
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('강사 검색'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '강사 이름으로 검색',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _teachers.isEmpty
                      ? const Center(child: Text('검색 결과가 없습니다'))
                      : ListView.builder(
                          itemCount: _teachers.length,
                          itemBuilder: (context, index) {
                            final teacher = _teachers[index];
                            return ListTile(
                              title: Text(teacher.name),
                              subtitle: Text(teacher.kindName),
                              onTap: () => Navigator.pop(context, teacher),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ],
    );
  }
}

// 반형태 검색 다이얼로그
class _ClassTypeSearchDialog extends StatefulWidget {
  @override
  State<_ClassTypeSearchDialog> createState() => _ClassTypeSearchDialogState();
}

class _ClassTypeSearchDialogState extends State<_ClassTypeSearchDialog> {
  final _searchController = TextEditingController();
  final _repository = ClassTypeRepository();
  List<ClassType> _classTypes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    setState(() => _isLoading = true);

    try {
      final result = await _repository.getList();
      setState(() => _classTypes = result);
    } catch (e) {
      // ignore
    } finally {
      setState(() => _isLoading = false);
    }
  }

  List<ClassType> get _filteredClassTypes {
    if (_searchController.text.isEmpty) return _classTypes;
    final query = _searchController.text.toLowerCase();
    return _classTypes.where((ct) =>
      ct.classTypeName.toLowerCase().contains(query)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('반형태 검색'),
      content: SizedBox(
        width: 500,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '반형태명으로 검색',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredClassTypes.isEmpty
                      ? const Center(child: Text('검색 결과가 없습니다'))
                      : ListView.builder(
                          itemCount: _filteredClassTypes.length,
                          itemBuilder: (context, index) {
                            final classType = _filteredClassTypes[index];
                            return ListTile(
                              title: Text(classType.classTypeName),
                              subtitle: Text('${gradeToString(classType.grade)} / ${subjectToString(classType.subject)} / ${classType.unitPrice}원'),
                              onTap: () => Navigator.pop(context, classType),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ],
    );
  }
}
