// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleEventImpl _$$ScheduleEventImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleEventImpl(
      eventId: (json['event_id'] as num).toInt(),
      categoryId: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String?,
      categoryType: json['category_type'] as String?,
      eventTypeId: (json['event_type_id'] as num).toInt(),
      eventTypeName: json['event_type_name'] as String?,
      colorCode: json['color_code'] as String?,
      eventDate: json['event_date'] as String,
      eventHour: (json['event_hour'] as num?)?.toInt(),
      eventMinute: (json['event_minute'] as num?)?.toInt() ?? 0,
      content: json['content'] as String?,
      isImportant: json['is_important'] == null
          ? false
          : const IntToBoolConverter().fromJson(json['is_important']),
      eventStatus:
          json['event_status'] as String? ?? ScheduleEventStatus.normal,
      studentId: (json['student_id'] as num?)?.toInt(),
      studentName: json['student_name'] as String?,
      studentPhone: json['student_phone'] as String?,
      studentGrade: (json['student_grade'] as num?)?.toInt(),
      gradeName: json['grade_name'] as String?,
      schoolName: json['school_name'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      tcName: json['tc_name'] as String?,
      consultId: (json['consult_id'] as num?)?.toInt(),
      consultDate: json['consult_date'] as String?,
      consultTypeCode: json['consult_type_code'] as String?,
      consultTypeName: json['consult_type_name'] as String?,
      createdBy: (json['created_by'] as num).toInt(),
      createdByName: json['created_by_name'] as String?,
      updatedBy: (json['updated_by'] as num?)?.toInt(),
      updatedByName: json['updated_by_name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ScheduleEventImplToJson(_$ScheduleEventImpl instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'category_type': instance.categoryType,
      'event_type_id': instance.eventTypeId,
      'event_type_name': instance.eventTypeName,
      'color_code': instance.colorCode,
      'event_date': instance.eventDate,
      'event_hour': instance.eventHour,
      'event_minute': instance.eventMinute,
      'content': instance.content,
      'is_important': const IntToBoolConverter().toJson(instance.isImportant),
      'event_status': instance.eventStatus,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'student_phone': instance.studentPhone,
      'student_grade': instance.studentGrade,
      'grade_name': instance.gradeName,
      'school_name': instance.schoolName,
      'tc_id': instance.tcId,
      'tc_name': instance.tcName,
      'consult_id': instance.consultId,
      'consult_date': instance.consultDate,
      'consult_type_code': instance.consultTypeCode,
      'consult_type_name': instance.consultTypeName,
      'created_by': instance.createdBy,
      'created_by_name': instance.createdByName,
      'updated_by': instance.updatedBy,
      'updated_by_name': instance.updatedByName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ScheduleEventCreateImpl _$$ScheduleEventCreateImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleEventCreateImpl(
  categoryId: (json['category_id'] as num).toInt(),
  eventTypeId: (json['event_type_id'] as num).toInt(),
  eventDate: json['event_date'] as String,
  eventHour: (json['event_hour'] as num?)?.toInt(),
  eventMinute: (json['event_minute'] as num?)?.toInt() ?? 0,
  content: json['content'] as String?,
  isImportant: json['is_important'] as bool? ?? false,
  eventStatus: json['event_status'] as String? ?? ScheduleEventStatus.normal,
  studentId: (json['student_id'] as num?)?.toInt(),
  tcId: (json['tc_id'] as num?)?.toInt(),
  consultTypeCode: json['consult_type_code'] as String?,
);

Map<String, dynamic> _$$ScheduleEventCreateImplToJson(
  _$ScheduleEventCreateImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'event_type_id': instance.eventTypeId,
  'event_date': instance.eventDate,
  'event_hour': instance.eventHour,
  'event_minute': instance.eventMinute,
  'content': instance.content,
  'is_important': instance.isImportant,
  'event_status': instance.eventStatus,
  'student_id': instance.studentId,
  'tc_id': instance.tcId,
  'consult_type_code': instance.consultTypeCode,
};

_$ScheduleEventUpdateImpl _$$ScheduleEventUpdateImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleEventUpdateImpl(
  categoryId: (json['category_id'] as num?)?.toInt(),
  eventTypeId: (json['event_type_id'] as num?)?.toInt(),
  eventDate: json['event_date'] as String?,
  eventHour: (json['event_hour'] as num?)?.toInt(),
  eventMinute: (json['event_minute'] as num?)?.toInt(),
  content: json['content'] as String?,
  isImportant: json['is_important'] as bool?,
  eventStatus: json['event_status'] as String?,
  studentId: (json['student_id'] as num?)?.toInt(),
  tcId: (json['tc_id'] as num?)?.toInt(),
  consultTypeCode: json['consult_type_code'] as String?,
);

Map<String, dynamic> _$$ScheduleEventUpdateImplToJson(
  _$ScheduleEventUpdateImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'event_type_id': instance.eventTypeId,
  'event_date': instance.eventDate,
  'event_hour': instance.eventHour,
  'event_minute': instance.eventMinute,
  'content': instance.content,
  'is_important': instance.isImportant,
  'event_status': instance.eventStatus,
  'student_id': instance.studentId,
  'tc_id': instance.tcId,
  'consult_type_code': instance.consultTypeCode,
};

_$ScheduleEventListParamsImpl _$$ScheduleEventListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleEventListParamsImpl(
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
  eventTypeId: (json['event_type_id'] as num?)?.toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  createdBy: (json['created_by'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 1000,
);

Map<String, dynamic> _$$ScheduleEventListParamsImplToJson(
  _$ScheduleEventListParamsImpl instance,
) => <String, dynamic>{
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
  'category_id': instance.categoryId,
  'event_type_id': instance.eventTypeId,
  'student_id': instance.studentId,
  'created_by': instance.createdBy,
  'page': instance.page,
  'perPage': instance.perPage,
};
