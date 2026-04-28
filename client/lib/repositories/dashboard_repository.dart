import '../core/api/api_client.dart';
import '../models/dashboard.dart';

class DashboardRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // KPI 조회
  Future<DashboardKPI> getKPI() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/dashboard/kpi',
    );

    return DashboardKPI.fromJson(response['data']);
  }

  // 퍼널 데이터 조회
  Future<List<FunnelData>> getFunnel() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/dashboard/funnel',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => FunnelData.fromJson(e)).toList();
  }

  // TC별 실적 조회
  Future<List<TCPerformance>> getTCPerformance() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/dashboard/tc-performance',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => TCPerformance.fromJson(e)).toList();
  }

  // 월별 추이 조회
  Future<List<MonthlyTrend>> getMonthlyTrend({int months = 6}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/dashboard/monthly-trend',
      queryParameters: {'months': months},
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => MonthlyTrend.fromJson(e)).toList();
  }
}
