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
import '../screens/consult/consult_detail_screen.dart';
import '../screens/consult/new_inquiry_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/promotion/promotion_list_screen.dart';
import '../screens/promotion/promotion_form_screen.dart';
import '../screens/promotion/promotion_detail_screen.dart';
import '../screens/school/school_list_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/class/class_list_screen.dart';
import '../screens/class/class_detail_screen.dart';
import '../screens/class/class_form_screen.dart';
import '../screens/staff/staff_list_screen.dart';
import '../screens/class_type/class_type_list_screen.dart';
import '../screens/mgmt_data/mgmt_data_list_screen.dart';
import '../screens/mgmt_report/mgmt_report_screen.dart';
import '../screens/mgmt_report/region_report_screen.dart';
import '../screens/schedule/schedule_calendar_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String staffList = '/staff';
  static const String studentList = '/students';
  static const String studentDetail = '/students/:id';
  static const String studentCreate = '/students/create';
  static const String consultList = '/consults';
  static const String consultCreate = '/consults/create';
  static const String consultDetail = '/consults/:id';
  static const String newInquiry = '/new-inquiry';
  static const String promotionList = '/promotions';
  static const String promotionCreate = '/promotions/create';
  static const String promotionDetail = '/promotions/:id';
  static const String schoolList = '/schools';
  static const String classTypeList = '/class-types';
  static const String calendar = '/calendar';
  static const String classList = '/classes';
  static const String classDetail = '/classes/:id';
  static const String classCreate = '/classes/create';
  static const String classEdit = '/classes/:id/edit';
  static const String mgmtDataList = '/mgmt-data';
  static const String mgmtReport = '/mgmt-report';
  static const String mgmtReportRegion = '/mgmt-report/region';
  static const String scheduleCalendar = '/schedule';
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

          // 직원 관리 (관리자만)
          GoRoute(
            path: AppRoutes.staffList,
            name: 'staffList',
            builder: (context, state) => const StaffListScreen(),
          ),

          // 학생 관리
          GoRoute(
            path: AppRoutes.studentList,
            name: 'studentList',
            builder: (context, state) {
              final schoolIdStr = state.uri.queryParameters['schoolId'];
              final schoolName = state.uri.queryParameters['schoolName'];
              final schoolId = schoolIdStr != null ? int.tryParse(schoolIdStr) : null;
              return StudentListScreen(
                key: ValueKey('students_${schoolId ?? 'all'}'),
                initialSchoolId: schoolId,
                initialSchoolName: schoolName,
              );
            },
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

          // 신규생 문의 (상담 관리와 분리된 독립 메뉴)
          GoRoute(
            path: AppRoutes.newInquiry,
            name: 'newInquiry',
            builder: (context, state) => const NewInquiryScreen(),
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
              final dateStr = state.uri.queryParameters['date'];
              DateTime? initialDate;
              if (dateStr != null) {
                initialDate = DateTime.tryParse(dateStr);
              }
              return ConsultFormScreen(
                studentId: studentId != null ? int.parse(studentId) : null,
                initialDate: initialDate,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.consultDetail,
            name: 'consultDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ConsultDetailScreen(consultId: id);
            },
          ),

          // 프로모션 관리
          GoRoute(
            path: AppRoutes.promotionList,
            name: 'promotionList',
            builder: (context, state) => const PromotionListScreen(),
          ),
          GoRoute(
            path: AppRoutes.promotionCreate,
            name: 'promotionCreate',
            builder: (context, state) {
              final dateStr = state.uri.queryParameters['date'];
              DateTime? initialDate;
              if (dateStr != null) {
                initialDate = DateTime.tryParse(dateStr);
              }
              return PromotionFormScreen(initialDate: initialDate);
            },
          ),
          GoRoute(
            path: AppRoutes.promotionDetail,
            name: 'promotionDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return PromotionDetailScreen(promotionId: id);
            },
          ),

          // 학교 관리
          GoRoute(
            path: AppRoutes.schoolList,
            name: 'schoolList',
            builder: (context, state) => const SchoolListScreen(),
          ),

          // 상담 달력
          GoRoute(
            path: AppRoutes.calendar,
            name: 'calendar',
            builder: (context, state) => const CalendarScreen(),
          ),

          // 반 형태 관리
          GoRoute(
            path: AppRoutes.classTypeList,
            name: 'classTypeList',
            builder: (context, state) => const ClassTypeListScreen(),
          ),

          // 반 관리
          GoRoute(
            path: AppRoutes.classList,
            name: 'classList',
            builder: (context, state) => const ClassListScreen(),
          ),
          GoRoute(
            path: AppRoutes.classCreate,
            name: 'classCreate',
            builder: (context, state) => const ClassFormScreen(),
          ),
          GoRoute(
            path: AppRoutes.classEdit,
            name: 'classEdit',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ClassFormScreen(classId: id);
            },
          ),
          GoRoute(
            path: AppRoutes.classDetail,
            name: 'classDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ClassDetailScreen(classId: id);
            },
          ),

          // 경영 데이터
          GoRoute(
            path: AppRoutes.mgmtDataList,
            name: 'mgmtDataList',
            builder: (context, state) => const MgmtDataListScreen(),
          ),

          // 경영 보고서
          GoRoute(
            path: AppRoutes.mgmtReport,
            name: 'mgmtReport',
            builder: (context, state) => const MgmtReportScreen(),
          ),

          // 지역별 보고서
          GoRoute(
            path: AppRoutes.mgmtReportRegion,
            name: 'mgmtReportRegion',
            builder: (context, state) => const RegionReportScreen(),
          ),

          // 일정 캘린더
          GoRoute(
            path: AppRoutes.scheduleCalendar,
            name: 'scheduleCalendar',
            builder: (context, state) => const ScheduleCalendarScreen(),
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

      // 경영 보고서는 관리자(kind=1) 전용 - URL 직접 접근 차단
      if (isLoggedIn &&
          state.matchedLocation.startsWith(AppRoutes.mgmtReport) &&
          authState.user?.kind != 1) {
        return AppRoutes.home;
      }

      return null;
    },
  );
});
