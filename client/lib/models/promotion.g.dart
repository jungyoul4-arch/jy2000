// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionImpl _$$PromotionImplFromJson(Map<String, dynamic> json) =>
    _$PromotionImpl(
      promotionId: (json['promotion_id'] as num).toInt(),
      promotionName: json['promotion_name'] as String,
      promotionCode: json['promotion_code'] as String?,
      promotionTypeCode: json['promotion_type_code'] as String?,
      promotionTypeName: json['promotion_type_name'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      description: json['description'] as String?,
      discountTypeCode: json['discount_type_code'] as String?,
      discountTypeName: json['discount_type_name'] as String?,
      discountValue: _parseDouble(json['discount_value']),
      targetGrade: json['target_grade'] as String?,
      targetSubject: json['target_subject'] as String?,
      isActive: json['is_active'] == null
          ? true
          : _parseBool(json['is_active']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$PromotionImplToJson(_$PromotionImpl instance) =>
    <String, dynamic>{
      'promotion_id': instance.promotionId,
      'promotion_name': instance.promotionName,
      'promotion_code': instance.promotionCode,
      'promotion_type_code': instance.promotionTypeCode,
      'promotion_type_name': instance.promotionTypeName,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'description': instance.description,
      'discount_type_code': instance.discountTypeCode,
      'discount_type_name': instance.discountTypeName,
      'discount_value': instance.discountValue,
      'target_grade': instance.targetGrade,
      'target_subject': instance.targetSubject,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$PromotionCreateImpl _$$PromotionCreateImplFromJson(
  Map<String, dynamic> json,
) => _$PromotionCreateImpl(
  promotionName: json['promotion_name'] as String,
  promotionCode: json['promotion_code'] as String?,
  promotionTypeCode: json['promotion_type_code'] as String?,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String?,
  description: json['description'] as String?,
  discountTypeCode: json['discount_type_code'] as String?,
  discountValue: (json['discount_value'] as num?)?.toDouble(),
  targetGrade: json['target_grade'] as String?,
  targetSubject: json['target_subject'] as String?,
);

Map<String, dynamic> _$$PromotionCreateImplToJson(
  _$PromotionCreateImpl instance,
) => <String, dynamic>{
  'promotion_name': instance.promotionName,
  'promotion_code': instance.promotionCode,
  'promotion_type_code': instance.promotionTypeCode,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'description': instance.description,
  'discount_type_code': instance.discountTypeCode,
  'discount_value': instance.discountValue,
  'target_grade': instance.targetGrade,
  'target_subject': instance.targetSubject,
};

_$PromotionListParamsImpl _$$PromotionListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$PromotionListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 20,
  sort: json['sort'] as String?,
  order: json['order'] as String?,
  search: json['search'] as String?,
);

Map<String, dynamic> _$$PromotionListParamsImplToJson(
  _$PromotionListParamsImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'sort': instance.sort,
  'order': instance.order,
  'search': instance.search,
};

_$PromotionAttendeeImpl _$$PromotionAttendeeImplFromJson(
  Map<String, dynamic> json,
) => _$PromotionAttendeeImpl(
  id: (json['id'] as num).toInt(),
  studentId: (json['student_id'] as num).toInt(),
  studentName: json['student_name'] as String?,
  studentPhone: json['student_phone'] as String?,
  schoolName: json['school_name'] as String?,
  grade: (json['grade'] as num?)?.toInt(),
  statusCode: json['status_code'] as String?,
  statusName: json['status_name'] as String?,
  appliedDate: json['applied_date'] as String?,
  memo: json['memo'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$$PromotionAttendeeImplToJson(
  _$PromotionAttendeeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'student_id': instance.studentId,
  'student_name': instance.studentName,
  'student_phone': instance.studentPhone,
  'school_name': instance.schoolName,
  'grade': instance.grade,
  'status_code': instance.statusCode,
  'status_name': instance.statusName,
  'applied_date': instance.appliedDate,
  'memo': instance.memo,
  'created_at': instance.createdAt,
};

_$NewAttendeeDataImpl _$$NewAttendeeDataImplFromJson(
  Map<String, dynamic> json,
) => _$NewAttendeeDataImpl(
  name: json['name'] as String,
  phone: json['phone'] as String,
  schoolId: (json['school_id'] as num?)?.toInt(),
  grade: (json['grade'] as num?)?.toInt(),
  memo: json['memo'] as String?,
);

Map<String, dynamic> _$$NewAttendeeDataImplToJson(
  _$NewAttendeeDataImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'school_id': instance.schoolId,
  'grade': instance.grade,
  'memo': instance.memo,
};

_$UserSearchResultImpl _$$UserSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$UserSearchResultImpl(
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String,
  grade: (json['grade'] as num?)?.toInt(),
  schoolName: json['school_name'] as String?,
  statusCode: json['status_code'] as String?,
  statusName: json['status_name'] as String?,
);

Map<String, dynamic> _$$UserSearchResultImplToJson(
  _$UserSearchResultImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'name': instance.name,
  'phone': instance.phone,
  'grade': instance.grade,
  'school_name': instance.schoolName,
  'status_code': instance.statusCode,
  'status_name': instance.statusName,
};
