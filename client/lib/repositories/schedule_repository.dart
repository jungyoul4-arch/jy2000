import '../core/api/api_client.dart';
import '../models/schedule_category.dart';
import '../models/schedule_event_type.dart';
import '../models/schedule_event.dart';

class ScheduleRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // ============================================================
  // 카테고리 관련
  // ============================================================

  /// 카테고리 목록 조회
  Future<List<ScheduleCategory>> getCategories() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/schedule/categories',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => ScheduleCategory.fromJson(e)).toList();
  }

  // ============================================================
  // 일정 유형 관련
  // ============================================================

  /// 일정 유형 목록 조회
  Future<List<ScheduleEventType>> getEventTypes() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/schedule/event-types',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => ScheduleEventType.fromJson(e)).toList();
  }

  // ============================================================
  // 일정 이벤트 관련
  // ============================================================

  /// 일정 목록 조회
  Future<List<ScheduleEvent>> getEvents({
    String? fromDate,
    String? toDate,
    int? categoryId,
    int? eventTypeId,
    int? studentId,
    int? createdBy,
  }) async {
    final queryParams = <String, dynamic>{
      'perPage': 10000, // 캘린더이므로 큰 값
    };

    if (fromDate != null) queryParams['from_date'] = fromDate;
    if (toDate != null) queryParams['to_date'] = toDate;
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (eventTypeId != null) queryParams['event_type_id'] = eventTypeId;
    if (studentId != null) queryParams['student_id'] = studentId;
    if (createdBy != null) queryParams['created_by'] = createdBy;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/schedule/events',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => ScheduleEvent.fromJson(e)).toList();
  }

  /// 일정 상세 조회
  Future<ScheduleEvent> getEventById(int eventId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/schedule/events/$eventId',
    );

    return ScheduleEvent.fromJson(response['data']);
  }

  /// 일정 등록
  Future<ScheduleEvent> createEvent({
    required int categoryId,
    required int eventTypeId,
    required String eventDate,
    String? content,
    int? studentId,
  }) async {
    final data = <String, dynamic>{
      'category_id': categoryId,
      'event_type_id': eventTypeId,
      'event_date': eventDate,
    };

    if (content != null) data['content'] = content;
    if (studentId != null) data['student_id'] = studentId;

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/schedule/events',
      data: data,
    );

    return ScheduleEvent.fromJson(response['data']);
  }

  /// 일정 수정
  Future<ScheduleEvent> updateEvent(
    int eventId, {
    int? categoryId,
    int? eventTypeId,
    String? eventDate,
    String? content,
    int? studentId,
  }) async {
    final data = <String, dynamic>{};

    if (categoryId != null) data['category_id'] = categoryId;
    if (eventTypeId != null) data['event_type_id'] = eventTypeId;
    if (eventDate != null) data['event_date'] = eventDate;
    if (content != null) data['content'] = content;
    // student_id는 null을 명시적으로 보낼 수 있음
    data['student_id'] = studentId;

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/schedule/events/$eventId',
      data: data,
    );

    return ScheduleEvent.fromJson(response['data']);
  }

  /// 일정 삭제
  Future<void> deleteEvent(int eventId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/schedule/events/$eventId',
    );
  }
}
