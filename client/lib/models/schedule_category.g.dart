// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleCategoryImpl _$$ScheduleCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleCategoryImpl(
  categoryId: (json['category_id'] as num).toInt(),
  categoryName: json['category_name'] as String,
  categoryType: json['category_type'] as String,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
  isActive: json['is_active'] == null
      ? true
      : const IntToBoolConverter().fromJson(json['is_active']),
);

Map<String, dynamic> _$$ScheduleCategoryImplToJson(
  _$ScheduleCategoryImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'category_type': instance.categoryType,
  'sort_order': instance.sortOrder,
  'is_active': const IntToBoolConverter().toJson(instance.isActive),
};
