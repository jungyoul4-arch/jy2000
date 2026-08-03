import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/schedule_provider.dart';

/// 모든 화면의 AppBar에 공통으로 들어가는 로그아웃 버튼.
///
/// 화면 폭이 좁으면 아이콘만, 넓으면 사용자 이름과 '로그아웃' 라벨을 함께 표시한다.
class LogoutButton extends ConsumerWidget {
  /// 사용자 이름 표시 여부 (기본: 화면 폭이 충분할 때만 표시)
  final bool showUserName;

  const LogoutButton({super.key, this.showUserName = true});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // 일정 캘린더의 선택 날짜를 초기화 (다음 로그인 시 오늘 날짜부터 시작)
      ref.invalidate(scheduleEventsProvider);
      await ref.read(authProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    // 좁은 화면에서는 아이콘 버튼만 표시
    final isWide = MediaQuery.of(context).size.width > 900;

    if (!isWide) {
      return IconButton(
        onPressed: () => _logout(context, ref),
        icon: const Icon(Icons.logout),
        tooltip: '로그아웃',
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showUserName && user != null) ...[
          const SizedBox(width: 8),
          Text(
            user.name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
        const SizedBox(width: 4),
        TextButton.icon(
          onPressed: () => _logout(context, ref),
          icon: const Icon(Icons.logout, size: 18),
          label: const Text('로그아웃'),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
