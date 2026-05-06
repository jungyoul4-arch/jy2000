import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/consult.dart';
import '../../repositories/consult_repository.dart';
import '../../providers/code_provider.dart';
import '../../providers/consult_provider.dart';

class ConsultFormScreen extends ConsumerStatefulWidget {
  final int? studentId;

  const ConsultFormScreen({super.key, this.studentId});

  @override
  ConsumerState<ConsultFormScreen> createState() => _ConsultFormScreenState();
}

class _ConsultFormScreenState extends ConsumerState<ConsultFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  List<String> _prevInterestSubjects = [];

  @override
  Widget build(BuildContext context) {
    final consultTypeCodes = ref.watch(consultTypeCodesProvider);
    final channelCodes = ref.watch(channelCodesProvider);
    final consultResultCodes = ref.watch(consultResultCodesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _goBack(),
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
                      FormBuilderCheckboxGroup<String>(
                        name: 'interest_subjects',
                        decoration: const InputDecoration(
                          labelText: '관심 과목',
                          border: InputBorder.none,
                        ),
                        wrapDirection: Axis.horizontal,
                        wrapSpacing: 16,
                        wrapRunSpacing: 0,
                        options: const [
                          FormBuilderFieldOption(value: '국어', child: Text('국어')),
                          FormBuilderFieldOption(value: '수학', child: Text('수학')),
                          FormBuilderFieldOption(value: '영어', child: Text('영어')),
                          FormBuilderFieldOption(value: '과학', child: Text('과학')),
                          FormBuilderFieldOption(value: '사회', child: Text('사회')),
                          FormBuilderFieldOption(value: '없음', child: Text('없음')),
                        ],
                        onChanged: (values) {
                          if (values == null) return;
                          final field = _formKey.currentState?.fields['interest_subjects'];
                          if (field == null) return;

                          final currentValues = List<String>.from(values);

                          // '없음'이 새로 선택된 경우 - 다른 과목 모두 해제
                          if (currentValues.contains('없음') && !_prevInterestSubjects.contains('없음')) {
                            _prevInterestSubjects = ['없음'];
                            field.didChange(['없음']);
                          }
                          // 다른 과목이 새로 선택된 경우 - '없음' 해제
                          else if (currentValues.contains('없음') && currentValues.length > 1) {
                            currentValues.remove('없음');
                            _prevInterestSubjects = currentValues;
                            field.didChange(currentValues);
                          }
                          else {
                            _prevInterestSubjects = currentValues;
                          }
                        },
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

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/consults');
    }
  }

  void _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;

        // 관심 과목 리스트를 콤마로 구분된 문자열로 변환
        final interestSubjects = values['interest_subjects'] as List<String>?;
        final interestSubjectStr = interestSubjects?.isNotEmpty == true
            ? interestSubjects!.join(',')
            : null;

        // 상담 일시 포맷팅 (ISO8601 형식)
        final consultDate = values['consult_date'] as DateTime?;
        final consultDateStr = consultDate != null
            ? consultDate.toIso8601String()
            : DateTime.now().toIso8601String();

        // 다음 상담 예정일 포맷팅 (ISO8601 형식)
        final nextConsultDate = values['next_consult_date'] as DateTime?;
        final nextConsultDateStr = nextConsultDate?.toIso8601String();

        // 상담 시간 파싱
        final durationStr = values['consult_duration'] as String?;
        final duration = durationStr != null && durationStr.isNotEmpty
            ? int.tryParse(durationStr)
            : null;

        final studentIdValue = int.parse(values['student_id'] as String);

        final consultData = ConsultCreate(
          studentId: studentIdValue,
          consultTypeCode: values['consult_type_code'] as String,
          consultDate: consultDateStr,
          consultDuration: duration,
          channelCode: values['channel_code'] as String?,
          content: values['content'] as String?,
          studentNeeds: values['student_needs'] as String?,
          consultResultCode: values['consult_result_code'] as String?,
          nextConsultDate: nextConsultDateStr,
          interestSubject: interestSubjectStr,
        );

        final repository = ConsultRepository();
        await repository.create(consultData);

        if (mounted) {
          // 학생 상담 내역 캐시 무효화 (학생 상세 페이지로 돌아갔을 때 새로고침됨)
          ref.invalidate(studentConsultListProvider(studentIdValue));
          // 상담 목록 새로고침 (상담 관리 화면으로 돌아갔을 때)
          ref.read(consultListProvider.notifier).refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('상담이 등록되었습니다')),
          );

          // 이전 페이지로 돌아가기
          _goBack();
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
