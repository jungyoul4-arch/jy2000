import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../../models/consult_student.dart';
import '../../providers/auth_provider.dart';
import '../../providers/consult_provider.dart';
import '../../widgets/logout_button.dart';
import 'student_consult_browser.dart';
import 'tc_register_dialog.dart';

/// 상담 관리
///
/// 신규생을 뺀 학생(재원 또는 퇴원)을 먼저 보여 주고, 고르면 그 학생의
/// 상담 내역이 뜬다. 신규생은 전용 화면(신규생 문의)에서 다룬다.
///
/// 상담 등록은 학생을 고른 뒤 그 학생의 목록 위에서 한다. 전역 버튼으로
/// 두면 폼에서 학생을 다시 골라야 해 같은 일을 두 번 하게 된다.
class ConsultListScreen extends ConsumerStatefulWidget {
  const ConsultListScreen({super.key});

  @override
  ConsumerState<ConsultListScreen> createState() => _ConsultListScreenState();
}

class _ConsultListScreenState extends ConsumerState<ConsultListScreen> {
  Future<void> _showTcRegisterDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const TcRegisterDialog(),
    );

    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('상담자 "${result.name}"이(가) 등록되었습니다.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _addConsult(ConsultStudent student) async {
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
    final authState = ref.watch(authProvider);
    final isAdmin = authState.user?.kind == 1 || authState.user?.isAdmin == true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('상담 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
            onPressed: () => ref.invalidate(consultStudentsProvider),
          ),
          const SizedBox(width: 8),
          if (isAdmin) ...[
            OutlinedButton.icon(
              onPressed: _showTcRegisterDialog,
              icon: const Icon(Icons.person_add),
              label: const Text('상담자 등록'),
            ),
            const SizedBox(width: 8),
          ],
          const LogoutButton(),
        ],
      ),
      body: StudentConsultBrowser(
        scope: ConsultStudentScope.existing,
        addConsultLabel: '상담 등록',
        onAddConsult: _addConsult,
      ),
    );
  }
}
