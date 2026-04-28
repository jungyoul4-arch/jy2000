import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      // 로그인
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // 메인 쉘 (사이드바 포함)
      ShellRoute(
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          // 대시보드
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),

          // 학생 관리
          GoRoute(
            path: studentList,
            name: 'studentList',
            builder: (context, state) => const StudentListScreen(),
          ),
          GoRoute(
            path: studentCreate,
            name: 'studentCreate',
            builder: (context, state) => const StudentFormScreen(),
          ),
          GoRoute(
            path: studentDetail,
            name: 'studentDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return StudentDetailScreen(studentId: id);
            },
          ),

          // 상담 관리
          GoRoute(
            path: consultList,
            name: 'consultList',
            builder: (context, state) => const ConsultListScreen(),
          ),
          GoRoute(
            path: consultCreate,
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
            path: promotionList,
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
      // TODO: 인증 상태 확인 후 리다이렉트
      // final isLoggedIn = ...;
      // if (!isLoggedIn && state.matchedLocation != login) {
      //   return login;
      // }
      return null;
    },
  );
}
