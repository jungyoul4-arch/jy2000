import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../../models/consult_student.dart';
import '../../providers/consult_provider.dart';
import '../../widgets/logout_button.dart';
import 'student_consult_browser.dart';

/// 신규생 문의
///
/// 신규생 = 아직 정율학원 학원생이 되지 않은 학생(active_flag=0, 퇴원 아님).
/// 상담한 학생 목록을 먼저 보여 주고, 고르면 그 학생의 문의 내역이 뜬다.
///
/// 연필 버튼이 입력 폼을 연다. 학생을 고른 상태면 그 학생에게 문의를
/// 덧붙이고, 아무도 고르지 않았으면 새 학생부터 등록한다.
class NewInquiryListScreen extends ConsumerStatefulWidget {
  const NewInquiryListScreen({super.key});

  @override
  ConsumerState<NewInquiryListScreen> createState() => _NewInquiryListScreenState();
}

class _NewInquiryListScreenState extends ConsumerState<NewInquiryListScreen> {
  /// 폼에서 돌아오면 목록을 다시 받는다. 방금 넣은 문의가 보여야 한다.
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
      body: StudentConsultBrowser(
        scope: ConsultStudentScope.newStudent,
        addConsultLabel: '문의 추가',
        onAddConsult: (student) => _openForm(student: student),
      ),
    );
  }
}
