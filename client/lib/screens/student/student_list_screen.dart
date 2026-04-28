import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../providers/student_provider.dart';
import '../../providers/code_provider.dart';
import '../../models/student.dart';
import '../../widgets/common/status_badge.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  const StudentListScreen({super.key});

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  final _searchController = TextEditingController();
  String? _selectedStatus;
  String? _selectedGrade;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(studentListProvider.notifier).fetchList(refresh: true);
    });
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
    final gradeCodes = ref.watch(gradeCodesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 관리'),
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
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    value: _selectedGrade,
                    decoration: const InputDecoration(
                      labelText: '학년',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('전체'),
                      ),
                      ...gradeCodes.map(
                        (code) => DropdownMenuItem(
                          value: code.codeId,
                          child: Text(code.codeName),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedGrade = value);
                      _applyFilter();
                    },
                  ),
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
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1000,
      columns: const [
        DataColumn2(label: Text('이름'), size: ColumnSize.S),
        DataColumn2(label: Text('전화번호'), size: ColumnSize.M),
        DataColumn2(label: Text('학년'), size: ColumnSize.S),
        DataColumn2(label: Text('상태'), size: ColumnSize.S),
        DataColumn2(label: Text('담당TC'), size: ColumnSize.S),
        DataColumn2(label: Text('최초접촉'), size: ColumnSize.S),
        DataColumn2(label: Text('등록일'), size: ColumnSize.S),
        DataColumn2(label: Text(''), fixedWidth: 50),
      ],
      rows: students.map((student) {
        return DataRow2(
          onTap: () => context.go('/students/${student.studentId}'),
          cells: [
            DataCell(Text(student.studentName)),
            DataCell(Text(student.phone)),
            DataCell(Text(student.gradeName ?? '-')),
            DataCell(
              StatusBadge(
                statusCode: student.statusCode,
                statusName: student.statusName ?? '',
              ),
            ),
            DataCell(Text(student.tcName ?? '-')),
            DataCell(Text(student.firstContactDate ?? '-')),
            DataCell(Text(student.registerDate ?? '-')),
            DataCell(
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => context.go('/students/${student.studentId}'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _onSearch(String value) {
    ref.read(studentListProvider.notifier).updateFilter(search: value);
  }

  void _applyFilter() {
    ref.read(studentListProvider.notifier).updateFilter(
          statusCode: _selectedStatus,
          gradeCode: _selectedGrade,
        );
  }
}
