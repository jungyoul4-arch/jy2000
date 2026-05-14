import '../core/api/api_client.dart';

class TcRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // TC User 등록 (User 테이블에 상담자 직접 등록)
  Future<TcUserCreateResult> createTcUser({
    required String phone,
    required String name,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/tc/user',
      data: {
        'phone': phone,
        'name': name,
      },
    );

    return TcUserCreateResult.fromJson(response['data']);
  }
}

class TcUserCreateResult {
  final int userId;
  final String name;
  final String phone;

  TcUserCreateResult({
    required this.userId,
    required this.name,
    required this.phone,
  });

  factory TcUserCreateResult.fromJson(Map<String, dynamic> json) {
    return TcUserCreateResult(
      userId: json['userId'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
