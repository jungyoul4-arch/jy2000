import '../core/api/api_client.dart';
import '../models/class_type.dart';

class ClassTypeRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 반 형태 목록 조회
  Future<List<ClassType>> getList({
    String? search,
    int? grade,
    int? subject,
  }) async {
    final queryParams = <String, dynamic>{
      'perPage': 1000, // 전체 목록 가져오기
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (grade != null) {
      queryParams['grade'] = grade;
    }
    if (subject != null) {
      queryParams['subject'] = subject;
    }

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class-type/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => ClassType.fromJson(e)).toList();
  }

  // 반 형태 상세 조회
  Future<ClassType> getById(int classTypeId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class-type/$classTypeId',
    );

    return ClassType.fromJson(response['data']);
  }

  // 반 형태명으로 검색 (정확히 일치)
  Future<ClassType?> findByName(String classTypeName) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/class-type/find-by-name',
      queryParameters: {'name': classTypeName},
    );

    final data = response['data'];
    if (data == null) return null;
    return ClassType.fromJson(data);
  }

  // 반 형태 생성
  Future<ClassType> create({
    required String classTypeName,
    int? year,
    required int grade,
    required int subject,
    int? format,
    int unitPrice = 0,
    List<int>? teacherIds,
    List<String>? teacherNames,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/class-type',
      data: {
        'class_type_name': classTypeName,
        if (year != null) 'year': year,
        'grade': grade,
        'subject': subject,
        if (format != null) 'format': format,
        'unit_price': unitPrice,
        if (teacherIds != null && teacherIds.isNotEmpty) 'teacher_ids': teacherIds,
        if (teacherNames != null && teacherNames.isNotEmpty) 'teacher_names': teacherNames,
      },
    );

    return ClassType.fromJson(response['data']);
  }

  // 반 형태 수정
  Future<ClassType> update(int classTypeId, {
    String? classTypeName,
    int? year,
    int? grade,
    int? subject,
    int? format,
    int? unitPrice,
    List<int>? teacherIds,
    List<String>? teacherNames,
  }) async {
    final data = <String, dynamic>{};
    if (classTypeName != null) data['class_type_name'] = classTypeName;
    if (year != null) data['year'] = year;
    if (grade != null) data['grade'] = grade;
    if (subject != null) data['subject'] = subject;
    if (format != null) data['format'] = format;
    if (unitPrice != null) data['unit_price'] = unitPrice;
    if (teacherIds != null) data['teacher_ids'] = teacherIds;
    if (teacherNames != null) data['teacher_names'] = teacherNames;

    final response = await _apiClient.put<Map<String, dynamic>>(
      '/class-type/$classTypeId',
      data: data,
    );

    return ClassType.fromJson(response['data']);
  }

  // 반 형태 삭제
  Future<void> delete(int classTypeId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/class-type/$classTypeId',
    );
  }
}
