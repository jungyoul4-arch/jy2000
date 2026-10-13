import '../core/api/api_client.dart';
import '../models/school.dart';

class SchoolRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 학교 목록 조회
  // 기본은 활성 학교만 온다. 삭제한 학교를 되살리려면 includeInactive로
  // 꺼내 봐야 한다.
  Future<List<School>> getList({
    String? search,
    int? schoolKind,
    int? regionKind,
    bool includeInactive = false,
  }) async {
    final queryParams = <String, dynamic>{
      'perPage': 1000, // 전체 목록 가져오기
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (schoolKind != null) {
      queryParams['school_kind'] = schoolKind.toString();
    }
    if (regionKind != null) {
      queryParams['region_kind'] = regionKind.toString();
    }
    if (includeInactive) {
      queryParams['include_inactive'] = 'true';
    }

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/school/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => School.fromJson(e)).toList();
  }

  // 지운 학교 되살리기
  Future<School> restore(int schoolId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/school/$schoolId/restore',
    );

    return School.fromJson(response['data']);
  }

  // 학교 상세 조회
  Future<School> getById(int schoolId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/school/$schoolId',
    );

    return School.fromJson(response['data']);
  }

  // 학교 생성
  Future<School> create({
    required String schoolName,
    required int schoolKind,
    required int regionKind,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/school',
      data: {
        'school_name': schoolName,
        'school_kind': schoolKind,
        'region_kind': regionKind,
      },
    );

    return School.fromJson(response['data']);
  }

  // 학교 수정
  Future<School> update(int schoolId, {
    String? schoolName,
    int? schoolKind,
    int? regionKind,
  }) async {
    final data = <String, dynamic>{};
    if (schoolName != null) data['school_name'] = schoolName;
    if (schoolKind != null) data['school_kind'] = schoolKind;
    if (regionKind != null) data['region_kind'] = regionKind;

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/school/$schoolId',
      data: data,
    );

    return School.fromJson(response['data']);
  }

  // 학교 삭제
  Future<void> delete(int schoolId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/school/$schoolId',
    );
  }
}
