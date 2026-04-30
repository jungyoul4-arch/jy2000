// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SchoolImpl _$$SchoolImplFromJson(Map<String, dynamic> json) => _$SchoolImpl(
  schoolId: (json['school_id'] as num).toInt(),
  schoolName: json['school_name'] as String,
  schoolKind: (json['school_kind'] as num).toInt(),
  regionKind: (json['region_kind'] as num).toInt(),
  isActive: json['is_active'] == null
      ? true
      : const IntToBoolConverter().fromJson(json['is_active']),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$$SchoolImplToJson(_$SchoolImpl instance) =>
    <String, dynamic>{
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'school_kind': instance.schoolKind,
      'region_kind': instance.regionKind,
      'is_active': const IntToBoolConverter().toJson(instance.isActive),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
