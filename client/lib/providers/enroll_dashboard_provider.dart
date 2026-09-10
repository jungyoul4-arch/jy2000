import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enroll_dashboard.dart';
import '../repositories/enroll_dashboard_repository.dart';

final enrollDashboardRepositoryProvider =
    Provider((ref) => EnrollDashboardRepository());

/// 스냅샷이 있는 년월 목록. 월 선택기가 쓴다.
final enrollMonthsProvider = FutureProvider<List<EnrollMonth>>((ref) async {
  final repository = ref.read(enrollDashboardRepositoryProvider);
  return repository.getMonths();
});

/// 월별 추이. 월을 바꿔도 그대로라 따로 둔다.
final enrollTrendProvider = FutureProvider<List<EnrollTrendPoint>>((ref) async {
  final repository = ref.read(enrollDashboardRepositoryProvider);
  return repository.getTrend();
});

/// 화면에서 고른 년월. null이면 서버가 최근 달을 고른다.
class EnrollPeriod {
  final int? year;
  final int? month;

  const EnrollPeriod({this.year, this.month});

  @override
  bool operator ==(Object other) =>
      other is EnrollPeriod && other.year == year && other.month == month;

  @override
  int get hashCode => Object.hash(year, month);
}

final enrollPeriodProvider = StateProvider<EnrollPeriod>((ref) => const EnrollPeriod());

/// 학년 필터. null이면 전체.
final enrollGradeFilterProvider = StateProvider<int?>((ref) => null);

/// 선택한 년월·학년의 대시보드.
///
/// 년월이나 학년이 바뀌면 자동으로 다시 받는다.
final enrollDashboardProvider = FutureProvider<EnrollDashboard?>((ref) async {
  final period = ref.watch(enrollPeriodProvider);
  final grade = ref.watch(enrollGradeFilterProvider);
  final repository = ref.read(enrollDashboardRepositoryProvider);

  return repository.getDashboard(
    year: period.year,
    month: period.month,
    grade: grade,
  );
});
