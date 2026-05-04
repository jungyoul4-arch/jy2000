import '../core/api/api_client.dart';
import '../core/api/api_response.dart';
import '../models/student.dart';

class StudentRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 학생 신규 등록
  Future<Student> create(StudentCreate data) async {
    final body = <String, dynamic>{
      'student_name': data.studentName,
      'phone': data.phone,
    };

    if (data.email != null) body['email'] = data.email;
    if (data.birthDate != null) body['birth_date'] = data.birthDate;
    if (data.genderCode != null) body['gender_code'] = data.genderCode;
    if (data.schoolId != null) body['school_id'] = data.schoolId;
    if (data.schoolName != null) body['school_name'] = data.schoolName;
    if (data.grade != null) body['grade'] = data.grade;
    if (data.statusCode != null) body['status_code'] = data.statusCode;
    if (data.sourceCode != null) body['source_code'] = data.sourceCode;
    if (data.sourceDetail != null) body['source_detail'] = data.sourceDetail;
    if (data.tcId != null) body['tc_id'] = data.tcId;
    if (data.memo != null) body['memo'] = data.memo;
    if (data.guardianName != null) body['guardian_name'] = data.guardianName;
    if (data.guardianPhone != null) body['guardian_phone'] = data.guardianPhone;
    if (data.parentKind != null) body['parent_kind'] = data.parentKind;

    final response = await _apiClient.post<Map<String, dynamic>>(
      '/student',
      data: body,
    );

    return Student.fromJson(response['data']);
  }

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

  // 학생 정보 업데이트
  Future<Student> update(int studentId, StudentUpdate data) async {
    final body = <String, dynamic>{};

    if (data.studentName != null) body['student_name'] = data.studentName;
    if (data.phone != null) body['phone'] = data.phone;
    if (data.email != null) body['email'] = data.email;
    if (data.birthDate != null) body['birth_date'] = data.birthDate;
    if (data.genderCode != null) body['gender_code'] = data.genderCode;
    if (data.schoolId != null) body['school_id'] = data.schoolId;
    if (data.schoolName != null) body['school_name'] = data.schoolName;
    if (data.grade != null) body['grade'] = data.grade;
    if (data.zipCode != null) body['zip_code'] = data.zipCode;
    if (data.address != null) body['address'] = data.address;
    if (data.addressDetail != null) body['address_detail'] = data.addressDetail;
    if (data.memo != null) body['memo'] = data.memo;

    if (data.parents != null) {
      body['parents'] = data.parents!.map((p) {
        final parent = <String, dynamic>{
          'phone': p.phone,
          'seq': p.seq,
          'parent_kind': p.parentKind,
        };
        if (p.parentId != null) parent['parent_id'] = p.parentId;
        return parent;
      }).toList();
    }

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/student/$studentId',
      data: body,
    );

    return Student.fromJson(response['data']);
  }

  // 보호자 삭제
  Future<void> deleteParent(int studentId, int parentId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/student/$studentId/parent/$parentId',
    );
  }

  // 학생 삭제 (관리자만)
  // hard: true면 완전 삭제, false면 soft delete
  Future<void> delete(int studentId, {bool hard = false}) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/student/$studentId',
      queryParameters: hard ? {'hard': 'true'} : null,
    );
  }
}
