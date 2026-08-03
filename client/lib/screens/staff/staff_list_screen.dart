import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../models/staff.dart';
import '../../providers/auth_provider.dart';
import '../../providers/staff_provider.dart';
import '../../utils/formatters.dart';
import 'staff_form_dialog.dart';
import '../../widgets/logout_button.dart';

class StaffListScreen extends ConsumerStatefulWidget {
  const StaffListScreen({super.key});

  @override
  ConsumerState<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends ConsumerState<StaffListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // StaffListNotifier 생성자에서 _loadSavedSort()가 호출되어
    // 저장된 정렬 상태로 자동으로 데이터를 로드함
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => StaffFormDialog(
        onSuccess: () {
          ref.read(staffListProvider.notifier).refresh();
        },
      ),
    );
  }

  void _showEditDialog(Staff staff) {
    showDialog(
      context: context,
      builder: (context) => StaffFormDialog(
        staff: staff,
        onSuccess: () {
          ref.read(staffListProvider.notifier).refresh();
        },
      ),
    );
  }

  void _onSearch(String value) {
    ref.read(staffListProvider.notifier).search(value);
  }

  @override
  Widget build(BuildContext context) {
    final staffState = ref.watch(staffListProvider);
    final authState = ref.watch(authProvider);
    final isAdmin = authState.user?.kind == 1 || authState.user?.isAdmin == true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('직원 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(staffListProvider.notifier).refresh();
            },
          ),
          // 관리자만 직원 등록 버튼 표시
          if (isAdmin) ...[
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: _showCreateDialog,
              icon: const Icon(Icons.add),
              label: const Text('직원 등록'),
            ),
          ],
          const SizedBox(width: 16),
          const LogoutButton(),
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
                    onChanged: (value) {
                      setState(() {}); // clear 버튼 업데이트
                    },
                    onSubmitted: _onSearch,
                  ),
                ),
                const SizedBox(width: 24),

                // 정렬 토글
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'name',
                      label: Text('이름순'),
                      icon: Icon(Icons.sort_by_alpha),
                    ),
                    ButtonSegment(
                      value: 'kind',
                      label: Text('역할순'),
                      icon: Icon(Icons.badge),
                    ),
                  ],
                  selected: {staffState.params.sort ?? 'name'},
                  onSelectionChanged: (selected) {
                    ref.read(staffListProvider.notifier).updateSort(
                          selected.first,
                          'asc',
                        );
                  },
                ),
                const Spacer(),

                // 결과 수
                if (staffState.meta != null)
                  Text(
                    '총 ${staffState.meta!.total}명',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 테이블
          Expanded(
            child: staffState.isLoading && staffState.staffList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : staffState.error != null
                    ? Center(child: Text('오류: ${staffState.error}'))
                    : staffState.staffList.isEmpty
                        ? const Center(child: Text('데이터가 없습니다'))
                        : _buildDataTable(staffState.staffList, isAdmin),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Staff> staffList, bool isAdmin) {
    final repository = ref.read(staffRepositoryProvider);

    // 관리자가 아니면 활성/삭제 컬럼 제외
    final columns = <DataColumn2>[
      const DataColumn2(label: Text('No.'), fixedWidth: 60),
      const DataColumn2(label: Text('이름'), size: ColumnSize.S),
      const DataColumn2(label: Text('역할'), size: ColumnSize.S),
      const DataColumn2(label: Text('ID'), fixedWidth: 70),
      const DataColumn2(label: Text('전화번호'), size: ColumnSize.M),
      const DataColumn2(label: Text('등록일'), size: ColumnSize.S),
      const DataColumn2(label: Text('최근접속일'), size: ColumnSize.M),
      const DataColumn2(label: Text('활성'), fixedWidth: 80),
    ];

    // 관리자만 수정/삭제 컬럼 추가
    if (isAdmin) {
      columns.add(const DataColumn2(label: Text(''), fixedWidth: 100));
    }

    return PaginatedDataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1000,
      rowsPerPage: 100,
      availableRowsPerPage: const [20, 50, 100],
      source: _StaffDataSource(
        staffList: staffList,
        isAdmin: isAdmin,
        onToggleActive: isAdmin
            ? (staff) async {
                try {
                  await repository.toggleActive(staff.userId);
                  ref.read(staffListProvider.notifier).refresh();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('상태 변경 실패: $e')),
                    );
                  }
                }
              }
            : null,
        onEdit: isAdmin ? (staff) => _showEditDialog(staff) : null,
        onDelete: isAdmin
            ? (staff) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('직원 삭제'),
                    content: Text('${staff.name}님을 삭제하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('취소'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('삭제'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await repository.delete(staff.userId);
                    ref.read(staffListProvider.notifier).refresh();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('직원이 삭제되었습니다.')),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('삭제 실패: $e')),
                      );
                    }
                  }
                }
              }
            : null,
      ),
      columns: columns,
    );
  }
}

class _StaffDataSource extends DataTableSource {
  final List<Staff> staffList;
  final bool isAdmin;
  final Function(Staff staff)? onToggleActive;
  final Function(Staff staff)? onEdit;
  final Function(Staff staff)? onDelete;

  _StaffDataSource({
    required this.staffList,
    required this.isAdmin,
    this.onToggleActive,
    this.onEdit,
    this.onDelete,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= staffList.length) return null;
    final staff = staffList[index];

    final cells = <DataCell>[
      DataCell(Text('${index + 1}')),
      DataCell(Text(staff.name)),
      DataCell(_buildKindBadge(staff.kind, staff.kindName)),
      DataCell(Text('${staff.userId}')),
      DataCell(Text(formatPhone(staff.phone))),
      DataCell(Text(formatDateTime(staff.regDt))),
      DataCell(Text(staff.lastLoginDt != null ? formatDateTime(staff.lastLoginDt) : '-')),
      // 활성 상태: 관리자만 토글 가능, 일반 사용자는 상태만 표시
      DataCell(
        isAdmin
            ? Switch(
                value: staff.activeFlag == 1,
                onChanged: onToggleActive != null ? (_) => onToggleActive!(staff) : null,
              )
            : Icon(
                staff.activeFlag == 1 ? Icons.check_circle : Icons.cancel,
                color: staff.activeFlag == 1 ? Colors.green : Colors.grey,
                size: 20,
              ),
      ),
    ];

    // 관리자만 수정/삭제 버튼 표시
    if (isAdmin) {
      cells.add(
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                onPressed: onEdit != null ? () => onEdit!(staff) : null,
                tooltip: '수정',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete != null ? () => onDelete!(staff) : null,
                tooltip: '삭제',
              ),
            ],
          ),
        ),
      );
    }

    return DataRow2(cells: cells);
  }

  Widget _buildKindBadge(int kind, String kindName) {
    Color color;
    switch (kind) {
      case 1:
        color = Colors.red; // 관리자
        break;
      case 3:
        color = Colors.blue; // 선생님
        break;
      case 5:
        color = Colors.green; // 상담원
        break;
      case 6:
        color = Colors.orange; // 사감
        break;
      case 7:
        color = Colors.grey; // 일반직원
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        kindName,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => staffList.length;

  @override
  int get selectedRowCount => 0;
}
