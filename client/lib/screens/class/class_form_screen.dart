import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/class_model.dart';
import '../../providers/class_provider.dart';
import '../../repositories/class_repository.dart';

// 과목 항목
const _genreItems = [
  (1, '국어', 'K'),
  (2, '수학', 'M'),
  (3, '영어', 'E'),
  (4, '과학', 'S'),
  (5, '사회', 'So'),
  (99, '기타', 'X'),
];

// 학년 항목
const _gradeItems = [
  (7, '중1'),
  (8, '중2'),
  (9, '중3'),
  (10, '고1'),
  (11, '고2'),
  (12, '고3'),
  (99, '기타'),
];

// 커리큘럼 항목
const _curriculumItems = [
  (1, '정시반', '정'),
  (2, '특별반', '특'),
];

// 레벨 항목
const _levelItems = [
  (1, '최상위반', 'A'),
  (2, '상위반', 'B'),
  (3, '중위반', 'C'),
  (4, '기초반', 'D'),
  (5, '모든레벨', 'E'),
  (99, '기타', 'X'),
];

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
  bool _isLoading = false;
  bool _isInitialized = false;

  // 기본 정보
  int? _genreId;
  int? _grade;
  int? _curriculum;
  int? _level;
  int? _year;
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
    _year = DateTime.now().year;

    if (isEditMode) {
      _loadClassData();
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
        _genreId = classDetail.genreId;
        _grade = classDetail.info.grade;
        _curriculum = classDetail.info.curriculum;
        _level = classDetail.info.level;
        _year = classDetail.info.year;
        _monthlyFeeController.text = classDetail.info.monthlyFee?.toString() ?? '';
        _classNameController.text = classDetail.className;

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

  String _generateClassName() {
    if (_genreId == null || _grade == null || _curriculum == null || _level == null || _year == null) {
      return '';
    }

    final genreCode = _genreItems.firstWhere((e) => e.$1 == _genreId).$3;

    String gradeStr;
    if (_grade! >= 7 && _grade! <= 9) {
      gradeStr = '중${_grade! - 6}';
    } else if (_grade! >= 10 && _grade! <= 12) {
      gradeStr = '고${_grade! - 9}';
    } else {
      gradeStr = '기타';
    }

    final curriculumStr = _curriculumItems.firstWhere((e) => e.$1 == _curriculum).$3;
    final levelStr = _levelItems.firstWhere((e) => e.$1 == _level).$3;
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
            genreId: _genreId,
            grade: _grade,
            curriculum: _curriculum,
            level: _level,
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
            genreId: _genreId!,
            grade: _grade!,
            curriculum: _curriculum!,
            level: _level!,
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
              // 기본 정보
              _buildSectionTitle('기본 정보'),
              _buildBasicInfoSection(),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 과목, 학년
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _genreId,
                    decoration: const InputDecoration(
                      labelText: '과목 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _genreItems.map((e) => DropdownMenuItem(
                      value: e.$1,
                      child: Text(e.$2),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _genreId = value);
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '과목을 선택하세요' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _grade,
                    decoration: const InputDecoration(
                      labelText: '학년 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _gradeItems.map((e) => DropdownMenuItem(
                      value: e.$1,
                      child: Text(e.$2),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _grade = value);
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '학년을 선택하세요' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 커리큘럼, 레벨
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _curriculum,
                    decoration: const InputDecoration(
                      labelText: '커리큘럼 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _curriculumItems.map((e) => DropdownMenuItem(
                      value: e.$1,
                      child: Text(e.$2),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _curriculum = value);
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '커리큘럼을 선택하세요' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _level,
                    decoration: const InputDecoration(
                      labelText: '레벨 *',
                      border: OutlineInputBorder(),
                    ),
                    items: _levelItems.map((e) => DropdownMenuItem(
                      value: e.$1,
                      child: Text(e.$2),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _level = value);
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '레벨을 선택하세요' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 년도
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _year,
                    decoration: const InputDecoration(
                      labelText: '년도 *',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DateTime.now().year,
                      DateTime.now().year + 1,
                    ].map((y) => DropdownMenuItem(
                      value: y,
                      child: Text('$y년'),
                    )).toList(),
                    onChanged: (value) {
                      setState(() => _year = value);
                      _updateClassName();
                    },
                    validator: (value) => value == null ? '년도를 선택하세요' : null,
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
                hintText: '예: 2026 K고1정AS동현(월7화8)',
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
