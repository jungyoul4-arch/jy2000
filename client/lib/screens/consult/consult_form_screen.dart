import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/consult.dart';
import '../../models/class_model.dart';
import '../../repositories/consult_repository.dart';
import '../../repositories/class_repository.dart';
import '../../providers/auth_provider.dart';
import '../../providers/code_provider.dart';
import '../../providers/consult_provider.dart';
import '../../providers/calendar_provider.dart';
import '../../widgets/consult_time_fields.dart';
import '../../widgets/logout_button.dart';
import '../../widgets/tc_picker_field.dart';

class ConsultFormScreen extends ConsumerStatefulWidget {
  final int? studentId;
  final DateTime? initialDate; // 달력에서 선택한 날짜 (고정)

  const ConsultFormScreen({super.key, this.studentId, this.initialDate});

  @override
  ConsumerState<ConsultFormScreen> createState() => _ConsultFormScreenState();
}

class _ConsultFormScreenState extends ConsumerState<ConsultFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _studentSearchController = TextEditingController();
  bool _isLoading = false;
  List<String> _prevInterestSubjects = [];

  // 학생 검색 관련
  Timer? _debounce;
  List<UserSearchResult> _studentSearchResults = [];
  bool _isSearching = false;
  UserSearchResult? _selectedStudent;
  String? _initialStudentName;

  // 상담자 (기본값: 로그인한 사용자)
  int? _selectedTcId;
  String? _selectedTcName;

  @override
  void initState() {
    super.initState();
    // 상담자 기본값: 로그인한 사용자
    final user = ref.read(authProvider).user;
    _selectedTcId = user?.userId;
    _selectedTcName = user?.name;

    // studentId가 전달된 경우 학생 정보 로드
    if (widget.studentId != null) {
      _loadInitialStudent();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _studentSearchController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialStudent() async {
    try {
      // 학생 ID를 문자열로 검색
      final repository = ClassRepository();
      final results = await repository.searchUsers('${widget.studentId}', kind: 2);
      final student = results.where((s) => s.userId == widget.studentId).firstOrNull;
      if (student != null && mounted) {
        setState(() {
          _selectedStudent = student;
          _studentSearchController.text = '${student.name} (${student.phone ?? ''})';
        });
      } else if (mounted) {
        // 검색 결과에 없으면 ID만으로 임시 객체 생성
        setState(() {
          _selectedStudent = UserSearchResult(
            userId: widget.studentId!,
            name: '학생 ID: ${widget.studentId}',
            kind: 2,
          );
          _studentSearchController.text = '학생 ID: ${widget.studentId}';
        });
      }
    } catch (e) {
      // 실패해도 ID로 임시 객체 생성
      if (mounted) {
        setState(() {
          _selectedStudent = UserSearchResult(
            userId: widget.studentId!,
            name: '학생 ID: ${widget.studentId}',
            kind: 2,
          );
          _studentSearchController.text = '학생 ID: ${widget.studentId}';
        });
      }
    }
  }

  void _onStudentSearch(String query) {
    _debounce?.cancel();
    if (query.isEmpty) {
      setState(() {
        _studentSearchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repository = ClassRepository();
        final results = await repository.searchUsers(query, kind: 2); // kind=2: 학생
        if (mounted) {
          setState(() {
            _studentSearchResults = results;
            _isSearching = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isSearching = false);
        }
      }
    });
  }

  void _selectStudent(UserSearchResult student) {
    setState(() {
      _selectedStudent = student;
      _studentSearchController.text = '${student.name} (${student.phone ?? ''})';
      _studentSearchResults = [];
    });
  }

  void _clearStudent() {
    setState(() {
      _selectedStudent = null;
      _studentSearchController.clear();
      _studentSearchResults = [];
    });
  }

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
          const LogoutButton(),
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
                      // 학생 검색 필드
                      TextField(
                        controller: _studentSearchController,
                        decoration: InputDecoration(
                          labelText: '학생 검색 *',
                          hintText: '이름 또는 전화번호로 검색',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _selectedStudent != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _clearStudent,
                                )
                              : _isSearching
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    )
                                  : null,
                          errorText: _selectedStudent == null && _studentSearchController.text.isEmpty
                              ? null
                              : null,
                        ),
                        readOnly: _selectedStudent != null,
                        onChanged: _selectedStudent == null ? _onStudentSearch : null,
                      ),
                      // 검색 결과 목록
                      if (_studentSearchResults.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          constraints: const BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _studentSearchResults.length,
                            itemBuilder: (context, index) {
                              final student = _studentSearchResults[index];
                              return ListTile(
                                dense: true,
                                title: Text(student.name),
                                subtitle: Text(student.phone ?? '-'),
                                trailing: Text('ID: ${student.userId}'),
                                onTap: () => _selectStudent(student),
                              );
                            },
                          ),
                        ),
                      // 선택된 학생 정보 표시
                      if (_selectedStudent != null)
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blue),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedStudent!.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${_selectedStudent!.phone ?? '-'} | ID: ${_selectedStudent!.userId}',
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          const SizedBox(width: 16),
                          // 상담자 (기본: 로그인 사용자, 클릭하여 변경)
                          Expanded(
                            child: TcPickerField(
                              tcId: _selectedTcId,
                              tcName: _selectedTcName,
                              onChanged: (staff) {
                                setState(() {
                                  _selectedTcId = staff.userId;
                                  _selectedTcName = staff.name;
                                });
                              },
                            ),
                          ),
                        ],
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
                                          initialValue: '${widget.initialDate!.year}-${widget.initialDate!.month.toString().padLeft(2, '0')}-${widget.initialDate!.day.toString().padLeft(2, '0')}',
                                          decoration: const InputDecoration(
                                            labelText: '상담 날짜',
                                            prefixIcon: Icon(Icons.calendar_today),
                                          ),
                                          readOnly: true,
                                          enabled: false,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // 시간 선택 (10~21시, 10분 단위)
                                      Expanded(
                                        flex: 2,
                                        child: ConsultTimeFields(
                                          initialValue: DateTime(
                                            widget.initialDate!.year,
                                            widget.initialDate!.month,
                                            widget.initialDate!.day,
                                            DateTime.now().hour,
                                            DateTime.now().minute,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      // 날짜 선택
                                      Expanded(
                                        child: FormBuilderDateTimePicker(
                                          name: 'consult_date',
                                          inputType: InputType.date,
                                          initialValue: DateTime.now(),
                                          decoration: const InputDecoration(
                                            labelText: '상담 날짜 *',
                                            prefixIcon: Icon(Icons.calendar_today),
                                          ),
                                          validator: FormBuilderValidators.required(
                                            errorText: '상담 날짜를 선택하세요',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // 시간 선택 (10~21시, 10분 단위)
                                      Expanded(
                                        flex: 2,
                                        child: ConsultTimeFields(
                                          initialValue: DateTime.now(),
                                        ),
                                      ),
                                    ],
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
    // 학생이 선택되지 않은 경우 에러
    if (_selectedStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('학생을 선택하세요')),
      );
      return;
    }

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final values = _formKey.currentState!.value;

        // 관심 과목 리스트를 콤마로 구분된 문자열로 변환
        final interestSubjects = values['interest_subjects'] as List<String>?;
        final interestSubjectStr = interestSubjects?.isNotEmpty == true
            ? interestSubjects!.join(',')
            : null;

        // 상담 일시 = 날짜 + 시/분 드롭다운 (10~21시, 10분 단위)
        final datePart = widget.initialDate ??
            (values['consult_date'] as DateTime?) ??
            DateTime.now();
        final hourPart = values['consult_hour'] as int? ?? defaultConsultHour;
        final minutePart = values['consult_minute'] as int? ?? 0;

        final consultDateStr = DateTime(
          datePart.year,
          datePart.month,
          datePart.day,
          hourPart,
          minutePart,
        ).toIso8601String();

        // 다음 상담 예정일 포맷팅 (ISO8601 형식)
        final nextConsultDate = values['next_consult_date'] as DateTime?;
        final nextConsultDateStr = nextConsultDate?.toIso8601String();

        // 상담 시간 파싱
        final durationStr = values['consult_duration'] as String?;
        final duration = durationStr != null && durationStr.isNotEmpty
            ? int.tryParse(durationStr)
            : null;

        final studentIdValue = _selectedStudent!.userId;

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
          tcId: _selectedTcId,
        );

        final repository = ConsultRepository();
        await repository.create(consultData);

        if (mounted) {
          // 학생 상담 내역 캐시 무효화 (학생 상세 페이지로 돌아갔을 때 새로고침됨)
          ref.invalidate(studentConsultListProvider(studentIdValue));
          // 상담 목록 새로고침 (상담 관리 화면으로 돌아갔을 때)
          ref.read(consultListProvider.notifier).refresh();
          // 캘린더 데이터 새로고침 (달력 화면으로 돌아갔을 때)
          ref.refresh(monthlyEventsProvider);
          ref.refresh(dailyEventsProvider);

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
