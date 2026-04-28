class AppConfig {
  static const String appName = '학생 상담 관리';
  static const String appVersion = '1.0.0';

  // API 설정
  static const String apiBaseUrl = 'https://jungyoul.com/node-api/v1';
  static const String devApiBaseUrl = 'http://localhost:3000/node-api/v1';

  // 타임아웃 (밀리초)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // 페이지네이션
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // 현재 환경
  static bool get isDevelopment => true; // 개발 중에는 true

  static String get baseUrl => isDevelopment ? devApiBaseUrl : apiBaseUrl;
}
