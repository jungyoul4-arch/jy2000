import 'package:freezed_annotation/freezed_annotation.dart';
import 'class_type.dart'; // gradeToString 사용

part 'mgmt_data.freezed.dart';
part 'mgmt_data.g.dart';

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
    @JsonKey(name: 'enrollment_count') @Default(1.0) double enrollmentCount,
    @JsonKey(name: 'comp_class_type') String? compClassType,
    String? subject,
    @JsonKey(name: 'teacher_id') int? teacherId,
    @JsonKey(name: 'teacher_name') String? teacherName, // JOIN으로 가져옴
    @JsonKey(name: 'class_name1') String? className1,
    @JsonKey(name: 'class_type_id') int? classTypeId,
    @JsonKey(name: 'class_type_name') String? classTypeName, // JOIN으로 가져옴
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
