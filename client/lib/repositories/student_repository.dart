import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/student.dart';

class StudentRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 학생 목록 조회
  Future<PaginatedResult<Student>> getList(StudentListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.sort != null) queryParams['sort'] = params.sort;
    if (params.order != null) queryParams['order'] = params.order;
    if (params.search != null) queryParams['search'] = params.search;
    if (params.statusCode != null) queryParams['status_code'] = params.statusCode;
    if (params.grade != null) queryParams['grade'] = params.grade;
    if (params.tcId != null) queryParams['tc_id'] = params.tcId;
    if (params.fromDate != null) queryParams['from_date'] = params.fromDate;
    if (params.toDate != null) queryParams['to_date'] = params.toDate;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/student/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final students = dataList.map((e) => Student.fromJson(e)).toList();

    final meta = PaginationMeta.fromJson(response['meta'] ?? {
      'total': 0,
      'page': params.page,
      'perPage': params.perPage,
      'totalPages': 0,
    });

    return PaginatedResult(data: students, meta: meta);
  }

  // 학생 상세 조회
  Future<Student> getById(int studentId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/student/$studentId',
    );

    return Student.fromJson(response['data']);
  }

  // 학생 상태 변경
  Future<Student> changeState(StudentStateChange data) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/student/state',
      data: {
        'student_id': data.studentId,
        'new_status_code': data.newStatusCode,
        if (data.newSubStatusCode != null)
          'new_sub_status_code': data.newSubStatusCode,
        if (data.changeReason != null)
          'change_reason': data.changeReason,
        if (data.newTcId != null)
          'new_tc_id': data.newTcId,
      },
    );

    return Student.fromJson(response['data']);
  }
}
