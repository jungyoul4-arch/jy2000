import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/class_type.dart';
import '../../providers/class_type_provider.dart';
import '../../providers/auth_provider.dart';

class ClassTypeListScreen extends ConsumerStatefulWidget {
  const ClassTypeListScreen({super.key});

  @override
  ConsumerState<ClassTypeListScreen> createState() => _ClassTypeListScreenState();
}

class _ClassTypeListScreenState extends ConsumerState<ClassTypeListScreen> {
  final _searchController = TextEditingController();
  String _searchText = '';
  final _numberFormat = NumberFormat('#,###');

  // 년도 옵션 (올해, 다음해)
  static List<int> get yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear, currentYear + 1];
  }

  // 중고 구분 옵션
  static const List<MapEntry<String, String>> levelOptions = [
    MapEntry('middle', '중등부'),
    MapEntry('high', '고등부'),
  ];

  // 과목 옵션 (int 코드 -> 문자열)
  static const List<MapEntry<int, String>> subjectOptions = [
    MapEntry(1, '국어'),
    MapEntry(2, '수학'),
    MapEntry(3, '영어'),
    MapEntry(4, '과학'),
    MapEntry(5, '사회'),
  ];

  // 형태 옵션 (int 코드 -> 문자열)
  static const List<MapEntry<int, String>> formatOptions = [
    MapEntry(1, '일반'),
    MapEntry(2, '종합'),
    MapEntry(3, '논술'),
    MapEntry(4, '모의'),
    MapEntry(5, '특강'),
    MapEntry(6, '썸머'),
    MapEntry(7, '윈터'),
  ];

  // 학년 옵션 (int 코드 -> 문자열)
  static const List<MapEntry<int, String>> gradeOptions = [
    MapEntry(9, '중3'),
    MapEntry(10, '고1'),
    MapEntry(11, '고2'),
    MapEntry(12, '고3'),
  ];

  // 중등부/고등부에 따른 학년 옵션
  static List<MapEntry<int, String>> getGradeOptionsForLevel(String level) {
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

  // 반형태명 자동 생성
  static String generateClassTypeName({
    required int year,
    required String level,
    required int subject,
    required int format,
    required int grade,
  }) {
    final levelStr = level == 'middle' ? '중등부' : '고등부';
    final subjectStr = subjectOptions.firstWhere((e) => e.key == subject).value;
    final formatStr = formatOptions.firstWhere((e) => e.key == format).value;
    final gradeStr = gradeOptions.firstWhere((e) => e.key == grade).value;
    return '$year $levelStr $subjectStr $formatStr ($gradeStr)';
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(classTypeListProvider.notifier).loadClassTypes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClassType> _filterClassTypes(List<ClassType> classTypes) {
    if (_searchText.isEmpty) return classTypes;
    return classTypes.where((ct) {
      return ct.classTypeName.toLowerCase().contains(_searchText.toLowerCase()) ||
          ct.gradeString.toLowerCase().contains(_searchText.toLowerCase()) ||
          ct.subjectString.toLowerCase().contains(_searchText.toLowerCase()) ||
          ct.teacherNames.any((t) => t.toLowerCase().contains(_searchText.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final classTypeState = ref.watch(classTypeListProvider);
    final authState = ref.watch(authProvider);
    final isAdmin = authState.user?.isAdmin ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('반 형태 관리'),
        actions: [
          if (isAdmin) ...[
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: () => _showAddDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('반 형태 추가'),
            ),
            const SizedBox(width: 16),
          ],
        ],
      ),
      body: Column(
        children: [
          // 검색 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '반형태, 학년, 과목, 강사 검색',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchText = '');
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() => _searchText = value);
                    },
                  ),
                ),
                const Spacer(),
                if (!classTypeState.isLoading && classTypeState.classTypes.isNotEmpty)
                  Text(
                    '총 ${_filterClassTypes(classTypeState.classTypes).length}개',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 목록
          Expanded(
            child: classTypeState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : classTypeState.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              '오류: ${classTypeState.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () {
                                ref.read(classTypeListProvider.notifier).loadClassTypes();
                              },
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : classTypeState.classTypes.isEmpty
                        ? const Center(child: Text('등록된 반 형태가 없습니다'))
                        : _buildClassTypeTable(_filterClassTypes(classTypeState.classTypes), isAdmin),
          ),
        ],
      ),
    );
  }

  Widget _buildClassTypeTable(List<ClassType> classTypes, bool isAdmin) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: [
          const DataColumn(label: Text('No.')),
          const DataColumn(label: Text('ID')),
          const DataColumn(label: Text('반형태')),
          const DataColumn(label: Text('학년')),
          const DataColumn(label: Text('과목')),
          const DataColumn(label: Text('단가'), numeric: true),
          const DataColumn(label: Text('강사들')),
          if (isAdmin) const DataColumn(label: Text('관리')),
        ],
        rows: classTypes.asMap().entries.map((entry) {
          final index = entry.key;
          final ct = entry.value;
          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text('${ct.classTypeId}')),
              DataCell(Text(ct.classTypeName)),
              DataCell(Text(ct.gradeString)),
              DataCell(Text(ct.subjectString)),
              DataCell(Text('${_numberFormat.format(ct.unitPrice)}원')),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Text(
                    ct.teachersString,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (isAdmin)
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () => _showEditDialog(context, ct),
                        tooltip: '수정',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _confirmDelete(context, ct),
                        tooltip: '삭제',
                      ),
                    ],
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final classTypeNameController = TextEditingController();

    int year = yearOptions.first; // 기본값: 올해
    String level = 'high'; // 기본값: 고등부
    int subject = 1; // 기본값: 국어
    int format = 1; // 기본값: 일반
    int grade = 10; // 기본값: 고1
    int unitPrice = 0;
    String teachersText = '';

    // 초기 반형태명 설정
    classTypeNameController.text = generateClassTypeName(
      year: year,
      level: level,
      subject: subject,
      format: format,
      grade: grade,
    );

    void updateClassTypeName(StateSetter setDialogState) {
      classTypeNameController.text = generateClassTypeName(
        year: year,
        level: level,
        subject: subject,
        format: format,
        grade: grade,
      );
    }

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          final availableGrades = getGradeOptionsForLevel(level);

          return AlertDialog(
            title: const Text('반 형태 추가'),
            content: SizedBox(
              width: 450,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. 년도
                      DropdownButtonFormField<int>(
                        value: year,
                        decoration: const InputDecoration(labelText: '년도'),
                        items: yearOptions
                            .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              year = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 2. 중고 구분
                      DropdownButtonFormField<String>(
                        value: level,
                        decoration: const InputDecoration(labelText: '중고 구분'),
                        items: levelOptions
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              level = value;
                              // 중등부 선택시 학년을 중3으로 변경
                              if (level == 'middle') {
                                grade = 9;
                              } else if (grade == 9) {
                                // 고등부 선택시 중3이었으면 고1로 변경
                                grade = 10;
                              }
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 3. 과목
                      DropdownButtonFormField<int>(
                        value: subject,
                        decoration: const InputDecoration(labelText: '과목'),
                        items: subjectOptions
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              subject = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 4. 형태
                      DropdownButtonFormField<int>(
                        value: format,
                        decoration: const InputDecoration(labelText: '형태'),
                        items: formatOptions
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              format = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 5. 학년
                      DropdownButtonFormField<int>(
                        value: grade,
                        decoration: const InputDecoration(labelText: '학년'),
                        items: availableGrades
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              grade = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 6. 반형태명 (자동 생성 + 수정 가능)
                      TextFormField(
                        controller: classTypeNameController,
                        decoration: const InputDecoration(
                          labelText: '반형태명',
                          hintText: '예: 2026 고등부 국어 모의 (고3)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '반형태명을 입력하세요';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // 7. 단가
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: '단가 (원)',
                          hintText: '예: 300000',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          unitPrice = int.tryParse(value ?? '') ?? 0;
                        },
                      ),
                      const SizedBox(height: 16),

                      // 8. 강사들
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: '강사들 (쉼표로 구분)',
                          hintText: '예: 김철수, 박영희',
                        ),
                        onSaved: (value) => teachersText = value ?? '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('취소'),
              ),
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    Navigator.pop(dialogContext);

                    final teacherNames = teachersText.isEmpty
                        ? <String>[]
                        : teachersText.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();

                    final success = await ref.read(classTypeListProvider.notifier).addClassType(
                      classTypeName: classTypeNameController.text,
                      year: year,
                      grade: grade,
                      subject: subject,
                      format: format,
                      unitPrice: unitPrice,
                      teacherNames: teacherNames,
                    );

                    if (mounted) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(success ? '반 형태가 추가되었습니다' : '반 형태 추가 실패'),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('추가'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, ClassType classType) {
    final formKey = GlobalKey<FormState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final classTypeNameController = TextEditingController(text: classType.classTypeName);

    int year = classType.year ?? yearOptions.first;
    // 학년에서 중고 구분 추론
    String level = classType.grade == 9 ? 'middle' : 'high';
    int subject = classType.subject;
    int format = classType.format ?? 1;
    int grade = classType.grade;
    int unitPrice = classType.unitPrice;
    String teachersText = classType.teachersString;

    // 년도 옵션에 현재 값이 없으면 추가
    final years = List<int>.from(yearOptions);
    if (!years.contains(year)) {
      years.insert(0, year);
    }

    void updateClassTypeName(StateSetter setDialogState) {
      classTypeNameController.text = generateClassTypeName(
        year: year,
        level: level,
        subject: subject,
        format: format,
        grade: grade,
      );
    }

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          final availableGrades = getGradeOptionsForLevel(level);

          // 학년 옵션에 현재 값이 없으면 추가
          final grades = List<MapEntry<int, String>>.from(availableGrades);
          if (!grades.any((e) => e.key == grade)) {
            grades.add(MapEntry(grade, gradeToString(grade)));
          }

          // 과목 옵션에 현재 값이 없으면 추가
          final subjects = List<MapEntry<int, String>>.from(subjectOptions);
          if (!subjects.any((e) => e.key == subject)) {
            subjects.add(MapEntry(subject, subjectToString(subject)));
          }

          // 형태 옵션에 현재 값이 없으면 추가
          final formats = List<MapEntry<int, String>>.from(formatOptions);
          if (!formats.any((e) => e.key == format)) {
            formats.add(MapEntry(format, formatToString(format)));
          }

          return AlertDialog(
            title: const Text('반 형태 수정'),
            content: SizedBox(
              width: 450,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. 년도
                      DropdownButtonFormField<int>(
                        value: year,
                        decoration: const InputDecoration(labelText: '년도'),
                        items: years
                            .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              year = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 2. 중고 구분
                      DropdownButtonFormField<String>(
                        value: level,
                        decoration: const InputDecoration(labelText: '중고 구분'),
                        items: levelOptions
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              level = value;
                              // 중등부 선택시 학년을 중3으로 변경
                              if (level == 'middle') {
                                grade = 9;
                              } else if (grade == 9) {
                                // 고등부 선택시 중3이었으면 고1로 변경
                                grade = 10;
                              }
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 3. 과목
                      DropdownButtonFormField<int>(
                        value: subject,
                        decoration: const InputDecoration(labelText: '과목'),
                        items: subjects
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              subject = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 4. 형태
                      DropdownButtonFormField<int>(
                        value: format,
                        decoration: const InputDecoration(labelText: '형태'),
                        items: formats
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              format = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 5. 학년
                      DropdownButtonFormField<int>(
                        value: grade,
                        decoration: const InputDecoration(labelText: '학년'),
                        items: grades
                            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              grade = value;
                              updateClassTypeName(setDialogState);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 6. 반형태명 (자동 생성 + 수정 가능)
                      TextFormField(
                        controller: classTypeNameController,
                        decoration: const InputDecoration(
                          labelText: '반형태명',
                          hintText: '예: 2026 고등부 국어 모의 (고3)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '반형태명을 입력하세요';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // 7. 단가
                      TextFormField(
                        initialValue: unitPrice.toString(),
                        decoration: const InputDecoration(labelText: '단가 (원)'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          unitPrice = int.tryParse(value ?? '') ?? 0;
                        },
                      ),
                      const SizedBox(height: 16),

                      // 8. 강사들
                      TextFormField(
                        initialValue: teachersText,
                        decoration: const InputDecoration(
                          labelText: '강사들 (쉼표로 구분)',
                        ),
                        onSaved: (value) => teachersText = value ?? '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('취소'),
              ),
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    Navigator.pop(dialogContext);

                    final teacherNames = teachersText.isEmpty
                        ? <String>[]
                        : teachersText.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();

                    final success = await ref.read(classTypeListProvider.notifier).updateClassType(
                      classTypeId: classType.classTypeId,
                      classTypeName: classTypeNameController.text,
                      year: year,
                      grade: grade,
                      subject: subject,
                      format: format,
                      unitPrice: unitPrice,
                      teacherNames: teacherNames,
                    );

                    if (mounted) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(success ? '반 형태가 수정되었습니다' : '반 형태 수정 실패'),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('저장'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, ClassType classType) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('반 형태 삭제'),
        content: Text('${classType.classTypeName}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await ref.read(classTypeListProvider.notifier).deleteClassType(classType.classTypeId);

              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(success ? '반 형태가 삭제되었습니다' : '삭제 실패'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
