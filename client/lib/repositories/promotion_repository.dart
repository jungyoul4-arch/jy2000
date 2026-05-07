import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/promotion.dart';

class PromotionRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 프로모션 목록 조회
  Future<PaginatedResult<Promotion>> getList(PromotionListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.sort != null) queryParams['sort'] = params.sort;
    if (params.order != null) queryParams['order'] = params.order;
    if (params.search != null) queryParams['search'] = params.search;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/promotion/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final promotions = dataList.map((e) => Promotion.fromJson(e)).toList();

    final meta = PaginationMeta.fromJson(response['meta'] ?? {
      'total': 0,
      'page': params.page,
      'perPage': params.perPage,
      'totalPages': 0,
    });

    return PaginatedResult(data: promotions, meta: meta);
  }

  // 프로모션 등록
  Future<Promotion> create(PromotionCreate data) async {
    final jsonData = data.toJson()..removeWhere((key, value) => value == null);

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/promotion',
      data: jsonData,
    );

    return Promotion.fromJson(response['data']);
  }

  // 프로모션 상세 조회
  Future<Promotion> getById(int promotionId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/promotion/$promotionId',
    );

    return Promotion.fromJson(response['data']);
  }

  // 프로모션 수정
  Future<Promotion> update(int promotionId, PromotionCreate data) async {
    final jsonData = data.toJson()..removeWhere((key, value) => value == null);

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/promotion/$promotionId',
      data: jsonData,
    );

    return Promotion.fromJson(response['data']);
  }

  // 참석자 목록 조회
  Future<List<PromotionAttendee>> getAttendees(int promotionId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/promotion/$promotionId/attendees',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => PromotionAttendee.fromJson(e)).toList();
  }

  // 신규 학생 생성 및 참석자 등록
  Future<void> addNewAttendee(int promotionId, NewAttendeeData data) async {
    final jsonData = data.toJson()..removeWhere((key, value) => value == null);

    await _apiClient.post<Map<String, dynamic>>(
      '/promotion/$promotionId/attendees/new',
      data: jsonData,
    );
  }

  // 기존 학생 참석자 등록
  Future<void> addExistingAttendee(int promotionId, int studentId, String? memo) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/promotion/$promotionId/attendees',
      data: {
        'student_id': studentId,
        if (memo != null) 'memo': memo,
      },
    );
  }

  // 참석자 삭제
  Future<void> removeAttendee(int promotionId, int attendeeId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/promotion/$promotionId/attendees/$attendeeId',
    );
  }

  // User 테이블에서 학생 검색
  Future<List<UserSearchResult>> searchUsers(String query) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/promotion/search-users',
      queryParameters: {'q': query},
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => UserSearchResult.fromJson(e)).toList();
  }
}
