// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_inquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewInquiryCreateImpl _$$NewInquiryCreateImplFromJson(
  Map<String, dynamic> json,
) => _$NewInquiryCreateImpl(
  consultDate: json['consult_date'] as String,
  studentName: json['student_name'] as String,
  studentId: (json['student_id'] as num?)?.toInt(),
  genderCode: json['gender_code'] as String?,
  schoolId: (json['school_id'] as num?)?.toInt(),
  schoolName: json['school_name'] as String?,
  grade: (json['grade'] as num?)?.toInt(),
  inquirySourceCode: json['inquiry_source_code'] as String?,
  subjectCode: (json['subject_code'] as num?)?.toInt(),
  interestSubject: json['interest_subject'] as String?,
  studentPhone: json['student_phone'] as String?,
  guardianPhone: json['guardian_phone'] as String?,
  selectorName: json['selector_name'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$$NewInquiryCreateImplToJson(
  _$NewInquiryCreateImpl instance,
) => <String, dynamic>{
  'consult_date': instance.consultDate,
  'student_name': instance.studentName,
  'student_id': instance.studentId,
  'gender_code': instance.genderCode,
  'school_id': instance.schoolId,
  'school_name': instance.schoolName,
  'grade': instance.grade,
  'inquiry_source_code': instance.inquirySourceCode,
  'subject_code': instance.subjectCode,
  'interest_subject': instance.interestSubject,
  'student_phone': instance.studentPhone,
  'guardian_phone': instance.guardianPhone,
  'selector_name': instance.selectorName,
  'content': instance.content,
};

_$NewInquiryResultImpl _$$NewInquiryResultImplFromJson(
  Map<String, dynamic> json,
) => _$NewInquiryResultImpl(
  consultId: (json['consult_id'] as num).toInt(),
  studentId: (json['student_id'] as num).toInt(),
  studentName: json['student_name'] as String,
  isNewStudent: json['is_new_student'] as bool? ?? false,
  guardianCreated: json['guardian_created'] as bool? ?? false,
);

Map<String, dynamic> _$$NewInquiryResultImplToJson(
  _$NewInquiryResultImpl instance,
) => <String, dynamic>{
  'consult_id': instance.consultId,
  'student_id': instance.studentId,
  'student_name': instance.studentName,
  'is_new_student': instance.isNewStudent,
  'guardian_created': instance.guardianCreated,
};

_$InquiryStudentLookupImpl _$$InquiryStudentLookupImplFromJson(
  Map<String, dynamic> json,
) => _$InquiryStudentLookupImpl(
  studentId: (json['student_id'] as num).toInt(),
  studentName: json['student_name'] as String,
  phone: json['phone'] as String?,
  activeFlag: (json['active_flag'] as num?)?.toInt() ?? 0,
  grade: (json['grade'] as num?)?.toInt(),
  genderCode: json['gender_code'] as String?,
  schoolId: (json['school_id'] as num?)?.toInt(),
  schoolName: json['school_name'] as String?,
  subjectCode: (json['subject_code'] as num?)?.toInt(),
  guardianPhone: json['guardian_phone'] as String?,
);

Map<String, dynamic> _$$InquiryStudentLookupImplToJson(
  _$InquiryStudentLookupImpl instance,
) => <String, dynamic>{
  'student_id': instance.studentId,
  'student_name': instance.studentName,
  'phone': instance.phone,
  'active_flag': instance.activeFlag,
  'grade': instance.grade,
  'gender_code': instance.genderCode,
  'school_id': instance.schoolId,
  'school_name': instance.schoolName,
  'subject_code': instance.subjectCode,
  'guardian_phone': instance.guardianPhone,
};
