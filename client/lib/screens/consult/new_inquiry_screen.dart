import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/new_inquiry.dart';
import '../../models/school.dart';
import '../../providers/auth_provider.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/code_provider.dart';
import '../../providers/consult_provider.dart';
import '../../repositories/consult_repository.dart';
import '../../repositories/school_repository.dart';
import '../../widgets/logout_button.dart';

/// 신규생 문의 작성 화면
///
/// consult 테이블에 상담 유형 '신규생 문의'(CONSULT_TYPE_INITIAL)로 기록한다.
/// 기존 학생이 아니면 저장 시 User(kind=2, active_flag=0)와 학부모를 함께 만든다.
class NewInquiryScreen extends ConsumerStatefulWidget {
  const NewInquiryScreen({super.key});

  @override
  ConsumerState<NewInquiryScreen> createState() => _NewInquiryScreenState();
}

class _NewInquiryScreenState extends ConsumerState<NewInquiryScreen> {
  // 문의날짜 (기본: 오늘)
  DateTime _inquiryDate = DateTime.now();

  // 학생 (타입어헤드로 고르면 studentId가 채워지고 관련 필드가 자동 입력됨)
  final _studentNameController = TextEditingController();
  int? _selectedStudentId;
  List<InquiryStudentLookup> _studentResults = [];
  bool _isSearchingStudent = false;
  Timer? _studentDebounce;

  // 학교 (타입어헤드)
  final _schoolController = TextEditingController();
  int? _selectedSchoolId;
  List<School> _schoolResults = [];
  bool _isSearchingSchool = false;
  Timer? _schoolDebounce;

  int? _grade;
  String? _genderCode;
  String? _inquirySourceCode;

  // 문의 과목 비트마스크 (논술 포함)
  int _subjectMask = 0;

  // 현재 재원중 — 학생 선택 시 User.active_flag로 자동 결정
  bool _isEnrolled = false;

  final _guardianPhoneController = TextEditingController();
  final _studentPhoneController = TextEditingController();
  final _selectorController = TextEditingController();
  final _contentController = TextEditingController();

  // 선정자 입력 이력 — 최근에 저장한 값부터 앞에 온다.
  // 매번 이름을 다시 타이핑하지 않도록 ▼ 버튼으로 골라 넣는다.
  static const String _selectorHistoryKey = 'new_inquiry_selector_history';
  static const int _selectorHistoryMax = 10;
  List<String> _selectorHistory = [];

  // 타이핑 중 이력에서 걸러낸 후보 (▼ 버튼과 별개로 동작)
  List<String> _selectorSuggestions = [];

  // 메신저 복사 텍스트 (저장 후 생성, 직접 수정 가능)
  final _messengerController = TextEditingController();
  bool _hasMessengerText = false;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSelectorHistory();
  }

  @override
  void dispose() {
    _studentDebounce?.cancel();
    _schoolDebounce?.cancel();
    _studentNameController.dispose();
    _schoolController.dispose();
    _guardianPhoneController.dispose();
    _studentPhoneController.dispose();
    _selectorController.dispose();
    _contentController.dispose();
    _messengerController.dispose();
    super.dispose();
  }

  // ============================================================
  // 학생 타입어헤드
  // ============================================================

  void _onStudentNameChanged(String query) {
    _studentDebounce?.cancel();

    // 직접 입력하면 기존 학생 연결 해제 (목록에서 다시 골라야 연결됨)
    if (_selectedStudentId != null) {
      setState(() => _selectedStudentId = null);
    }

    if (query.trim().isEmpty) {
      setState(() {
        _studentResults = [];
        _isSearchingStudent = false;
      });
      return;
    }

    setState(() => _isSearchingStudent = true);

    _studentDebounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final results =
            await ConsultRepository().lookupInquiryStudents(query.trim());
        if (mounted) {
          setState(() {
            _studentResults = results;
            _isSearchingStudent = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => _isSearchingStudent = false);
      }
    });
  }

  /// 기존 학생 선택 — 해당 학생의 정보로 관련 필드를 자동 채운다
  void _selectStudent(InquiryStudentLookup student) {
    setState(() {
      _selectedStudentId = student.studentId;
      _studentNameController.text = student.studentName;
      _studentResults = [];

      _grade = student.grade;
      _genderCode = student.genderCode ?? _genderCode;
      _selectedSchoolId = student.schoolId;
      _schoolController.text = student.schoolName ?? '';
      _subjectMask = student.subjectCode ?? 0;

      // 구분(신입/재원)과 재원여부는 active_flag로 자동 결정
      _isEnrolled = student.isEnrolled;

      if (student.phone != null && student.phone!.isNotEmpty) {
        _studentPhoneController.text = student.phone!;
      }
      if (student.guardianPhone != null && student.guardianPhone!.isNotEmpty) {
        _guardianPhoneController.text = student.guardianPhone!;
      }
    });
  }

  // ============================================================
  // 학교 타입어헤드
  // ============================================================

  void _onSchoolChanged(String query) {
    _schoolDebounce?.cancel();

    if (_selectedSchoolId != null) {
      setState(() => _selectedSchoolId = null);
    }

    // 학교가 바뀌면 학년 옵션도 바뀌므로 범위를 벗어난 학년은 해제
    _resetGradeIfInvalid(query);

    if (query.trim().isEmpty) {
      setState(() {
        _schoolResults = [];
        _isSearchingSchool = false;
      });
      return;
    }

    setState(() => _isSearchingSchool = true);

    _schoolDebounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final results = await SchoolRepository().getList(search: query.trim());
        if (mounted) {
          setState(() {
            _schoolResults = results.take(20).toList();
            _isSearchingSchool = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => _isSearchingSchool = false);
      }
    });
  }

  void _selectSchool(School school) {
    setState(() {
      _selectedSchoolId = school.schoolId;
      _schoolController.text = school.schoolName;
      _schoolResults = [];
    });
    _resetGradeIfInvalid(school.schoolName);
  }

  /// 학교명으로 정해지는 학년 옵션에 현재 학년이 없으면 해제한다
  void _resetGradeIfInvalid(String schoolName) {
    if (_grade == null) return;
    final options = InquiryGrade.optionsFor(schoolName);
    if (!options.any((entry) => entry.$1 == _grade)) {
      setState(() => _grade = null);
    }
  }

  // ============================================================
  // 저장
  // ============================================================

  Future<void> _save() async {
    final studentName = _studentNameController.text.trim();
    if (studentName.isEmpty) {
      _showSnack('학생 이름을 입력하세요', isError: true);
      return;
    }

    // User.phone은 NOT NULL UNIQUE(로그인 ID)라 비워둘 수 없다
    final studentPhone = _studentPhoneController.text.trim();
    if (studentPhone.isEmpty) {
      _showSnack('학생 연락처를 입력하세요', isError: true);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final data = NewInquiryCreate(
        consultDate: DateFormat('yyyy-MM-dd').format(_inquiryDate),
        studentName: studentName,
        studentId: _selectedStudentId,
        genderCode: _genderCode,
        schoolId: _selectedSchoolId,
        // 학교 목록에 없는 학교는 이름만 넘긴다
        schoolName: _selectedSchoolId == null
            ? _emptyToNull(_schoolController.text)
            : null,
        grade: _grade,
        inquirySourceCode: _inquirySourceCode,
        subjectCode: _subjectMask > 0 ? _subjectMask : null,
        interestSubject: InquirySubject.labelOf(_subjectMask),
        studentPhone: studentPhone,
        guardianPhone: _emptyToNull(_guardianPhoneController.text),
        selectorName: _emptyToNull(_selectorController.text),
        content: _emptyToNull(_contentController.text),
      );

      final result = await ConsultRepository().createNewInquiry(data);

      if (!mounted) return;

      // 메신저 텍스트 생성 (학생 이름을 지우기 전에 만든다)
      final messengerText = _buildMessengerText(studentName);

      // 다음 문의부터 ▼로 골라 쓸 수 있도록 선정자 이름을 기억해 둔다
      unawaited(_rememberSelector(data.selectorName));

      // 목록/캘린더 새로고침
      ref.read(consultListProvider.notifier).refresh();
      ref.invalidate(studentConsultListProvider(result.studentId));
      ref.invalidate(monthlyEventsProvider);
      ref.invalidate(dailyEventsProvider);

      setState(() {
        _messengerController.text = messengerText;
        _hasMessengerText = true;

        // 다음 학생을 바로 입력할 수 있도록 이름/연락처만 비운다.
        // 문의날짜·문의경로·과목·접수자·선정자 등은 유지한다.
        _studentNameController.clear();
        _selectedStudentId = null;
        _studentResults = [];
        _guardianPhoneController.clear();
        _studentPhoneController.clear();
      });

      final extra = <String>[
        if (result.isNewStudent) '학생 신규 등록',
        if (result.guardianCreated) '학부모 등록',
      ];
      _showSnack(
        extra.isEmpty
            ? '신규생 문의가 등록되었습니다'
            : '신규생 문의가 등록되었습니다 (${extra.join(', ')})',
      );
    } catch (e) {
      if (mounted) _showSnack('저장 실패: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  /// 메신저 복사 텍스트
  ///
  /// ```
  /// [신규 문의] 8/18
  /// 이름: 홍길동
  /// 문의경로: -
  /// 과목: -
  /// 연락처: -
  ///
  /// 접수자: 김가영
  /// ```
  String _buildMessengerText(String studentName) {
    final sourceName = ref
        .read(inquirySourceCodesProvider)
        .where((code) => code.codeId == _inquirySourceCode)
        .map((code) => code.codeName)
        .firstOrNull;

    // 연락처는 학부모 우선, 없으면 학생
    final phone = _emptyToNull(_guardianPhoneController.text) ??
        _emptyToNull(_studentPhoneController.text);

    final receiver = ref.read(authProvider).user?.name ?? '';

    return [
      '[신규 문의] ${_inquiryDate.month}/${_inquiryDate.day}',
      '이름: $studentName',
      '문의경로: ${sourceName ?? '-'}',
      '과목: ${InquirySubject.labelOf(_subjectMask) ?? '-'}',
      '연락처: ${phone ?? '-'}',
      '',
      '접수자: $receiver',
    ].join('\n');
  }

  Future<void> _copyMessengerText() async {
    await Clipboard.setData(ClipboardData(text: _messengerController.text));
    if (mounted) _showSnack('메신저 텍스트가 복사되었습니다');
  }

  /// 화면을 처음 로드한 상태로 되돌린다
  void _reset() {
    setState(() {
      _inquiryDate = DateTime.now();
      _studentNameController.clear();
      _selectedStudentId = null;
      _studentResults = [];
      _schoolController.clear();
      _selectedSchoolId = null;
      _schoolResults = [];
      _grade = null;
      _genderCode = null;
      _inquirySourceCode = null;
      _subjectMask = 0;
      _isEnrolled = false;
      _guardianPhoneController.clear();
      _studentPhoneController.clear();
      _selectorController.clear();
      _selectorSuggestions = [];
      _contentController.clear();
      _messengerController.clear();
      _hasMessengerText = false;
    });
  }

  // ============================================================
  // 선정자 입력 이력
  // ============================================================

  Future<void> _loadSelectorHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_selectorHistoryKey) ?? [];
    if (mounted) setState(() => _selectorHistory = saved);
  }

  /// 저장에 성공한 선정자 이름을 맨 앞에 넣는다 (중복 제거, 최근 10건 유지)
  Future<void> _rememberSelector(String? name) async {
    final value = name?.trim();
    if (value == null || value.isEmpty) return;

    final updated = [
      value,
      ..._selectorHistory.where((e) => e != value),
    ].take(_selectorHistoryMax).toList();

    if (mounted) setState(() => _selectorHistory = updated);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_selectorHistoryKey, updated);
  }

  Future<void> _removeSelectorHistory(String name) async {
    final updated = _selectorHistory.where((e) => e != name).toList();
    if (mounted) {
      setState(() {
        _selectorHistory = updated;
        _selectorSuggestions =
            _selectorSuggestions.where((e) => e != name).toList();
      });
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_selectorHistoryKey, updated);
  }

  /// 입력한 글자가 들어간 이력을 후보로 내린다.
  /// 이미 똑같이 다 친 값은 고를 게 없으므로 제외한다.
  void _onSelectorChanged(String query) {
    final keyword = query.trim();

    setState(() {
      _selectorSuggestions = keyword.isEmpty
          ? []
          : _selectorHistory
              .where((name) => name.contains(keyword) && name != keyword)
              .toList();
    });
  }

  void _selectSelector(String name) {
    setState(() {
      _selectorController.text = name;
      _selectorController.selection =
          TextSelection.collapsed(offset: name.length);
      _selectorSuggestions = [];
    });
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  // ============================================================
  // 빌드
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('신규생 문의'),
        actions: const [
          SizedBox(width: 16),
          LogoutButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormCard(),
                if (_hasMessengerText) ...[
                  const SizedBox(height: 24),
                  _buildMessengerCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(Icons.edit, '신규생 문의 작성'),
            const Divider(height: 24),

            // 문의날짜 / 학생 이름 / 구분
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDateField()),
                const SizedBox(width: 16),
                Expanded(child: _buildStudentNameField()),
                const SizedBox(width: 16),
                Expanded(child: _buildStudentKindField()),
              ],
            ),
            const SizedBox(height: 16),

            // 학교 / 학년 / 성별
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSchoolField()),
                const SizedBox(width: 16),
                Expanded(child: _buildGradeField()),
                const SizedBox(width: 16),
                Expanded(child: _buildGenderField()),
              ],
            ),
            const SizedBox(height: 16),

            _buildInquirySourceField(),
            const SizedBox(height: 16),

            _buildSubjectField(),
            const SizedBox(height: 16),

            // 논술 / 재원여부
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildEssayField()),
                const SizedBox(width: 16),
                Expanded(child: _buildEnrolledField()),
              ],
            ),
            const SizedBox(height: 16),

            // 학부모 연락처 / 학생 연락처
            Row(
              children: [
                Expanded(
                  child: _labeled(
                    '학부모 연락처',
                    TextField(
                      controller: _guardianPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '010-0000-0000',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _labeled(
                    '학생 연락처',
                    TextField(
                      controller: _studentPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '010-0000-0000',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    required: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 접수자 / 선정자
            Row(
              children: [
                Expanded(child: _buildReceiverField()),
                const SizedBox(width: 16),
                Expanded(child: _buildSelectorField()),
              ],
            ),
            const SizedBox(height: 16),

            _labeled(
              '문의 내용 / 비고',
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: '상담 내용을 자유롭게 입력하세요...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: _isSaving ? null : _reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('초기화'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: const Text('저장 및 메신저 텍스트 생성'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return _labeled(
      '문의날짜',
      InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: _inquiryDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) setState(() => _inquiryDate = picked);
        },
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            suffixIcon: Icon(Icons.calendar_today, size: 18),
          ),
          child: Text(DateFormat('yyyy-MM-dd').format(_inquiryDate)),
        ),
      ),
      required: true,
    );
  }

  Widget _buildStudentNameField() {
    return _labeled(
      '학생 이름',
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _studentNameController,
            onChanged: _onStudentNameChanged,
            decoration: InputDecoration(
              hintText: '이름 입력 (기존 학생은 목록에서 선택)',
              border: const OutlineInputBorder(),
              isDense: true,
              filled: _selectedStudentId != null,
              fillColor: Colors.blue.shade50,
              suffixIcon: _isSearchingStudent
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : _selectedStudentId != null
                      ? const Icon(Icons.check_circle,
                          color: Colors.blue, size: 20)
                      : null,
            ),
          ),
          if (_studentResults.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _studentResults.length,
                itemBuilder: (context, index) {
                  final student = _studentResults[index];
                  final info = [
                    student.schoolName,
                    InquiryGrade.labelOf(student.grade),
                    student.phone,
                  ].where((s) => s != null && s.isNotEmpty).join(' · ');

                  return ListTile(
                    dense: true,
                    title: Text(student.studentName),
                    subtitle: Text(info.isEmpty ? '-' : info),
                    trailing: Text(
                      student.isEnrolled ? '재원' : '신입',
                      style: TextStyle(
                        fontSize: 12,
                        color: student.isEnrolled
                            ? Colors.blue
                            : Colors.grey.shade600,
                      ),
                    ),
                    onTap: () => _selectStudent(student),
                  );
                },
              ),
            ),
        ],
      ),
      required: true,
    );
  }

  /// 구분 — 학생 선택 시 User.active_flag로 자동 선택되며 재원여부와 같은 값이다.
  /// 화면 표시용이므로 별도 컬럼에 저장하지 않는다.
  Widget _buildStudentKindField() {
    return _labeled(
      '구분',
      DropdownButtonFormField<bool>(
        value: _isEnrolled,
        isExpanded: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
        items: const [
          DropdownMenuItem(value: false, child: Text('신입')),
          DropdownMenuItem(value: true, child: Text('재원')),
        ],
        onChanged: (value) => setState(() => _isEnrolled = value ?? false),
      ),
    );
  }

  Widget _buildSchoolField() {
    return _labeled(
      '학교',
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _schoolController,
            onChanged: _onSchoolChanged,
            decoration: InputDecoration(
              hintText: '○○고등학교',
              border: const OutlineInputBorder(),
              isDense: true,
              suffixIcon: _isSearchingSchool
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : _selectedSchoolId != null
                      ? const Icon(Icons.check_circle,
                          color: Colors.blue, size: 20)
                      : null,
            ),
          ),
          if (_schoolResults.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _schoolResults.length,
                itemBuilder: (context, index) {
                  final school = _schoolResults[index];
                  return ListTile(
                    dense: true,
                    title: Text(school.schoolName),
                    onTap: () => _selectSchool(school),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  /// 학년 — 학교명 끝 글자('고'/'중')에 따라 옵션이 달라진다
  Widget _buildGradeField() {
    final options = InquiryGrade.optionsFor(_schoolController.text);
    final validValue = options.any((entry) => entry.$1 == _grade) ? _grade : null;

    return _labeled(
      '학년',
      DropdownButtonFormField<int>(
        value: validValue,
        isExpanded: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          hintText: '선택',
        ),
        items: options
            .map((entry) => DropdownMenuItem(
                  value: entry.$1,
                  child: Text(entry.$2),
                ))
            .toList(),
        onChanged: (value) => setState(() => _grade = value),
      ),
    );
  }

  Widget _buildGenderField() {
    final genderCodes = ref.watch(genderCodesProvider);

    return _labeled(
      '성별',
      Wrap(
        spacing: 4,
        children: genderCodes
            .map((code) => _radio<String>(
                  label: code.codeName,
                  value: code.codeId,
                  groupValue: _genderCode,
                  onChanged: (value) => setState(() => _genderCode = value),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildInquirySourceField() {
    final sourceCodes = ref.watch(inquirySourceCodesProvider);

    return _labeled(
      '문의경로',
      sourceCodes.isEmpty
          ? Text(
              '문의경로 코드를 불러오는 중입니다...',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            )
          : Wrap(
              spacing: 8,
              children: sourceCodes
                  .map((code) => _radio<String>(
                        label: code.codeName,
                        value: code.codeId,
                        groupValue: _inquirySourceCode,
                        onChanged: (value) =>
                            setState(() => _inquirySourceCode = value),
                      ))
                  .toList(),
            ),
    );
  }

  Widget _buildSubjectField() {
    return _labeled(
      '문의 과목',
      Wrap(
        spacing: 8,
        children: InquirySubject.general
            .map((entry) => _subjectCheckbox(entry.$1, entry.$2))
            .toList(),
      ),
    );
  }

  Widget _buildEssayField() {
    return _labeled(
      '논술',
      Wrap(
        spacing: 8,
        children: InquirySubject.essay
            .map((entry) => _subjectCheckbox(entry.$1, entry.$2))
            .toList(),
      ),
    );
  }

  Widget _buildEnrolledField() {
    return _labeled(
      '재원여부',
      Row(
        children: [
          Checkbox(
            value: _isEnrolled,
            onChanged: (value) => setState(() => _isEnrolled = value ?? false),
          ),
          const Text('현재 재원중'),
        ],
      ),
    );
  }

  Widget _buildReceiverField() {
    final receiver = ref.watch(authProvider).user?.name ?? '';

    return _labeled(
      '접수자',
      InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
        child: Text(receiver.isEmpty ? '-' : receiver),
      ),
    );
  }

  /// 선정자 입력란
  ///
  /// 자유 입력이지만 실제로는 같은 이름이 반복되므로 저장에 성공한 이름을
  /// 기기에 쌓아 둔다. 고르는 방법은 두 가지다.
  ///   - 타입어헤드: 글자를 치면 그 글자가 든 이력이 아래에 뜬다
  ///   - ▼ 버튼    : 아무것도 치지 않아도 전체 이력을 펼친다
  Widget _buildSelectorField() {
    final hasHistory = _selectorHistory.isNotEmpty;

    return _labeled(
      '선정자',
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _selectorController,
            onChanged: _onSelectorChanged,
            decoration: InputDecoration(
              hintText: '예: 황규훈 부원장',
              border: const OutlineInputBorder(),
              isDense: true,
              suffixIcon: PopupMenuButton<String>(
                enabled: hasHistory,
                tooltip: hasHistory ? '이전 입력에서 선택' : '저장된 선정자가 없습니다',
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: hasHistory ? null : Theme.of(context).disabledColor,
                ),
                // ▼로 고를 때는 타이핑 후보 목록을 닫는다
                onSelected: _selectSelector,
                itemBuilder: (context) => _selectorHistory
                    .map(
                      (name) => PopupMenuItem<String>(
                        value: name,
                        child: Row(
                          children: [
                            Expanded(child: Text(name)),
                            // 잘못 저장된 이름을 지울 수 있게 한다
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              tooltip: '목록에서 삭제',
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                Navigator.pop(context);
                                _removeSelectorHistory(name);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (_selectorSuggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectorSuggestions.length,
                itemBuilder: (context, index) {
                  final name = _selectorSuggestions[index];
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.history, size: 18),
                    title: Text(name),
                    onTap: () => _selectSelector(name),
                  );
                },
              ),
            ),
        ],
      ),
      suffix: '(담당 부원장님)',
    );
  }

  Widget _buildMessengerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(Icons.copy, '메신저 복사 텍스트'),
            const Divider(height: 24),
            Stack(
              children: [
                TextField(
                  controller: _messengerController,
                  maxLines: 9,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.lightBlue.shade50,
                    contentPadding: const EdgeInsets.fromLTRB(12, 48, 12, 12),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: FilledButton.icon(
                    onPressed: _copyMessengerText,
                    icon: const Icon(Icons.content_paste, size: 16),
                    label: const Text('복사'),
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 공통 위젯
  // ============================================================

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  /// 라벨 + 필드. required면 라벨 뒤에 빨간 * 를 붙인다
  Widget _labeled(
    String label,
    Widget field, {
    bool required = false,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            if (required)
              const Text(' *', style: TextStyle(color: Colors.red, fontSize: 13)),
            if (suffix != null)
              Text(
                ' $suffix',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
          ],
        ),
        const SizedBox(height: 6),
        field,
      ],
    );
  }

  Widget _radio<T>({
    required String label,
    required T value,
    required T? groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            visualDensity: VisualDensity.compact,
          ),
          Text(label),
        ],
      ),
    );
  }

  Widget _subjectCheckbox(int bit, String label) {
    final checked = _subjectMask & bit > 0;

    return InkWell(
      onTap: () => setState(() => _subjectMask ^= bit),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: checked,
            onChanged: (_) => setState(() => _subjectMask ^= bit),
            visualDensity: VisualDensity.compact,
          ),
          Text(label),
        ],
      ),
    );
  }
}
