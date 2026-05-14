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
      schoolId: const FlexibleIntConverter().fromJson(json['school_id']),
      schoolName: json['school_name'] as String?,
      grade: const FlexibleIntConverter().fromJson(json['grade']),
      gradeName: json['grade_name'] as String?,
      guardianName: json['guardian_name'] as String?,
      guardianPhone: json['guardian_phone'] as String?,
      guardianRelation: const FlexibleIntConverter().fromJson(
        json['guardian_relation'],
      ),
      relationName: json['relation_name'] as String?,
      zipCode: json['zip_code'] as String?,
      address: json['address'] as String?,
      addressDetail: json['address_detail'] as String?,
      statusCode: json['status_code'] as String,
      statusName: json['status_name'] as String?,
      subStatusCode: json['sub_status_code'] as String?,
      subStatusName: json['sub_status_name'] as String?,
      classTypeCode: json['class_type_code'] as String?,
      classTypeName: json['class_type_name'] as String?,
      subjectCode: const FlexibleIntConverter().fromJson(json['subject_code']),
      sourceCode: json['source_code'] as String?,
      sourceName: json['source_name'] as String?,
      sourceDetail: json['source_detail'] as String?,
      tcId: const FlexibleIntConverter().fromJson(json['tc_id']),
      tcName: json['tc_name'] as String?,
      firstContactDate: json['first_contact_date'] as String?,
      consultDate: json['consult_date'] as String?,
      registerDate: json['register_date'] as String?,
      enrollDate: json['enroll_date'] as String?,
      enrollStartDate: json['enroll_start_date'] as String?,
      enrollEndDate: json['enroll_end_date'] as String?,
      withdrawDate: json['withdraw_date'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => ParentInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'school_id': const FlexibleIntConverter().toJson(instance.schoolId),
      'school_name': instance.schoolName,
      'grade': const FlexibleIntConverter().toJson(instance.grade),
      'grade_name': instance.gradeName,
      'guardian_name': instance.guardianName,
      'guardian_phone': instance.guardianPhone,
      'guardian_relation': const FlexibleIntConverter().toJson(
        instance.guardianRelation,
      ),
      'relation_name': instance.relationName,
      'zip_code': instance.zipCode,
      'address': instance.address,
      'address_detail': instance.addressDetail,
      'status_code': instance.statusCode,
      'status_name': instance.statusName,
      'sub_status_code': instance.subStatusCode,
      'sub_status_name': instance.subStatusName,
      'class_type_code': instance.classTypeCode,
      'class_type_name': instance.classTypeName,
      'subject_code': const FlexibleIntConverter().toJson(instance.subjectCode),
      'source_code': instance.sourceCode,
      'source_name': instance.sourceName,
      'source_detail': instance.sourceDetail,
      'tc_id': const FlexibleIntConverter().toJson(instance.tcId),
      'tc_name': instance.tcName,
      'first_contact_date': instance.firstContactDate,
      'consult_date': instance.consultDate,
      'register_date': instance.registerDate,
      'enroll_date': instance.enrollDate,
      'enroll_start_date': instance.enrollStartDate,
      'enroll_end_date': instance.enrollEndDate,
      'withdraw_date': instance.withdrawDate,
      'memo': instance.memo,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'parents': instance.parents,
    };

_$ParentInfoImpl _$$ParentInfoImplFromJson(Map<String, dynamic> json) =>
    _$ParentInfoImpl(
      parentId: (json['parent_id'] as num?)?.toInt(),
      phone: json['phone'] as String,
      seq: (json['seq'] as num?)?.toInt() ?? 1,
      parentKind: (json['parent_kind'] as num?)?.toInt() ?? 2,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ParentInfoImplToJson(_$ParentInfoImpl instance) =>
    <String, dynamic>{
      'parent_id': instance.parentId,
      'phone': instance.phone,
      'seq': instance.seq,
      'parent_kind': instance.parentKind,
      'name': instance.name,
    };

_$StudentUpdateImpl _$$StudentUpdateImplFromJson(Map<String, dynamic> json) =>
    _$StudentUpdateImpl(
      studentName: json['student_name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      birthDate: json['birth_date'] as String?,
      genderCode: json['gender_code'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
      classTypeCode: json['class_type_code'] as String?,
      subjectCode: (json['subject_code'] as num?)?.toInt(),
      sourceCode: json['source_code'] as String?,
      enrollStartDate: json['enroll_start_date'] as String?,
      enrollEndDate: json['enroll_end_date'] as String?,
      zipCode: json['zip_code'] as String?,
      address: json['address'] as String?,
      addressDetail: json['address_detail'] as String?,
      memo: json['memo'] as String?,
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => ParentInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StudentUpdateImplToJson(_$StudentUpdateImpl instance) =>
    <String, dynamic>{
      'student_name': instance.studentName,
      'phone': instance.phone,
      'email': instance.email,
      'birth_date': instance.birthDate,
      'gender_code': instance.genderCode,
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'grade': instance.grade,
      'class_type_code': instance.classTypeCode,
      'subject_code': instance.subjectCode,
      'source_code': instance.sourceCode,
      'enroll_start_date': instance.enrollStartDate,
      'enroll_end_date': instance.enrollEndDate,
      'zip_code': instance.zipCode,
      'address': instance.address,
      'address_detail': instance.addressDetail,
      'memo': instance.memo,
      'parents': instance.parents,
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

_$StudentCreateImpl _$$StudentCreateImplFromJson(Map<String, dynamic> json) =>
    _$StudentCreateImpl(
      studentName: json['student_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      birthDate: json['birth_date'] as String?,
      genderCode: json['gender_code'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
      classTypeCode: json['class_type_code'] as String?,
      subjectCode: (json['subject_code'] as num?)?.toInt(),
      statusCode: json['status_code'] as String?,
      sourceCode: json['source_code'] as String?,
      sourceDetail: json['source_detail'] as String?,
      enrollStartDate: json['enroll_start_date'] as String?,
      enrollEndDate: json['enroll_end_date'] as String?,
      tcId: (json['tc_id'] as num?)?.toInt(),
      memo: json['memo'] as String?,
      guardianName: json['guardian_name'] as String?,
      guardianPhone: json['guardian_phone'] as String?,
      parentKind: (json['parent_kind'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$StudentCreateImplToJson(_$StudentCreateImpl instance) =>
    <String, dynamic>{
      'student_name': instance.studentName,
      'phone': instance.phone,
      'email': instance.email,
      'birth_date': instance.birthDate,
      'gender_code': instance.genderCode,
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'grade': instance.grade,
      'class_type_code': instance.classTypeCode,
      'subject_code': instance.subjectCode,
      'status_code': instance.statusCode,
      'source_code': instance.sourceCode,
      'source_detail': instance.sourceDetail,
      'enroll_start_date': instance.enrollStartDate,
      'enroll_end_date': instance.enrollEndDate,
      'tc_id': instance.tcId,
      'memo': instance.memo,
      'guardian_name': instance.guardianName,
      'guardian_phone': instance.guardianPhone,
      'parent_kind': instance.parentKind,
    };

_$StudentListParamsImpl _$$StudentListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$StudentListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 500,
  sort: json['sort'] as String? ?? 'student_name',
  order: json['order'] as String? ?? 'asc',
  search: json['search'] as String?,
  statusCode: json['status_code'] as String?,
  grade: (json['grade'] as num?)?.toInt(),
  classTypeCode: json['class_type_code'] as String?,
  subjectCode: (json['subject_code'] as num?)?.toInt(),
  sourceCode: json['source_code'] as String?,
  tcId: (json['tc_id'] as num?)?.toInt(),
  schoolId: (json['school_id'] as num?)?.toInt(),
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
  'class_type_code': instance.classTypeCode,
  'subject_code': instance.subjectCode,
  'source_code': instance.sourceCode,
  'tc_id': instance.tcId,
  'school_id': instance.schoolId,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
};

_$StudentHistoryImpl _$$StudentHistoryImplFromJson(Map<String, dynamic> json) =>
    _$StudentHistoryImpl(
      historyId: (json['history_id'] as num).toInt(),
      studentId: (json['student_id'] as num).toInt(),
      prevStatusCode: json['prev_status_code'] as String?,
      prevStatusName: json['prev_status_name'] as String?,
      newStatusCode: json['new_status_code'] as String,
      newStatusName: json['new_status_name'] as String?,
      prevSubStatus: json['prev_sub_status'] as String?,
      prevSubStatusName: json['prev_sub_status_name'] as String?,
      newSubStatus: json['new_sub_status'] as String?,
      newSubStatusName: json['new_sub_status_name'] as String?,
      changeTypeCode: json['change_type_code'] as String,
      changeTypeName: json['change_type_name'] as String?,
      changeReasonCode: json['change_reason_code'] as String?,
      changeReasonName: json['change_reason_name'] as String?,
      changeReason: json['change_reason'] as String?,
      prevTcId: (json['prev_tc_id'] as num?)?.toInt(),
      prevTcName: json['prev_tc_name'] as String?,
      newTcId: (json['new_tc_id'] as num?)?.toInt(),
      newTcName: json['new_tc_name'] as String?,
      changedBy: (json['changed_by'] as num).toInt(),
      changedByName: json['changed_by_name'] as String?,
      changedAt: json['changed_at'] as String,
    );

Map<String, dynamic> _$$StudentHistoryImplToJson(
  _$StudentHistoryImpl instance,
) => <String, dynamic>{
  'history_id': instance.historyId,
  'student_id': instance.studentId,
  'prev_status_code': instance.prevStatusCode,
  'prev_status_name': instance.prevStatusName,
  'new_status_code': instance.newStatusCode,
  'new_status_name': instance.newStatusName,
  'prev_sub_status': instance.prevSubStatus,
  'prev_sub_status_name': instance.prevSubStatusName,
  'new_sub_status': instance.newSubStatus,
  'new_sub_status_name': instance.newSubStatusName,
  'change_type_code': instance.changeTypeCode,
  'change_type_name': instance.changeTypeName,
  'change_reason_code': instance.changeReasonCode,
  'change_reason_name': instance.changeReasonName,
  'change_reason': instance.changeReason,
  'prev_tc_id': instance.prevTcId,
  'prev_tc_name': instance.prevTcName,
  'new_tc_id': instance.newTcId,
  'new_tc_name': instance.newTcName,
  'changed_by': instance.changedBy,
  'changed_by_name': instance.changedByName,
  'changed_at': instance.changedAt,
};
