import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/staff.dart';
import '../providers/staff_provider.dart';

/// 상담자(관리자/상담원/선생님 등) 선택 필드.
///
/// 탭하면 검색 가능한 선택 다이얼로그가 열린다. 후보 목록은 `/staff/list`
/// (kind IN 1,3,5,6,7)를 사용하므로 학생/학부모는 애초에 포함되지 않는다.
class TcPickerField extends ConsumerWidget {
  /// 현재 선택된 상담자 ID
  final int? tcId;

  /// 현재 선택된 상담자명 (표시용)
  final String? tcName;

  /// 선택이 바뀌면 호출된다
  final ValueChanged<Staff> onChanged;

  /// 라벨 표시 여부 (false면 입력 필드만)
  final bool showLabel;

  /// 비활성화 (읽기 전용)
  final bool enabled;

  const TcPickerField({
    super.key,
    required this.tcId,
    required this.tcName,
    required this.onChanged,
    this.showLabel = true,
    this.enabled = true,
  });

  Future<void> _showPicker(BuildContext context) async {
    final searchController = TextEditingController();

    final selected = await showDialog<Staff>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('상담자 선택'),
        content: SizedBox(
          width: 400,
          child: Consumer(
            builder: (context, ref, _) {
              final staffAsync = ref.watch(consultantListProvider);

              return staffAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: SelectableText('상담자 목록 로드 실패: $err'),
                ),
                data: (staffList) => StatefulBuilder(
                  builder: (context, setInnerState) {
                    final keyword = searchController.text.trim();
                    final filtered = keyword.isEmpty
                        ? staffList
                        : staffList
                            .where((s) =>
                                s.name.contains(keyword) ||
                                s.phone.contains(keyword))
                            .toList();

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: searchController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: '이름 또는 전화번호 검색...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (_) => setInnerState(() {}),
                        ),
                        const SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 320),
                          child: filtered.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Text('검색 결과가 없습니다'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filtered.length,
                                  itemBuilder: (context, index) {
                                    final staff = filtered[index];
                                    final isSelected = staff.userId == tcId;

                                    return ListTile(
                                      dense: true,
                                      selected: isSelected,
                                      leading: const Icon(
                                        Icons.person_outline,
                                        size: 18,
                                      ),
                                      title: Text(staff.name),
                                      subtitle: Text(staff.kindName),
                                      trailing: isSelected
                                          ? const Icon(Icons.check,
                                              color: Colors.blue, size: 18)
                                          : null,
                                      onTap: () =>
                                          Navigator.pop(dialogContext, staff),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
        ],
      ),
    );

    searchController.dispose();

    if (selected != null) {
      onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final field = InkWell(
      onTap: enabled ? () => _showPicker(context) : null,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        child: Row(
          children: [
            const Icon(Icons.support_agent, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                tcName ?? '상담자를 선택하세요',
                style: TextStyle(
                  color: tcName == null ? Colors.grey.shade600 : Colors.black,
                ),
              ),
            ),
            if (enabled) const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );

    if (!showLabel) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('상담자', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        field,
      ],
    );
  }
}
