import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/consult.dart';
import '../../repositories/consult_repository.dart';
import '../../providers/code_provider.dart';
import '../../providers/consult_provider.dart';
import '../../widgets/logout_button.dart';

// 상담 상세 Provider
final consultDetailProvider =
    FutureProvider.family<Consult, int>((ref, consultId) async {
  final repository = ref.read(consultRepositoryProvider);
  return repository.getById(consultId);
});

class ConsultDetailScreen extends ConsumerStatefulWidget {
  final int consultId;

  const ConsultDetailScreen({super.key, required this.consultId});

  @override
  ConsumerState<ConsultDetailScreen> createState() =>
      _ConsultDetailScreenState();
}

class _ConsultDetailScreenState extends ConsumerState<ConsultDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isEditing = false;
  bool _isLoading = false;
  List<String> _prevInterestSubjects = [];

  @override
  Widget build(BuildContext context) {
    final consultAsync = ref.watch(consultDetailProvider(widget.consultId));
    final consultTypeCodes = ref.watch(consultTypeCodesProvider);
    final channelCodes = ref.watch(channelCodesProvider);
    final consultResultCodes = ref.watch(consultResultCodesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBack(),
        ),
        title: const Text('상담 상세'),
        actions: [
          if (!_isEditing)
            TextButton.icon(
              onPressed: () {
                // 편집 모드 진입 시 관심 과목 이전 상태 초기화
                final consult = ref.read(consultDetailProvider(widget.consultId)).value;
                if (consult != null) {
                  _prevInterestSubjects = consult.interestSubject?.split(',') ?? [];
                }
                setState(() => _isEditing = true);
              },
              icon: const Icon(Icons.edit),
              label: const Text('편집'),
            )
          else ...[
            TextButton(
              onPressed: () {
                _prevInterestSubjects = [];
                setState(() => _isEditing = false);
                ref.invalidate(consultDetailProvider(widget.consultId));
              },
              child: const Text('취소'),
            ),
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
          const SizedBox(width: 16),
          const LogoutButton(),
        ],
      ),
      body: consultAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (consult) => SingleChildScrollView(
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                            '학생', '${consult.studentName} (${consult.studentId})'),
                        _buildInfoRow('전화번호', consult.studentPhone ?? '-'),
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderDropdown<String>(
                                      name: 'consult_type_code',
                                      initialValue: consult.consultTypeCode,
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
                                    )
                                  : _buildInfoRow(
                                      '상담 유형', consult.consultTypeName ?? '-'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderDropdown<String>(
                                      name: 'channel_code',
                                      initialValue: consult.channelCode,
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
                                    )
                                  : _buildInfoRow(
                                      '상담 채널', consult.channelName ?? '-'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderDateTimePicker(
                                      name: 'consult_date',
                                      inputType: InputType.both,
                                      initialValue:
                                          DateTime.tryParse(consult.consultDate),
                                      decoration: const InputDecoration(
                                        labelText: '상담 일시 *',
                                      ),
                                      validator: FormBuilderValidators.required(
                                        errorText: '상담 일시를 선택하세요',
                                      ),
                                    )
                                  : _buildInfoRow(
                                      '상담 일시', _formatDateTime(consult.consultDate)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderTextField(
                                      name: 'consult_duration',
                                      initialValue:
                                          consult.consultDuration?.toString(),
                                      decoration: const InputDecoration(
                                        labelText: '상담 시간 (분)',
                                      ),
                                      keyboardType: TextInputType.number,
                                    )
                                  : _buildInfoRow('상담 시간',
                                      '${consult.consultDuration ?? '-'}분'),
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        _isEditing
                            ? FormBuilderTextField(
                                name: 'content',
                                initialValue: consult.content,
                                decoration: const InputDecoration(
                                  labelText: '상담 내용',
                                  hintText: '상담 내용을 입력하세요',
                                ),
                                maxLines: 4,
                              )
                            : _buildInfoRow('상담 내용', consult.content ?? '-'),
                        const SizedBox(height: 16),
                        _isEditing
                            ? FormBuilderTextField(
                                name: 'student_needs',
                                initialValue: consult.studentNeeds,
                                decoration: const InputDecoration(
                                  labelText: '학생 니즈/요구사항',
                                ),
                                maxLines: 2,
                              )
                            : _buildInfoRow(
                                '학생 니즈/요구사항', consult.studentNeeds ?? '-'),
                        const SizedBox(height: 16),
                        _isEditing
                            ? FormBuilderCheckboxGroup<String>(
                                name: 'interest_subjects',
                                initialValue:
                                    consult.interestSubject?.split(',') ?? [],
                                decoration: const InputDecoration(
                                  labelText: '관심 과목',
                                  border: InputBorder.none,
                                ),
                                wrapDirection: Axis.horizontal,
                                wrapSpacing: 16,
                                wrapRunSpacing: 0,
                                options: const [
                                  FormBuilderFieldOption(
                                      value: '국어', child: Text('국어')),
                                  FormBuilderFieldOption(
                                      value: '수학', child: Text('수학')),
                                  FormBuilderFieldOption(
                                      value: '영어', child: Text('영어')),
                                  FormBuilderFieldOption(
                                      value: '과학', child: Text('과학')),
                                  FormBuilderFieldOption(
                                      value: '사회', child: Text('사회')),
                                  FormBuilderFieldOption(
                                      value: '없음', child: Text('없음')),
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
                              )
                            : _buildInfoRow(
                                '관심 과목', consult.interestSubject ?? '-'),
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderDropdown<String>(
                                      name: 'consult_result_code',
                                      initialValue: consult.consultResultCode,
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
                                    )
                                  : _buildInfoRow(
                                      '상담 결과', consult.consultResultName ?? '-'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _isEditing
                                  ? FormBuilderDateTimePicker(
                                      name: 'next_consult_date',
                                      inputType: InputType.both,
                                      initialValue: consult.nextConsultDate != null
                                          ? DateTime.tryParse(
                                              consult.nextConsultDate!)
                                          : null,
                                      decoration: const InputDecoration(
                                        labelText: '다음 상담 예정일',
                                      ),
                                    )
                                  : _buildInfoRow(
                                      '다음 상담 예정일',
                                      consult.nextConsultDate != null
                                          ? _formatDateTime(
                                              consult.nextConsultDate!)
                                          : '-'),
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
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/consults');
    }
  }

  void _onSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;
        final consultAsync =
            ref.read(consultDetailProvider(widget.consultId)).value;

        // 관심 과목 리스트를 콤마로 구분된 문자열로 변환
        final interestSubjects = values['interest_subjects'] as List<String>?;
        final interestSubjectStr = interestSubjects?.isNotEmpty == true
            ? interestSubjects!.join(',')
            : null;

        // 상담 일시 포맷팅 (ISO8601 형식)
        final consultDate = values['consult_date'] as DateTime?;
        final consultDateStr = consultDate?.toIso8601String();

        // 다음 상담 예정일 포맷팅 (ISO8601 형식)
        final nextConsultDate = values['next_consult_date'] as DateTime?;
        final nextConsultDateStr = nextConsultDate?.toIso8601String();

        // 상담 시간 파싱
        final durationStr = values['consult_duration'] as String?;
        final duration = durationStr != null && durationStr.isNotEmpty
            ? int.tryParse(durationStr)
            : null;

        final updateData = ConsultUpdate(
          consultTypeCode: values['consult_type_code'] as String?,
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
        await repository.update(widget.consultId, updateData);

        if (mounted) {
          // 캐시 무효화
          ref.invalidate(consultDetailProvider(widget.consultId));
          if (consultAsync != null) {
            ref.invalidate(studentConsultListProvider(consultAsync.studentId));
          }
          // StateNotifierProvider는 invalidate 대신 refresh 호출
          ref.read(consultListProvider.notifier).refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('상담이 수정되었습니다')),
          );
          setState(() => _isEditing = false);
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
