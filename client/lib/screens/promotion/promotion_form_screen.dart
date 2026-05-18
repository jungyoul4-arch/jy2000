import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../models/promotion.dart';
import '../../repositories/promotion_repository.dart';
import '../../providers/promotion_provider.dart';
import '../../providers/calendar_provider.dart';

class PromotionFormScreen extends ConsumerStatefulWidget {
  final DateTime? initialDate; // 달력에서 선택한 날짜 (고정)

  const PromotionFormScreen({super.key, this.initialDate});

  @override
  ConsumerState<PromotionFormScreen> createState() => _PromotionFormScreenState();
}

class _PromotionFormScreenState extends ConsumerState<PromotionFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _goBack(),
        ),
        title: const Text('설명회 등록'),
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
              // 기본 정보
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '기본 정보',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'promotion_name',
                        decoration: const InputDecoration(
                          labelText: '설명회명 *',
                          hintText: '예: 2024 여름방학 입시설명회',
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: '설명회명을 입력하세요',
                        ),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderDropdown<String>(
                        name: 'promotion_type_code',
                        decoration: const InputDecoration(
                          labelText: '설명회 유형 *',
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: '설명회 유형을 선택하세요',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'PROMO_ENTRANCE', child: Text('입시 설명회')),
                          DropdownMenuItem(value: 'PROMO_PARENT', child: Text('학부모 설명회')),
                          DropdownMenuItem(value: 'PROMO_ADMISSION', child: Text('입학 설명회')),
                          DropdownMenuItem(value: 'PROMO_CONSULT', child: Text('진학 상담회')),
                          DropdownMenuItem(value: 'PROMO_SPECIAL', child: Text('특강 안내')),
                          DropdownMenuItem(value: 'PROMO_OPEN', child: Text('오픈 클래스')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'description',
                        decoration: const InputDecoration(
                          labelText: '설명회 내용',
                          hintText: '설명회 상세 내용을 입력하세요',
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 일시 및 장소
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '일시 및 장소',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: widget.initialDate != null
                                ? Row(
                                    children: [
                                      // 고정된 날짜 표시
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: DateFormat('yyyy-MM-dd').format(widget.initialDate!),
                                          decoration: const InputDecoration(
                                            labelText: '설명회 날짜',
                                            prefixIcon: Icon(Icons.calendar_today),
                                          ),
                                          readOnly: true,
                                          enabled: false,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // 시간만 선택
                                      Expanded(
                                        child: FormBuilderDateTimePicker(
                                          name: 'start_date',
                                          inputType: InputType.time,
                                          initialValue: DateTime(
                                            widget.initialDate!.year,
                                            widget.initialDate!.month,
                                            widget.initialDate!.day,
                                            14, 0, // 기본 시간 14:00
                                          ),
                                          decoration: const InputDecoration(
                                            labelText: '설명회 시간 *',
                                            prefixIcon: Icon(Icons.access_time),
                                          ),
                                          validator: FormBuilderValidators.required(
                                            errorText: '시간을 선택하세요',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : FormBuilderDateTimePicker(
                                    name: 'start_date',
                                    inputType: InputType.both,
                                    initialValue: DateTime.now(),
                                    format: DateFormat('yyyy-MM-dd HH:mm'),
                                    decoration: const InputDecoration(
                                      labelText: '설명회 일시 *',
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    validator: FormBuilderValidators.required(
                                      errorText: '설명회 일시를 선택하세요',
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'target_subject',
                              decoration: const InputDecoration(
                                labelText: '장소',
                                hintText: '예: 본원 3층 대강당',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 대상 및 정원
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '대상 및 정원',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'target_grade',
                              decoration: const InputDecoration(
                                labelText: '대상 학년',
                                hintText: '예: 중3, 고1, 고2',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'discount_value',
                              decoration: const InputDecoration(
                                labelText: '참가 정원',
                                hintText: '예: 50',
                                suffixText: '명',
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
      context.go('/promotions');
    }
  }

  void _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;

        // 설명회 일시 포맷팅 (MySQL DATETIME 형식)
        DateTime? startDate = values['start_date'] as DateTime?;
        // initialDate가 있으면 날짜 부분을 고정하고 시간만 사용
        if (widget.initialDate != null && startDate != null) {
          startDate = DateTime(
            widget.initialDate!.year,
            widget.initialDate!.month,
            widget.initialDate!.day,
            startDate.hour,
            startDate.minute,
          );
        }
        final startDateStr = startDate != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate)
            : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

        // 참가 정원 파싱
        final capacityStr = values['discount_value'] as String?;
        final capacity = capacityStr != null && capacityStr.isNotEmpty
            ? double.tryParse(capacityStr)
            : null;

        final promotionData = PromotionCreate(
          promotionName: values['promotion_name'] as String,
          promotionTypeCode: values['promotion_type_code'] as String?,
          startDate: startDateStr,
          description: values['description'] as String?,
          targetGrade: values['target_grade'] as String?,
          targetSubject: values['target_subject'] as String?,
          discountValue: capacity,
        );

        final repository = PromotionRepository();
        await repository.create(promotionData);

        if (mounted) {
          ref.read(promotionListProvider.notifier).refresh();
          // 캘린더 데이터 새로고침 (달력 화면으로 돌아갔을 때)
          ref.refresh(monthlyEventsProvider);
          ref.refresh(dailyEventsProvider);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('설명회가 등록되었습니다')),
          );

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
