import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../providers/code_provider.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final int? studentId; // null이면 신규 등록

  const StudentFormScreen({super.key, this.studentId});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  bool get isEdit => widget.studentId != null;

  @override
  Widget build(BuildContext context) {
    final gradeCodes = ref.watch(gradeCodesProvider);
    final statusCodes = ref.watch(statusCodesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/students'),
        ),
        title: Text(isEdit ? '학생 수정' : '학생 등록'),
        actions: [
          FilledButton(
            onPressed: _isLoading ? null : _onSubmit,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isEdit ? '저장' : '등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 정보
              _buildSection(
                title: '기본 정보',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'student_name',
                          decoration: const InputDecoration(
                            labelText: '학생 이름 *',
                          ),
                          validator: FormBuilderValidators.required(
                            errorText: '이름을 입력하세요',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'phone',
                          decoration: const InputDecoration(
                            labelText: '전화번호 *',
                            hintText: '010-0000-0000',
                          ),
                          validator: FormBuilderValidators.required(
                            errorText: '전화번호를 입력하세요',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'email',
                          decoration: const InputDecoration(
                            labelText: '이메일',
                          ),
                          validator: FormBuilderValidators.email(
                            errorText: '올바른 이메일을 입력하세요',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'birth_date',
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                            labelText: '생년월일',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'school_name',
                          decoration: const InputDecoration(
                            labelText: '학교명',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderDropdown<String>(
                          name: 'grade_code',
                          decoration: const InputDecoration(
                            labelText: '학년',
                          ),
                          items: gradeCodes
                              .map(
                                (code) => DropdownMenuItem(
                                  value: code.codeId,
                                  child: Text(code.codeName),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 보호자 정보
              _buildSection(
                title: '보호자 정보',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'guardian_name',
                          decoration: const InputDecoration(
                            labelText: '보호자명',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'guardian_phone',
                          decoration: const InputDecoration(
                            labelText: '보호자 연락처',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 상태 정보
              _buildSection(
                title: '상태 정보',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<String>(
                          name: 'status_code',
                          decoration: const InputDecoration(
                            labelText: '상태 *',
                          ),
                          initialValue: 'STATUS_PROSPECT',
                          items: statusCodes
                              .map(
                                (code) => DropdownMenuItem(
                                  value: code.codeId,
                                  child: Text(code.codeName),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 메모
              _buildSection(
                title: '메모',
                children: [
                  FormBuilderTextField(
                    name: 'memo',
                    decoration: const InputDecoration(
                      hintText: '메모를 입력하세요',
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
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
            ...children,
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;
        // TODO: API 호출
        debugPrint('Form values: $values');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isEdit ? '학생 정보가 수정되었습니다' : '학생이 등록되었습니다'),
            ),
          );
          context.go('/students');
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
}
