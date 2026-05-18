// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarEventImpl _$$CalendarEventImplFromJson(Map<String, dynamic> json) =>
    _$CalendarEventImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      date: json['date'] as String,
      time: json['time'] as String?,
      title: json['title'] as String,
      studentId: (json['student_id'] as num?)?.toInt(),
      studentName: json['student_name'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      tcName: json['tc_name'] as String?,
      promotionId: (json['promotion_id'] as num?)?.toInt(),
      promotionName: json['promotion_name'] as String?,
    );

Map<String, dynamic> _$$CalendarEventImplToJson(_$CalendarEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'date': instance.date,
      'time': instance.time,
      'title': instance.title,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'tc_id': instance.tcId,
      'tc_name': instance.tcName,
      'promotion_id': instance.promotionId,
      'promotion_name': instance.promotionName,
    };
