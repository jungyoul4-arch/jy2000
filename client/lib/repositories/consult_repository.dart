import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/consult.dart';

class ConsultRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 상담 목록 조회
  Future<PaginatedResult<Consult>> getList(ConsultListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.sort != null) queryParams['sort'] = params.sort;
    if (params.order != null) queryParams['order'] = params.order;
    if (params.search != null) queryParams['search'] = params.search;
    if (params.studentId != null) queryParams['student_id'] = params.studentId;
    if (params.tcId != null) queryParams['tc_id'] = params.tcId;
    if (params.consultTypeCode != null) {
      queryParams['consult_type_code'] = params.consultTypeCode;
    }
    if (params.consultResultCode != null) {
      queryParams['consult_result_code'] = params.consultResultCode;
    }
    if (params.fromDate != null) queryParams['from_date'] = params.fromDate;
    if (params.toDate != null) queryParams['to_date'] = params.toDate;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/consult/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final consults = dataList.map((e) => Consult.fromJson(e)).toList();

    final meta = PaginationMeta.fromJson(response['meta'] ?? {
      'total': 0,
      'page': params.page,
      'perPage': params.perPage,
      'totalPages': 0,
    });

    return PaginatedResult(data: consults, meta: meta);
  }

  // 상담 등록
  Future<Consult> create(ConsultCreate data) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/consult',
      data: data.toJson(),
    );

    return Consult.fromJson(response['data']);
  }
}
