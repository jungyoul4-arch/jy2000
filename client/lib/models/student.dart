import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

/// 숫자 또는 문자열을 int?로 변환하는 컨버터
class FlexibleIntConverter implements JsonConverter<int?, dynamic> {
  const FlexibleIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is num) return json.toInt();
    if (json is String) {
      final parsed = int.tryParse(json);
      return parsed;
    }
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}

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
    @JsonKey(name: 'school_id') @FlexibleIntConverter() int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation') @FlexibleIntConverter() int? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') @FlexibleIntConverter() int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<ParentInfo>? parents,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}

@freezed
class ParentInfo with _$ParentInfo {
  const factory ParentInfo({
    @JsonKey(name: 'parent_id') int? parentId,
    required String phone,
    @Default(1) int seq,
    @JsonKey(name: 'parent_kind') @Default(2) int parentKind,
    String? name,
  }) = _ParentInfo;

  factory ParentInfo.fromJson(Map<String, dynamic> json) =>
      _$ParentInfoFromJson(json);
}

@freezed
class StudentUpdate with _$StudentUpdate {
  const factory StudentUpdate({
    @JsonKey(name: 'student_name') String? studentName,
    String? phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    String? memo,
    List<ParentInfo>? parents,
  }) = _StudentUpdate;

  factory StudentUpdate.fromJson(Map<String, dynamic> json) =>
      _$StudentUpdateFromJson(json);
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
class StudentCreate with _$StudentCreate {
  const factory StudentCreate({
    @JsonKey(name: 'student_name') required String studentName,
    required String phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') int? tcId,
    String? memo,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'parent_kind') int? parentKind,
  }) = _StudentCreate;

  factory StudentCreate.fromJson(Map<String, dynamic> json) =>
      _$StudentCreateFromJson(json);
}

@freezed
class StudentListParams with _$StudentListParams {
  const factory StudentListParams({
    @Default(1) int page,
    @Default(500) int perPage,
    @Default('student_name') String? sort,
    @Default('asc') String? order,
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

@freezed
class StudentHistory with _$StudentHistory {
  const factory StudentHistory({
    @JsonKey(name: 'history_id') required int historyId,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'prev_status_code') String? prevStatusCode,
    @JsonKey(name: 'prev_status_name') String? prevStatusName,
    @JsonKey(name: 'new_status_code') required String newStatusCode,
    @JsonKey(name: 'new_status_name') String? newStatusName,
    @JsonKey(name: 'prev_sub_status') String? prevSubStatus,
    @JsonKey(name: 'prev_sub_status_name') String? prevSubStatusName,
    @JsonKey(name: 'new_sub_status') String? newSubStatus,
    @JsonKey(name: 'new_sub_status_name') String? newSubStatusName,
    @JsonKey(name: 'change_type_code') required String changeTypeCode,
    @JsonKey(name: 'change_type_name') String? changeTypeName,
    @JsonKey(name: 'change_reason_code') String? changeReasonCode,
    @JsonKey(name: 'change_reason_name') String? changeReasonName,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'prev_tc_id') int? prevTcId,
    @JsonKey(name: 'prev_tc_name') String? prevTcName,
    @JsonKey(name: 'new_tc_id') int? newTcId,
    @JsonKey(name: 'new_tc_name') String? newTcName,
    @JsonKey(name: 'changed_by') required int changedBy,
    @JsonKey(name: 'changed_by_name') String? changedByName,
    @JsonKey(name: 'changed_at') required String changedAt,
  }) = _StudentHistory;

  factory StudentHistory.fromJson(Map<String, dynamic> json) =>
      _$StudentHistoryFromJson(json);
}
