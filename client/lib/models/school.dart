import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';
part 'school.g.dart';

// int를 bool로 변환하는 컨버터
class IntToBoolConverter implements JsonConverter<bool, dynamic> {
  const IntToBoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is int) return json == 1;
    return false;
  }

  @override
  dynamic toJson(bool object) => object ? 1 : 0;
}

@freezed
class School with _$School {
  const factory School({
    @JsonKey(name: 'school_id') required int schoolId,
    @JsonKey(name: 'school_name') required String schoolName,
    @JsonKey(name: 'school_kind') required int schoolKind, // 1=중학교, 2=고등학교
    @JsonKey(name: 'region_kind') required int regionKind, // 1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타
    @JsonKey(name: 'is_active') @IntToBoolConverter() @Default(true) bool isActive,
    @JsonKey(name: 'student_count') @Default(0) int studentCount, // 해당 학교 학생 수
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _School;

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
}

// 학교 종류 상수
class SchoolKind {
  static const int middle = 1;  // 중학교
  static const int high = 2;    // 고등학교

  static String getName(int kind) {
    switch (kind) {
      case middle:
        return '중학교';
      case high:
        return '고등학교';
      default:
        return '알 수 없음';
    }
  }
}

// 학교 권역 상수
class RegionKind {
  static const int wonmi = 1;    // 원미권
  static const int sosa = 2;     // 소사권
  static const int ojeong = 3;   // 오정권
  static const int incheon = 4;  // 인천권
  static const int seoul = 5;    // 서울권
  static const int gyeonggi = 6; // 경기기타권
  static const int etc = 99;     // 기타

  static String getName(int kind) {
    switch (kind) {
      case wonmi:
        return '원미권';
      case sosa:
        return '소사권';
      case ojeong:
        return '오정권';
      case incheon:
        return '인천권';
      case seoul:
        return '서울권';
      case gyeonggi:
        return '경기기타권';
      case etc:
        return '기타';
      default:
        return '알 수 없음';
    }
  }

  static List<int> get values => [wonmi, sosa, ojeong, incheon, seoul, gyeonggi, etc];
}
