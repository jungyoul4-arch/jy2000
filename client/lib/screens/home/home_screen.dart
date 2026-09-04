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
  int _selectedIndex = 0;

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
        label: '상담 관리',
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isExtended = MediaQuery.of(context).size.width > 1200;
    final navItems = _getNavItems(authState.user?.kind);

    return Scaffold(
      body: Row(
        children: [
          // 사이드바
          NavigationRail(
            extended: isExtended,
            minExtendedWidth: 200,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
              context.go(navItems[index].path);
            },
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(
                    Icons.school,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  if (isExtended) ...[
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
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isExtended && authState.user != null) ...[
                        Text(
                          authState.user!.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                      ],
                      isExtended
                          ? TextButton.icon(
                              onPressed: _logout,
                              icon: const Icon(Icons.logout),
                              label: const Text('로그아웃'),
                            )
                          : IconButton(
                              onPressed: _logout,
                              icon: const Icon(Icons.logout),
                              tooltip: '로그아웃',
                            ),
                    ],
                  ),
                ),
              ),
            ),
            destinations: navItems
                .map(
                  (item) => NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(item.label),
                  ),
                )
                .toList(),
          ),

          // Divider
          const VerticalDivider(thickness: 1, width: 1),

          // Main Content
          Expanded(
            child: widget.child,
          ),
        ],
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
