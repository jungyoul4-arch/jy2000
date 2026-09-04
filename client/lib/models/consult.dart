import 'package:freezed_annotation/freezed_annotation.dart';

part 'consult.freezed.dart';
part 'consult.g.dart';

@freezed
class Consult with _$Consult {
  const factory Consult({
    @JsonKey(name: 'consult_id') required int consultId,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_type_code') required String consultTypeCode,
    @JsonKey(name: 'consult_type_name') String? consultTypeName,
    @JsonKey(name: 'consult_date') required String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'channel_name') String? channelName,
    @JsonKey(name: 'inquiry_source_code') String? inquirySourceCode,
    @JsonKey(name: 'inquiry_source_name') String? inquirySourceName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'selector_name') String? selectorName,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'consult_result_name') String? consultResultName,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_name') String? nextActionName,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Consult;

  factory Consult.fromJson(Map<String, dynamic> json) =>
      _$ConsultFromJson(json);
}

@freezed
class ConsultCreate with _$ConsultCreate {
  const factory ConsultCreate({
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'consult_type_code') required String consultTypeCode,
    @JsonKey(name: 'consult_date') required String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  }) = _ConsultCreate;

  factory ConsultCreate.fromJson(Map<String, dynamic> json) =>
      _$ConsultCreateFromJson(json);
}

@freezed
class ConsultListParams with _$ConsultListParams {
  const factory ConsultListParams({
    @Default(1) int page,
    @Default(20) int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  }) = _ConsultListParams;

  factory ConsultListParams.fromJson(Map<String, dynamic> json) =>
      _$ConsultListParamsFromJson(json);
}

@freezed
class ConsultUpdate with _$ConsultUpdate {
  const factory ConsultUpdate({
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  }) = _ConsultUpdate;

  factory ConsultUpdate.fromJson(Map<String, dynamic> json) =>
      _$ConsultUpdateFromJson(json);
}
