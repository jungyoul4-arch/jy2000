import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import '../../models/mgmt_data.dart';
import '../../providers/mgmt_data_provider.dart';
import '../../providers/auth_provider.dart';

class MgmtDataListScreen extends ConsumerStatefulWidget {
  const MgmtDataListScreen({super.key});

  @override
  ConsumerState<MgmtDataListScreen> createState() => _MgmtDataListScreenState();
}

class _MgmtDataListScreenState extends ConsumerState<MgmtDataListScreen> {
  final _filePathController = TextEditingController();
  final _searchController = TextEditingController();
  String _searchText = '';

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
            const Text('경영 보고서'),
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
                  label: const Text('경영데이터 업로드'),
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
                      setState(() => _searchText = value);
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
                            Text('오류: ${mgmtDataState.error}'),
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
                        : _buildDataTable(_filterData(mgmtDataState.data)),
          ),
        ],
      ),
    );
  }

  Widget _buildYearMonthSelector(MgmtDataListState state) {
    if (state.availableMonths.isEmpty) {
      final now = DateTime.now();
      return OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.calendar_today, size: 18),
        label: Text('${now.year}년 ${now.month}월'),
      );
    }

    return PopupMenuButton<YearMonth>(
      initialValue: state.selectedYear != null && state.selectedMonth != null
          ? YearMonth(year: state.selectedYear!, month: state.selectedMonth!)
          : null,
      onSelected: (ym) {
        ref.read(mgmtDataListProvider.notifier).changeYearMonth(ym.year, ym.month);
      },
      itemBuilder: (context) {
        return state.availableMonths.map((ym) {
          return PopupMenuItem(
            value: ym,
            child: Text('${ym.year}년 ${ym.month}월'),
          );
        }).toList();
      },
      child: OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.calendar_today, size: 18),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${state.selectedYear ?? '-'}년 ${state.selectedMonth ?? '-'}월'),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(List<MgmtData> data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text('학생이름')),
            DataColumn(label: Text('학교')),
            DataColumn(label: Text('학년')),
            DataColumn(label: Text('수강인원'), numeric: true),
            DataColumn(label: Text('종합반종류')),
            DataColumn(label: Text('과목')),
            DataColumn(label: Text('강사')),
            DataColumn(label: Text('반명/교재명')),
            DataColumn(label: Text('반형태')),
          ],
          rows: data.map((d) {
            return DataRow(
              cells: [
                DataCell(Text(d.studentName ?? '')),
                DataCell(Text(d.schoolName ?? '')),
                DataCell(Text(d.gradeString)),
                DataCell(Text(d.enrollmentCount.toString())),
                DataCell(Text(d.compClassType ?? '')),
                DataCell(Text(d.subject ?? '')),
                DataCell(Text(d.teacherName ?? '')),
                DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      d.className1 ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Text(
                      d.classTypeName ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
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

    // 년월 선택 다이얼로그
    final yearMonth = await _showYearMonthDialog();
    if (yearMonth == null) return;

    final result = await ref.read(mgmtDataListProvider.notifier).uploadExcel(
      _filePathController.text,
      yearMonth.year,
      yearMonth.month,
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

  Future<YearMonth?> _showYearMonthDialog() async {
    final now = DateTime.now();
    int selectedYear = now.year;
    int selectedMonth = now.month;

    return showDialog<YearMonth>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('업로드할 년월 선택'),
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
