import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 반 목록 조회
  Future<PaginatedResult<ClassModel>> getList(ClassListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.sort != null) queryParams['sort'] = params.sort;
    if (params.order != null) queryParams['order'] = params.order;
    if (params.search != null) queryParams['search'] = params.search;
    if (params.genreId != null) queryParams['genre_id'] = params.genreId;
    if (params.grade != null) queryParams['grade'] = params.grade;
    if (params.level != null) queryParams['level'] = params.level;
    if (params.year != null) queryParams['year'] = params.year;
    if (params.isActive != null) queryParams['is_active'] = params.isActive;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final classes = dataList.map((e) => ClassModel.fromJson(e)).toList();

    final meta = PaginationMeta.fromJson(response['meta'] ?? {
      'total': 0,
      'page': params.page,
      'perPage': params.perPage,
      'totalPages': 0,
    });

    return PaginatedResult(data: classes, meta: meta);
  }

  // 반 상세 조회
  Future<ClassDetail> getById(int classId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class/$classId',
    );

    return ClassDetail.fromJson(response['data']);
  }

  // 반 등록
  Future<ClassDetail> create(ClassCreate data) async {
    final body = data.toJson();
    body.removeWhere((key, value) => value == null);

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/class',
      data: body,
    );

    return ClassDetail.fromJson(response['data']);
  }

  // 반 수정
  Future<ClassDetail> update(int classId, ClassUpdate data) async {
    final body = data.toJson();
    body.removeWhere((key, value) => value == null);

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/class/$classId',
      data: body,
    );

    return ClassDetail.fromJson(response['data']);
  }

  // 반 삭제
  Future<void> delete(int classId) async {
    await _apiClient.delete<Map<String, dynamic>>('/class/$classId');
  }

  // 멤버 추가
  Future<void> addMember(int classId, int userId, int kind) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/class/$classId/member',
      data: {'user_id': userId, 'kind': kind},
    );
  }

  // 멤버 제거
  Future<void> removeMember(int classId, int userId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/class/$classId/member/$userId',
    );
  }

  // 선생님 목록 조회
  Future<List<ClassTeacher>> getTeachers({String? search}) async {
    final queryParams = <String, dynamic>{};
    if (search != null) queryParams['search'] = search;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class/teachers',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => ClassTeacher.fromJson(e)).toList();
  }

  // 사용자 검색 (학생/선생님)
  Future<List<UserSearchResult>> searchUsers(String search, {int? kind}) async {
    final queryParams = <String, dynamic>{'search': search};
    if (kind != null) queryParams['kind'] = kind;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class/search-users',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => UserSearchResult.fromJson(e)).toList();
  }
}
