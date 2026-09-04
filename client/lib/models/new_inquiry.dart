import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_inquiry.freezed.dart';
part 'new_inquiry.g.dart';

/// 신규생 문의 상담 유형 코드 (code_master: CONSULT_TYPE)
///
/// 표시명은 '신규생 문의'이며, 일반 상담 등록 화면과 일정 캘린더에서는 이 유형을 제외한다.
const String newInquiryConsultTypeCode = 'CONSULT_TYPE_INITIAL';

/// 상담 유형 기본값 — 재상담
///
/// 일정 캘린더에서 학생을 연동해 상담을 자동 생성할 때 쓰는 기본 유형.
/// 서버의 scheduleService.DEFAULT_CONSULT_TYPE_CODE와 같은 값이어야 한다.
const String defaultConsultTypeCode = 'CONSULT_TYPE_FOLLOWUP';

/// 문의 과목 비트마스크
///
/// student_info.subject_code에 저장되는 값. code_master 코드가 아니다.
/// 논술 3종(64/128/256)은 신규생 문의 화면에서 추가된 값이다.
class InquirySubject {
  static const int korean = 1; // 국어
  static const int math = 2; // 수학
  static const int english = 4; // 영어
  static const int science = 8; // 과학
  static const int social = 16; // 사회
  static const int etc = 32; // 기타
  static const int essayBrief = 64; // 약술형 논술
  static const int essayHumanities = 128; // 인문 논술
  static const int essayMath = 256; // 수리 논술

  /// 일반 과목 (표시 순서: 이미지 기준 국어/영어/수학/과학/사회)
  static const List<(int, String)> general = [
    (korean, '국어'),
    (english, '영어'),
    (math, '수학'),
    (science, '과학'),
    (social, '사회'),
  ];

  /// 논술 과목
  static const List<(int, String)> essay = [
    (essayBrief, '약술형 논술'),
    (essayHumanities, '인문 논술'),
    (essayMath, '수리 논술'),
  ];

  /// 비트마스크를 표시명 목록으로 변환 (일반 과목 → 논술 순)
  static List<String> namesOf(int mask) {
    return [...general, ...essay]
        .where((entry) => mask & entry.$1 > 0)
        .map((entry) => entry.$2)
        .toList();
  }

  /// 비트마스크를 콤마 문자열로 변환. 선택이 없으면 null
  static String? labelOf(int mask) {
    final names = namesOf(mask);
    return names.isEmpty ? null : names.join(',');
  }
}

/// 학년 옵션
///
/// User.grade 코드: 7~9 = 중1~중3, 10~12 = 고1~고3, 13 = N수생
class InquiryGrade {
  static const List<(int, String)> middle = [
    (7, '중1'),
    (8, '중2'),
    (9, '중3'),
  ];

  static const List<(int, String)> high = [
    (10, '고1'),
    (11, '고2'),
    (12, '고3'),
    (13, 'N수생'),
  ];

  /// 학교명 끝 글자로 학년 옵션을 결정한다.
  ///
  /// '○○고등학교'/'○○고' → 고1~고3, N수생
  /// '○○중학교'/'○○중'   → 중1~중3
  /// 판별할 수 없으면 중·고 전체
  static List<(int, String)> optionsFor(String? schoolName) {
    final name = schoolName?.trim() ?? '';
    if (name.isEmpty) return [...middle, ...high];

    // '고등학교'/'중학교' 접미사를 떼고 끝 글자로 판별
    final base = name
        .replaceAll('등학교', '')
        .replaceAll('학교', '');

    if (base.endsWith('고')) return high;
    if (base.endsWith('중')) return middle;
    return [...middle, ...high];
  }

  /// 학년 코드의 표시명
  static String? labelOf(int? grade) {
    if (grade == null) return null;
    for (final entry in [...middle, ...high]) {
      if (entry.$1 == grade) return entry.$2;
    }
    return null;
  }
}

/// 신규생 문의 등록 요청
@freezed
class NewInquiryCreate with _$NewInquiryCreate {
  const factory NewInquiryCreate({
    /// 문의 날짜 (YYYY-MM-DD)
    @JsonKey(name: 'consult_date') required String consultDate,
    @JsonKey(name: 'student_name') required String studentName,

    /// 기존 학생을 타입어헤드로 고른 경우에만 값이 있다
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'inquiry_source_code') String? inquirySourceCode,

    /// 문의 과목 비트마스크
    @JsonKey(name: 'subject_code') int? subjectCode,

    /// 문의 과목 표시명 콤마 문자열
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'selector_name') String? selectorName,
    String? content,
  }) = _NewInquiryCreate;

  factory NewInquiryCreate.fromJson(Map<String, dynamic> json) =>
      _$NewInquiryCreateFromJson(json);
}

/// 신규생 문의 등록 결과
@freezed
class NewInquiryResult with _$NewInquiryResult {
  const factory NewInquiryResult({
    @JsonKey(name: 'consult_id') required int consultId,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(name: 'is_new_student') @Default(false) bool isNewStudent,
    @JsonKey(name: 'guardian_created') @Default(false) bool guardianCreated,
  }) = _NewInquiryResult;

  factory NewInquiryResult.fromJson(Map<String, dynamic> json) =>
      _$NewInquiryResultFromJson(json);
}

/// 신규생 문의 화면의 학생 타입어헤드 결과
///
/// kind=2인 학생을 active_flag 상관없이 반환하며, 선택 시 화면 자동 채움에 쓰인다.
@freezed
class InquiryStudentLookup with _$InquiryStudentLookup {
  const InquiryStudentLookup._();

  const factory InquiryStudentLookup({
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'student_name') required String studentName,
    String? phone,

    /// 1이면 현재 재원중
    @JsonKey(name: 'active_flag') @Default(0) int activeFlag,
    int? grade,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
  }) = _InquiryStudentLookup;

  factory InquiryStudentLookup.fromJson(Map<String, dynamic> json) =>
      _$InquiryStudentLookupFromJson(json);

  /// 현재 재원중 여부 — '구분'과 '재원여부'를 자동 결정한다
  bool get isEnrolled => activeFlag == 1;
}
