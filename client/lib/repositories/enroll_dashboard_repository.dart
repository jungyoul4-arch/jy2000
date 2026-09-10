import '../core/api/api_client.dart';
import '../models/enroll_dashboard.dart';

/// 재원생 경영 대시보드 조회
///
/// 서버가 한 달치를 통째로 집계해 내려 준다. 카드마다 따로 부르면
/// 왕복이 열 번을 넘어서 한 번에 받는다.
class EnrollDashboardRepository {
  final ApiClient _apiClient = ApiClient.instance;

  /// 스냅샷이 있는 년월 목록
  Future<List<EnrollMonth>> getMonths() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/enroll-dashboard/months',
    );

    final List<dynamic> data = response['data'] ?? [];
    return data
        .whereType<Map>()
        .map((e) => EnrollMonth.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// 월별 추이 (전 기간)
  Future<List<EnrollTrendPoint>> getTrend() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/enroll-dashboard/trend',
    );

    final List<dynamic> data = response['data'] ?? [];
    return data
        .whereType<Map>()
        .map((e) => EnrollTrendPoint.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// 한 달치 대시보드. 년월을 안 주면 서버가 최근 달을 고른다.
  Future<EnrollDashboard?> getDashboard({
    int? year,
    int? month,
    int? grade,
  }) async {
    final query = <String, dynamic>{};
    if (year != null) query['year'] = year;
    if (month != null) query['month'] = month;
    if (grade != null) query['grade'] = grade;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/enroll-dashboard',
      queryParameters: query.isEmpty ? null : query,
    );

    final data = response['data'];
    // 스냅샷이 하나도 없으면 서버가 null을 준다.
    if (data is! Map) return null;

    return EnrollDashboard.fromJson(Map<String, dynamic>.from(data));
  }
}
