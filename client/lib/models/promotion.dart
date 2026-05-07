import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion.freezed.dart';
part 'promotion.g.dart';

// discount_value가 서버에서 문자열로 올 수 있음
double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

// is_active가 서버에서 int(0/1)로 올 수 있음
bool _parseBool(dynamic value) {
  if (value == null) return true;
  if (value is bool) return value;
  if (value is num) return value != 0;
  return true;
}

@freezed
class Promotion with _$Promotion {
  const factory Promotion({
    @JsonKey(name: 'promotion_id') required int promotionId,
    @JsonKey(name: 'promotion_name') required String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'promotion_type_name') String? promotionTypeName,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_type_name') String? discountTypeName,
    @JsonKey(name: 'discount_value', fromJson: _parseDouble) double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
    @JsonKey(name: 'is_active', fromJson: _parseBool) @Default(true) bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Promotion;

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
}

@freezed
class PromotionCreate with _$PromotionCreate {
  const factory PromotionCreate({
    @JsonKey(name: 'promotion_name') required String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
  }) = _PromotionCreate;

  factory PromotionCreate.fromJson(Map<String, dynamic> json) =>
      _$PromotionCreateFromJson(json);
}

@freezed
class PromotionListParams with _$PromotionListParams {
  const factory PromotionListParams({
    @Default(1) int page,
    @Default(20) int perPage,
    String? sort,
    String? order,
    String? search,
  }) = _PromotionListParams;

  factory PromotionListParams.fromJson(Map<String, dynamic> json) =>
      _$PromotionListParamsFromJson(json);
}

@freezed
class PromotionAttendee with _$PromotionAttendee {
  const factory PromotionAttendee({
    required int id,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'applied_date') String? appliedDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _PromotionAttendee;

  factory PromotionAttendee.fromJson(Map<String, dynamic> json) =>
      _$PromotionAttendeeFromJson(json);
}

@freezed
class NewAttendeeData with _$NewAttendeeData {
  const factory NewAttendeeData({
    required String name,
    required String phone,
    @JsonKey(name: 'school_id') int? schoolId,
    int? grade,
    String? memo,
  }) = _NewAttendeeData;

  factory NewAttendeeData.fromJson(Map<String, dynamic> json) =>
      _$NewAttendeeDataFromJson(json);
}

@freezed
class UserSearchResult with _$UserSearchResult {
  const factory UserSearchResult({
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    required String phone,
    int? grade,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
  }) = _UserSearchResult;

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);
}
