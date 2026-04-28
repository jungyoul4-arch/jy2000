import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../providers/student_provider.dart';
import '../../widgets/common/status_badge.dart';

class StudentDetailScreen extends ConsumerWidget {
  final int studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentDetailProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/students'),
        ),
        title: const Text('학생 상세'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // TODO: 상담 등록 페이지로 이동
              context.go('/consults/create?studentId=$studentId');
            },
            icon: const Icon(Icons.add),
            label: const Text('상담 등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: studentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (student) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      student.studentName.isNotEmpty
                          ? student.studentName[0]
                          : '?',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.studentName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          StatusBadge(
                            statusCode: student.statusCode,
                            statusName: student.statusName ?? '',
                          ),
                          if (student.subStatusName != null) ...[
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                student.subStatusName!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: 상태 변경 다이얼로그
                    },
                    child: const Text('상태 변경'),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 상세 정보
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 기본 정보
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      title: '기본 정보',
                      items: [
                        _InfoItem('전화번호', student.phone),
                        _InfoItem('이메일', student.email ?? '-'),
                        _InfoItem('생년월일', student.birthDate ?? '-'),
                        _InfoItem('성별', student.genderName ?? '-'),
                        _InfoItem('학교', student.schoolName ?? '-'),
                        _InfoItem('학년', student.gradeName ?? '-'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 보호자 정보
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      title: '보호자 정보',
                      items: [
                        _InfoItem('보호자명', student.guardianName ?? '-'),
                        _InfoItem('연락처', student.guardianPhone ?? '-'),
                        _InfoItem('관계', student.relationName ?? '-'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 관리 정보
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      title: '관리 정보',
                      items: [
                        _InfoItem('담당 TC', student.tcName ?? '-'),
                        _InfoItem('유입경로', student.sourceName ?? '-'),
                        _InfoItem('최초접촉', student.firstContactDate ?? '-'),
                        _InfoItem('상담일', student.consultDate ?? '-'),
                        _InfoItem('등록일', student.registerDate ?? '-'),
                        _InfoItem('재원시작', student.enrollDate ?? '-'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 메모
              if (student.memo != null && student.memo!.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '메모',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(student.memo!),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required List<_InfoItem> items,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        item.label,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Text(item.value)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem(this.label, this.value);
}
