// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mgmt_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MgmtDataImpl _$$MgmtDataImplFromJson(Map<String, dynamic> json) =>
    _$MgmtDataImpl(
      mgmtDataId: (json['mgmt_data_id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      studentId: (json['student_id'] as num?)?.toInt(),
      studentName: json['student_name'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
      enrollmentCount: json['enrollment_count'] == null
          ? 1.0
          : const StringToDoubleConverter().fromJson(json['enrollment_count']),
      compClassType: json['comp_class_type'] as String?,
      subject: json['subject'] as String?,
      teacherId: (json['teacher_id'] as num?)?.toInt(),
      teacherName: json['teacher_name'] as String?,
      className1: json['class_name1'] as String?,
      classTypeId: (json['class_type_id'] as num?)?.toInt(),
      classTypeName: json['class_type_name'] as String?,
      unitPrice: (json['unit_price'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 0,
      studentNameOrig: json['student_name_orig'] as String?,
      teacherNameOrig: json['teacher_name_orig'] as String?,
      classTypeNameOrig: json['class_type_name_orig'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$MgmtDataImplToJson(_$MgmtDataImpl instance) =>
    <String, dynamic>{
      'mgmt_data_id': instance.mgmtDataId,
      'year': instance.year,
      'month': instance.month,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'grade': instance.grade,
      'enrollment_count': const StringToDoubleConverter().toJson(
        instance.enrollmentCount,
      ),
      'comp_class_type': instance.compClassType,
      'subject': instance.subject,
      'teacher_id': instance.teacherId,
      'teacher_name': instance.teacherName,
      'class_name1': instance.className1,
      'class_type_id': instance.classTypeId,
      'class_type_name': instance.classTypeName,
      'unit_price': instance.unitPrice,
      'price': instance.price,
      'student_name_orig': instance.studentNameOrig,
      'teacher_name_orig': instance.teacherNameOrig,
      'class_type_name_orig': instance.classTypeNameOrig,
      'created_at': instance.createdAt,
    };

_$YearMonthImpl _$$YearMonthImplFromJson(Map<String, dynamic> json) =>
    _$YearMonthImpl(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
    );

Map<String, dynamic> _$$YearMonthImplToJson(_$YearMonthImpl instance) =>
    <String, dynamic>{'year': instance.year, 'month': instance.month};
