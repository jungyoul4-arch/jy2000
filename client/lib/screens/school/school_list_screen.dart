import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/school.dart';
import '../../providers/school_provider.dart';

class SchoolListScreen extends ConsumerStatefulWidget {
  const SchoolListScreen({super.key});

  @override
  ConsumerState<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends ConsumerState<SchoolListScreen> {
  int? _filterKind;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(schoolListProvider.notifier).loadSchools();
    });
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
        ],
      ),
      body: schoolState.isLoading
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
                  : _buildSchoolList(schoolState.schools),
    );
  }

  Widget _buildSchoolList(List<School> schools) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schools.length,
      itemBuilder: (context, index) {
        final school = schools[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: school.schoolKind == 1
                  ? Colors.blue.shade100
                  : Colors.orange.shade100,
              child: Text(
                school.schoolKind == 1 ? '중' : '고',
                style: TextStyle(
                  color: school.schoolKind == 1 ? Colors.blue : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(school.schoolName),
            subtitle: Text('${SchoolKind.getName(school.schoolKind)} | ${RegionKind.getName(school.regionKind)}'),
            trailing: Row(
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
    String schoolName = '';
    int schoolKind = 1;
    int regionKind = 1;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
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
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  Navigator.pop(context);

                  final success = await ref.read(schoolListProvider.notifier).addSchool(
                    schoolName: schoolName,
                    schoolKind: schoolKind,
                    regionKind: regionKind,
                  );

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
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
    String schoolName = school.schoolName;
    int schoolKind = school.schoolKind;
    int regionKind = school.regionKind;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
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
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  Navigator.pop(context);

                  final success = await ref.read(schoolListProvider.notifier).updateSchool(
                    schoolId: school.schoolId,
                    schoolName: schoolName,
                    schoolKind: schoolKind,
                    regionKind: regionKind,
                  );

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('학교 삭제'),
        content: Text('${school.schoolName}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              Navigator.pop(context);

              final success = await ref.read(schoolListProvider.notifier).deleteSchool(school.schoolId);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? '학교가 삭제되었습니다' : '삭제 실패: 해당 학교에 등록된 학생이 있습니다'),
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
