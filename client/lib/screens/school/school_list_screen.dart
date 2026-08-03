import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/school.dart';
import '../../providers/school_provider.dart';
import '../../widgets/logout_button.dart';

class SchoolListScreen extends ConsumerStatefulWidget {
  const SchoolListScreen({super.key});

  @override
  ConsumerState<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends ConsumerState<SchoolListScreen> {
  static const _sortPrefKey = 'school_list_sort_by_student_count';

  int? _filterKind;
  bool _sortByStudentCount = false; // false: 가나다순, true: 학생수순
  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadSortPreference();
    Future.microtask(() {
      ref.read(schoolListProvider.notifier).loadSchools();
    });
  }

  Future<void> _loadSortPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSort = prefs.getBool(_sortPrefKey) ?? false;
    setState(() => _sortByStudentCount = savedSort);
  }

  Future<void> _saveSortPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sortPrefKey, value);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<School> _filterAndSortSchools(List<School> schools) {
    var filtered = schools.where((s) {
      if (_searchText.isEmpty) return true;
      return s.schoolName.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    // 삭제된 학교는 항상 맨 뒤로
    filtered.sort((a, b) {
      // 먼저 is_active 기준 정렬 (활성 학교가 앞에)
      if (a.isActive != b.isActive) {
        return a.isActive ? -1 : 1;
      }
      // 같은 활성 상태 내에서 정렬
      if (_sortByStudentCount) {
        return b.studentCount.compareTo(a.studentCount);
      } else {
        return a.schoolName.compareTo(b.schoolName);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final schoolState = ref.watch(schoolListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('학교 관리'),
        actions: [
          // 필터 드롭다운
          DropdownButton<int?>(
            value: _filterKind,
            hint: const Text('전체'),
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: null, child: Text('전체')),
              DropdownMenuItem(value: 1, child: Text('중학교')),
              DropdownMenuItem(value: 2, child: Text('고등학교')),
            ],
            onChanged: (value) {
              setState(() => _filterKind = value);
              ref.read(schoolListProvider.notifier).loadSchools(schoolKind: value);
            },
          ),
          const SizedBox(width: 16),
          FilledButton.icon(
            onPressed: () => _showAddDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('학교 추가'),
          ),
          const SizedBox(width: 16),
          const LogoutButton(),
        ],
      ),
      body: Column(
        children: [
          // 필터/검색 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                // 검색
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '학교명 검색',
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
                const SizedBox(width: 16),

                // 정렬 토글
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('가나다순'),
                      icon: Icon(Icons.sort_by_alpha),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('학생수순'),
                      icon: Icon(Icons.people),
                    ),
                  ],
                  selected: {_sortByStudentCount},
                  onSelectionChanged: (selected) {
                    setState(() => _sortByStudentCount = selected.first);
                    _saveSortPreference(selected.first);
                  },
                ),
                const Spacer(),

                // 결과 수
                if (!schoolState.isLoading && schoolState.schools.isNotEmpty)
                  Text(
                    '총 ${_filterAndSortSchools(schoolState.schools).length}개',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 목록
          Expanded(
            child: schoolState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : schoolState.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('오류: ${schoolState.error}'),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () {
                                ref.read(schoolListProvider.notifier).loadSchools();
                              },
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : schoolState.schools.isEmpty
                        ? const Center(child: Text('등록된 학교가 없습니다'))
                        : _buildSchoolList(_filterAndSortSchools(schoolState.schools)),
          ),
        ],
      ),
    );
  }

  void _navigateToStudentList(School school) {
    // 학생 관리 화면으로 이동 (쿼리 파라미터로 학교 필터 전달)
    context.go('/students?schoolId=${school.schoolId}&schoolName=${Uri.encodeComponent(school.schoolName)}');
  }

  Widget _buildSchoolList(List<School> schools) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schools.length,
      itemBuilder: (context, index) {
        final school = schools[index];
        final isDeleted = !school.isActive;

        return Card(
          color: isDeleted ? Colors.grey.shade200 : null,
          child: ListTile(
            onTap: isDeleted || school.studentCount == 0
                ? null
                : () => _navigateToStudentList(school),
            leading: CircleAvatar(
              backgroundColor: isDeleted
                  ? Colors.grey.shade300
                  : school.schoolKind == 1
                      ? Colors.blue.shade100
                      : Colors.orange.shade100,
              child: Text(
                school.schoolKind == 1 ? '중' : '고',
                style: TextStyle(
                  color: isDeleted
                      ? Colors.grey
                      : school.schoolKind == 1
                          ? Colors.blue
                          : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  school.schoolName,
                  style: TextStyle(
                    color: isDeleted ? Colors.grey : null,
                    decoration: isDeleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (!isDeleted && school.studentCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${school.studentCount}명',
                      style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
                if (isDeleted) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '삭제됨',
                      style: TextStyle(fontSize: 11, color: Colors.red.shade700),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Text(
              '${SchoolKind.getName(school.schoolKind)} | ${RegionKind.getName(school.regionKind)}',
              style: TextStyle(color: isDeleted ? Colors.grey : null),
            ),
            trailing: isDeleted
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () => _showEditDialog(context, school),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _confirmDelete(context, school),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _showAddDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String schoolName = '';
    int schoolKind = 1;
    int regionKind = 1;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('학교 추가'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '학교명',
                    hintText: '예: 서울중, 한국고',
                    helperText: '학교명은 "중" 또는 "고"로 끝나야 합니다',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '학교명을 입력하세요';
                    }
                    if (!value.endsWith('중') && !value.endsWith('고')) {
                      return '학교명은 "중" 또는 "고"로 끝나야 합니다';
                    }
                    return null;
                  },
                  onSaved: (value) => schoolName = value!,
                  onChanged: (value) {
                    // 자동으로 학교 종류 설정
                    if (value.endsWith('중')) {
                      setDialogState(() => schoolKind = 1);
                    } else if (value.endsWith('고')) {
                      setDialogState(() => schoolKind = 2);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: schoolKind,
                  decoration: const InputDecoration(
                    labelText: '학교 종류',
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('중학교')),
                    DropdownMenuItem(value: 2, child: Text('고등학교')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => schoolKind = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: regionKind,
                  decoration: const InputDecoration(
                    labelText: '권역',
                  ),
                  items: RegionKind.values.map((v) =>
                    DropdownMenuItem(value: v, child: Text(RegionKind.getName(v)))
                  ).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => regionKind = value);
                    }
                  },
                ),
              ],
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

                  final success = await ref.read(schoolListProvider.notifier).addSchool(
                    schoolName: schoolName,
                    schoolKind: schoolKind,
                    regionKind: regionKind,
                  );

                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text(success ? '학교가 추가되었습니다' : '학교 추가 실패'),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('추가'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, School school) {
    final formKey = GlobalKey<FormState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String schoolName = school.schoolName;
    int schoolKind = school.schoolKind;
    int regionKind = school.regionKind;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('학교 수정'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: schoolName,
                  decoration: const InputDecoration(
                    labelText: '학교명',
                    hintText: '예: 서울중, 한국고',
                    helperText: '학교명은 "중" 또는 "고"로 끝나야 합니다',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '학교명을 입력하세요';
                    }
                    if (!value.endsWith('중') && !value.endsWith('고')) {
                      return '학교명은 "중" 또는 "고"로 끝나야 합니다';
                    }
                    return null;
                  },
                  onSaved: (value) => schoolName = value!,
                  onChanged: (value) {
                    if (value.endsWith('중')) {
                      setDialogState(() => schoolKind = 1);
                    } else if (value.endsWith('고')) {
                      setDialogState(() => schoolKind = 2);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: schoolKind,
                  decoration: const InputDecoration(
                    labelText: '학교 종류',
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('중학교')),
                    DropdownMenuItem(value: 2, child: Text('고등학교')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => schoolKind = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: regionKind,
                  decoration: const InputDecoration(
                    labelText: '권역',
                  ),
                  items: RegionKind.values.map((v) =>
                    DropdownMenuItem(value: v, child: Text(RegionKind.getName(v)))
                  ).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => regionKind = value);
                    }
                  },
                ),
              ],
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

                  final success = await ref.read(schoolListProvider.notifier).updateSchool(
                    schoolId: school.schoolId,
                    schoolName: schoolName,
                    schoolKind: schoolKind,
                    regionKind: regionKind,
                  );

                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text(success ? '학교가 수정되었습니다' : '학교 수정 실패'),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, School school) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('학교 삭제'),
        content: Text('${school.schoolName}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await ref.read(schoolListProvider.notifier).deleteSchool(school.schoolId);

              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(success ? '학교가 삭제되었습니다' : '삭제 실패'),
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
