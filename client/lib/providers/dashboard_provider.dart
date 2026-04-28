import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dashboard.dart';
import '../repositories/dashboard_repository.dart';

// Repository Provider
final dashboardRepositoryProvider = Provider((ref) => DashboardRepository());

// KPI Provider
final kpiProvider = FutureProvider<DashboardKPI>((ref) async {
  final repository = ref.read(dashboardRepositoryProvider);
  return repository.getKPI();
});

// 퍼널 Provider
final funnelProvider = FutureProvider<List<FunnelData>>((ref) async {
  final repository = ref.read(dashboardRepositoryProvider);
  return repository.getFunnel();
});

// TC 실적 Provider
final tcPerformanceProvider = FutureProvider<List<TCPerformance>>((ref) async {
  final repository = ref.read(dashboardRepositoryProvider);
  return repository.getTCPerformance();
});

// 월별 추이 Provider
final monthlyTrendProvider = FutureProvider<List<MonthlyTrend>>((ref) async {
  final repository = ref.read(dashboardRepositoryProvider);
  return repository.getMonthlyTrend();
});

// 대시보드 전체 데이터 Provider
class DashboardData {
  final DashboardKPI? kpi;
  final List<FunnelData> funnel;
  final List<TCPerformance> tcPerformance;
  final List<MonthlyTrend> monthlyTrend;
  final bool isLoading;
  final String? error;

  DashboardData({
    this.kpi,
    this.funnel = const [],
    this.tcPerformance = const [],
    this.monthlyTrend = const [],
    this.isLoading = false,
    this.error,
  });
}

class DashboardNotifier extends StateNotifier<DashboardData> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(DashboardData());

  Future<void> loadAll() async {
    state = DashboardData(isLoading: true);

    try {
      final results = await Future.wait([
        _repository.getKPI(),
        _repository.getFunnel(),
        _repository.getTCPerformance(),
        _repository.getMonthlyTrend(),
      ]);

      state = DashboardData(
        kpi: results[0] as DashboardKPI,
        funnel: results[1] as List<FunnelData>,
        tcPerformance: results[2] as List<TCPerformance>,
        monthlyTrend: results[3] as List<MonthlyTrend>,
        isLoading: false,
      );
    } catch (e) {
      state = DashboardData(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() => loadAll();
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardData>((ref) {
  return DashboardNotifier(ref.read(dashboardRepositoryProvider));
});
