import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../config/app_config.dart';
import 'api_exception.dart';

class ApiClient {
  static ApiClient? _instance;
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 인터셉터 추가
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          // TODO: 토큰 추가
          // final token = await _getToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  static ApiClient get instance {
    _instance ??= ApiClient._();
    return _instance!;
  }

  Dio get dio => _dio;

  // 토큰 설정
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // 토큰 제거
  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  // GET 요청
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST 요청
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT 요청
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH 요청
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE 요청
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 응답 처리
  T _handleResponse<T>(Response response, T Function(dynamic)? fromJson) {
    final data = response.data;

    if (data == null) {
      throw ApiException(message: 'Empty response');
    }

    // API 응답 구조 확인
    if (data is Map<String, dynamic>) {
      if (data['success'] == false) {
        throw ApiException(
          message: data['message'] ?? 'Unknown error',
          code: data['code'],
          errors: data['errors'],
        );
      }

      // fromJson이 있으면 data 필드 파싱
      if (fromJson != null) {
        return fromJson(data['data']);
      }
    }

    return data as T;
  }

  // 에러 처리
  ApiException _handleError(DioException error) {
    String message;
    int? code;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = '연결 시간이 초과되었습니다.';
        break;
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null && response.data is Map<String, dynamic>) {
          message = response.data['message'] ?? '서버 오류가 발생했습니다.';
          code = response.data['code'];
        } else {
          message = '서버 오류가 발생했습니다. (${response?.statusCode})';
          code = response?.statusCode;
        }
        break;
      case DioExceptionType.cancel:
        message = '요청이 취소되었습니다.';
        break;
      case DioExceptionType.connectionError:
        message = '네트워크 연결을 확인해주세요.';
        break;
      default:
        message = '알 수 없는 오류가 발생했습니다.';
    }

    return ApiException(message: message, code: code);
  }
}
