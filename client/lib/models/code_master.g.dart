// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_master.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CodeMasterImpl _$$CodeMasterImplFromJson(Map<String, dynamic> json) =>
    _$CodeMasterImpl(
      codeId: json['code_id'] as String,
      codeGroup: json['code_group'] as String,
      codeValue: json['code_value'] as String,
      codeName: json['code_name'] as String,
      codeNameEn: json['code_name_en'] as String?,
      parentCodeId: json['parent_code_id'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CodeMasterImplToJson(_$CodeMasterImpl instance) =>
    <String, dynamic>{
      'code_id': instance.codeId,
      'code_group': instance.codeGroup,
      'code_value': instance.codeValue,
      'code_name': instance.codeName,
      'code_name_en': instance.codeNameEn,
      'parent_code_id': instance.parentCodeId,
      'sort_order': instance.sortOrder,
    };
