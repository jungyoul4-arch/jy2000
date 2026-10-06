import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/consult.dart';
import '../../models/consult_student.dart';
import '../../providers/consult_provider.dart';
import '../../utils/formatters.dart';

/// 팝업에서 고를 수 있는 동작.
///
/// 신규생 문의는 '문의 추가'와 '상담 일정 등록' 둘을 내건다. 학생이 이미
/// User에 있으므로 일정이 붙는 정식 상담도 바로 잡을 수 있다.
class StudentConsultAction {
  final String label;
  final IconData icon;
  final void Function(ConsultStudent student) onTap;

  /// 첫 번째(기본) 동작은 채운 버튼으로, 나머지는 외곽선 버튼으로 그린다.
  final bool primary;

  const StudentConsultAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });
}

/// 작은 배지. 상태·상담유형 표시에 쓴다.
class MiniBadge extends StatelessWidget {
  final String text;
  final Color color;

  const MiniBadge({super.key, required this.text, required this.color});

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

/// 한 학생의 상담 목록.
///
/// 신규생 문의는 팝업 안에서, 상담 관리는 오른쪽 칸에서 같은 걸 쓴다.
class StudentConsultListView extends ConsumerWidget {
  final ConsultStudent student;
  final List<StudentConsultAction> actions;

  const StudentConsultListView({
    super.key,
    required this.student,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultsAsync = ref.watch(studentConsultListProvider(student.studentId));

    return consultsAsync.when(
      loading: () => const Center(child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      )),
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('상담 기록이 없습니다', style: TextStyle(color: Colors.grey.shade600)),
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final a in actions)
                        OutlinedButton.icon(
                          onPressed: () => a.onTap(student),
                          icon: Icon(a.icon, size: 18),
                          label: Text(a.label),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: consults.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) => _ConsultTile(consult: consults[i]),
        );
      },
    );
  }
}

class _ConsultTile extends StatelessWidget {
  final Consult consult;

  const _ConsultTile({required this.consult});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 상세는 기존 화면을 그대로 쓴다. 팝업 안에서 눌렀다면 팝업을 닫고 간다.
      onTap: () {
        final navigator = Navigator.of(context);
        if (navigator.canPop()) navigator.pop();
        context.push('/consults/${consult.consultId}');
      },
      title: Row(
        children: [
          Text(
            formatDateTime(consult.consultDate),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          if (consult.consultTypeName != null)
            MiniBadge(text: consult.consultTypeName!, color: AppTheme.primaryColor),
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
          maxLines: 3,
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

/// 학생을 고르면 뜨는 팝업 — 학생 요약 + 상담 목록.
///
/// 목록 화면을 반으로 쪼개지 않고 가로를 다 쓰게 하려고 상세를 팝업으로 뺐다.
Future<void> showStudentConsultDialog(
  BuildContext context, {
  required ConsultStudent student,
  List<StudentConsultAction> actions = const [],
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760, maxHeight: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DialogHeader(student: student, actions: actions),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                child: StudentConsultListView(student: student, actions: actions),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _DialogHeader extends StatelessWidget {
  final ConsultStudent student;
  final List<StudentConsultAction> actions;

  const _DialogHeader({required this.student, required this.actions});

  @override
  Widget build(BuildContext context) {
    final status = student.statusLabel;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        student.studentName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: 8),
                      MiniBadge(
                        text: status,
                        color: student.isEnrolled
                            ? AppTheme.successColor
                            : Colors.grey.shade600,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (student.subtitle.isNotEmpty) student.subtitle,
                    if (student.phone != null) formatPhone(student.phone),
                    if (student.hasConsult) '상담 ${student.consultCount}건',
                  ].join(' · '),
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          for (final a in actions) ...[
            const SizedBox(width: 8),
            // 동작은 팝업을 닫고 화면을 옮긴다. 팝업을 띄운 채로 두면
            // 돌아왔을 때 목록이 갱신되지 않은 팝업이 남는다.
            a.primary
                ? FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      a.onTap(student);
                    },
                    icon: Icon(a.icon, size: 18),
                    label: Text(a.label),
                  )
                : OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      a.onTap(student);
                    },
                    icon: Icon(a.icon, size: 18),
                    label: Text(a.label),
                  ),
          ],
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: '닫기',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

String formatDateTime(String raw) {
  final date = DateTime.tryParse(raw);
  if (date == null) return raw;
  return DateFormat('yyyy-MM-dd HH:mm').format(date);
}
