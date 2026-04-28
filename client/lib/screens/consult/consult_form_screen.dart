import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../providers/code_provider.dart';

class ConsultFormScreen extends ConsumerStatefulWidget {
  final int? studentId;

  const ConsultFormScreen({super.key, this.studentId});

  @override
  ConsumerState<ConsultFormScreen> createState() => _ConsultFormScreenState();
}

class _ConsultFormScreenState extends ConsumerState<ConsultFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final consultTypeCodes = ref.watch(consultTypeCodesProvider);
    final channelCodes = ref.watch(channelCodesProvider);
    final consultResultCodes = ref.watch(consultResultCodesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/consults'),
        ),
        title: const Text('상담 등록'),
        actions: [
          FilledButton(
            onPressed: _isLoading ? null : _onSubmit,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('등록'),
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
              // 학생 정보
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '학생 정보',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'student_id',
                        initialValue: widget.studentId?.toString(),
                        decoration: const InputDecoration(
                          labelText: '학생 ID *',
                          hintText: '학생 ID를 입력하세요',
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: '학생 ID를 입력하세요',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 상담 정보
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '상담 정보',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderDropdown<String>(
                              name: 'consult_type_code',
                              decoration: const InputDecoration(
                                labelText: '상담 유형 *',
                              ),
                              validator: FormBuilderValidators.required(
                                errorText: '상담 유형을 선택하세요',
                              ),
                              items: consultTypeCodes
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
                          Expanded(
                            child: FormBuilderDropdown<String>(
                              name: 'channel_code',
                              decoration: const InputDecoration(
                                labelText: '상담 채널',
                              ),
                              items: channelCodes
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
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'consult_date',
                              inputType: InputType.both,
                              initialValue: DateTime.now(),
                              decoration: const InputDecoration(
                                labelText: '상담 일시 *',
                              ),
                              validator: FormBuilderValidators.required(
                                errorText: '상담 일시를 선택하세요',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'consult_duration',
                              decoration: const InputDecoration(
                                labelText: '상담 시간 (분)',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 상담 내용
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '상담 내용',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'content',
                        decoration: const InputDecoration(
                          labelText: '상담 내용',
                          hintText: '상담 내용을 입력하세요',
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'student_needs',
                        decoration: const InputDecoration(
                          labelText: '학생 니즈/요구사항',
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'interest_subject',
                        decoration: const InputDecoration(
                          labelText: '관심 과목',
                          hintText: '예: 수학, 영어',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 결과 및 후속 조치
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '결과 및 후속 조치',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderDropdown<String>(
                              name: 'consult_result_code',
                              decoration: const InputDecoration(
                                labelText: '상담 결과',
                              ),
                              items: consultResultCodes
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
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'next_consult_date',
                              inputType: InputType.both,
                              decoration: const InputDecoration(
                                labelText: '다음 상담 예정일',
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;
        // TODO: API 호출
        debugPrint('Form values: $values');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('상담이 등록되었습니다')),
          );
          context.go('/consults');
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
