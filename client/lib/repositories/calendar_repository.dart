import '../core/api/api_client.dart';
import '../models/calendar_event.dart';

class CalendarRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 월별 캘린더 이벤트 조회
  Future<List<CalendarEvent>> getMonthlyEvents(int year, int month) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/calendar/monthly',
      queryParameters: {
        'year': year,
        'month': month,
      },
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => CalendarEvent.fromJson(e)).toList();
  }

  // 특정 날짜 이벤트 조회
  Future<List<CalendarEvent>> getDailyEvents(String date) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/calendar/daily',
      queryParameters: {
        'date': date,
      },
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => CalendarEvent.fromJson(e)).toList();
  }
}
