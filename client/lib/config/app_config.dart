import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

class AppConfig {
  static const String appName = '학원 관리';
  static const String appVersion = '1.0.0 Beta';

  // API 설정
  static const String apiBaseUrl = 'https://jungyoul.com/node-api/v1';
  static const String devApiBaseUrl = 'http://116.125.120.84:3001/node-api/v1';

  // 타임아웃 (밀리초)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // 페이지네이션
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // 현재 환경 - 웹이거나 릴리스 모드면 프로덕션
  static bool get isDevelopment => !kIsWeb && !kReleaseMode;

  static String get baseUrl => isDevelopment ? devApiBaseUrl : apiBaseUrl;
}
