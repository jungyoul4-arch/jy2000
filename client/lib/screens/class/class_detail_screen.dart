import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/class_model.dart';
import '../../providers/class_provider.dart';
import '../../repositories/class_repository.dart';

// 과목 이름 맵
const _genreNameMap = {
  1: '국어',
  2: '수학',
  3: '영어',
  4: '과학',
  5: '사회',
  99: '기타',
};

// 레벨 이름 맵
const _levelNameMap = {
  1: '최상위(A)',
  2: '상위(B)',
  3: '중위(C)',
  4: '기초(D)',
  5: '모든레벨(E)',
  99: '기타',
};

// 커리큘럼 이름 맵
const _curriculumNameMap = {
  1: '정시반',
  2: '특별반',
};

class ClassDetailScreen extends ConsumerWidget {
  final int classId;

  const ClassDetailScreen({super.key, required this.classId});

  String _getGradeStr(int? grade) {
    if (grade == null) return '-';
    if (grade >= 7 && grade <= 9) return '중${grade - 6}';
    if (grade >= 10 && grade <= 12) return '고${grade - 9}';
    if (grade == 14) return '성인';
    return '기타';
  }

  String _formatFee(int? fee) {
    if (fee == null) return '-';
    final formatter = NumberFormat('#,###');
    return '${formatter.format(fee)}원';
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _getLectureDates(ClassInfo info) {
    final dates = [
      info.lectureDate1,
      info.lectureDate2,
      info.lectureDate3,
      info.lectureDate4,
      info.lectureDate5,
    ].where((d) => d != null && d.isNotEmpty).toList();
    return dates.isEmpty ? '-' : dates.join(', ');
  }

  Future<void> _deleteClass(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('반 삭제'),
        content: const Text(
          '정말로 이 반을 삭제하시겠습니까?\n\n'
          '관련된 모든 데이터(반 정보, 선생님 배정, 학생 배정)가 삭제됩니다.\n'
          '이 작업은 되돌릴 수 없습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final repository = ref.read(classRepositoryProvider);
        await repository.delete(classId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('반이 삭제되었습니다.')),
          );
          ref.read(classListProvider.notifier).refresh();
          context.go('/classes');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('삭제 실패: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classDetailAsync = ref.watch(classDetailProvider(classId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/classes');
            }
          },
        ),
        title: const Text('반 상세'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(classDetailProvider(classId)),
            tooltip: '새로고침',
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/classes/$classId/edit'),
            icon: const Icon(Icons.edit),
            label: const Text('편집'),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            onPressed: () => _deleteClass(context, ref),
            icon: const Icon(Icons.delete),
            label: const Text('삭제'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: classDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('오류: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(classDetailProvider(classId)),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
        data: (classDetail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 정보 카드
              _buildInfoCard(context, classDetail),
              const SizedBox(height: 16),
              // 강의 일시 카드
              _buildScheduleCard(context, classDetail.info),
              const SizedBox(height: 16),
              // 선생님 카드
              _buildTeachersCard(context, classDetail.teachers),
              const SizedBox(height: 16),
              // 학생 목록 카드
              _buildStudentsCard(context, ref, classDetail.students),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ClassDetail classDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.class_outlined),
                const SizedBox(width: 8),
                Text(
                  '기본 정보',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Divider(),
            _buildInfoRow('반 이름', classDetail.className),
            _buildInfoRow('ID', '${classDetail.classId}'),
            _buildInfoRow('과목', _genreNameMap[classDetail.genreId] ?? '-'),
            _buildInfoRow('학년', _getGradeStr(classDetail.info.grade)),
            _buildInfoRow('커리큘럼', _curriculumNameMap[classDetail.info.curriculum] ?? '-'),
            _buildInfoRow('수준', _levelNameMap[classDetail.info.level] ?? '-'),
            _buildInfoRow('년도', '${classDetail.info.year}년'),
            _buildInfoRow('수강료', _formatFee(classDetail.info.monthlyFee)),
            _buildInfoRow('등록일', _formatDate(classDetail.regDt)),
            if (classDetail.info.termStart != null || classDetail.info.termEnd != null)
              _buildInfoRow(
                '학기 기간',
                '${_formatDate(classDetail.info.termStart)} ~ ${_formatDate(classDetail.info.termEnd)}',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(BuildContext context, ClassInfo info) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule),
                const SizedBox(width: 8),
                Text(
                  '강의 일시',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Divider(),
            Text(
              _getLectureDates(info),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachersCard(BuildContext context, List<ClassMember> teachers) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 8),
                Text(
                  '선생님 (${teachers.length}명)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Divider(),
            if (teachers.isEmpty)
              const Text('등록된 선생님이 없습니다.')
            else
              ...teachers.map((teacher) => ListTile(
                    leading: CircleAvatar(
                      child: Text(teacher.userName?.substring(0, 1) ?? '?'),
                    ),
                    title: Text(teacher.userName ?? '-'),
                    subtitle: Text(teacher.phone ?? '-'),
                    dense: true,
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsCard(BuildContext context, WidgetRef ref, List<ClassMember> students) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '학생 목록 (${students.length}명)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showAddStudentDialog(context, ref, students),
                  icon: const Icon(Icons.person_add, size: 18),
                  label: const Text('학생 추가'),
                ),
              ],
            ),
            const Divider(),
            if (students.isEmpty)
              const Text('등록된 학생이 없습니다.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(student.userName ?? '-'),
                    subtitle: Text(student.phone ?? '-'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () => _removeStudent(context, ref, student),
                          tooltip: '학생 제외',
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () {
                      context.push('/students/${student.userId}');
                    },
                    dense: true,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddStudentDialog(BuildContext context, WidgetRef ref, List<ClassMember> currentStudents) async {
    await showDialog(
      context: context,
      builder: (context) => _AddStudentDialog(
        classId: classId,
        currentStudentIds: currentStudents.map((s) => s.userId).toList(),
        onAdded: () {
          ref.refresh(classDetailProvider(classId));
        },
      ),
    );
  }

  Future<void> _removeStudent(BuildContext context, WidgetRef ref, ClassMember student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('학생 제외'),
        content: Text('${student.userName ?? '학생'}을(를) 이 반에서 제외하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('제외'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final repository = ref.read(classRepositoryProvider);
        await repository.removeMember(classId, student.userId);
        ref.refresh(classDetailProvider(classId));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${student.userName ?? '학생'}이(가) 제외되었습니다.')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('오류: $e')),
          );
        }
      }
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

// 학생 추가 다이얼로그
class _AddStudentDialog extends ConsumerStatefulWidget {
  final int classId;
  final List<int> currentStudentIds;
  final VoidCallback onAdded;

  const _AddStudentDialog({
    required this.classId,
    required this.currentStudentIds,
    required this.onAdded,
  });

  @override
  ConsumerState<_AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends ConsumerState<_AddStudentDialog> {
  final _searchController = TextEditingController();
  List<UserSearchResult> _searchResults = [];
  bool _isSearching = false;
  bool _isAdding = false;
  late List<int> _addedStudentIds;

  @override
  void initState() {
    super.initState();
    _addedStudentIds = List.from(widget.currentStudentIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);

    try {
      final repository = ref.read(classRepositoryProvider);
      final results = await repository.searchUsers(query, kind: 2);
      setState(() {
        _searchResults = results
            .where((r) => !_addedStudentIds.contains(r.userId))
            .toList();
      });
    } catch (e) {
      // ignore
    } finally {
      setState(() => _isSearching = false);
    }
  }

  Future<void> _addStudent(UserSearchResult student) async {
    setState(() => _isAdding = true);

    try {
      final repository = ref.read(classRepositoryProvider);
      await repository.addMember(widget.classId, student.userId, 2); // kind=2 학생

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${student.name}이(가) 추가되었습니다.')),
        );
        setState(() {
          _searchResults.remove(student);
          _addedStudentIds.add(student.userId);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAdding = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('학생 추가'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '학생 이름 또는 전화번호로 검색',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: _search,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? '검색어를 입력하세요'
                            : '검색 결과가 없습니다',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final student = _searchResults[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(student.name.isNotEmpty ? student.name[0] : '?'),
                          ),
                          title: Text(student.name),
                          subtitle: Text(student.phone ?? ''),
                          trailing: FilledButton.icon(
                            onPressed: _isAdding ? null : () => _addStudent(student),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('추가'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onAdded(); // 닫을 때 목록 새로고침
            Navigator.pop(context);
          },
          child: const Text('닫기'),
        ),
      ],
    );
  }
}
