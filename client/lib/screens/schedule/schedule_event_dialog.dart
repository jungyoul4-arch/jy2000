import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/schedule_category.dart';
import '../../models/schedule_event.dart';
import '../../models/schedule_event_type.dart';
import '../../models/student.dart';
import '../../providers/auth_provider.dart';
import '../../providers/code_provider.dart';
import '../../repositories/student_repository.dart';
import '../../widgets/consult_time_fields.dart';
import '../../widgets/tc_picker_field.dart';

class ScheduleEventDialog extends ConsumerStatefulWidget {
  final ScheduleCategory category;
  final DateTime date;
  final List<ScheduleEventType> eventTypes;
  final ScheduleEvent? existingEvent;
  final Future<bool> Function(
    int eventTypeId,
    int? eventHour,
    int eventMinute,
    String? content,
    bool isImportant,
    int? studentId,
    int? tcId,
    String? consultTypeCode,
  ) onSave;
  final Future<bool> Function()? onDelete;

  const ScheduleEventDialog({
    super.key,
    required this.category,
    required this.date,
    required this.eventTypes,
    this.existingEvent,
    required this.onSave,
    this.onDelete,
  });

  @override
  ConsumerState<ScheduleEventDialog> createState() => _ScheduleEventDialogState();
}

class _ScheduleEventDialogState extends ConsumerState<ScheduleEventDialog> {
  late int _selectedEventTypeId;
  late int _selectedMinute;
  int _selectedHour = defaultConsultHour;
  String? _selectedConsultTypeCode;
  bool _isImportant = false;
  // 상담자 (기본값: 로그인한 사용자)
  int? _selectedTcId;
  String? _selectedTcName;
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _studentSearchController = TextEditingController();
  Student? _selectedStudent;
  int? _selectedStudentId;
  List<Student> _searchResults = [];
  bool _isSearching = false;
  bool _isSaving = false;

  // 디바운스용 타이머
  Timer? _debounce;

  // 분 선택 옵션
  static const List<int> minuteOptions = [0, 10, 20, 30, 40, 50];

  /// 분 지정 가능 여부 - 시간대 슬롯 또는 전화상담 카테고리
  bool get _isMinuteEnabled =>
      widget.category.isTimeSlot || widget.category.isConsult;

  /// 시(hour) 지정 필요 여부 - 카테고리명에 시각이 없는 전화상담 카테고리
  bool get _isHourEnabled => widget.category.isConsult;

  /// 선택한 일정 유형이 '상담'인지 여부 (상담 유형을 추가로 입력받는다)
  bool get _isConsultEventType {
    final type = widget.eventTypes
        .where((t) => t.eventTypeId == _selectedEventTypeId)
        .firstOrNull;
    return type?.eventTypeName == '상담';
  }

  @override
  void initState() {
    super.initState();
    // 기존 일정이 있으면 값 설정
    if (widget.existingEvent != null) {
      _selectedEventTypeId = widget.existingEvent!.eventTypeId;
      // 분은 시간대(TIME_SLOT) 카테고리에서만 사용
      final existingMinute = widget.existingEvent!.eventMinute;
      _selectedMinute = _isMinuteEnabled && minuteOptions.contains(existingMinute)
          ? existingMinute
          : 0;
      final existingHour = widget.existingEvent!.eventHour;
      _selectedHour = existingHour != null && consultHourOptions.contains(existingHour)
          ? existingHour
          : defaultConsultHour;
      _selectedConsultTypeCode = widget.existingEvent!.consultTypeCode;
      _contentController.text = widget.existingEvent!.content ?? '';
      _isImportant = widget.existingEvent!.isImportant;
      _selectedStudentId = widget.existingEvent!.studentId;
      _selectedTcId = widget.existingEvent!.tcId;
      _selectedTcName = widget.existingEvent!.tcName;
      if (widget.existingEvent!.studentId != null) {
        // 학생 정보 표시
        _studentSearchController.text = widget.existingEvent!.studentName ?? '';
      }
    } else {
      // 기본 일정 유형 (첫 번째)
      _selectedEventTypeId = widget.eventTypes.isNotEmpty
          ? widget.eventTypes.first.eventTypeId
          : 1;
      _selectedMinute = 0;
    }

    // 상담자 기본값: 로그인한 사용자
    if (_selectedTcId == null) {
      final user = ref.read(authProvider).user;
      _selectedTcId = user?.userId;
      _selectedTcName = user?.name;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _contentController.dispose();
    _studentSearchController.dispose();
    super.dispose();
  }

  /// 학생 검색 (디바운스 적용)
  void _onStudentSearchChanged(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchStudents(query);
    });
  }

  /// 학생 검색 (API 호출)
  Future<void> _searchStudents(String query) async {
    try {
      final repository = StudentRepository();
      final result = await repository.getList(
        StudentListParams(
          page: 1,
          perPage: 10,
          search: query,
        ),
      );

      if (mounted) {
        setState(() {
          _searchResults = result.data;
          _isSearching = false;
        });

        // 디버깅: 검색 결과 로그
        print('[학생 검색] 검색어: $query, 결과 수: ${result.data.length}');
        if (result.data.isEmpty) {
          print('[학생 검색] 검색 결과가 없습니다.');
        }
      }
    } catch (e) {
      print('[학생 검색 에러] $e');
      if (mounted) {
        setState(() => _isSearching = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('학생 검색 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 저장
  Future<void> _save() async {
    setState(() => _isSaving = true);

    try {
      final success = await widget.onSave(
        _selectedEventTypeId,
        _isHourEnabled ? _selectedHour : null,
        _isMinuteEnabled ? _selectedMinute : 0,
        _contentController.text.isNotEmpty ? _contentController.text : null,
        _isImportant,
        _selectedStudentId,
        _selectedTcId,
        _isConsultEventType ? _selectedConsultTypeCode : null,
      );

      if (success && mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.existingEvent != null ? '일정이 수정되었습니다' : '일정이 등록되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('저장 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  /// 삭제
  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('일정 삭제'),
        content: const Text('이 일정을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isSaving = true);

    try {
      final success = await widget.onDelete!();
      if (success && mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('일정이 삭제되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('삭제 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekdays = ['', '월', '화', '수', '목', '금', '토', '일'];
    final dateStr = '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일 (${weekdays[widget.date.weekday]})';
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: screenSize.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 타이틀 바
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    widget.existingEvent != null ? '일정 수정' : '일정 등록',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // 컨텐츠
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              // 날짜 및 카테고리 정보
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateStr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '카테고리: ${widget.category.categoryName}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 일정 유형 선택
              const Text('일정 유형', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.eventTypes.map((type) {
                  final isSelected = _selectedEventTypeId == type.eventTypeId;
                  return ChoiceChip(
                    label: Text(type.eventTypeName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedEventTypeId = type.eventTypeId);
                      }
                    },
                    backgroundColor: type.color.withOpacity(0.3),
                    selectedColor: type.color,
                    labelStyle: TextStyle(
                      color: isSelected ? type.textColor : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // 상담 유형 (일정 유형이 '상담'일 때만)
              if (_isConsultEventType) ...[
                const Text('상담 유형', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    final consultTypes = ref.watch(consultTypeCodesProvider);
                    // 코드가 아직 로드되지 않았으면 안내만 표시
                    if (consultTypes.isEmpty) {
                      return Text(
                        '상담 유형 코드를 불러오는 중입니다...',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      );
                    }

                    final validValue = consultTypes
                            .any((c) => c.codeId == _selectedConsultTypeCode)
                        ? _selectedConsultTypeCode
                        : null;

                    return DropdownButtonFormField<String>(
                      value: validValue,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '상담 유형을 선택하세요',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: consultTypes
                          .map((code) => DropdownMenuItem(
                                value: code.codeId,
                                child: Text(code.codeName),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedConsultTypeCode = value);
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],

              // 상담자 선택 (기본: 로그인 사용자, 클릭하여 변경)
              TcPickerField(
                tcId: _selectedTcId,
                tcName: _selectedTcName,
                onChanged: (staff) {
                  setState(() {
                    _selectedTcId = staff.userId;
                    _selectedTcName = staff.name;
                  });
                },
              ),
              const SizedBox(height: 16),

              // 시각 선택 (시간대 슬롯: 분만 / 전화상담: 시 + 분)
              if (_isMinuteEnabled) ...[
                Text(
                  _isHourEnabled ? '시각' : '분 (${widget.category.categoryName}시)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (_isHourEnabled) ...[
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedHour,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          items: consultHourOptions.map((hour) {
                            return DropdownMenuItem(
                              value: hour,
                              child: Text('$hour시'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedHour = value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedMinute,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: minuteOptions.map((minute) {
                          return DropdownMenuItem(
                            value: minute,
                            child: Text('$minute분'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedMinute = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // 내용 입력
              const Text('내용', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: '일정 내용을 입력하세요...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              // 중요 일정 여부 (캘린더에 빨간색 볼드로 표시)
              CheckboxListTile(
                value: _isImportant,
                onChanged: (value) {
                  setState(() => _isImportant = value ?? false);
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: const Text(
                  '중요 일정',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                subtitle: Text(
                  '캘린더에 빨간색 굵은 글씨로 표시됩니다.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 16),

              // 학생 연동 (선택)
              const Text('학생 연동 (선택)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                '학생을 연동하면 해당 학생의 상담 기록에도 자동 등록됩니다.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _studentSearchController,
                decoration: InputDecoration(
                  hintText: '학생 이름 또는 전화번호 검색...',
                  border: const OutlineInputBorder(),
                  suffixIcon: _selectedStudentId != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedStudent = null;
                              _selectedStudentId = null;
                              _studentSearchController.clear();
                              _searchResults = [];
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  // 직접 입력하면 기존 연동 해제 (목록에서 다시 선택해야 연동됨)
                  if (_selectedStudent != null || _selectedStudentId != null) {
                    setState(() {
                      _selectedStudent = null;
                      _selectedStudentId = null;
                    });
                  }
                  _onStudentSearchChanged(value);
                },
              ),

              // 학생 검색 결과
              if (_isSearching)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_searchResults.isNotEmpty && _selectedStudent == null)
                Container(
                  constraints: const BoxConstraints(maxHeight: 150),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final student = _searchResults[index];
                      return ListTile(
                        dense: true,
                        title: Text(student.studentName),
                        subtitle: Text(student.phone),
                        onTap: () {
                          setState(() {
                            _selectedStudent = student;
                            _selectedStudentId = student.studentId;
                            _studentSearchController.text = student.studentName;
                            _searchResults = [];
                          });
                        },
                      );
                    },
                  ),
                ),

              // 선택된 학생 표시
              if (_selectedStudent != null)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_selectedStudent!.studentName} (${_selectedStudent!.phone})',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            // 액션 버튼
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 삭제 버튼 (수정 시에만)
                  if (widget.onDelete != null)
                    TextButton(
                      onPressed: _isSaving ? null : _delete,
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('삭제'),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(widget.existingEvent != null ? '수정' : '저장'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
