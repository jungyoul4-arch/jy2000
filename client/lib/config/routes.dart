import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/student/student_list_screen.dart';
import '../screens/student/student_detail_screen.dart';
import '../screens/student/student_form_screen.dart';
import '../screens/consult/consult_list_screen.dart';
import '../screens/consult/consult_form_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/promotion/promotion_list_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String studentList = '/students';
  static const String studentDetail = '/students/:id';
  static const String studentCreate = '/students/create';
  static const String consultList = '/consults';
  static const String consultCreate = '/consults/create';
  static const String promotionList = '/promotions';
}

// GoRouter Refresh Notifier
class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) {
      notifyListeners();
    });
  }
}

// GoRouter Provider
final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = GoRouterRefreshNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    routes: [
      // 로그인
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // 메인 쉘 (사이드바 포함)
      ShellRoute(
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          // 대시보드
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),

          // 학생 관리
          GoRoute(
            path: AppRoutes.studentList,
            name: 'studentList',
            builder: (context, state) => const StudentListScreen(),
          ),
          GoRoute(
            path: AppRoutes.studentCreate,
            name: 'studentCreate',
            builder: (context, state) => const StudentFormScreen(),
          ),
          GoRoute(
            path: AppRoutes.studentDetail,
            name: 'studentDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return StudentDetailScreen(studentId: id);
            },
          ),

          // 상담 관리
          GoRoute(
            path: AppRoutes.consultList,
            name: 'consultList',
            builder: (context, state) => const ConsultListScreen(),
          ),
          GoRoute(
            path: AppRoutes.consultCreate,
            name: 'consultCreate',
            builder: (context, state) {
              final studentId = state.uri.queryParameters['studentId'];
              return ConsultFormScreen(
                studentId: studentId != null ? int.parse(studentId) : null,
              );
            },
          ),

          // 프로모션 관리
          GoRoute(
            path: AppRoutes.promotionList,
            name: 'promotionList',
            builder: (context, state) => const PromotionListScreen(),
          ),
        ],
      ),
    ],

    // 에러 페이지
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),

    // 리다이렉트 (인증 체크)
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoading = authState.status == AuthStatus.initial;
      final isLoggedIn = authState.status == AuthStatus.authenticated;
      final isOnLoginPage = state.matchedLocation == AppRoutes.login;

      // 초기 로딩 중 - 로그인 페이지에 머무름
      if (isLoading) {
        return isOnLoginPage ? null : AppRoutes.login;
      }

      // 로그인 안됨 + 로그인 페이지 아님 -> 로그인 페이지로
      if (!isLoggedIn && !isOnLoginPage) {
        return AppRoutes.login;
      }

      // 로그인 됨 + 로그인 페이지 -> 홈으로
      if (isLoggedIn && isOnLoginPage) {
        return AppRoutes.home;
      }

      return null;
    },
  );
});
