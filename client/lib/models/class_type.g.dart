// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassTypeTeacherImpl _$$ClassTypeTeacherImplFromJson(
  Map<String, dynamic> json,
) => _$ClassTypeTeacherImpl(
  teacherId: (json['teacher_id'] as num).toInt(),
  teacherName: json['teacher_name'] as String? ?? '',
);

Map<String, dynamic> _$$ClassTypeTeacherImplToJson(
  _$ClassTypeTeacherImpl instance,
) => <String, dynamic>{
  'teacher_id': instance.teacherId,
  'teacher_name': instance.teacherName,
};

_$ClassTypeImpl _$$ClassTypeImplFromJson(Map<String, dynamic> json) =>
    _$ClassTypeImpl(
      classTypeId: (json['class_type_id'] as num).toInt(),
      classTypeName: json['class_type_name'] as String,
      year: (json['year'] as num?)?.toInt(),
      grade: (json['grade'] as num).toInt(),
      subject: (json['subject'] as num).toInt(),
      format: (json['format'] as num?)?.toInt(),
      unitPrice: (json['unit_price'] as num?)?.toInt() ?? 0,
      teachers:
          (json['teachers'] as List<dynamic>?)
              ?.map((e) => ClassTypeTeacher.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isActive: json['is_active'] == null
          ? true
          : const IntToBoolConverter().fromJson(json['is_active']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ClassTypeImplToJson(_$ClassTypeImpl instance) =>
    <String, dynamic>{
      'class_type_id': instance.classTypeId,
      'class_type_name': instance.classTypeName,
      'year': instance.year,
      'grade': instance.grade,
      'subject': instance.subject,
      'format': instance.format,
      'unit_price': instance.unitPrice,
      'teachers': instance.teachers,
      'is_active': const IntToBoolConverter().toJson(instance.isActive),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ClassTypeCreateImpl _$$ClassTypeCreateImplFromJson(
  Map<String, dynamic> json,
) => _$ClassTypeCreateImpl(
  classTypeName: json['class_type_name'] as String,
  year: (json['year'] as num?)?.toInt(),
  grade: (json['grade'] as num).toInt(),
  subject: (json['subject'] as num).toInt(),
  format: (json['format'] as num?)?.toInt(),
  unitPrice: (json['unit_price'] as num?)?.toInt() ?? 0,
  teacherIds:
      (json['teacher_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  teacherNames:
      (json['teacher_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ClassTypeCreateImplToJson(
  _$ClassTypeCreateImpl instance,
) => <String, dynamic>{
  'class_type_name': instance.classTypeName,
  'year': instance.year,
  'grade': instance.grade,
  'subject': instance.subject,
  'format': instance.format,
  'unit_price': instance.unitPrice,
  'teacher_ids': instance.teacherIds,
  'teacher_names': instance.teacherNames,
};
