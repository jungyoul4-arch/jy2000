import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../../models/consult_student.dart';
import '../../providers/consult_provider.dart';
import '../../widgets/logout_button.dart';
import 'student_consult_dialog.dart';
import 'student_consult_table.dart';

/// 신규생 문의
///
/// 신규생 = 아직 정율학원 학원생이 되지 않은 학생(active_flag=0, 퇴원 아님).
/// 목록이 가로를 다 쓰고, 고른 학생의 문의 내역은 팝업으로 뜬다.
class NewInquiryListScreen extends ConsumerStatefulWidget {
  const NewInquiryListScreen({super.key});

  @override
  ConsumerState<NewInquiryListScreen> createState() => _NewInquiryListScreenState();
}

class _NewInquiryListScreenState extends ConsumerState<NewInquiryListScreen> {
  /// 폼에서 돌아오면 목록을 다시 받는다. 방금 넣은 문의가 보여야 한다.
  ///
  /// [student]가 있으면 그 학생에게 덧붙이고, 없으면 새 학생부터 등록한다.
  Future<void> _openForm({ConsultStudent? student}) async {
    final uri = Uri(
      path: AppRoutes.newInquiryCreate,
      queryParameters: student == null
          ? null
          : {
              'studentId': '${student.studentId}',
              'studentName': student.studentName,
            },
    );

    await context.push(uri.toString());
    if (!mounted) return;

    ref.invalidate(consultStudentsProvider);
    if (student != null) {
      ref.invalidate(studentConsultListProvider(student.studentId));
    }
  }

  /// 일정 캘린더에 뜨는 정식 상담을 그 학생으로 잡는다.
  Future<void> _openConsultForm(ConsultStudent student) async {
    final uri = Uri(
      path: AppRoutes.consultCreate,
      queryParameters: {'studentId': '${student.studentId}'},
    );

    await context.push(uri.toString());
    if (!mounted) return;

    ref.invalidate(consultStudentsProvider);
    ref.invalidate(studentConsultListProvider(student.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('신규생 문의'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
            onPressed: () => ref.invalidate(consultStudentsProvider),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () => _openForm(),
            icon: const Icon(Icons.edit),
            label: const Text('신규 문의 등록'),
          ),
          const SizedBox(width: 16),
          const LogoutButton(),
        ],
      ),
      body: StudentConsultTable(
        scope: ConsultStudentScope.newStudent,
        consultWord: '문의',
        emptyLabel: '신규생이 없습니다',
        actions: [
          StudentConsultAction(
            label: '문의 추가',
            icon: Icons.edit,
            primary: true,
            onTap: (student) => _openForm(student: student),
          ),
          // 신규생도 이미 User에 있으므로 일정이 붙는 정식 상담을 바로 잡을 수
          // 있다. 상담 관리의 '상담 등록'과 같은 화면으로 간다.
          StudentConsultAction(
            label: '상담 일정 등록',
            icon: Icons.event_available,
            onTap: _openConsultForm,
          ),
        ],
      ),
    );
  }
}
