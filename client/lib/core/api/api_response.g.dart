// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  success: json['success'] as bool,
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  meta: json['meta'] == null
      ? null
      : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
  errors: (json['errors'] as List<dynamic>?)
      ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'code': instance.code,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'meta': instance.meta,
  'errors': instance.errors,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$PaginationMetaImpl _$$PaginationMetaImplFromJson(Map<String, dynamic> json) =>
    _$PaginationMetaImpl(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$$PaginationMetaImplToJson(
  _$PaginationMetaImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'page': instance.page,
  'perPage': instance.perPage,
  'totalPages': instance.totalPages,
};

_$ValidationErrorImpl _$$ValidationErrorImplFromJson(
  Map<String, dynamic> json,
) => _$ValidationErrorImpl(
  field: json['field'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$$ValidationErrorImplToJson(
  _$ValidationErrorImpl instance,
) => <String, dynamic>{'field': instance.field, 'message': instance.message};
