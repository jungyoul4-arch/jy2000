import '../core/api/api_client.dart';
import '../models/code_master.dart';

class CodeRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // 전체 코드 조회 (그룹별)
  Future<Map<String, List<CodeMaster>>> getAllCodes() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/code',
    );

    final Map<String, dynamic> data = response['data'] ?? {};
    final result = <String, List<CodeMaster>>{};

    data.forEach((key, value) {
      if (value is List) {
        result[key] = value.map((e) => CodeMaster.fromJson(e)).toList();
      }
    });

    return result;
  }

  // 특정 그룹 코드 조회
  Future<List<CodeMaster>> getCodesByGroup(String group) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/code/$group',
    );

    final List<dynamic> dataList = response['data'] ?? [];
    return dataList.map((e) => CodeMaster.fromJson(e)).toList();
  }
}
