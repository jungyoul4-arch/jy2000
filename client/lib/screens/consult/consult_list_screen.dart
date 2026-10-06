import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../../models/consult_student.dart';
import '../../providers/auth_provider.dart';
import '../../providers/consult_provider.dart';
import '../../widgets/logout_button.dart';
import 'student_consult_dialog.dart';
import 'student_consult_table.dart';
import 'tc_register_dialog.dart';

/// 상담 관리
///
/// 신규생을 뺀 학생(재원 또는 퇴원)을 보여 준다. 신규생은 전용 화면에서
/// 다룬다. 목록이 가로를 다 쓰고, 고른 학생의 상담 내역은 팝업으로 뜬다.
///
/// 상담 등록은 두 길이 있다.
///   상단 버튼 — 학생을 아직 못 정했을 때. 폼 안에서 타입어헤드로 고른다.
///   팝업 안   — 학생이 정해진 상태. 그 학생에게 바로 붙는다.
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

  /// [student]가 없으면 폼에서 학생을 직접 고른다.
  Future<void> _addConsult({ConsultStudent? student}) async {
    final uri = Uri(
      path: AppRoutes.consultCreate,
      queryParameters:
          student == null ? null : {'studentId': '${student.studentId}'},
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
          FilledButton.icon(
            onPressed: () => _addConsult(),
            icon: const Icon(Icons.add),
            label: const Text('상담 등록'),
          ),
          const SizedBox(width: 16),
          const LogoutButton(),
        ],
      ),
      body: StudentConsultTable(
        scope: ConsultStudentScope.existing,
        emptyLabel: '재원·퇴원 학생이 없습니다',
        actions: [
          StudentConsultAction(
            label: '상담 등록',
            icon: Icons.add,
            primary: true,
            onTap: (student) => _addConsult(student: student),
          ),
        ],
      ),
    );
  }
}
