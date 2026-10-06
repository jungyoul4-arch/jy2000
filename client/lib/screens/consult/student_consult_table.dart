import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/consult_student.dart';
import '../../providers/consult_provider.dart';
import '../../utils/formatters.dart';
import 'student_consult_dialog.dart';

/// 학생 목록 표 — 신규생 문의와 상담 관리가 대상(scope)만 바꿔 같이 쓴다.
///
/// 화면을 반으로 나누지 않고 목록이 가로를 다 쓴다. 한 줄에 학교·학년·
/// 연락처·최근 상담 내용까지 실어 목록만 훑어도 판단이 되게 하고, 고른
/// 학생의 상담 내역은 팝업으로 띄운다.
class StudentConsultTable extends ConsumerStatefulWidget {
  final ConsultStudentScope scope;

  /// 학생을 고른 뒤 팝업에서 할 수 있는 동작들.
  final List<StudentConsultAction> actions;

  /// '상담' 대신 '문의'처럼 부를 때 쓰는 말. 컬럼·안내문에 함께 쓰인다.
  final String consultWord;

  /// 대상이 한 명도 없을 때 보여 줄 문구
  final String emptyLabel;

  const StudentConsultTable({
    super.key,
    required this.scope,
    this.actions = const [],
    this.consultWord = '상담',
    this.emptyLabel = '대상 학생이 없습니다',
  });

  @override
  ConsumerState<StudentConsultTable> createState() => StudentConsultTableState();
}

class StudentConsultTableState extends ConsumerState<StudentConsultTable> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  late ConsultStudentQuery _query = ConsultStudentQuery(scope: widget.scope);

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// 한 글자마다 서버를 때리지 않도록 300ms 모아서 보낸다.
  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _query = _query.copyWith(search: value));
    });
  }

  void _openDialog(ConsultStudent student) {
    showStudentConsultDialog(context, student: student, actions: widget.actions);
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(consultStudentsProvider(_query));
    final searching = _query.search.trim().isNotEmpty;
    final word = widget.consultWord;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              SizedBox(
                width: 280,
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: '이름 · 전화 · 학교로 검색',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    isDense: true,
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // 과거/미래는 켜짐·꺼짐이 아니라 둘 중 하나를 고르는 것이다.
              // FilterChip으로 두면 지금 어느 쪽을 보고 있는지 알기 어렵다.
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: false,
                    icon: const Icon(Icons.history, size: 16),
                    label: Text('과거 $word', style: const TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: true,
                    icon: const Icon(Icons.event_note, size: 16),
                    label: Text('미래 $word', style: const TextStyle(fontSize: 12)),
                  ),
                ],
                selected: {_query.planOnly},
                showSelectedIcon: false,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onSelectionChanged: (sel) =>
                    setState(() => _query = _query.copyWith(planOnly: sel.first)),
              ),
              const SizedBox(width: 12),

              for (final sort in ConsultStudentSort.values)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(
                      _sortLabel(sort, _query.planOnly),
                      style: const TextStyle(fontSize: 12),
                    ),
                    selected: _query.sort == sort,
                    visualDensity: VisualDensity.compact,
                    onSelected: (_) => setState(() => _query = _query.copyWith(sort: sort)),
                  ),
                ),
              // 검색 중에는 대상 전원에서 찾으므로 이 칩이 의미가 없다.
              // 미래 보기는 애초에 상담이 있는 학생만 나온다.
              if (!searching && !_query.planOnly)
                FilterChip(
                  label: Text('$word 없는 학생 포함', style: const TextStyle(fontSize: 12)),
                  selected: !_query.hasConsultOnly,
                  visualDensity: VisualDensity.compact,
                  onSelected: (showAll) => setState(
                    () => _query = _query.copyWith(hasConsultOnly: !showAll),
                  ),
                ),
              const Spacer(),
              studentsAsync.maybeWhen(
                data: (students) => Text(
                  '${students.length}명',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        Expanded(
          child: studentsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SelectableText(
                  '목록을 불러오지 못했습니다\n\n$e',
                  style: const TextStyle(color: AppTheme.errorColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (students) {
              if (students.isEmpty) {
                return Center(
                  child: Text(
                    searching
                        ? '검색 결과가 없습니다'
                        : _query.planOnly
                            ? '앞으로 잡힌 $word이 없습니다'
                            : widget.emptyLabel,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }
              return _Table(
                students: students,
                consultWord: word,
                planMode: _query.planOnly,
                showStatus: widget.scope == ConsultStudentScope.existing,
                onTap: _openDialog,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Table extends StatelessWidget {
  final List<ConsultStudent> students;
  final String consultWord;

  /// 계획 보기에서는 지난 내역 대신 앞으로 잡힌 일정을 보여 준다.
  final bool planMode;

  /// 신규생은 전원이 신규생이라 상태 배지가 무의미하다. 재원·퇴원에서만 붙인다.
  final bool showStatus;
  final void Function(ConsultStudent) onTap;

  const _Table({
    required this.students,
    required this.consultWord,
    required this.planMode,
    required this.showStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1100,
      // 최근 상담 내용이 두 줄까지 들어가 기본 높이로는 잘린다.
      dataRowHeight: 56,
      columns: [
        const DataColumn2(label: Text('이름'), size: ColumnSize.S),
        const DataColumn2(label: Text('학년'), fixedWidth: 64),
        const DataColumn2(label: Text('학교'), size: ColumnSize.S),
        const DataColumn2(label: Text('연락처'), fixedWidth: 130),
        DataColumn2(label: Text(consultWord), fixedWidth: 60, numeric: true),
        DataColumn2(
          label: Text(planMode ? '예정일' : '최근 $consultWord일'),
          fixedWidth: planMode ? 130 : 110,
        ),
        DataColumn2(
          label: Text(planMode ? '$consultWord할 내용' : '최근 $consultWord 내용'),
          size: ColumnSize.L,
        ),
      ],
      rows: students.map((s) {
        // 계획 보기면 앞으로 잡힌 일정을, 아니면 지난 내역을 보여 준다.
        final rawPreview = planMode ? s.nextPlanContent : s.lastConsultContent;
        final preview = rawPreview?.replaceAll(RegExp(r'\s+'), ' ').trim();
        final typeName = planMode ? s.nextPlanTypeName : s.lastConsultTypeName;
        final status = s.statusLabel;

        return DataRow2(
          onTap: () => onTap(s),
          cells: [
            DataCell(Row(
              children: [
                Flexible(
                  child: Text(
                    s.studentName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                if (showStatus && status != null) ...[
                  const SizedBox(width: 5),
                  MiniBadge(
                    text: status,
                    color: s.isEnrolled ? AppTheme.successColor : Colors.grey.shade600,
                  ),
                ],
              ],
            )),
            DataCell(Text(s.gradeName.isEmpty ? '-' : s.gradeName)),
            DataCell(Text(s.schoolName ?? '-', overflow: TextOverflow.ellipsis)),
            DataCell(Text(formatPhone(s.phone))),
            DataCell(Text(s.hasConsult ? '${s.consultCount}' : '-')),
            DataCell(planMode
                ? Text(
                    _planDate(s.nextPlanDate),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  )
                : Text(
                    s.hasConsult ? _shortDate(s.lastConsultDate) : '$consultWord 없음',
                    style: s.hasConsult
                        ? null
                        : TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  )),
            DataCell(
              preview == null || preview.isEmpty
                  ? const Text('-')
                  : Row(
                      children: [
                        if (typeName != null) ...[
                          MiniBadge(
                            text: typeName,
                            color: planMode
                                ? AppTheme.warningColor
                                : AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Expanded(
                          child: Text(
                            preview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12.5, height: 1.3),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// 미래 보기에서는 '최근 상담순'이 말이 안 된다. 가까운 예정일 순이다.
String _sortLabel(ConsultStudentSort sort, bool planMode) {
  if (sort == ConsultStudentSort.name) return sort.label;
  return planMode ? '예정일순' : sort.label;
}

// 요일은 직접 붙인다. DateFormat의 'ko' 로케일은 initializeDateFormatting을
// 거쳐야 하는데 이 앱은 그 초기화를 하지 않아 런타임에 터진다.
const _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

/// 계획은 시각까지 봐야 한다. '10-07(화) 16:20' 꼴로 둔다.
String _planDate(String? raw) {
  if (raw == null) return '-';
  final date = DateTime.tryParse(raw);
  if (date == null) return raw;
  final day = _weekdays[date.weekday - 1];
  return '${DateFormat('MM-dd').format(date)}($day) ${DateFormat('HH:mm').format(date)}';
}

String _shortDate(String? raw) {
  if (raw == null) return '-';
  final date = DateTime.tryParse(raw);
  if (date == null) return raw.length >= 10 ? raw.substring(0, 10) : raw;
  return DateFormat('yyyy-MM-dd').format(date);
}
