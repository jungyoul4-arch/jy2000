import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'student_name') required String studentName,
    required String phone,
    @JsonKey(name: 'phone_sub') String? phoneSub,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'gender_name') String? genderName,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation') String? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}

@freezed
class StudentStateChange with _$StudentStateChange {
  const factory StudentStateChange({
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'new_status_code') required String newStatusCode,
    @JsonKey(name: 'new_sub_status_code') String? newSubStatusCode,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'new_tc_id') int? newTcId,
  }) = _StudentStateChange;

  factory StudentStateChange.fromJson(Map<String, dynamic> json) =>
      _$StudentStateChangeFromJson(json);
}

@freezed
class StudentListParams with _$StudentListParams {
  const factory StudentListParams({
    @Default(1) int page,
    @Default(20) int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'status_code') String? statusCode,
    int? grade,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  }) = _StudentListParams;

  factory StudentListParams.fromJson(Map<String, dynamic> json) =>
      _$StudentListParamsFromJson(json);
}
