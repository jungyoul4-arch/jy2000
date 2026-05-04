import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/school.dart';
import '../../models/student.dart';
import '../../providers/code_provider.dart';
import '../../providers/school_provider.dart';
import '../../providers/student_provider.dart';

// 학년 정보 클래스
class GradeItem {
  final int value;
  final String displayName;

  const GradeItem(this.value, this.displayName);
}

class StudentFormScreen extends ConsumerStatefulWidget {
  final int? studentId; // null이면 신규 등록

  const StudentFormScreen({super.key, this.studentId});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _schoolController = TextEditingController();
  bool _isLoading = false;
  School? _selectedSchool;

  bool get isEdit => widget.studentId != null;

  @override
  void initState() {
    super.initState();
    // 학교 목록 로드
    Future.microtask(() {
      ref.read(schoolListProvider.notifier).loadSchools();
    });
  }

  @override
  void dispose() {
    _schoolController.dispose();
    super.dispose();
  }

  // 학교 종류에 따라 학년 목록 생성
  // grade 값: 1-6:초, 7-9:중, 10-12:고, 13:N수생, 14:성인
  List<GradeItem> _getGradeItems() {
    final schoolName = _schoolController.text;
    final schoolKind = _selectedSchool?.schoolKind;

    // 학교가 선택/입력되지 않은 경우 전체 표시
    if (schoolName.isEmpty) {
      return const [
        GradeItem(7, '중1'), GradeItem(8, '중2'), GradeItem(9, '중3'),
        GradeItem(10, '고1'), GradeItem(11, '고2'), GradeItem(12, '고3'),
        GradeItem(13, 'N수생'), GradeItem(14, '성인'),
      ];
    }

    // 중학교인 경우 (schoolKind=1 또는 학교명이 '중'으로 끝남)
    final isMiddleSchool = schoolKind == 1 || schoolName.endsWith('중');
    // 고등학교인 경우 (schoolKind=2 또는 학교명이 '고'로 끝남)
    final isHighSchool = schoolKind == 2 || schoolName.endsWith('고');

    if (isMiddleSchool) {
      return const [
        GradeItem(7, '1학년'),
        GradeItem(8, '2학년'),
        GradeItem(9, '3학년'),
        GradeItem(14, '성인'),
      ];
    } else if (isHighSchool) {
      return const [
        GradeItem(10, '1학년'),
        GradeItem(11, '2학년'),
        GradeItem(12, '3학년'),
        GradeItem(13, 'N수생'),
        GradeItem(14, '성인'),
      ];
    }

    // 기본값
    return const [
      GradeItem(7, '중1'), GradeItem(8, '중2'), GradeItem(9, '중3'),
      GradeItem(10, '고1'), GradeItem(11, '고2'), GradeItem(12, '고3'),
      GradeItem(13, 'N수생'), GradeItem(14, '성인'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final gradeItems = _getGradeItems();
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
                        child: _buildSchoolAutocomplete(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'birth_year',
                          decoration: const InputDecoration(
                            labelText: '생년',
                          ),
                          items: List.generate(20, (index) {
                            final year = DateTime.now().year - 10 - index;
                            return DropdownMenuItem(
                              value: year,
                              child: Text('$year년'),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'grade',
                          decoration: const InputDecoration(
                            labelText: '학년',
                          ),
                          items: gradeItems
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.value,
                                  child: Text(item.displayName),
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

              // 보호자 정보
              _buildSection(
                title: '보호자 정보',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'guardian_phone',
                          decoration: const InputDecoration(
                            labelText: '보호자 연락처',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 120,
                        child: FormBuilderDropdown<int>(
                          name: 'parent_kind',
                          decoration: const InputDecoration(
                            labelText: '관계',
                          ),
                          initialValue: 2,
                          items: const [
                            DropdownMenuItem(value: 1, child: Text('부')),
                            DropdownMenuItem(value: 2, child: Text('모')),
                            DropdownMenuItem(value: 3, child: Text('친척')),
                            DropdownMenuItem(value: 99, child: Text('기타')),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(child: SizedBox()),
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
        // 컨트롤러 동기화
        if (_schoolController.text != controller.text && _schoolController.text.isNotEmpty) {
          controller.text = _schoolController.text;
        }
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: '학교명',
            hintText: '학교 선택 또는 직접 입력',
            suffixIcon: _selectedSchool != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      _schoolController.clear();
                      setState(() => _selectedSchool = null);
                    },
                  )
                : null,
            helperText: _selectedSchool != null
                ? '${SchoolKind.getName(_selectedSchool!.schoolKind)} 선택됨'
                : '목록에서 선택하거나 새 학교명 입력',
          ),
          onChanged: (value) {
            _schoolController.text = value;
            // 직접 입력 시 선택 해제 및 학년 필터 갱신
            if (_selectedSchool != null && _selectedSchool!.schoolName != value) {
              setState(() => _selectedSchool = null);
            } else {
              // 학년 필터 갱신을 위해 setState 호출
              setState(() {});
            }
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final school = options.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: school.schoolKind == 1
                          ? Colors.blue.shade100
                          : Colors.orange.shade100,
                      child: Text(
                        school.schoolKind == 1 ? '중' : '고',
                        style: TextStyle(
                          fontSize: 12,
                          color: school.schoolKind == 1 ? Colors.blue : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(school.schoolName),
                    subtitle: Text(SchoolKind.getName(school.schoolKind)),
                    onTap: () => onSelected(school),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (School school) {
        _schoolController.text = school.schoolName;
        setState(() => _selectedSchool = school);
      },
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
        final values = Map<String, dynamic>.from(_formKey.currentState!.value);

        // 학교 정보 추가
        int? schoolId;
        String? schoolName;
        if (_selectedSchool != null) {
          schoolId = _selectedSchool!.schoolId;
          schoolName = _selectedSchool!.schoolName;
        } else if (_schoolController.text.isNotEmpty) {
          schoolName = _schoolController.text;
        }

        // 생년 변환 (birth_year -> birth_date 형식)
        String? birthDate;
        if (values['birth_year'] != null) {
          birthDate = '${values['birth_year']}-01-01';
        }

        if (isEdit) {
          // 수정 모드
          final updateData = StudentUpdate(
            studentName: values['student_name'],
            phone: values['phone'],
            birthDate: birthDate,
            schoolId: schoolId,
            schoolName: schoolName,
            grade: values['grade'],
            memo: values['memo'],
          );

          final repository = ref.read(studentRepositoryProvider);
          await repository.update(widget.studentId!, updateData);
        } else {
          // 신규 등록 모드
          final createData = StudentCreate(
            studentName: values['student_name'],
            phone: values['phone'],
            birthDate: birthDate,
            schoolId: schoolId,
            schoolName: schoolName,
            grade: values['grade'],
            statusCode: values['status_code'] ?? 'STATUS_PROSPECT',
            memo: values['memo'],
            guardianName: values['student_name'], // 보호자명 = 학생명
            guardianPhone: values['guardian_phone'],
            parentKind: values['parent_kind'],
          );

          final repository = ref.read(studentRepositoryProvider);
          await repository.create(createData);
        }

        // 목록 새로고침
        ref.read(studentListProvider.notifier).refresh();

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
