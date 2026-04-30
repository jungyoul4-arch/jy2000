import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/student.dart';
import '../../models/school.dart';
import '../../providers/student_provider.dart';
import '../../providers/school_provider.dart';
import '../../repositories/student_repository.dart';
import '../../widgets/common/status_badge.dart';
import '../../utils/formatters.dart';

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
          studentAsync.whenOrNull(
            data: (student) => TextButton.icon(
              onPressed: () => _showEditDialog(context, ref, student),
              icon: const Icon(Icons.edit),
              label: const Text('편집'),
            ),
          ) ?? const SizedBox.shrink(),
          TextButton.icon(
            onPressed: () {
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
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
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
                        _InfoItem('전화번호', formatPhone(student.phone)),
                        _InfoItem('이메일', student.email ?? '-'),
                        _InfoItem('생년월일', formatDate(student.birthDate)),
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
                      items: _buildParentItems(student),
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
                        _InfoItem('최초접촉', formatDateTime(student.firstContactDate)),
                        _InfoItem('상담일', formatDate(student.consultDate)),
                        _InfoItem('등록일', formatDate(student.registerDate)),
                        _InfoItem('재원시작', formatDate(student.enrollDate)),
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

  List<_InfoItem> _buildParentItems(Student student) {
    final items = <_InfoItem>[];

    if (student.parents != null && student.parents!.isNotEmpty) {
      for (var i = 0; i < student.parents!.length; i++) {
        final parent = student.parents![i];
        final relation = _getParentKindName(parent.parentKind);
        items.add(_InfoItem('보호자${i + 1} ($relation)', formatPhone(parent.phone)));
      }
    } else if (student.guardianPhone != null) {
      // 기존 호환성
      items.add(_InfoItem('보호자명', student.guardianName ?? '-'));
      items.add(_InfoItem('연락처', formatPhone(student.guardianPhone)));
      items.add(_InfoItem('관계', student.relationName ?? '-'));
    } else {
      items.add(_InfoItem('보호자', '등록된 보호자가 없습니다'));
    }

    return items;
  }

  String _getParentKindName(int kind) {
    switch (kind) {
      case 1: return '부';
      case 2: return '모';
      case 3: return '친척';
      default: return '기타';
    }
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Student student) {
    showDialog(
      context: context,
      builder: (context) => _StudentEditDialog(
        student: student,
        onSaved: () {
          ref.invalidate(studentDetailProvider(studentId));
        },
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
                      width: 100,
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

// 학생 편집 다이얼로그
class _StudentEditDialog extends ConsumerStatefulWidget {
  final Student student;
  final VoidCallback onSaved;

  const _StudentEditDialog({
    required this.student,
    required this.onSaved,
  });

  @override
  ConsumerState<_StudentEditDialog> createState() => _StudentEditDialogState();
}

class _StudentEditDialogState extends ConsumerState<_StudentEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _schoolController;
  late TextEditingController _memoController;

  // 보호자 정보
  late TextEditingController _parent1PhoneController;
  late TextEditingController _parent2PhoneController;
  int _parent1Kind = 2; // 모
  int _parent2Kind = 1; // 부
  int? _parent1Id;
  int? _parent2Id;

  int? _selectedGrade;
  School? _selectedSchool;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.studentName);
    _phoneController = TextEditingController(text: widget.student.phone);
    _emailController = TextEditingController(text: widget.student.email ?? '');
    _schoolController = TextEditingController(text: widget.student.schoolName ?? '');
    _memoController = TextEditingController(text: widget.student.memo ?? '');
    // 학년 값이 유효한 범위(7-14)인 경우에만 설정
    final grade = widget.student.grade;
    _selectedGrade = (grade != null && grade >= 7 && grade <= 14) ? grade : null;

    // 보호자 정보 초기화
    if (widget.student.parents != null && widget.student.parents!.isNotEmpty) {
      final p1 = widget.student.parents![0];
      _parent1PhoneController = TextEditingController(text: p1.phone);
      _parent1Kind = p1.parentKind;
      _parent1Id = p1.parentId;

      if (widget.student.parents!.length > 1) {
        final p2 = widget.student.parents![1];
        _parent2PhoneController = TextEditingController(text: p2.phone);
        _parent2Kind = p2.parentKind;
        _parent2Id = p2.parentId;
      } else {
        _parent2PhoneController = TextEditingController();
      }
    } else {
      _parent1PhoneController = TextEditingController(text: widget.student.guardianPhone ?? '');
      _parent2PhoneController = TextEditingController();
    }

    // 학교 목록 로드
    Future.microtask(() {
      ref.read(schoolListProvider.notifier).loadSchools();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _schoolController.dispose();
    _memoController.dispose();
    _parent1PhoneController.dispose();
    _parent2PhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  const SizedBox(width: 8),
                  const Text(
                    '학생 정보 편집',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // 폼
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 기본 정보
                      const Text('기본 정보', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: '이름 *'),
                              validator: (v) => v?.isEmpty == true ? '이름을 입력하세요' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(labelText: '전화번호 *'),
                              validator: (v) => v?.isEmpty == true ? '전화번호를 입력하세요' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(labelText: '이메일'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedGrade,
                              decoration: const InputDecoration(labelText: '학년'),
                              items: const [
                                DropdownMenuItem(value: 7, child: Text('중1')),
                                DropdownMenuItem(value: 8, child: Text('중2')),
                                DropdownMenuItem(value: 9, child: Text('중3')),
                                DropdownMenuItem(value: 10, child: Text('고1')),
                                DropdownMenuItem(value: 11, child: Text('고2')),
                                DropdownMenuItem(value: 12, child: Text('고3')),
                                DropdownMenuItem(value: 13, child: Text('N수생')),
                                DropdownMenuItem(value: 14, child: Text('성인')),
                              ],
                              onChanged: (v) => setState(() => _selectedGrade = v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSchoolAutocomplete(),

                      const SizedBox(height: 24),

                      // 보호자 정보
                      const Text('보호자 정보', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),

                      // 보호자 1
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _parent1PhoneController,
                              decoration: const InputDecoration(labelText: '보호자1 전화번호'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _parent1Kind,
                              decoration: const InputDecoration(labelText: '관계'),
                              items: const [
                                DropdownMenuItem(value: 1, child: Text('부')),
                                DropdownMenuItem(value: 2, child: Text('모')),
                                DropdownMenuItem(value: 3, child: Text('친척')),
                                DropdownMenuItem(value: 99, child: Text('기타')),
                              ],
                              onChanged: (v) => setState(() => _parent1Kind = v ?? 2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 보호자 2
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _parent2PhoneController,
                              decoration: const InputDecoration(labelText: '보호자2 전화번호'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _parent2Kind,
                              decoration: const InputDecoration(labelText: '관계'),
                              items: const [
                                DropdownMenuItem(value: 1, child: Text('부')),
                                DropdownMenuItem(value: 2, child: Text('모')),
                                DropdownMenuItem(value: 3, child: Text('친척')),
                                DropdownMenuItem(value: 99, child: Text('기타')),
                              ],
                              onChanged: (v) => setState(() => _parent2Kind = v ?? 1),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 메모
                      const Text('메모', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _memoController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: '메모를 입력하세요',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 버튼
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _isLoading ? null : _onSave,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('저장'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchoolAutocomplete() {
    final schoolState = ref.watch(schoolListProvider);
    final schools = schoolState.schools;

    return Autocomplete<School>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return schools;
        }
        return schools.where((school) =>
            school.schoolName.contains(textEditingValue.text));
      },
      displayStringForOption: (School school) => school.schoolName,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        if (_schoolController.text.isNotEmpty && controller.text.isEmpty) {
          controller.text = _schoolController.text;
        }
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(labelText: '학교'),
          onChanged: (value) {
            _schoolController.text = value;
            if (_selectedSchool != null && _selectedSchool!.schoolName != value) {
              _selectedSchool = null;
            }
          },
        );
      },
      onSelected: (School school) {
        _schoolController.text = school.schoolName;
        _selectedSchool = school;
      },
    );
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final parents = <ParentInfo>[];

      // 보호자 1
      if (_parent1PhoneController.text.isNotEmpty) {
        parents.add(ParentInfo(
          parentId: _parent1Id,
          phone: _parent1PhoneController.text,
          seq: 1,
          parentKind: _parent1Kind,
        ));
      }

      // 보호자 2
      if (_parent2PhoneController.text.isNotEmpty) {
        parents.add(ParentInfo(
          parentId: _parent2Id,
          phone: _parent2PhoneController.text,
          seq: 2,
          parentKind: _parent2Kind,
        ));
      }

      final update = StudentUpdate(
        studentName: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        schoolId: _selectedSchool?.schoolId,
        schoolName: _schoolController.text.isNotEmpty ? _schoolController.text : null,
        grade: _selectedGrade,
        memo: _memoController.text.isNotEmpty ? _memoController.text : null,
        parents: parents.isNotEmpty ? parents : null,
      );

      final repository = StudentRepository();
      await repository.update(widget.student.studentId, update);

      if (mounted) {
        Navigator.of(context).pop();
        widget.onSaved();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('학생 정보가 수정되었습니다')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
