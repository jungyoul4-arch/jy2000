class ApiException implements Exception {
  final String message;
  final int? code;
  final List<dynamic>? errors;

  ApiException({
    required this.message,
    this.code,
    this.errors,
  });

  @override
  String toString() => 'ApiException: $message (code: $code)';

  // 유효성 검사 에러 메시지 추출
  String? getFieldError(String fieldName) {
    if (errors == null) return null;

    for (final error in errors!) {
      if (error is Map<String, dynamic> && error['field'] == fieldName) {
        return error['message'] as String?;
      }
    }
    return null;
  }

  // 모든 에러 메시지 합치기
  String get allErrorMessages {
    if (errors == null || errors!.isEmpty) return message;

    final messages = errors!
        .map((e) => e is Map<String, dynamic> ? e['message'] : e.toString())
        .join(', ');

    return messages.isNotEmpty ? messages : message;
  }
}
