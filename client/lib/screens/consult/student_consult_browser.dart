import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/consult.dart';
import '../../models/consult_student.dart';
import '../../providers/consult_provider.dart';

/// 학생 목록 → 그 학생의 상담 목록 2단 화면.
///
/// 신규생 문의와 상담 관리가 대상(scope)만 바꿔 같이 쓴다. 상담을 고르면
/// 기존 상담 상세 화면으로 넘어간다 — 3단을 한 화면에 욱여넣기보다
/// 이미 있는 상세 화면을 그대로 쓰는 편이 낫다.
///
/// 넓은 화면은 좌우로 붙이고, 좁으면 학생 목록만 보이다가 고르면 상담
/// 목록으로 넘어간다.
class StudentConsultBrowser extends ConsumerStatefulWidget {
  final ConsultStudentScope scope;

  /// 상담 목록 위에 놓을 '상담 추가' 동작. 학생이 정해진 상태로 부른다.
  final void Function(ConsultStudent student)? onAddConsult;

  /// 상담 추가 버튼 문구
  final String addConsultLabel;

  const StudentConsultBrowser({
    super.key,
    required this.scope,
    this.onAddConsult,
    this.addConsultLabel = '상담 추가',
  });

  @override
  ConsumerState<StudentConsultBrowser> createState() => _StudentConsultBrowserState();
}

class _StudentConsultBrowserState extends ConsumerState<StudentConsultBrowser> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  late ConsultStudentQuery _query = ConsultStudentQuery(scope: widget.scope);
  ConsultStudent? _selected;

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

  void _select(ConsultStudent student) {
    setState(() => _selected = student);
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    final studentsAsync = ref.watch(consultStudentsProvider(_query));

    final list = _StudentList(
      async: studentsAsync,
      query: _query,
      selected: _selected,
      searchController: _searchController,
      onSearchChanged: _onSearchChanged,
      onSortChanged: (sort) => setState(() => _query = _query.copyWith(sort: sort)),
      onScopeAllChanged: (showAll) =>
          setState(() => _query = _query.copyWith(hasConsultOnly: !showAll)),
      onSelect: _select,
    );

    if (!wide) {
      // 좁은 화면에서는 학생을 고르면 상담 목록으로 넘어간다.
      if (_selected == null) return list;
      return _ConsultPanel(
        student: _selected!,
        onBack: () => setState(() => _selected = null),
        onAddConsult: widget.onAddConsult,
        addConsultLabel: widget.addConsultLabel,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 380, child: list),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(
          child: _selected == null
              ? const Center(
                  child: Text(
                    '왼쪽에서 학생을 선택하세요',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : _ConsultPanel(
                  student: _selected!,
                  onAddConsult: widget.onAddConsult,
                  addConsultLabel: widget.addConsultLabel,
                ),
        ),
      ],
    );
  }
}

// ============================================================
// 학생 목록
// ============================================================

class _StudentList extends StatelessWidget {
  final AsyncValue<List<ConsultStudent>> async;
  final ConsultStudentQuery query;
  final ConsultStudent? selected;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ConsultStudentSort> onSortChanged;
  final ValueChanged<bool> onScopeAllChanged;
  final ValueChanged<ConsultStudent> onSelect;

  const _StudentList({
    required this.async,
    required this.query,
    required this.selected,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onScopeAllChanged,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final searching = query.search.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: '이름 · 전화 · 학교로 검색',
              prefixIcon: const Icon(Icons.search, size: 20),
              isDense: true,
              suffixIcon: searchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    ),
            ),
          ),
        ),

        // 정렬과 범위. 검색 중에는 범위 칩이 의미 없다 — 대상 전원에서 찾는다.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final sort in ConsultStudentSort.values)
                ChoiceChip(
                  label: Text(sort.label, style: const TextStyle(fontSize: 12)),
                  selected: query.sort == sort,
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) => onSortChanged(sort),
                ),
              if (!searching)
                FilterChip(
                  label: const Text('상담 없는 학생 포함', style: TextStyle(fontSize: 12)),
                  selected: !query.hasConsultOnly,
                  visualDensity: VisualDensity.compact,
                  onSelected: onScopeAllChanged,
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),

        Expanded(
          child: async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                '학생 목록을 불러오지 못했습니다\n\n$e',
                style: const TextStyle(color: AppTheme.errorColor, fontSize: 12),
              ),
            ),
            data: (students) {
              if (students.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      searching ? '검색 결과가 없습니다' : '대상 학생이 없습니다',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
                    child: Row(
                      children: [
                        Text(
                          '${students.length}명',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                        // 서버가 500명에서 자른다. 잘린 걸 모르면 "없다"고 오해한다.
                        if (students.length >= 500) ...[
                          const SizedBox(width: 6),
                          Text(
                            '(500명까지만 표시 — 검색해 주세요)',
                            style: TextStyle(fontSize: 11, color: AppTheme.warningColor),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: students.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (context, i) => _StudentTile(
                        student: students[i],
                        selected: students[i].studentId == selected?.studentId,
                        onTap: () => onSelect(students[i]),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StudentTile extends StatelessWidget {
  final ConsultStudent student;
  final bool selected;
  final VoidCallback onTap;

  const _StudentTile({
    required this.student,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = student.statusLabel;

    // 최근 상담 내용은 줄바꿈이 섞여 있어 그대로 두면 높이가 들쑥날쑥해진다.
    // 한 줄로 펴서 두 줄까지만 보여 준다.
    final preview = student.lastConsultContent?.replaceAll(RegExp(r'\s+'), ' ').trim();

    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? AppTheme.primaryColor.withValues(alpha: 0.08) : null,
        padding: const EdgeInsets.fromLTRB(14, 9, 12, 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    student.studentName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                if (status != null) ...[
                  const SizedBox(width: 6),
                  _Badge(
                    text: status,
                    color: student.isEnrolled ? AppTheme.successColor : Colors.grey.shade600,
                  ),
                ],
                const Spacer(),
                if (student.hasConsult) ...[
                  Text(
                    '${student.consultCount}건',
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _shortDate(student.lastConsultDate),
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade500),
                  ),
                ] else
                  Text(
                    '상담 없음',
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade400),
                  ),
              ],
            ),
            if (student.subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  student.subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            if (preview != null && preview.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (student.lastConsultTypeName != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: _Badge(
                          text: student.lastConsultTypeName!,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                    Expanded(
                      child: Text(
                        preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(text, style: TextStyle(fontSize: 10.5, color: color)),
    );
  }
}

// ============================================================
// 선택한 학생의 상담 목록
// ============================================================

class _ConsultPanel extends ConsumerWidget {
  final ConsultStudent student;
  final VoidCallback? onBack;
  final void Function(ConsultStudent student)? onAddConsult;
  final String addConsultLabel;

  const _ConsultPanel({
    required this.student,
    this.onBack,
    this.onAddConsult,
    required this.addConsultLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultsAsync = ref.watch(studentConsultListProvider(student.studentId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          color: Colors.grey.shade50,
          child: Row(
            children: [
              if (onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: '학생 목록',
                  onPressed: onBack,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.studentName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      [
                        if (student.subtitle.isNotEmpty) student.subtitle,
                        if (student.phone != null) student.phone!,
                      ].join(' · '),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              if (onAddConsult != null)
                FilledButton.icon(
                  onPressed: () => onAddConsult!(student),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(addConsultLabel),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: consultsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SelectableText(
                  '상담 목록을 불러오지 못했습니다\n\n$e',
                  style: const TextStyle(color: AppTheme.errorColor),
                ),
              ),
            ),
            data: (consults) {
              if (consults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('상담 기록이 없습니다', style: TextStyle(color: Colors.grey.shade600)),
                      if (onAddConsult != null) ...[
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => onAddConsult!(student),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(addConsultLabel),
                        ),
                      ],
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: consults.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) => _ConsultTile(consult: consults[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ConsultTile extends StatelessWidget {
  final Consult consult;

  const _ConsultTile({required this.consult});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/consults/${consult.consultId}'),
      title: Row(
        children: [
          Text(
            _formatDate(consult.consultDate),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          if (consult.consultTypeName != null)
            _Badge(text: consult.consultTypeName!, color: AppTheme.primaryColor),
          const SizedBox(width: 6),
          if (consult.channelName != null)
            Text(
              consult.channelName!,
              style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
            ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          consult.content?.trim().isNotEmpty == true ? consult.content!.trim() : '내용 없음',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (consult.tcName != null)
            Text(consult.tcName!, style: const TextStyle(fontSize: 12)),
          if (consult.consultResultName != null)
            Text(
              consult.consultResultName!,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
        ],
      ),
    );
  }
}

String _formatDate(String raw) {
  final date = DateTime.tryParse(raw);
  if (date == null) return raw;
  return DateFormat('yyyy-MM-dd HH:mm').format(date);
}

String _shortDate(String? raw) {
  if (raw == null) return '';
  final date = DateTime.tryParse(raw);
  if (date == null) return raw.length >= 10 ? raw.substring(5, 10) : raw;
  return DateFormat('MM/dd').format(date);
}
