import '../core/api/api_client.dart';
import '../models/auth.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  // 인증 코드 요청
  Future<RequestCodeResponse> requestCode(String phone) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/request-code',
      data: {'phone': phone},
    );

    // response는 {success, message, data} 구조
    final data = response['data'] as Map<String, dynamic>;
    return RequestCodeResponse.fromJson(data);
  }

  // 인증 코드 확인 및 로그인
  Future<VerifyCodeResponse> verifyCode(String phone, String code) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/verify-code',
      data: {'phone': phone, 'code': code},
    );

    final data = response['data'] as Map<String, dynamic>;
    return VerifyCodeResponse.fromJson(data);
  }

  // ID/PW 로그인
  Future<VerifyCodeResponse> login(String loginId, String password) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'loginId': loginId, 'password': password},
    );

    final data = response['data'] as Map<String, dynamic>;
    return VerifyCodeResponse.fromJson(data);
  }
}
