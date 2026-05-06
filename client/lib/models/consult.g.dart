// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsultImpl _$$ConsultImplFromJson(Map<String, dynamic> json) =>
    _$ConsultImpl(
      consultId: (json['consult_id'] as num).toInt(),
      studentId: (json['student_id'] as num).toInt(),
      studentName: json['student_name'] as String?,
      studentPhone: json['student_phone'] as String?,
      consultTypeCode: json['consult_type_code'] as String,
      consultTypeName: json['consult_type_name'] as String?,
      consultDate: json['consult_date'] as String,
      consultDuration: (json['consult_duration'] as num?)?.toInt(),
      channelCode: json['channel_code'] as String?,
      channelName: json['channel_name'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      tcName: json['tc_name'] as String?,
      content: json['content'] as String?,
      studentNeeds: json['student_needs'] as String?,
      consultResultCode: json['consult_result_code'] as String?,
      consultResultName: json['consult_result_name'] as String?,
      resultDetail: json['result_detail'] as String?,
      nextActionCode: json['next_action_code'] as String?,
      nextActionName: json['next_action_name'] as String?,
      nextActionDetail: json['next_action_detail'] as String?,
      nextConsultDate: json['next_consult_date'] as String?,
      interestSubject: json['interest_subject'] as String?,
      interestProgram: json['interest_program'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ConsultImplToJson(_$ConsultImpl instance) =>
    <String, dynamic>{
      'consult_id': instance.consultId,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'student_phone': instance.studentPhone,
      'consult_type_code': instance.consultTypeCode,
      'consult_type_name': instance.consultTypeName,
      'consult_date': instance.consultDate,
      'consult_duration': instance.consultDuration,
      'channel_code': instance.channelCode,
      'channel_name': instance.channelName,
      'tc_id': instance.tcId,
      'tc_name': instance.tcName,
      'content': instance.content,
      'student_needs': instance.studentNeeds,
      'consult_result_code': instance.consultResultCode,
      'consult_result_name': instance.consultResultName,
      'result_detail': instance.resultDetail,
      'next_action_code': instance.nextActionCode,
      'next_action_name': instance.nextActionName,
      'next_action_detail': instance.nextActionDetail,
      'next_consult_date': instance.nextConsultDate,
      'interest_subject': instance.interestSubject,
      'interest_program': instance.interestProgram,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ConsultCreateImpl _$$ConsultCreateImplFromJson(Map<String, dynamic> json) =>
    _$ConsultCreateImpl(
      studentId: (json['student_id'] as num).toInt(),
      consultTypeCode: json['consult_type_code'] as String,
      consultDate: json['consult_date'] as String,
      consultDuration: (json['consult_duration'] as num?)?.toInt(),
      channelCode: json['channel_code'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      content: json['content'] as String?,
      studentNeeds: json['student_needs'] as String?,
      consultResultCode: json['consult_result_code'] as String?,
      resultDetail: json['result_detail'] as String?,
      nextActionCode: json['next_action_code'] as String?,
      nextActionDetail: json['next_action_detail'] as String?,
      nextConsultDate: json['next_consult_date'] as String?,
      interestSubject: json['interest_subject'] as String?,
      interestProgram: json['interest_program'] as String?,
    );

Map<String, dynamic> _$$ConsultCreateImplToJson(_$ConsultCreateImpl instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'consult_type_code': instance.consultTypeCode,
      'consult_date': instance.consultDate,
      'consult_duration': instance.consultDuration,
      'channel_code': instance.channelCode,
      'tc_id': instance.tcId,
      'content': instance.content,
      'student_needs': instance.studentNeeds,
      'consult_result_code': instance.consultResultCode,
      'result_detail': instance.resultDetail,
      'next_action_code': instance.nextActionCode,
      'next_action_detail': instance.nextActionDetail,
      'next_consult_date': instance.nextConsultDate,
      'interest_subject': instance.interestSubject,
      'interest_program': instance.interestProgram,
    };

_$ConsultListParamsImpl _$$ConsultListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$ConsultListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 20,
  sort: json['sort'] as String?,
  order: json['order'] as String?,
  search: json['search'] as String?,
  studentId: (json['student_id'] as num?)?.toInt(),
  tcId: (json['tc_id'] as num?)?.toInt(),
  consultTypeCode: json['consult_type_code'] as String?,
  consultResultCode: json['consult_result_code'] as String?,
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
);

Map<String, dynamic> _$$ConsultListParamsImplToJson(
  _$ConsultListParamsImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'sort': instance.sort,
  'order': instance.order,
  'search': instance.search,
  'student_id': instance.studentId,
  'tc_id': instance.tcId,
  'consult_type_code': instance.consultTypeCode,
  'consult_result_code': instance.consultResultCode,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
};

_$ConsultUpdateImpl _$$ConsultUpdateImplFromJson(Map<String, dynamic> json) =>
    _$ConsultUpdateImpl(
      consultTypeCode: json['consult_type_code'] as String?,
      consultDate: json['consult_date'] as String?,
      consultDuration: (json['consult_duration'] as num?)?.toInt(),
      channelCode: json['channel_code'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      content: json['content'] as String?,
      studentNeeds: json['student_needs'] as String?,
      consultResultCode: json['consult_result_code'] as String?,
      resultDetail: json['result_detail'] as String?,
      nextActionCode: json['next_action_code'] as String?,
      nextActionDetail: json['next_action_detail'] as String?,
      nextConsultDate: json['next_consult_date'] as String?,
      interestSubject: json['interest_subject'] as String?,
      interestProgram: json['interest_program'] as String?,
    );

Map<String, dynamic> _$$ConsultUpdateImplToJson(_$ConsultUpdateImpl instance) =>
    <String, dynamic>{
      'consult_type_code': instance.consultTypeCode,
      'consult_date': instance.consultDate,
      'consult_duration': instance.consultDuration,
      'channel_code': instance.channelCode,
      'tc_id': instance.tcId,
      'content': instance.content,
      'student_needs': instance.studentNeeds,
      'consult_result_code': instance.consultResultCode,
      'result_detail': instance.resultDetail,
      'next_action_code': instance.nextActionCode,
      'next_action_detail': instance.nextActionDetail,
      'next_consult_date': instance.nextConsultDate,
      'interest_subject': instance.interestSubject,
      'interest_program': instance.interestProgram,
    };
