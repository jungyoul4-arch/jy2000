import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/class_model.dart';
import '../../models/class_type.dart';
import '../../providers/class_provider.dart';
import '../../providers/class_type_provider.dart';

// 년도 옵션 (올해, 다음해)
List<int> get _yearOptions {
  final currentYear = DateTime.now().year;
  return [currentYear, currentYear + 1];
}

// 중고 구분 옵션
const List<MapEntry<String, String>> _schoolLevelOptions = [
  MapEntry('middle', '중등부'),
  MapEntry('high', '고등부'),
];

// 과목 항목 (genreId와 동일)
const _subjectItems = [
  (1, '국어'),
  (2, '수학'),
  (3, '영어'),
  (4, '과학'),
  (5, '사회'),
];

// 형태 옵션
const List<MapEntry<int, String>> _formatOptions = [
  MapEntry(1, '일반'),
  MapEntry(2, '종합'),
  MapEntry(3, '논술'),
  MapEntry(4, '모의'),
  MapEntry(5, '특강'),
  MapEntry(6, '썸머'),
  MapEntry(7, '윈터'),
];

// 학년 옵션 (중고 구분에 따라)
List<MapEntry<int, String>> _getGradeOptionsForLevel(String level) {
  if (level == 'middle') {
    return [const MapEntry(9, '중3')];
  } else {
    return [
      const MapEntry(10, '고1'),
      const MapEntry(11, '고2'),
      const MapEntry(12, '고3'),
    ];
  }
}

// 학년 코드 -> 문자열 변환
String _gradeToString(int grade) {
  if (grade >= 7 && grade <= 9) return '중${grade - 6}';
  if (grade >= 10 && grade <= 12) return '고${grade - 9}';
  return '$grade';
}

// 요일 항목
const _dayItems = ['일', '월', '화', '수', '목', '금', '토'];

class ClassFormScreen extends ConsumerStatefulWidget {
  final int? classId; // null이면 신규 등록

  const ClassFormScreen({super.key, this.classId});

  @override
  ConsumerState<ClassFormScreen> createState() => _ClassFormScreenState();
}

class _ClassFormScreenState extends ConsumerState<ClassFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberFormat = NumberFormat('#,###');
  bool _isLoading = false;
  bool _isInitialized = false;

  // 기본 정보 (반 형태 추가와 동일한 방식)
  int? _year;
  String _schoolLevel = 'high'; // 중고 구분 (middle/high)
  int? _subject; // 과목 (genreId와 동일)
  int? _format; // 형태
  int? _grade; // 학년

  // 반 형태 관련
  int? _classTypeId;
  int? _unitPrice;
  String _generatedClassTypeName = '';
  bool _isSearchingClassType = false;

  // 기존 Class 모델 필드 (저장용)
  int? _curriculum; // 기본값 사용
  int? _level; // 기본값 사용

  final _monthlyFeeController = TextEditingController();
  final _classNameController = TextEditingController();

  // 강의 기간
  DateTime? _termStart;
  DateTime? _termEnd;

  // 강의 일시
  final Map<String, bool> _selectedDays = {
    '일': false,
    '월': false,
    '화': false,
    '수': false,
    '목': false,
    '금': false,
    '토': false,
  };
  final Map<String, int> _dayStartTimes = {};

  // 선생님
  List<UserSearchResult> _selectedTeachers = [];
  final _teacherSearchController = TextEditingController();
  List<UserSearchResult> _teacherSearchResults = [];
  bool _isSearchingTeachers = false;

  // 학생 (편집 모드에서만)
  List<UserSearchResult> _selectedStudents = [];
  final _studentSearchController = TextEditingController();
  List<UserSearchResult> _studentSearchResults = [];
  bool _isSearchingStudents = false;

  bool get isEditMode => widget.classId != null;

  @override
  void initState() {
    super.initState();
    _year = _yearOptions.first;
    _subject = 1; // 기본값: 국어
    _format = 1; // 기본값: 일반
    _grade = 10; // 기본값: 고1
    _curriculum = 1; // 기본값: 정시반
    _level = 5; // 기본값: 모든레벨

    if (isEditMode) {
      _loadClassData();
    } else {
      _updateClassTypeName();
    }
  }

  @override
  void dispose() {
    _monthlyFeeController.dispose();
    _classNameController.dispose();
    _teacherSearchController.dispose();
    _studentSearchController.dispose();
    super.dispose();
  }

  Future<void> _loadClassData() async {
    try {
      final repository = ref.read(classRepositoryProvider);
      final classDetail = await repository.getById(widget.classId!);

      setState(() {
        _subject = classDetail.genreId;
        _grade = classDetail.info.grade;
        _curriculum = classDetail.info.curriculum;
        _level = classDetail.info.level;
        _year = classDetail.info.year;
        _monthlyFeeController.text = classDetail.info.monthlyFee?.toString() ?? '';
        _classNameController.text = classDetail.className;

        // 중고 구분 추론
        _schoolLevel = (_grade != null && _grade! <= 9) ? 'middle' : 'high';

        // 강의 기간
        if (classDetail.info.termStart != null) {
          _termStart = DateTime.tryParse(classDetail.info.termStart!);
        }
        if (classDetail.info.termEnd != null) {
          _termEnd = DateTime.tryParse(classDetail.info.termEnd!);
        }

        // 강의 일시 파싱
        _parseLectureDates([
          classDetail.info.lectureDate1,
          classDetail.info.lectureDate2,
          classDetail.info.lectureDate3,
          classDetail.info.lectureDate4,
          classDetail.info.lectureDate5,
        ]);

        // 선생님
        _selectedTeachers = classDetail.teachers.map((t) => UserSearchResult(
          userId: t.userId,
          name: t.userName ?? '',
          phone: t.phone,
          kind: 3,
        )).toList();

        // 학생
        _selectedStudents = classDetail.students.map((s) => UserSearchResult(
          userId: s.userId,
          name: s.userName ?? '',
          phone: s.phone,
          kind: 2,
        )).toList();

        _isInitialized = true;
      });

      // 반 형태명 업데이트 및 매칭
      _updateClassTypeName();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('데이터 로드 실패: $e')),
        );
      }
    }
  }

  void _parseLectureDates(List<String?> dates) {
    for (final date in dates) {
      if (date == null || date.isEmpty) continue;
      // 예: "월7" -> 요일: 월, 시간: 7 (1~12는 오후로 해석하여 +12)
      if (date.length >= 2) {
        final day = date.substring(0, 1);
        var time = int.tryParse(date.substring(1));
        if (_dayItems.contains(day) && time != null) {
          // 기존 데이터(1~12)를 새 형식(10~23)으로 변환
          if (time >= 1 && time <= 9) {
            time = time + 12; // 오후로 해석 (예: 6 -> 18)
          } else if (time < 10 || time > 23) {
            continue; // 범위 밖이면 무시
          }
          _selectedDays[day] = true;
          _dayStartTimes[day] = time;
        }
      }
    }
  }

  // 반 형태명 생성 (class_type_list_screen과 동일한 규칙)
  String _generateClassTypeName() {
    if (_year == null || _subject == null || _format == null || _grade == null) {
      return '';
    }

    final levelStr = _schoolLevel == 'middle' ? '중등부' : '고등부';
    final subjectStr = _subjectItems.firstWhere((e) => e.$1 == _subject).$2;
    final formatStr = _formatOptions.firstWhere((e) => e.key == _format).value;
    final gradeStr = _gradeToString(_grade!);

    return '$_year $levelStr $subjectStr $formatStr ($gradeStr)';
  }

  // 반 이름 생성 (기존 방식 유지)
  String _generateClassName() {
    if (_subject == null || _grade == null || _year == null) {
      return '';
    }

    // 과목 코드
    const genreCodes = {1: 'K', 2: 'M', 3: 'E', 4: 'S', 5: 'So'};
    final genreCode = genreCodes[_subject] ?? 'X';

    // 학년 문자열
    final gradeStr = _gradeToString(_grade!);

    // 커리큘럼과 레벨 (기본값 사용)
    final curriculumStr = _curriculum == 1 ? '정' : '특';
    const levelCodes = {1: 'A', 2: 'B', 3: 'C', 4: 'D', 5: 'E'};
    final levelStr = levelCodes[_level] ?? 'X';

    final teamStr = _selectedTeachers.length > 1 ? 'T' : 'S';

    final teacherSuffix = _selectedTeachers.isNotEmpty
        ? _selectedTeachers.map((t) => t.name.length >= 2 ? t.name.substring(t.name.length - 2) : t.name).join('')
        : '';

    final lectureDateStr = _selectedDays.entries
        .where((e) => e.value && _dayStartTimes.containsKey(e.key))
        .map((e) {
          final time = _dayStartTimes[e.key]!;
          final displayTime = time > 12 ? time - 12 : time;
          return '${e.key}$displayTime';
        })
        .join('');

    return '$_year $genreCode$gradeStr$curriculumStr$levelStr$teamStr$teacherSuffix($lectureDateStr)';
  }

  void _updateClassTypeName() {
    final newName = _generateClassTypeName();
    setState(() {
      _generatedClassTypeName = newName;
      _classTypeId = null;
      _unitPrice = null;
    });

    // 자동 매칭 시도
    if (newName.isNotEmpty) {
      _tryMatchClassType(newName);
    }
  }

  Future<void> _tryMatchClassType(String classTypeName) async {
    if (classTypeName.isEmpty) return;

    setState(() => _isSearchingClassType = true);

    try {
      final repository = ref.read(classTypeRepositoryProvider);
      final classType = await repository.findByName(classTypeName);

      if (mounted) {
        setState(() {
          if (classType != null) {
            _classTypeId = classType.classTypeId;
            _unitPrice = classType.unitPrice;
          } else {
            _classTypeId = null;
            _unitPrice = null;
          }
          _isSearchingClassType = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSearchingClassType = false);
      }
    }
  }

  void _updateClassName() {
    if (!_isInitialized && isEditMode) return;
    setState(() {
      _classNameController.text = _generateClassName();
    });
  }

  Future<void> _searchTeachers(String query) async {
    if (query.isEmpty) {
      setState(() => _teacherSearchResults = []);
      return;
    }

    setState(() => _isSearchingTeachers = true);

    try {
      final repository = ref.read(classRepositoryProvider);
      final results = await repository.searchUsers(query, kind: 3);
      setState(() {
        _teacherSearchResults = results
            .where((r) => !_selectedTeachers.any((t) => t.userId == r.userId))
            .toList();
      });
    } catch (e) {
      // 에러 무시
    } finally {
      setState(() => _isSearchingTeachers = false);
    }
  }

  Future<void> _searchStudents(String query) async {
    if (query.isEmpty) {
      setState(() => _studentSearchResults = []);
      return;
    }

    setState(() => _isSearchingStudents = true);

    try {
      final repository = ref.read(classRepositoryProvider);
      final results = await repository.searchUsers(query, kind: 2);
      setState(() {
        _studentSearchResults = results
            .where((r) => !_selectedStudents.any((s) => s.userId == r.userId))
            .toList();
      });
    } catch (e) {
      // 에러 무시
    } finally {
      setState(() => _isSearchingStudents = false);
    }
  }

  List<LectureDate> _buildLectureDates() {
    return _selectedDays.entries
        .where((e) => e.value && _dayStartTimes.containsKey(e.key))
        .map((e) {
          final time = _dayStartTimes[e.key]!;
          final displayTime = time > 12 ? time - 12 : time;
          return LectureDate(
            day: e.key,
            startTime: displayTime,
          );
        })
        .toList();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedTeachers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('선생님을 최소 1명 이상 등록해주세요.')),
      );
      return;
    }

    final lectureDates = _buildLectureDates();
    if (lectureDates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('강의 일시를 최소 1개 이상 선택해주세요.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repository = ref.read(classRepositoryProvider);
      final monthlyFee = int.tryParse(_monthlyFeeController.text.replaceAll(',', ''));

      // 날짜 포맷 함수
      String? formatDate(DateTime? date) {
        if (date == null) return null;
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      if (isEditMode) {
        // 수정
        await repository.update(
          widget.classId!,
          ClassUpdate(
            genreId: _subject,
            grade: _grade,
            curriculum: _curriculum ?? 1,
            level: _level ?? 5,
            year: _year,
            termStart: formatDate(_termStart),
            termEnd: formatDate(_termEnd),
            lectureDates: lectureDates,
            teacherIds: _selectedTeachers.map((t) => t.userId).toList(),
            studentIds: _selectedStudents.map((s) => s.userId).toList(),
            monthlyFee: monthlyFee,
            className: _classNameController.text,
          ),
        );
      } else {
        // 신규 등록
        await repository.create(
          ClassCreate(
            genreId: _subject!,
            grade: _grade!,
            curriculum: _curriculum ?? 1,
            level: _level ?? 5,
            year: _year!,
            termStart: formatDate(_termStart),
            termEnd: formatDate(_termEnd),
            lectureDates: lectureDates,
            teacherIds: _selectedTeachers.map((t) => t.userId).toList(),
            monthlyFee: monthlyFee,
            className: _classNameController.text.isNotEmpty ? _classNameController.text : null,
          ),
        );
      }

      if (mounted) {
        ref.read(classListProvider.notifier).refresh();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEditMode ? '반이 수정되었습니다.' : '반이 등록되었습니다.')),
        );
        context.go('/classes');
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

  void _showClassTypeSearchDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => _ClassTypeSearchDialog(
        onSelect: (classType) {
          setState(() {
            _classTypeId = classType.classTypeId;
            _unitPrice = classType.unitPrice;
            _generatedClassTypeName = classType.classTypeName;

            // 선택한 반 형태의 정보로 업데이트
            _year = classType.year ?? _year;
            _grade = classType.grade;
            _subject = classType.subject;
            _format = classType.format;
            _schoolLevel = classType.grade <= 9 ? 'middle' : 'high';
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isEditMode && !_isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('반 편집')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
        title: Text(isEditMode ? '반 편집' : '반 등록'),
        actions: [
          FilledButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isEditMode ? '저장' : '등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 정보 (반 형태와 동일한 방식)
              _buildSectionTitle('기본 정보'),
              _buildBasicInfoSection(),
              const SizedBox(height: 24),

              // 반 형태 정보 (자동 생성된 반 형태명 + 수업 단가)
              _buildSectionTitle('반 형태'),
              _buildClassTypeSection(),
              const SizedBox(height: 24),

              // 강의 기간
              _buildSectionTitle('강의 기간'),
              _buildTermSection(),
              const SizedBox(height: 24),

              // 강의 일시
              _buildSectionTitle('강의 일시'),
              _buildScheduleSection(),
              const SizedBox(height: 24),

              // 선생님
              _buildSectionTitle('선생님'),
              _buildTeacherSection(),
              const SizedBox(height: 24),

              // 학생 (편집 모드에서만)
              if (isEditMode) ...[
                _buildSectionTitle('학생'),
                _buildStudentSection(),
                const SizedBox(height: 24),
              ],

              // 반 이름
              _buildSectionTitle('반 이름'),
              _buildClassNameSection(),
              const SizedBox(height: 24),

              // 수강료
              _buildSectionTitle('수강료'),
              _buildFeeSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    final availableGrades = _getGradeOptionsForLevel(_schoolLevel);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 년도, 중고 구분
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _year,
                    decoration: const InputDecoration(
                      labelText: '년도 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _yearOptions.map((y) => DropdownMenuItem(
                      value: y,
                      child: Text('$y년'),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _year = value);
                      _updateClassTypeName();
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '년도를 선택하세요' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _schoolLevel,
                    decoration: const InputDecoration(
                      labelText: '중고 구분 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _schoolLevelOptions.map((e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _schoolLevel = value;
                          // 중등부 선택시 학년을 중3으로 변경
                          if (_schoolLevel == 'middle') {
                            _grade = 9;
                          } else if (_grade == 9) {
                            // 고등부 선택시 중3이었으면 고1로 변경
                            _grade = 10;
                          }
                        });
                        _updateClassTypeName();
                        _updateClassName();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 과목, 형태
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _subject,
                    decoration: const InputDecoration(
                      labelText: '과목 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _subjectItems.map((e) => DropdownMenuItem(
                      value: e.$1,
                      child: Text(e.$2),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _subject = value);
                      _updateClassTypeName();
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '과목을 선택하세요' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _format,
                    decoration: const InputDecoration(
                      labelText: '형태 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _formatOptions.map((e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _format = value);
                      _updateClassTypeName();
                    },
                    validator: (value) => value == null ? '형태를 선택하세요' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 학년
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _grade,
                    decoration: const InputDecoration(
                      labelText: '학년 *',
                      border: OutlineInputBorder(),
                    ),
                    items: availableGrades.map((e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _grade = value);
                      _updateClassTypeName();
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '학년을 선택하세요' : null,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassTypeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 반 형태명 표시
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: '반 형태명',
                      border: const OutlineInputBorder(),
                      suffixIcon: _isSearchingClassType
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : _classTypeId != null
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : const Icon(Icons.warning, color: Colors.orange),
                    ),
                    child: Text(
                      _generatedClassTypeName.isNotEmpty ? _generatedClassTypeName : '기본 정보를 선택하세요',
                      style: TextStyle(
                        color: _generatedClassTypeName.isEmpty ? Colors.grey : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _showClassTypeSearchDialog,
                  icon: const Icon(Icons.search),
                  label: const Text('반 형태 검색'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 상태 메시지 및 수업 단가
            if (_classTypeId != null) ...[
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    '반 형태가 매칭되었습니다 (ID: $_classTypeId)',
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 수업 단가 표시
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      '수업 단가: ${_numberFormat.format(_unitPrice ?? 0)}원',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (_generatedClassTypeName.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '일치하는 반 형태가 없습니다. "반 형태 검색" 버튼으로 검색하세요.',
                      style: TextStyle(color: Colors.orange.shade700, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTermSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _termStart ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _termStart = picked);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: '시작일',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _termStart != null
                        ? '${_termStart!.year}-${_termStart!.month.toString().padLeft(2, '0')}-${_termStart!.day.toString().padLeft(2, '0')}'
                        : '선택',
                    style: TextStyle(
                      color: _termStart != null ? null : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _termEnd ?? _termStart ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _termEnd = picked);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: '종료일',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _termEnd != null
                        ? '${_termEnd!.year}-${_termEnd!.month.toString().padLeft(2, '0')}-${_termEnd!.day.toString().padLeft(2, '0')}'
                        : '선택',
                    style: TextStyle(
                      color: _termEnd != null ? null : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 요일 선택
            Wrap(
              spacing: 8,
              children: _dayItems.map((day) {
                final isSelected = _selectedDays[day] ?? false;
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedDays[day] = selected;
                      if (!selected) {
                        _dayStartTimes.remove(day);
                      }
                    });
                    _updateClassName();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // 선택된 요일별 시간 설정
            ..._selectedDays.entries.where((e) => e.value).map((entry) {
              final day = entry.key;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '$day요일',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 140,
                      child: DropdownButtonFormField<int>(
                        value: _dayStartTimes[day],
                        decoration: const InputDecoration(
                          labelText: '시작 시간',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        items: List.generate(14, (i) => i + 10).map((h) => DropdownMenuItem(
                          value: h,
                          child: Text(h < 12 ? '오전 $h시' : h == 12 ? '12시' : '오후 ${h - 12}시'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() => _dayStartTimes[day] = value!);
                          _updateClassName();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (_selectedDays.values.where((v) => v).isEmpty)
              const Text(
                '요일을 선택하세요',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 선생님 검색
            TextField(
              controller: _teacherSearchController,
              decoration: InputDecoration(
                hintText: '선생님 이름 또는 전화번호로 검색',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearchingTeachers
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
              onChanged: _searchTeachers,
            ),
            // 검색 결과
            if (_teacherSearchResults.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _teacherSearchResults.length,
                  itemBuilder: (context, index) {
                    final teacher = _teacherSearchResults[index];
                    return ListTile(
                      title: Text(teacher.name),
                      subtitle: Text(teacher.phone ?? ''),
                      trailing: FilledButton.icon(
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('추가'),
                        onPressed: () {
                          setState(() {
                            _selectedTeachers.add(teacher);
                            _teacherSearchResults.remove(teacher);
                            _teacherSearchController.clear();
                          });
                          _updateClassName();
                        },
                      ),
                      dense: true,
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            // 선택된 선생님들
            if (_selectedTeachers.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedTeachers.map((teacher) {
                  return Chip(
                    avatar: CircleAvatar(
                      child: Text(teacher.name.isNotEmpty ? teacher.name[0] : '?'),
                    ),
                    label: Text(teacher.name),
                    onDeleted: () {
                      setState(() => _selectedTeachers.remove(teacher));
                      _updateClassName();
                    },
                  );
                }).toList(),
              )
            else
              const Text(
                '선생님을 검색하여 추가하세요',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 학생 검색
            TextField(
              controller: _studentSearchController,
              decoration: InputDecoration(
                hintText: '학생 이름 또는 전화번호로 검색',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearchingStudents
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
              onChanged: _searchStudents,
            ),
            // 검색 결과
            if (_studentSearchResults.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _studentSearchResults.length,
                  itemBuilder: (context, index) {
                    final student = _studentSearchResults[index];
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text(student.phone ?? ''),
                      trailing: FilledButton.icon(
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('추가'),
                        onPressed: () {
                          setState(() {
                            _selectedStudents.add(student);
                            _studentSearchResults.remove(student);
                            _studentSearchController.clear();
                          });
                        },
                      ),
                      dense: true,
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            // 선택된 학생들
            if (_selectedStudents.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedStudents.map((student) {
                  return Chip(
                    avatar: CircleAvatar(
                      child: Text(student.name.isNotEmpty ? student.name[0] : '?'),
                    ),
                    label: Text(student.name),
                    onDeleted: () {
                      setState(() => _selectedStudents.remove(student));
                    },
                  );
                }).toList(),
              )
            else
              const Text(
                '학생을 검색하여 추가하세요 (선택 사항)',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassNameSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '반 이름은 선택 항목에 따라 자동 생성됩니다. 필요시 수정할 수 있습니다.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _classNameController,
              decoration: const InputDecoration(
                labelText: '반 이름',
                border: OutlineInputBorder(),
                hintText: '예: 2026 K고1정ES동현(월7화8)',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _monthlyFeeController,
                decoration: const InputDecoration(
                  labelText: '수강료',
                  border: OutlineInputBorder(),
                  suffixText: '원',
                  hintText: '예: 300000',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

// 반 형태 검색 다이얼로그
class _ClassTypeSearchDialog extends ConsumerStatefulWidget {
  final void Function(ClassType) onSelect;

  const _ClassTypeSearchDialog({required this.onSelect});

  @override
  ConsumerState<_ClassTypeSearchDialog> createState() => _ClassTypeSearchDialogState();
}

class _ClassTypeSearchDialogState extends ConsumerState<_ClassTypeSearchDialog> {
  final _searchController = TextEditingController();
  List<ClassType> _allClassTypes = []; // 전체 목록 유지
  List<ClassType> _searchResults = [];
  bool _isLoading = false;
  final _numberFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _loadAllClassTypes();
  }

  Future<void> _loadAllClassTypes() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(classTypeRepositoryProvider);
      final results = await repository.getList();
      setState(() {
        _allClassTypes = results;
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterResults(String query) {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = _allClassTypes);
      return;
    }

    // 공백으로 분리하여 각 단어가 모두 포함된 항목만 표시 (AND 조건)
    final keywords = query.toLowerCase().split(' ').where((k) => k.isNotEmpty).toList();

    setState(() {
      _searchResults = _allClassTypes.where((ct) {
        // 검색 대상 텍스트 결합
        final searchText = '${ct.classTypeName} ${ct.gradeString} ${ct.subjectString}'.toLowerCase();
        // 모든 키워드가 포함되어야 함
        return keywords.every((keyword) => searchText.contains(keyword));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('반 형태 검색'),
      content: SizedBox(
        width: 500,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '검색어 (예: 고등부 국어 → 모두 포함된 결과)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterResults,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? const Center(child: Text('검색 결과가 없습니다'))
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final ct = _searchResults[index];
                            return ListTile(
                              title: Text(ct.classTypeName),
                              subtitle: Text(
                                '${ct.gradeString} | ${ct.subjectString} | ${_numberFormat.format(ct.unitPrice)}원',
                              ),
                              trailing: FilledButton(
                                onPressed: () {
                                  widget.onSelect(ct);
                                  Navigator.pop(context);
                                },
                                child: const Text('선택'),
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
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ],
    );
  }
}
