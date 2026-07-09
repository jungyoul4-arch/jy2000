import 'package:freezed_annotation/freezed_annotation.dart';
import 'class_type.dart'; // gradeToString 사용

part 'mgmt_data.freezed.dart';
part 'mgmt_data.g.dart';

// String 또는 num을 double로 변환하는 컨버터
class StringToDoubleConverter implements JsonConverter<double, dynamic> {
  const StringToDoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json == null) return 1.0;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json) ?? 1.0;
    return 1.0;
  }

  @override
  dynamic toJson(double object) => object;
}

@freezed
class MgmtData with _$MgmtData {
  const MgmtData._();

  const factory MgmtData({
    @JsonKey(name: 'mgmt_data_id') required int mgmtDataId,
    required int year,
    required int month,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName, // JOIN으로 가져옴
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName, // JOIN으로 가져옴
    int? grade, // 1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3
    @JsonKey(name: 'enrollment_count')
    @StringToDoubleConverter()
    @Default(1.0)
    double enrollmentCount,
    @JsonKey(name: 'comp_class_type') String? compClassType,
    String? subject,
    @JsonKey(name: 'teacher_id') int? teacherId,
    @JsonKey(name: 'teacher_name') String? teacherName, // JOIN으로 가져옴
    @JsonKey(name: 'class_name1') String? className1,
    @JsonKey(name: 'class_type_id') int? classTypeId,
    @JsonKey(name: 'class_type_name') String? classTypeName, // JOIN으로 가져옴
    @JsonKey(name: 'unit_price') @Default(0) int unitPrice, // 단가 (class_type JOIN으로 가져옴)
    @Default(0) int price, // 가격 (unit_price × enrollment_count)
    @JsonKey(name: 'student_name_orig') String? studentNameOrig, // 엑셀 원본 학생 이름
    @JsonKey(name: 'teacher_name_orig') String? teacherNameOrig, // 엑셀 원본 강사 이름
    @JsonKey(name: 'class_type_name_orig') String? classTypeNameOrig, // 엑셀 원본 반형태 이름
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _MgmtData;

  factory MgmtData.fromJson(Map<String, dynamic> json) =>
      _$MgmtDataFromJson(json);

  // 학년 문자열 반환
  String get gradeString => grade != null ? gradeToString(grade!) : '';
}

// 년월 정보
@freezed
class YearMonth with _$YearMonth {
  const factory YearMonth({
    required int year,
    required int month,
  }) = _YearMonth;

  factory YearMonth.fromJson(Map<String, dynamic> json) =>
      _$YearMonthFromJson(json);
}
