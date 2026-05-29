import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/mgmt_data.dart';

class MgmtDataRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 경영 데이터 목록 조회
  Future<MgmtDataListResult> getList({
    int? year,
    int? month,
    String? search,
    int page = 1,
    int perPage = 100,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'perPage': perPage,
    };

    if (year != null) queryParams['year'] = year.toString();
    if (month != null) queryParams['month'] = month.toString();
    if (search != null && search.isNotEmpty) queryParams['search'] = search;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/mgmt-data/list',
      queryParameters: queryParams,
    );

    final List<dynamic> dataList = response['data'] ?? [];
    final meta = response['meta'] as Map<String, dynamic>?;

    final availableMonths = (meta?['availableMonths'] as List<dynamic>?)
            ?.map((e) => YearMonth.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return MgmtDataListResult(
      data: dataList.map((e) => MgmtData.fromJson(e)).toList(),
      total: meta?['total'] ?? 0,
      availableMonths: availableMonths,
    );
  }

  // 특정 년월 데이터 삭제
  Future<int> deleteByMonth(int year, int month) async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      '/mgmt-data/$year/$month',
    );

    return response['data']?['deletedCount'] ?? 0;
  }

  // 경영 데이터 수정 (관리자만)
  Future<MgmtData> update(int mgmtDataId, {int? studentId, int? teacherId, int? schoolId, int? classTypeId}) async {
    final body = <String, dynamic>{};
    if (studentId != null) body['studentId'] = studentId;
    if (teacherId != null) body['teacherId'] = teacherId;
    if (schoolId != null) body['schoolId'] = schoolId;
    if (classTypeId != null) body['classTypeId'] = classTypeId;

    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/mgmt-data/$mgmtDataId',
      data: body,
    );

    return MgmtData.fromJson(response['data']);
  }

  // 엑셀 파일 업로드
  Future<UploadResult> uploadExcel(String filePath, int year, int month) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'year': year.toString(),
      'month': month.toString(),
    });

    final response = await _apiClient.dio.post(
      '/mgmt-data/upload',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    final data = response.data;
    if (data['success'] == false) {
      throw Exception(data['message'] ?? 'Upload failed');
    }

    return UploadResult(
      inserted: data['data']?['inserted'] ?? 0,
      matched: data['data']?['matched'] ?? 0,
    );
  }
}

// 목록 조회 결과
class MgmtDataListResult {
  final List<MgmtData> data;
  final int total;
  final List<YearMonth> availableMonths;

  MgmtDataListResult({
    required this.data,
    required this.total,
    required this.availableMonths,
  });
}

// 업로드 결과
class UploadResult {
  final int inserted;
  final int matched;

  UploadResult({
    required this.inserted,
    required this.matched,
  });
}
