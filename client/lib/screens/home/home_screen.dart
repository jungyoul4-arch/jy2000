import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = [
    _NavItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: '대시보드',
      path: AppRoutes.home,
    ),
    _NavItem(
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      label: '학생 관리',
      path: AppRoutes.studentList,
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
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      label: '상담 달력',
      path: AppRoutes.calendar,
    ),
  ];

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
      await ref.read(authProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isExtended = MediaQuery.of(context).size.width > 1200;

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
              context.go(_navItems[index].path);
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
                      '상담 관리',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
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
            destinations: _navItems
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
