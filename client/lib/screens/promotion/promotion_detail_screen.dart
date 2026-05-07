import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../models/promotion.dart';
import '../../models/school.dart';
import '../../repositories/promotion_repository.dart';
import '../../providers/promotion_provider.dart';
import '../../providers/school_provider.dart';

// 프로모션 상세 조회 Provider
final promotionDetailProvider =
    FutureProvider.family<Promotion, int>((ref, promotionId) async {
  final repository = ref.read(promotionRepositoryProvider);
  return repository.getById(promotionId);
});

// 참석자 목록 Provider
final promotionAttendeesProvider =
    FutureProvider.family<List<PromotionAttendee>, int>((ref, promotionId) async {
  final repository = ref.read(promotionRepositoryProvider);
  return repository.getAttendees(promotionId);
});

class PromotionDetailScreen extends ConsumerStatefulWidget {
  final int promotionId;

  const PromotionDetailScreen({super.key, required this.promotionId});

  @override
  ConsumerState<PromotionDetailScreen> createState() =>
      _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends ConsumerState<PromotionDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isEditing = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final promotionAsync = ref.watch(promotionDetailProvider(widget.promotionId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBack(),
        ),
        title: Text(_isEditing ? '설명회 수정' : '설명회 상세'),
        actions: [
          if (!_isEditing)
            FilledButton.icon(
              onPressed: () => setState(() => _isEditing = true),
              icon: const Icon(Icons.edit),
              label: const Text('수정'),
            )
          else ...[
            OutlinedButton(
              onPressed: () => setState(() => _isEditing = false),
              child: const Text('취소'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _isLoading ? null : _onSubmit,
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
        ],
      ),
      body: promotionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('오류: $error')),
        data: (promotion) => _buildContent(promotion),
      ),
    );
  }

  Widget _buildContent(Promotion promotion) {
    // 설명회 일시 파싱
    final DateTime startDate = DateTime.tryParse(promotion.startDate) ?? DateTime.now();

    return SingleChildScrollView(
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
                      initialValue: promotion.promotionName,
                      readOnly: !_isEditing,
                      decoration: InputDecoration(
                        labelText: '설명회명 *',
                        filled: !_isEditing,
                        fillColor: Colors.grey.shade50,
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: '설명회명을 입력하세요',
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isEditing)
                      FormBuilderDropdown<String>(
                        name: 'promotion_type_code',
                        initialValue: promotion.promotionTypeCode,
                        decoration: const InputDecoration(
                          labelText: '설명회 유형 *',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'PROMO_ENTRANCE', child: Text('입시 설명회')),
                          DropdownMenuItem(value: 'PROMO_PARENT', child: Text('학부모 설명회')),
                          DropdownMenuItem(value: 'PROMO_ADMISSION', child: Text('입학 설명회')),
                          DropdownMenuItem(value: 'PROMO_CONSULT', child: Text('진학 상담회')),
                          DropdownMenuItem(value: 'PROMO_SPECIAL', child: Text('특강 안내')),
                          DropdownMenuItem(value: 'PROMO_OPEN', child: Text('오픈 클래스')),
                        ],
                      )
                    else
                      TextFormField(
                        initialValue: _getPromotionTypeName(promotion.promotionTypeCode),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '설명회 유형',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'description',
                      initialValue: promotion.description,
                      readOnly: !_isEditing,
                      decoration: InputDecoration(
                        labelText: '설명회 내용',
                        filled: !_isEditing,
                        fillColor: Colors.grey.shade50,
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
                          child: _isEditing
                              ? FormBuilderDateTimePicker(
                                  name: 'start_date',
                                  inputType: InputType.both,
                                  initialValue: startDate,
                                  format: DateFormat('yyyy-MM-dd HH:mm'),
                                  decoration: const InputDecoration(
                                    labelText: '설명회 일시 *',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                )
                              : TextFormField(
                                  initialValue: DateFormat('yyyy-MM-dd HH:mm').format(startDate),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: '설명회 일시',
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'target_subject',
                            initialValue: promotion.targetSubject,
                            readOnly: !_isEditing,
                            decoration: InputDecoration(
                              labelText: '장소',
                              filled: !_isEditing,
                              fillColor: Colors.grey.shade50,
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
                            initialValue: promotion.targetGrade,
                            readOnly: !_isEditing,
                            decoration: InputDecoration(
                              labelText: '대상 학년',
                              filled: !_isEditing,
                              fillColor: Colors.grey.shade50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'discount_value',
                            initialValue: promotion.discountValue?.toInt().toString(),
                            readOnly: !_isEditing,
                            decoration: InputDecoration(
                              labelText: '참가 정원',
                              suffixText: '명',
                              filled: !_isEditing,
                              fillColor: Colors.grey.shade50,
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

            // 참석 예정자 목록
            _buildAttendeesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeesSection() {
    final attendeesAsync = ref.watch(promotionAttendeesProvider(widget.promotionId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '참석 예정자',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                FilledButton.icon(
                  onPressed: () => _showAddAttendeeDialog(),
                  icon: const Icon(Icons.person_add, size: 18),
                  label: const Text('등록'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            attendeesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('오류: $error'),
              data: (attendees) => attendees.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('등록된 참석자가 없습니다'),
                      ),
                    )
                  : _buildAttendeesTable(attendees),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeesTable(List<PromotionAttendee> attendees) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.8),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1.5),
        6: FixedColumnWidth(50),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: const [
            Padding(padding: EdgeInsets.all(8), child: Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('이름', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('연락처', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('학교', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('학년', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('상태', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text('')),
          ],
        ),
        ...attendees.asMap().entries.map((entry) {
          final index = entry.key;
          final attendee = entry.value;
          return TableRow(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: Text('${index + 1}')),
              Padding(padding: const EdgeInsets.all(8), child: Text(attendee.studentName ?? '-')),
              Padding(padding: const EdgeInsets.all(8), child: Text(attendee.studentPhone ?? '-')),
              Padding(padding: const EdgeInsets.all(8), child: Text(attendee.schoolName ?? '-')),
              Padding(padding: const EdgeInsets.all(8), child: Text(_formatGrade(attendee.grade))),
              Padding(padding: const EdgeInsets.all(8), child: Text(attendee.statusName ?? '-')),
              Padding(
                padding: const EdgeInsets.all(4),
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => _removeAttendee(attendee),
                  color: Colors.red,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  String _formatGrade(int? grade) {
    if (grade == null) return '-';
    if (grade >= 1 && grade <= 6) return '초$grade';
    if (grade >= 7 && grade <= 9) return '중${grade - 6}';
    if (grade >= 10 && grade <= 12) return '고${grade - 9}';
    if (grade == 13) return 'N수생';
    if (grade == 14) return '성인';
    return '$grade';
  }

  void _showAddAttendeeDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => _AttendeeRegistrationDialog(
        promotionId: widget.promotionId,
        onRegistered: () {
          ref.invalidate(promotionAttendeesProvider(widget.promotionId));
        },
      ),
    );
  }

  void _removeAttendee(PromotionAttendee attendee) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('참석자 삭제'),
        content: Text('${attendee.studentName}님을 참석자 목록에서 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final repository = PromotionRepository();
        await repository.removeAttendee(widget.promotionId, attendee.id);

        if (mounted) {
          ref.invalidate(promotionAttendeesProvider(widget.promotionId));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('참석자가 삭제되었습니다')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('오류: $e')),
          );
        }
      }
    }
  }

  String _getPromotionTypeName(String? typeCode) {
    switch (typeCode) {
      case 'PROMO_ENTRANCE':
        return '입시 설명회';
      case 'PROMO_PARENT':
        return '학부모 설명회';
      case 'PROMO_ADMISSION':
        return '입학 설명회';
      case 'PROMO_CONSULT':
        return '진학 상담회';
      case 'PROMO_SPECIAL':
        return '특강 안내';
      case 'PROMO_OPEN':
        return '오픈 클래스';
      default:
        return typeCode ?? '-';
    }
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

        // 설명회 일시 포맷팅
        final startDate = values['start_date'] as DateTime?;
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
        await repository.update(widget.promotionId, promotionData);

        if (mounted) {
          // 캐시 무효화
          ref.invalidate(promotionDetailProvider(widget.promotionId));
          ref.read(promotionListProvider.notifier).refresh();

          setState(() => _isEditing = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('설명회가 수정되었습니다')),
          );
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

// 참석자 등록 다이얼로그 위젯
class _AttendeeRegistrationDialog extends ConsumerStatefulWidget {
  final int promotionId;
  final VoidCallback onRegistered;

  const _AttendeeRegistrationDialog({
    required this.promotionId,
    required this.onRegistered,
  });

  @override
  ConsumerState<_AttendeeRegistrationDialog> createState() => _AttendeeRegistrationDialogState();
}

class _AttendeeRegistrationDialogState extends ConsumerState<_AttendeeRegistrationDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _schoolController = TextEditingController();
  final _memoController = TextEditingController();

  bool _isNewStudent = true; // true: 신규, false: 기존 학생
  bool _isSubmitting = false;
  bool _isSearching = false;
  School? _selectedSchool;
  UserSearchResult? _selectedUser;
  String _studentSearchQuery = '';
  List<UserSearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(schoolListProvider.notifier).loadSchools();
    });
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  // User 검색 API 호출
  Future<void> _searchUsers(String query) async {
    if (query.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    try {
      final repository = PromotionRepository();
      final results = await repository.searchUsers(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  // 학년 목록 (학교 종류에 따라)
  List<DropdownMenuItem<int>> _getGradeItems() {
    final schoolName = _schoolController.text;
    final schoolKind = _selectedSchool?.schoolKind;

    // 중학교
    final isMiddleSchool = schoolKind == 1 || schoolName.endsWith('중');
    // 고등학교
    final isHighSchool = schoolKind == 2 || schoolName.endsWith('고');

    if (isMiddleSchool) {
      return const [
        DropdownMenuItem(value: 7, child: Text('1학년')),
        DropdownMenuItem(value: 8, child: Text('2학년')),
        DropdownMenuItem(value: 9, child: Text('3학년')),
        DropdownMenuItem(value: 14, child: Text('성인')),
      ];
    } else if (isHighSchool) {
      return const [
        DropdownMenuItem(value: 10, child: Text('1학년')),
        DropdownMenuItem(value: 11, child: Text('2학년')),
        DropdownMenuItem(value: 12, child: Text('3학년')),
        DropdownMenuItem(value: 13, child: Text('N수생')),
        DropdownMenuItem(value: 14, child: Text('성인')),
      ];
    }

    // 기본값 (학교 미선택)
    return const [
      DropdownMenuItem(value: 7, child: Text('중1')),
      DropdownMenuItem(value: 8, child: Text('중2')),
      DropdownMenuItem(value: 9, child: Text('중3')),
      DropdownMenuItem(value: 10, child: Text('고1')),
      DropdownMenuItem(value: 11, child: Text('고2')),
      DropdownMenuItem(value: 12, child: Text('고3')),
      DropdownMenuItem(value: 13, child: Text('N수생')),
      DropdownMenuItem(value: 14, child: Text('성인')),
    ];
  }

  // 전화번호 정규화 (하이픈 제거)
  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[-\s]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('참석자 등록'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 신규/기존 학생 토글
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('신규 학생'), icon: Icon(Icons.person_add)),
                ButtonSegment(value: false, label: Text('기존 학생'), icon: Icon(Icons.search)),
              ],
              selected: {_isNewStudent},
              onSelectionChanged: (selected) {
                setState(() {
                  _isNewStudent = selected.first;
                  _selectedUser = null;
                });
              },
            ),
            const SizedBox(height: 16),

            if (_isNewStudent) _buildNewStudentForm() else _buildExistingStudentSearch(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _onSubmit,
          child: _isSubmitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('등록'),
        ),
      ],
    );
  }

  Widget _buildNewStudentForm() {
    final schoolState = ref.watch(schoolListProvider);
    final schools = schoolState.schools;

    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: '이름 *'),
            validator: FormBuilderValidators.required(errorText: '이름을 입력하세요'),
          ),
          const SizedBox(height: 12),
          FormBuilderTextField(
            name: 'phone',
            decoration: const InputDecoration(
              labelText: '전화번호 *',
              hintText: '010-0000-0000',
            ),
            validator: FormBuilderValidators.required(errorText: '전화번호를 입력하세요'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          // 학교 Autocomplete
          Autocomplete<School>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return schools;
              }
              return schools.where((school) =>
                  school.schoolName.contains(textEditingValue.text));
            },
            displayStringForOption: (School school) => school.schoolName,
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
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
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            controller.clear();
                            _schoolController.clear();
                            setState(() => _selectedSchool = null);
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  _schoolController.text = value;
                  if (_selectedSchool != null && _selectedSchool!.schoolName != value) {
                    setState(() => _selectedSchool = null);
                  } else {
                    setState(() {}); // 학년 목록 갱신
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
                    constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final school = options.elementAt(index);
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            radius: 12,
                            backgroundColor: school.schoolKind == 1 ? Colors.blue.shade100 : Colors.orange.shade100,
                            child: Text(
                              school.schoolKind == 1 ? '중' : '고',
                              style: TextStyle(fontSize: 10, color: school.schoolKind == 1 ? Colors.blue : Colors.orange),
                            ),
                          ),
                          title: Text(school.schoolName, style: const TextStyle(fontSize: 14)),
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
          ),
          const SizedBox(height: 12),
          FormBuilderDropdown<int>(
            name: 'grade',
            decoration: const InputDecoration(labelText: '학년'),
            items: _getGradeItems(),
          ),
          const SizedBox(height: 12),
          FormBuilderTextField(
            name: 'memo',
            decoration: const InputDecoration(labelText: '메모'),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildExistingStudentSearch() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: '학생 검색',
            hintText: '이름 또는 전화번호로 검색 (2자 이상)',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isSearching ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : null,
          ),
          onChanged: (value) {
            setState(() => _studentSearchQuery = value);
            _searchUsers(value);
          },
        ),
        const SizedBox(height: 12),
        if (_studentSearchQuery.length >= 2) _buildStudentSearchResults(),
        if (_selectedUser != null) ...[
          const SizedBox(height: 12),
          Card(
            color: Colors.blue.shade50,
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.blue),
              title: Text(_selectedUser!.name),
              subtitle: Text('${_selectedUser!.phone} / ${_selectedUser!.schoolName ?? '-'}'),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _selectedUser = null),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        TextFormField(
          controller: _memoController,
          decoration: const InputDecoration(labelText: '메모'),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildStudentSearchResults() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return const Text('검색 결과가 없습니다', style: TextStyle(color: Colors.grey));
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final user = _searchResults[index];
          final isSelected = _selectedUser?.userId == user.userId;
          return ListTile(
            dense: true,
            selected: isSelected,
            selectedTileColor: Colors.blue.shade100,
            leading: CircleAvatar(
              radius: 16,
              child: Text(user.name.isNotEmpty ? user.name[0] : '?'),
            ),
            title: Text(user.name),
            subtitle: Text('${user.phone} / ${user.schoolName ?? '-'}'),
            trailing: Text(user.statusName ?? '', style: const TextStyle(fontSize: 12)),
            onTap: () => setState(() => _selectedUser = user),
          );
        },
      ),
    );
  }

  void _onSubmit() async {
    setState(() => _isSubmitting = true);

    try {
      final repository = PromotionRepository();

      if (_isNewStudent) {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          final values = _formKey.currentState!.value;
          final phone = _normalizePhone(values['phone'] as String);

          await repository.addNewAttendee(
            widget.promotionId,
            NewAttendeeData(
              name: values['name'] as String,
              phone: phone,
              schoolId: _selectedSchool?.schoolId,
              grade: values['grade'] as int?,
              memo: values['memo'] as String?,
            ),
          );

          if (mounted) {
            Navigator.pop(context);
            widget.onRegistered();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('참석자가 등록되었습니다')),
            );
          }
        }
      } else {
        // 기존 학생 등록
        if (_selectedUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('학생을 선택하세요')),
          );
          return;
        }

        await repository.addExistingAttendee(
          widget.promotionId,
          _selectedUser!.userId,
          _memoController.text.isNotEmpty ? _memoController.text : null,
        );

        if (mounted) {
          Navigator.pop(context);
          widget.onRegistered();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('참석자가 등록되었습니다')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
