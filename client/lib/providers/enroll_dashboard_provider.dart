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

/// 화면에서 고른 기간.
///
/// 기본값은 '현재' — 저장된 월 스냅샷이 아니라 조회 시점의 DB를 집계한다.
/// 월 스냅샷은 매월 1일 cron이 전월을 굳히므로 이번 달은 비어 있는데,
/// 원장이 가장 자주 보는 건 지금 수치라 그쪽을 기본으로 둔다.
class EnrollPeriod {
  final bool isCurrent;
  final int? year;
  final int? month;

  const EnrollPeriod.current()
      : isCurrent = true,
        year = null,
        month = null;

  const EnrollPeriod.month(this.year, this.month) : isCurrent = false;

  @override
  bool operator ==(Object other) =>
      other is EnrollPeriod &&
      other.isCurrent == isCurrent &&
      other.year == year &&
      other.month == month;

  @override
  int get hashCode => Object.hash(isCurrent, year, month);
}

final enrollPeriodProvider =
    StateProvider<EnrollPeriod>((ref) => const EnrollPeriod.current());

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
    current: period.isCurrent,
    year: period.year,
    month: period.month,
    grade: grade,
  );
});
