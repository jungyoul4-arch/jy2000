import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/staff.dart';

class StaffRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 직원 목록 조회
  Future<PaginatedResult<Staff>> getList(StaffListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.sort != null) queryParams['sort'] = params.sort;
    if (params.order != null) queryParams['order'] = params.order;
    if (params.search != null && params.search!.isNotEmpty) {
      queryParams['search'] = params.search;
    }

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/staff/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final staffList = dataList.map((e) => Staff.fromJson(e)).toList();

    final meta = PaginationMeta.fromJson(response['meta'] ?? {
      'total': 0,
      'page': params.page,
      'perPage': params.perPage,
      'totalPages': 0,
    });

    return PaginatedResult(data: staffList, meta: meta);
  }

  // 직원 상세 조회
  Future<Staff> getById(int userId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/staff/$userId',
    );

    return Staff.fromJson(response['data']);
  }

  // 직원 등록
  Future<Staff> create(StaffCreate data) async {
    final body = <String, dynamic>{
      'name': data.name,
      'phone': data.phone,
      'kind': data.kind,
    };

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/staff',
      data: body,
    );

    return Staff.fromJson(response['data']);
  }

  // 직원 수정
  Future<Staff> update(int userId, StaffCreate data) async {
    final body = <String, dynamic>{
      'name': data.name,
      'phone': data.phone,
      'kind': data.kind,
    };

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/staff/$userId',
      data: body,
    );

    return Staff.fromJson(response['data']);
  }

  // 직원 활성/비활성 토글
  Future<Staff> toggleActive(int userId) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/staff/$userId/toggle-active',
    );

    return Staff.fromJson(response['data']);
  }

  // 직원 삭제
  Future<void> delete(int userId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/staff/$userId',
    );
  }
}
