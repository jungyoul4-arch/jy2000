// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      studentId: (json['student_id'] as num).toInt(),
      studentName: json['student_name'] as String,
      phone: json['phone'] as String,
      phoneSub: json['phone_sub'] as String?,
      email: json['email'] as String?,
      birthDate: json['birth_date'] as String?,
      genderCode: json['gender_code'] as String?,
      genderName: json['gender_name'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
      gradeName: json['grade_name'] as String?,
      guardianName: json['guardian_name'] as String?,
      guardianPhone: json['guardian_phone'] as String?,
      guardianRelation: json['guardian_relation'] as String?,
      relationName: json['relation_name'] as String?,
      address: json['address'] as String?,
      addressDetail: json['address_detail'] as String?,
      statusCode: json['status_code'] as String,
      statusName: json['status_name'] as String?,
      subStatusCode: json['sub_status_code'] as String?,
      subStatusName: json['sub_status_name'] as String?,
      sourceCode: json['source_code'] as String?,
      sourceName: json['source_name'] as String?,
      sourceDetail: json['source_detail'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      tcName: json['tc_name'] as String?,
      firstContactDate: json['first_contact_date'] as String?,
      consultDate: json['consult_date'] as String?,
      registerDate: json['register_date'] as String?,
      enrollDate: json['enroll_date'] as String?,
      withdrawDate: json['withdraw_date'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'phone': instance.phone,
      'phone_sub': instance.phoneSub,
      'email': instance.email,
      'birth_date': instance.birthDate,
      'gender_code': instance.genderCode,
      'gender_name': instance.genderName,
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'grade': instance.grade,
      'grade_name': instance.gradeName,
      'guardian_name': instance.guardianName,
      'guardian_phone': instance.guardianPhone,
      'guardian_relation': instance.guardianRelation,
      'relation_name': instance.relationName,
      'address': instance.address,
      'address_detail': instance.addressDetail,
      'status_code': instance.statusCode,
      'status_name': instance.statusName,
      'sub_status_code': instance.subStatusCode,
      'sub_status_name': instance.subStatusName,
      'source_code': instance.sourceCode,
      'source_name': instance.sourceName,
      'source_detail': instance.sourceDetail,
      'tc_id': instance.tcId,
      'tc_name': instance.tcName,
      'first_contact_date': instance.firstContactDate,
      'consult_date': instance.consultDate,
      'register_date': instance.registerDate,
      'enroll_date': instance.enrollDate,
      'withdraw_date': instance.withdrawDate,
      'memo': instance.memo,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$StudentStateChangeImpl _$$StudentStateChangeImplFromJson(
  Map<String, dynamic> json,
) => _$StudentStateChangeImpl(
  studentId: (json['student_id'] as num).toInt(),
  newStatusCode: json['new_status_code'] as String,
  newSubStatusCode: json['new_sub_status_code'] as String?,
  changeReason: json['change_reason'] as String?,
  newTcId: (json['new_tc_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$$StudentStateChangeImplToJson(
  _$StudentStateChangeImpl instance,
) => <String, dynamic>{
  'student_id': instance.studentId,
  'new_status_code': instance.newStatusCode,
  'new_sub_status_code': instance.newSubStatusCode,
  'change_reason': instance.changeReason,
  'new_tc_id': instance.newTcId,
};

_$StudentListParamsImpl _$$StudentListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$StudentListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 20,
  sort: json['sort'] as String?,
  order: json['order'] as String?,
  search: json['search'] as String?,
  statusCode: json['status_code'] as String?,
  grade: (json['grade'] as num?)?.toInt(),
  tcId: (json['tc_id'] as num?)?.toInt(),
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
);

Map<String, dynamic> _$$StudentListParamsImplToJson(
  _$StudentListParamsImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'sort': instance.sort,
  'order': instance.order,
  'search': instance.search,
  'status_code': instance.statusCode,
  'grade': instance.grade,
  'tc_id': instance.tcId,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
};
