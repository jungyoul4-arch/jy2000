// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_event_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleEventTypeImpl _$$ScheduleEventTypeImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleEventTypeImpl(
  eventTypeId: (json['event_type_id'] as num).toInt(),
  eventTypeName: json['event_type_name'] as String,
  colorCode: json['color_code'] as String,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
  isActive: json['is_active'] == null
      ? true
      : const IntToBoolConverter().fromJson(json['is_active']),
);

Map<String, dynamic> _$$ScheduleEventTypeImplToJson(
  _$ScheduleEventTypeImpl instance,
) => <String, dynamic>{
  'event_type_id': instance.eventTypeId,
  'event_type_name': instance.eventTypeName,
  'color_code': instance.colorCode,
  'sort_order': instance.sortOrder,
  'is_active': const IntToBoolConverter().toJson(instance.isActive),
};
