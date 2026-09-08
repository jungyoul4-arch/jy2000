import 'package:flutter/services.dart';

/// 전화번호 입력란 공통 포맷터 — 숫자와 '-'만 받는다.
///
/// 공백이 섞여 들어가면 서버에서 지워 주더라도 화면에 보이는 값과
/// 저장되는 값이 달라지고, 붙여넣기로 들어온 공백은 눈에 띄지 않는다.
/// 아예 입력되지 않게 막는다.
final List<TextInputFormatter> phoneInputFormatters = [
  FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
];

/// 전화번호 포맷팅 (01011112222 -> 010-1111-2222)
String formatPhone(String? phone) {
  if (phone == null || phone.isEmpty) return '-';

  // 숫자만 추출
  final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');

  if (digits.length == 11) {
    // 010-1234-5678
    return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}';
  } else if (digits.length == 10) {
    // 02-1234-5678 또는 031-123-4567
    if (digits.startsWith('02')) {
      return '${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6)}';
    } else {
      return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
    }
  } else if (digits.length == 9) {
    // 02-123-4567
    return '${digits.substring(0, 2)}-${digits.substring(2, 5)}-${digits.substring(5)}';
  }

  return phone;
}

/// 날짜+시간 포맷 (2026-04-28 15:10)
String formatDateTime(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '-';
  try {
    final dt = DateTime.parse(dateStr);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
           '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  } catch (e) {
    return dateStr.length > 16 ? dateStr.substring(0, 16) : dateStr;
  }
}

/// 날짜만 포맷 (2026-04-28)
String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '-';
  try {
    final dt = DateTime.parse(dateStr);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  } catch (e) {
    return dateStr.length > 10 ? dateStr.substring(0, 10) : dateStr;
  }
}
