import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/schedule_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<_NavItem> _getNavItems(int? userKind) {
    // 관리자 여부 (User.kind: 1=관리자, 2=학생, 3=선생님, 4=학부모, 5=상담원)
    final isAdmin = userKind == 1;

    return [
      _NavItem(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: '대시보드',
        path: AppRoutes.home,
      ),
      // 직원 관리 메뉴 - 모든 로그인 사용자에게 표시
      _NavItem(
        icon: Icons.badge_outlined,
        selectedIcon: Icons.badge,
        label: '직원 관리',
        path: AppRoutes.staffList,
      ),
      _NavItem(
        icon: Icons.people_outline,
        selectedIcon: Icons.people,
        label: '학생 관리',
        path: AppRoutes.studentList,
      ),
      _NavItem(
        // 채워진 아이콘 고정: person_search(0xe49c)는 이전 배포본 폰트에도 있는
        // 글리프라 아이콘 폰트가 캐시에 남아 있어도 정상 표시된다.
        icon: Icons.person_search,
        selectedIcon: Icons.person_search,
        label: '신규생 문의',
        path: AppRoutes.newInquiry,
      ),
      _NavItem(
        icon: Icons.chat_outlined,
        selectedIcon: Icons.chat,
        label: '재/퇴원생 상담',
        path: AppRoutes.consultList,
      ),
      _NavItem(
        icon: Icons.event_outlined,
        selectedIcon: Icons.event,
        label: '설명회',
        path: AppRoutes.promotionList,
      ),
      _NavItem(
        icon: Icons.school_outlined,
        selectedIcon: Icons.school,
        label: '학교 관리',
        path: AppRoutes.schoolList,
      ),
      _NavItem(
        icon: Icons.category_outlined,
        selectedIcon: Icons.category,
        label: '반 형태 관리',
        path: AppRoutes.classTypeList,
      ),
      _NavItem(
        icon: Icons.class_outlined,
        selectedIcon: Icons.class_,
        label: '반 관리',
        path: AppRoutes.classList,
      ),
      _NavItem(
        icon: Icons.table_chart_outlined,
        selectedIcon: Icons.table_chart,
        label: '일정 캘린더',
        path: AppRoutes.scheduleCalendar,
      ),
      _NavItem(
        icon: Icons.analytics_outlined,
        selectedIcon: Icons.analytics,
        label: '경영 데이터',
        path: AppRoutes.mgmtDataList,
      ),
      // 경영 보고서 - 관리자(kind=1)에게만 표시
      if (isAdmin)
        _NavItem(
          icon: Icons.assessment_outlined,
          selectedIcon: Icons.assessment,
          label: '경영 보고서',
          path: AppRoutes.mgmtReport,
        ),
    ];
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
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

  /// 주소와 맞는 메뉴를 고른다. 더 긴 경로가 우선이라
  /// `/class-types` 가 `/classes` 로 붙지 않는다.
  int _selectedIndexFor(String location, List<_NavItem> items) {
    var bestIndex = 0;
    var bestLength = -1;
    for (var i = 0; i < items.length; i++) {
      final path = items[i].path;
      final matches = path == AppRoutes.home
          ? location == AppRoutes.home || location == AppRoutes.dashboard
          : location == path || location.startsWith('$path/');
      if (matches && path.length > bestLength) {
        bestIndex = i;
        bestLength = path.length;
      }
    }
    return bestIndex;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isExtended = MediaQuery.of(context).size.width > 1200;
    final navItems = _getNavItems(authState.user?.kind);
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _selectedIndexFor(location, navItems);

    return Scaffold(
      body: Row(
        children: [
          _Sidebar(
            extended: isExtended,
            items: navItems,
            selectedIndex: selectedIndex,
            userName: authState.user?.name,
            onSelected: (index) => context.go(navItems[index].path),
            onLogout: _logout,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

/// 메뉴가 창 높이보다 길어도 잘리지 않게 스크롤된다.
/// NavigationRail 은 목적지가 많으면 아래로 넘친다.
class _Sidebar extends StatelessWidget {
  final bool extended;
  final List<_NavItem> items;
  final int selectedIndex;
  final String? userName;
  final ValueChanged<int> onSelected;
  final VoidCallback onLogout;

  const _Sidebar({
    required this.extended,
    required this.items,
    required this.selectedIndex,
    required this.userName,
    required this.onSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = extended ? 220.0 : 72.0;

    return SizedBox(
      width: width,
      child: Material(
        color: scheme.surface,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Icon(Icons.school, size: 32, color: scheme.primary),
                  if (extended) ...[
                    const SizedBox(height: 8),
                    Text(
                      '학원 관리',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'v${AppConfig.appVersion}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final selected = index == selectedIndex;
                  final icon = Icon(selected ? item.selectedIcon : item.icon);
                  if (!extended) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: IconButton(
                        tooltip: item.label,
                        isSelected: selected,
                        color: selected ? scheme.primary : null,
                        onPressed: () => onSelected(index),
                        icon: icon,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: ListTile(
                      selected: selected,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      leading: icon,
                      title: Text(item.label),
                      onTap: () => onSelected(index),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (extended && userName != null) ...[
                    Text(
                      userName!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout),
                      label: const Text('로그아웃'),
                    ),
                  ] else
                    IconButton(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout),
                      tooltip: '로그아웃',
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

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String path;

  _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.path,
  });
}
