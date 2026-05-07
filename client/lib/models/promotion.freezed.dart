// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return _Promotion.fromJson(json);
}

/// @nodoc
mixin _$Promotion {
  @JsonKey(name: 'promotion_id')
  int get promotionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_name')
  String get promotionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_code')
  String? get promotionCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_type_code')
  String? get promotionTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_type_name')
  String? get promotionTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type_code')
  String? get discountTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type_name')
  String? get discountTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value', fromJson: _parseDouble)
  double? get discountValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_grade')
  String? get targetGrade => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_subject')
  String? get targetSubject => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _parseBool)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Promotion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotionCopyWith<Promotion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionCopyWith<$Res> {
  factory $PromotionCopyWith(Promotion value, $Res Function(Promotion) then) =
      _$PromotionCopyWithImpl<$Res, Promotion>;
  @useResult
  $Res call({
    @JsonKey(name: 'promotion_id') int promotionId,
    @JsonKey(name: 'promotion_name') String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'promotion_type_name') String? promotionTypeName,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_type_name') String? discountTypeName,
    @JsonKey(name: 'discount_value', fromJson: _parseDouble)
    double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
    @JsonKey(name: 'is_active', fromJson: _parseBool) bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$PromotionCopyWithImpl<$Res, $Val extends Promotion>
    implements $PromotionCopyWith<$Res> {
  _$PromotionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionId = null,
    Object? promotionName = null,
    Object? promotionCode = freezed,
    Object? promotionTypeCode = freezed,
    Object? promotionTypeName = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? discountTypeCode = freezed,
    Object? discountTypeName = freezed,
    Object? discountValue = freezed,
    Object? targetGrade = freezed,
    Object? targetSubject = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            promotionId: null == promotionId
                ? _value.promotionId
                : promotionId // ignore: cast_nullable_to_non_nullable
                      as int,
            promotionName: null == promotionName
                ? _value.promotionName
                : promotionName // ignore: cast_nullable_to_non_nullable
                      as String,
            promotionCode: freezed == promotionCode
                ? _value.promotionCode
                : promotionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            promotionTypeCode: freezed == promotionTypeCode
                ? _value.promotionTypeCode
                : promotionTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            promotionTypeName: freezed == promotionTypeName
                ? _value.promotionTypeName
                : promotionTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountTypeCode: freezed == discountTypeCode
                ? _value.discountTypeCode
                : discountTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountTypeName: freezed == discountTypeName
                ? _value.discountTypeName
                : discountTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountValue: freezed == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as double?,
            targetGrade: freezed == targetGrade
                ? _value.targetGrade
                : targetGrade // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetSubject: freezed == targetSubject
                ? _value.targetSubject
                : targetSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromotionImplCopyWith<$Res>
    implements $PromotionCopyWith<$Res> {
  factory _$$PromotionImplCopyWith(
    _$PromotionImpl value,
    $Res Function(_$PromotionImpl) then,
  ) = __$$PromotionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'promotion_id') int promotionId,
    @JsonKey(name: 'promotion_name') String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'promotion_type_name') String? promotionTypeName,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_type_name') String? discountTypeName,
    @JsonKey(name: 'discount_value', fromJson: _parseDouble)
    double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
    @JsonKey(name: 'is_active', fromJson: _parseBool) bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$PromotionImplCopyWithImpl<$Res>
    extends _$PromotionCopyWithImpl<$Res, _$PromotionImpl>
    implements _$$PromotionImplCopyWith<$Res> {
  __$$PromotionImplCopyWithImpl(
    _$PromotionImpl _value,
    $Res Function(_$PromotionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionId = null,
    Object? promotionName = null,
    Object? promotionCode = freezed,
    Object? promotionTypeCode = freezed,
    Object? promotionTypeName = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? discountTypeCode = freezed,
    Object? discountTypeName = freezed,
    Object? discountValue = freezed,
    Object? targetGrade = freezed,
    Object? targetSubject = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PromotionImpl(
        promotionId: null == promotionId
            ? _value.promotionId
            : promotionId // ignore: cast_nullable_to_non_nullable
                  as int,
        promotionName: null == promotionName
            ? _value.promotionName
            : promotionName // ignore: cast_nullable_to_non_nullable
                  as String,
        promotionCode: freezed == promotionCode
            ? _value.promotionCode
            : promotionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        promotionTypeCode: freezed == promotionTypeCode
            ? _value.promotionTypeCode
            : promotionTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        promotionTypeName: freezed == promotionTypeName
            ? _value.promotionTypeName
            : promotionTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountTypeCode: freezed == discountTypeCode
            ? _value.discountTypeCode
            : discountTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountTypeName: freezed == discountTypeName
            ? _value.discountTypeName
            : discountTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountValue: freezed == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as double?,
        targetGrade: freezed == targetGrade
            ? _value.targetGrade
            : targetGrade // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetSubject: freezed == targetSubject
            ? _value.targetSubject
            : targetSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionImpl implements _Promotion {
  const _$PromotionImpl({
    @JsonKey(name: 'promotion_id') required this.promotionId,
    @JsonKey(name: 'promotion_name') required this.promotionName,
    @JsonKey(name: 'promotion_code') this.promotionCode,
    @JsonKey(name: 'promotion_type_code') this.promotionTypeCode,
    @JsonKey(name: 'promotion_type_name') this.promotionTypeName,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') this.endDate,
    this.description,
    @JsonKey(name: 'discount_type_code') this.discountTypeCode,
    @JsonKey(name: 'discount_type_name') this.discountTypeName,
    @JsonKey(name: 'discount_value', fromJson: _parseDouble) this.discountValue,
    @JsonKey(name: 'target_grade') this.targetGrade,
    @JsonKey(name: 'target_subject') this.targetSubject,
    @JsonKey(name: 'is_active', fromJson: _parseBool) this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$PromotionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionImplFromJson(json);

  @override
  @JsonKey(name: 'promotion_id')
  final int promotionId;
  @override
  @JsonKey(name: 'promotion_name')
  final String promotionName;
  @override
  @JsonKey(name: 'promotion_code')
  final String? promotionCode;
  @override
  @JsonKey(name: 'promotion_type_code')
  final String? promotionTypeCode;
  @override
  @JsonKey(name: 'promotion_type_name')
  final String? promotionTypeName;
  @override
  @JsonKey(name: 'start_date')
  final String startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  final String? description;
  @override
  @JsonKey(name: 'discount_type_code')
  final String? discountTypeCode;
  @override
  @JsonKey(name: 'discount_type_name')
  final String? discountTypeName;
  @override
  @JsonKey(name: 'discount_value', fromJson: _parseDouble)
  final double? discountValue;
  @override
  @JsonKey(name: 'target_grade')
  final String? targetGrade;
  @override
  @JsonKey(name: 'target_subject')
  final String? targetSubject;
  @override
  @JsonKey(name: 'is_active', fromJson: _parseBool)
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Promotion(promotionId: $promotionId, promotionName: $promotionName, promotionCode: $promotionCode, promotionTypeCode: $promotionTypeCode, promotionTypeName: $promotionTypeName, startDate: $startDate, endDate: $endDate, description: $description, discountTypeCode: $discountTypeCode, discountTypeName: $discountTypeName, discountValue: $discountValue, targetGrade: $targetGrade, targetSubject: $targetSubject, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionImpl &&
            (identical(other.promotionId, promotionId) ||
                other.promotionId == promotionId) &&
            (identical(other.promotionName, promotionName) ||
                other.promotionName == promotionName) &&
            (identical(other.promotionCode, promotionCode) ||
                other.promotionCode == promotionCode) &&
            (identical(other.promotionTypeCode, promotionTypeCode) ||
                other.promotionTypeCode == promotionTypeCode) &&
            (identical(other.promotionTypeName, promotionTypeName) ||
                other.promotionTypeName == promotionTypeName) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discountTypeCode, discountTypeCode) ||
                other.discountTypeCode == discountTypeCode) &&
            (identical(other.discountTypeName, discountTypeName) ||
                other.discountTypeName == discountTypeName) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.targetGrade, targetGrade) ||
                other.targetGrade == targetGrade) &&
            (identical(other.targetSubject, targetSubject) ||
                other.targetSubject == targetSubject) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    promotionId,
    promotionName,
    promotionCode,
    promotionTypeCode,
    promotionTypeName,
    startDate,
    endDate,
    description,
    discountTypeCode,
    discountTypeName,
    discountValue,
    targetGrade,
    targetSubject,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      __$$PromotionImplCopyWithImpl<_$PromotionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionImplToJson(this);
  }
}

abstract class _Promotion implements Promotion {
  const factory _Promotion({
    @JsonKey(name: 'promotion_id') required final int promotionId,
    @JsonKey(name: 'promotion_name') required final String promotionName,
    @JsonKey(name: 'promotion_code') final String? promotionCode,
    @JsonKey(name: 'promotion_type_code') final String? promotionTypeCode,
    @JsonKey(name: 'promotion_type_name') final String? promotionTypeName,
    @JsonKey(name: 'start_date') required final String startDate,
    @JsonKey(name: 'end_date') final String? endDate,
    final String? description,
    @JsonKey(name: 'discount_type_code') final String? discountTypeCode,
    @JsonKey(name: 'discount_type_name') final String? discountTypeName,
    @JsonKey(name: 'discount_value', fromJson: _parseDouble)
    final double? discountValue,
    @JsonKey(name: 'target_grade') final String? targetGrade,
    @JsonKey(name: 'target_subject') final String? targetSubject,
    @JsonKey(name: 'is_active', fromJson: _parseBool) final bool isActive,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$PromotionImpl;

  factory _Promotion.fromJson(Map<String, dynamic> json) =
      _$PromotionImpl.fromJson;

  @override
  @JsonKey(name: 'promotion_id')
  int get promotionId;
  @override
  @JsonKey(name: 'promotion_name')
  String get promotionName;
  @override
  @JsonKey(name: 'promotion_code')
  String? get promotionCode;
  @override
  @JsonKey(name: 'promotion_type_code')
  String? get promotionTypeCode;
  @override
  @JsonKey(name: 'promotion_type_name')
  String? get promotionTypeName;
  @override
  @JsonKey(name: 'start_date')
  String get startDate;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate;
  @override
  String? get description;
  @override
  @JsonKey(name: 'discount_type_code')
  String? get discountTypeCode;
  @override
  @JsonKey(name: 'discount_type_name')
  String? get discountTypeName;
  @override
  @JsonKey(name: 'discount_value', fromJson: _parseDouble)
  double? get discountValue;
  @override
  @JsonKey(name: 'target_grade')
  String? get targetGrade;
  @override
  @JsonKey(name: 'target_subject')
  String? get targetSubject;
  @override
  @JsonKey(name: 'is_active', fromJson: _parseBool)
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromotionCreate _$PromotionCreateFromJson(Map<String, dynamic> json) {
  return _PromotionCreate.fromJson(json);
}

/// @nodoc
mixin _$PromotionCreate {
  @JsonKey(name: 'promotion_name')
  String get promotionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_code')
  String? get promotionCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_type_code')
  String? get promotionTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type_code')
  String? get discountTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value')
  double? get discountValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_grade')
  String? get targetGrade => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_subject')
  String? get targetSubject => throw _privateConstructorUsedError;

  /// Serializes this PromotionCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotionCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotionCreateCopyWith<PromotionCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionCreateCopyWith<$Res> {
  factory $PromotionCreateCopyWith(
    PromotionCreate value,
    $Res Function(PromotionCreate) then,
  ) = _$PromotionCreateCopyWithImpl<$Res, PromotionCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'promotion_name') String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
  });
}

/// @nodoc
class _$PromotionCreateCopyWithImpl<$Res, $Val extends PromotionCreate>
    implements $PromotionCreateCopyWith<$Res> {
  _$PromotionCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotionCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionName = null,
    Object? promotionCode = freezed,
    Object? promotionTypeCode = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? discountTypeCode = freezed,
    Object? discountValue = freezed,
    Object? targetGrade = freezed,
    Object? targetSubject = freezed,
  }) {
    return _then(
      _value.copyWith(
            promotionName: null == promotionName
                ? _value.promotionName
                : promotionName // ignore: cast_nullable_to_non_nullable
                      as String,
            promotionCode: freezed == promotionCode
                ? _value.promotionCode
                : promotionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            promotionTypeCode: freezed == promotionTypeCode
                ? _value.promotionTypeCode
                : promotionTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountTypeCode: freezed == discountTypeCode
                ? _value.discountTypeCode
                : discountTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountValue: freezed == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as double?,
            targetGrade: freezed == targetGrade
                ? _value.targetGrade
                : targetGrade // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetSubject: freezed == targetSubject
                ? _value.targetSubject
                : targetSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromotionCreateImplCopyWith<$Res>
    implements $PromotionCreateCopyWith<$Res> {
  factory _$$PromotionCreateImplCopyWith(
    _$PromotionCreateImpl value,
    $Res Function(_$PromotionCreateImpl) then,
  ) = __$$PromotionCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'promotion_name') String promotionName,
    @JsonKey(name: 'promotion_code') String? promotionCode,
    @JsonKey(name: 'promotion_type_code') String? promotionTypeCode,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? description,
    @JsonKey(name: 'discount_type_code') String? discountTypeCode,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'target_grade') String? targetGrade,
    @JsonKey(name: 'target_subject') String? targetSubject,
  });
}

/// @nodoc
class __$$PromotionCreateImplCopyWithImpl<$Res>
    extends _$PromotionCreateCopyWithImpl<$Res, _$PromotionCreateImpl>
    implements _$$PromotionCreateImplCopyWith<$Res> {
  __$$PromotionCreateImplCopyWithImpl(
    _$PromotionCreateImpl _value,
    $Res Function(_$PromotionCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromotionCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionName = null,
    Object? promotionCode = freezed,
    Object? promotionTypeCode = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? discountTypeCode = freezed,
    Object? discountValue = freezed,
    Object? targetGrade = freezed,
    Object? targetSubject = freezed,
  }) {
    return _then(
      _$PromotionCreateImpl(
        promotionName: null == promotionName
            ? _value.promotionName
            : promotionName // ignore: cast_nullable_to_non_nullable
                  as String,
        promotionCode: freezed == promotionCode
            ? _value.promotionCode
            : promotionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        promotionTypeCode: freezed == promotionTypeCode
            ? _value.promotionTypeCode
            : promotionTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountTypeCode: freezed == discountTypeCode
            ? _value.discountTypeCode
            : discountTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountValue: freezed == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as double?,
        targetGrade: freezed == targetGrade
            ? _value.targetGrade
            : targetGrade // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetSubject: freezed == targetSubject
            ? _value.targetSubject
            : targetSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionCreateImpl implements _PromotionCreate {
  const _$PromotionCreateImpl({
    @JsonKey(name: 'promotion_name') required this.promotionName,
    @JsonKey(name: 'promotion_code') this.promotionCode,
    @JsonKey(name: 'promotion_type_code') this.promotionTypeCode,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') this.endDate,
    this.description,
    @JsonKey(name: 'discount_type_code') this.discountTypeCode,
    @JsonKey(name: 'discount_value') this.discountValue,
    @JsonKey(name: 'target_grade') this.targetGrade,
    @JsonKey(name: 'target_subject') this.targetSubject,
  });

  factory _$PromotionCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionCreateImplFromJson(json);

  @override
  @JsonKey(name: 'promotion_name')
  final String promotionName;
  @override
  @JsonKey(name: 'promotion_code')
  final String? promotionCode;
  @override
  @JsonKey(name: 'promotion_type_code')
  final String? promotionTypeCode;
  @override
  @JsonKey(name: 'start_date')
  final String startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  final String? description;
  @override
  @JsonKey(name: 'discount_type_code')
  final String? discountTypeCode;
  @override
  @JsonKey(name: 'discount_value')
  final double? discountValue;
  @override
  @JsonKey(name: 'target_grade')
  final String? targetGrade;
  @override
  @JsonKey(name: 'target_subject')
  final String? targetSubject;

  @override
  String toString() {
    return 'PromotionCreate(promotionName: $promotionName, promotionCode: $promotionCode, promotionTypeCode: $promotionTypeCode, startDate: $startDate, endDate: $endDate, description: $description, discountTypeCode: $discountTypeCode, discountValue: $discountValue, targetGrade: $targetGrade, targetSubject: $targetSubject)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionCreateImpl &&
            (identical(other.promotionName, promotionName) ||
                other.promotionName == promotionName) &&
            (identical(other.promotionCode, promotionCode) ||
                other.promotionCode == promotionCode) &&
            (identical(other.promotionTypeCode, promotionTypeCode) ||
                other.promotionTypeCode == promotionTypeCode) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discountTypeCode, discountTypeCode) ||
                other.discountTypeCode == discountTypeCode) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.targetGrade, targetGrade) ||
                other.targetGrade == targetGrade) &&
            (identical(other.targetSubject, targetSubject) ||
                other.targetSubject == targetSubject));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    promotionName,
    promotionCode,
    promotionTypeCode,
    startDate,
    endDate,
    description,
    discountTypeCode,
    discountValue,
    targetGrade,
    targetSubject,
  );

  /// Create a copy of PromotionCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionCreateImplCopyWith<_$PromotionCreateImpl> get copyWith =>
      __$$PromotionCreateImplCopyWithImpl<_$PromotionCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionCreateImplToJson(this);
  }
}

abstract class _PromotionCreate implements PromotionCreate {
  const factory _PromotionCreate({
    @JsonKey(name: 'promotion_name') required final String promotionName,
    @JsonKey(name: 'promotion_code') final String? promotionCode,
    @JsonKey(name: 'promotion_type_code') final String? promotionTypeCode,
    @JsonKey(name: 'start_date') required final String startDate,
    @JsonKey(name: 'end_date') final String? endDate,
    final String? description,
    @JsonKey(name: 'discount_type_code') final String? discountTypeCode,
    @JsonKey(name: 'discount_value') final double? discountValue,
    @JsonKey(name: 'target_grade') final String? targetGrade,
    @JsonKey(name: 'target_subject') final String? targetSubject,
  }) = _$PromotionCreateImpl;

  factory _PromotionCreate.fromJson(Map<String, dynamic> json) =
      _$PromotionCreateImpl.fromJson;

  @override
  @JsonKey(name: 'promotion_name')
  String get promotionName;
  @override
  @JsonKey(name: 'promotion_code')
  String? get promotionCode;
  @override
  @JsonKey(name: 'promotion_type_code')
  String? get promotionTypeCode;
  @override
  @JsonKey(name: 'start_date')
  String get startDate;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate;
  @override
  String? get description;
  @override
  @JsonKey(name: 'discount_type_code')
  String? get discountTypeCode;
  @override
  @JsonKey(name: 'discount_value')
  double? get discountValue;
  @override
  @JsonKey(name: 'target_grade')
  String? get targetGrade;
  @override
  @JsonKey(name: 'target_subject')
  String? get targetSubject;

  /// Create a copy of PromotionCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotionCreateImplCopyWith<_$PromotionCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromotionListParams _$PromotionListParamsFromJson(Map<String, dynamic> json) {
  return _PromotionListParams.fromJson(json);
}

/// @nodoc
mixin _$PromotionListParams {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  String? get sort => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;

  /// Serializes this PromotionListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotionListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotionListParamsCopyWith<PromotionListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionListParamsCopyWith<$Res> {
  factory $PromotionListParamsCopyWith(
    PromotionListParams value,
    $Res Function(PromotionListParams) then,
  ) = _$PromotionListParamsCopyWithImpl<$Res, PromotionListParams>;
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
  });
}

/// @nodoc
class _$PromotionListParamsCopyWithImpl<$Res, $Val extends PromotionListParams>
    implements $PromotionListParamsCopyWith<$Res> {
  _$PromotionListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotionListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
  }) {
    return _then(
      _value.copyWith(
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            sort: freezed == sort
                ? _value.sort
                : sort // ignore: cast_nullable_to_non_nullable
                      as String?,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as String?,
            search: freezed == search
                ? _value.search
                : search // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromotionListParamsImplCopyWith<$Res>
    implements $PromotionListParamsCopyWith<$Res> {
  factory _$$PromotionListParamsImplCopyWith(
    _$PromotionListParamsImpl value,
    $Res Function(_$PromotionListParamsImpl) then,
  ) = __$$PromotionListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
  });
}

/// @nodoc
class __$$PromotionListParamsImplCopyWithImpl<$Res>
    extends _$PromotionListParamsCopyWithImpl<$Res, _$PromotionListParamsImpl>
    implements _$$PromotionListParamsImplCopyWith<$Res> {
  __$$PromotionListParamsImplCopyWithImpl(
    _$PromotionListParamsImpl _value,
    $Res Function(_$PromotionListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromotionListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
  }) {
    return _then(
      _$PromotionListParamsImpl(
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        sort: freezed == sort
            ? _value.sort
            : sort // ignore: cast_nullable_to_non_nullable
                  as String?,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as String?,
        search: freezed == search
            ? _value.search
            : search // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionListParamsImpl implements _PromotionListParams {
  const _$PromotionListParamsImpl({
    this.page = 1,
    this.perPage = 20,
    this.sort,
    this.order,
    this.search,
  });

  factory _$PromotionListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionListParamsImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int perPage;
  @override
  final String? sort;
  @override
  final String? order;
  @override
  final String? search;

  @override
  String toString() {
    return 'PromotionListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionListParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.search, search) || other.search == search));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, page, perPage, sort, order, search);

  /// Create a copy of PromotionListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionListParamsImplCopyWith<_$PromotionListParamsImpl> get copyWith =>
      __$$PromotionListParamsImplCopyWithImpl<_$PromotionListParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionListParamsImplToJson(this);
  }
}

abstract class _PromotionListParams implements PromotionListParams {
  const factory _PromotionListParams({
    final int page,
    final int perPage,
    final String? sort,
    final String? order,
    final String? search,
  }) = _$PromotionListParamsImpl;

  factory _PromotionListParams.fromJson(Map<String, dynamic> json) =
      _$PromotionListParamsImpl.fromJson;

  @override
  int get page;
  @override
  int get perPage;
  @override
  String? get sort;
  @override
  String? get order;
  @override
  String? get search;

  /// Create a copy of PromotionListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotionListParamsImplCopyWith<_$PromotionListParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromotionAttendee _$PromotionAttendeeFromJson(Map<String, dynamic> json) {
  return _PromotionAttendee.fromJson(json);
}

/// @nodoc
mixin _$PromotionAttendee {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_phone')
  String? get studentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  String? get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String? get statusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendee_type')
  int? get attendeeType => throw _privateConstructorUsedError; // 1=학생, 2=부, 3=모
  int? get attended => throw _privateConstructorUsedError; // 1=참석, 0=불참
  @JsonKey(name: 'applied_date')
  String? get appliedDate => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PromotionAttendee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotionAttendee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotionAttendeeCopyWith<PromotionAttendee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionAttendeeCopyWith<$Res> {
  factory $PromotionAttendeeCopyWith(
    PromotionAttendee value,
    $Res Function(PromotionAttendee) then,
  ) = _$PromotionAttendeeCopyWithImpl<$Res, PromotionAttendee>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'attendee_type') int? attendeeType,
    int? attended,
    @JsonKey(name: 'applied_date') String? appliedDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$PromotionAttendeeCopyWithImpl<$Res, $Val extends PromotionAttendee>
    implements $PromotionAttendeeCopyWith<$Res> {
  _$PromotionAttendeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotionAttendee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? statusCode = freezed,
    Object? statusName = freezed,
    Object? attendeeType = freezed,
    Object? attended = freezed,
    Object? appliedDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentPhone: freezed == studentPhone
                ? _value.studentPhone
                : studentPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            schoolName: freezed == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusName: freezed == statusName
                ? _value.statusName
                : statusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            attendeeType: freezed == attendeeType
                ? _value.attendeeType
                : attendeeType // ignore: cast_nullable_to_non_nullable
                      as int?,
            attended: freezed == attended
                ? _value.attended
                : attended // ignore: cast_nullable_to_non_nullable
                      as int?,
            appliedDate: freezed == appliedDate
                ? _value.appliedDate
                : appliedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromotionAttendeeImplCopyWith<$Res>
    implements $PromotionAttendeeCopyWith<$Res> {
  factory _$$PromotionAttendeeImplCopyWith(
    _$PromotionAttendeeImpl value,
    $Res Function(_$PromotionAttendeeImpl) then,
  ) = __$$PromotionAttendeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'attendee_type') int? attendeeType,
    int? attended,
    @JsonKey(name: 'applied_date') String? appliedDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$PromotionAttendeeImplCopyWithImpl<$Res>
    extends _$PromotionAttendeeCopyWithImpl<$Res, _$PromotionAttendeeImpl>
    implements _$$PromotionAttendeeImplCopyWith<$Res> {
  __$$PromotionAttendeeImplCopyWithImpl(
    _$PromotionAttendeeImpl _value,
    $Res Function(_$PromotionAttendeeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromotionAttendee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? statusCode = freezed,
    Object? statusName = freezed,
    Object? attendeeType = freezed,
    Object? attended = freezed,
    Object? appliedDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PromotionAttendeeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentPhone: freezed == studentPhone
            ? _value.studentPhone
            : studentPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        schoolName: freezed == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusName: freezed == statusName
            ? _value.statusName
            : statusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        attendeeType: freezed == attendeeType
            ? _value.attendeeType
            : attendeeType // ignore: cast_nullable_to_non_nullable
                  as int?,
        attended: freezed == attended
            ? _value.attended
            : attended // ignore: cast_nullable_to_non_nullable
                  as int?,
        appliedDate: freezed == appliedDate
            ? _value.appliedDate
            : appliedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionAttendeeImpl implements _PromotionAttendee {
  const _$PromotionAttendeeImpl({
    required this.id,
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'student_name') this.studentName,
    @JsonKey(name: 'student_phone') this.studentPhone,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'status_code') this.statusCode,
    @JsonKey(name: 'status_name') this.statusName,
    @JsonKey(name: 'attendee_type') this.attendeeType,
    this.attended,
    @JsonKey(name: 'applied_date') this.appliedDate,
    this.memo,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PromotionAttendeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionAttendeeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'student_name')
  final String? studentName;
  @override
  @JsonKey(name: 'student_phone')
  final String? studentPhone;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @override
  @JsonKey(name: 'status_name')
  final String? statusName;
  @override
  @JsonKey(name: 'attendee_type')
  final int? attendeeType;
  // 1=학생, 2=부, 3=모
  @override
  final int? attended;
  // 1=참석, 0=불참
  @override
  @JsonKey(name: 'applied_date')
  final String? appliedDate;
  @override
  final String? memo;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'PromotionAttendee(id: $id, studentId: $studentId, studentName: $studentName, studentPhone: $studentPhone, schoolName: $schoolName, grade: $grade, statusCode: $statusCode, statusName: $statusName, attendeeType: $attendeeType, attended: $attended, appliedDate: $appliedDate, memo: $memo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionAttendeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentPhone, studentPhone) ||
                other.studentPhone == studentPhone) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.attendeeType, attendeeType) ||
                other.attendeeType == attendeeType) &&
            (identical(other.attended, attended) ||
                other.attended == attended) &&
            (identical(other.appliedDate, appliedDate) ||
                other.appliedDate == appliedDate) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    studentName,
    studentPhone,
    schoolName,
    grade,
    statusCode,
    statusName,
    attendeeType,
    attended,
    appliedDate,
    memo,
    createdAt,
  );

  /// Create a copy of PromotionAttendee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionAttendeeImplCopyWith<_$PromotionAttendeeImpl> get copyWith =>
      __$$PromotionAttendeeImplCopyWithImpl<_$PromotionAttendeeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionAttendeeImplToJson(this);
  }
}

abstract class _PromotionAttendee implements PromotionAttendee {
  const factory _PromotionAttendee({
    required final int id,
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'student_name') final String? studentName,
    @JsonKey(name: 'student_phone') final String? studentPhone,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'status_code') final String? statusCode,
    @JsonKey(name: 'status_name') final String? statusName,
    @JsonKey(name: 'attendee_type') final int? attendeeType,
    final int? attended,
    @JsonKey(name: 'applied_date') final String? appliedDate,
    final String? memo,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$PromotionAttendeeImpl;

  factory _PromotionAttendee.fromJson(Map<String, dynamic> json) =
      _$PromotionAttendeeImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'student_name')
  String? get studentName;
  @override
  @JsonKey(name: 'student_phone')
  String? get studentPhone;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
  int? get grade;
  @override
  @JsonKey(name: 'status_code')
  String? get statusCode;
  @override
  @JsonKey(name: 'status_name')
  String? get statusName;
  @override
  @JsonKey(name: 'attendee_type')
  int? get attendeeType; // 1=학생, 2=부, 3=모
  @override
  int? get attended; // 1=참석, 0=불참
  @override
  @JsonKey(name: 'applied_date')
  String? get appliedDate;
  @override
  String? get memo;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of PromotionAttendee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotionAttendeeImplCopyWith<_$PromotionAttendeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewAttendeeData _$NewAttendeeDataFromJson(Map<String, dynamic> json) {
  return _NewAttendeeData.fromJson(json);
}

/// @nodoc
mixin _$NewAttendeeData {
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendee_type')
  int? get attendeeType => throw _privateConstructorUsedError;

  /// Serializes this NewAttendeeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewAttendeeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewAttendeeDataCopyWith<NewAttendeeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewAttendeeDataCopyWith<$Res> {
  factory $NewAttendeeDataCopyWith(
    NewAttendeeData value,
    $Res Function(NewAttendeeData) then,
  ) = _$NewAttendeeDataCopyWithImpl<$Res, NewAttendeeData>;
  @useResult
  $Res call({
    String name,
    String phone,
    @JsonKey(name: 'school_id') int? schoolId,
    int? grade,
    String? memo,
    @JsonKey(name: 'attendee_type') int? attendeeType,
  });
}

/// @nodoc
class _$NewAttendeeDataCopyWithImpl<$Res, $Val extends NewAttendeeData>
    implements $NewAttendeeDataCopyWith<$Res> {
  _$NewAttendeeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewAttendeeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? schoolId = freezed,
    Object? grade = freezed,
    Object? memo = freezed,
    Object? attendeeType = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            attendeeType: freezed == attendeeType
                ? _value.attendeeType
                : attendeeType // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewAttendeeDataImplCopyWith<$Res>
    implements $NewAttendeeDataCopyWith<$Res> {
  factory _$$NewAttendeeDataImplCopyWith(
    _$NewAttendeeDataImpl value,
    $Res Function(_$NewAttendeeDataImpl) then,
  ) = __$$NewAttendeeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String phone,
    @JsonKey(name: 'school_id') int? schoolId,
    int? grade,
    String? memo,
    @JsonKey(name: 'attendee_type') int? attendeeType,
  });
}

/// @nodoc
class __$$NewAttendeeDataImplCopyWithImpl<$Res>
    extends _$NewAttendeeDataCopyWithImpl<$Res, _$NewAttendeeDataImpl>
    implements _$$NewAttendeeDataImplCopyWith<$Res> {
  __$$NewAttendeeDataImplCopyWithImpl(
    _$NewAttendeeDataImpl _value,
    $Res Function(_$NewAttendeeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewAttendeeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? schoolId = freezed,
    Object? grade = freezed,
    Object? memo = freezed,
    Object? attendeeType = freezed,
  }) {
    return _then(
      _$NewAttendeeDataImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        attendeeType: freezed == attendeeType
            ? _value.attendeeType
            : attendeeType // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewAttendeeDataImpl implements _NewAttendeeData {
  const _$NewAttendeeDataImpl({
    required this.name,
    required this.phone,
    @JsonKey(name: 'school_id') this.schoolId,
    this.grade,
    this.memo,
    @JsonKey(name: 'attendee_type') this.attendeeType,
  });

  factory _$NewAttendeeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewAttendeeDataImplFromJson(json);

  @override
  final String name;
  @override
  final String phone;
  @override
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @override
  final int? grade;
  @override
  final String? memo;
  @override
  @JsonKey(name: 'attendee_type')
  final int? attendeeType;

  @override
  String toString() {
    return 'NewAttendeeData(name: $name, phone: $phone, schoolId: $schoolId, grade: $grade, memo: $memo, attendeeType: $attendeeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewAttendeeDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.attendeeType, attendeeType) ||
                other.attendeeType == attendeeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    phone,
    schoolId,
    grade,
    memo,
    attendeeType,
  );

  /// Create a copy of NewAttendeeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewAttendeeDataImplCopyWith<_$NewAttendeeDataImpl> get copyWith =>
      __$$NewAttendeeDataImplCopyWithImpl<_$NewAttendeeDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewAttendeeDataImplToJson(this);
  }
}

abstract class _NewAttendeeData implements NewAttendeeData {
  const factory _NewAttendeeData({
    required final String name,
    required final String phone,
    @JsonKey(name: 'school_id') final int? schoolId,
    final int? grade,
    final String? memo,
    @JsonKey(name: 'attendee_type') final int? attendeeType,
  }) = _$NewAttendeeDataImpl;

  factory _NewAttendeeData.fromJson(Map<String, dynamic> json) =
      _$NewAttendeeDataImpl.fromJson;

  @override
  String get name;
  @override
  String get phone;
  @override
  @JsonKey(name: 'school_id')
  int? get schoolId;
  @override
  int? get grade;
  @override
  String? get memo;
  @override
  @JsonKey(name: 'attendee_type')
  int? get attendeeType;

  /// Create a copy of NewAttendeeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewAttendeeDataImplCopyWith<_$NewAttendeeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSearchResult _$UserSearchResultFromJson(Map<String, dynamic> json) {
  return _UserSearchResult.fromJson(json);
}

/// @nodoc
mixin _$UserSearchResult {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  String? get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String? get statusName => throw _privateConstructorUsedError;

  /// Serializes this UserSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSearchResultCopyWith<UserSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSearchResultCopyWith<$Res> {
  factory $UserSearchResultCopyWith(
    UserSearchResult value,
    $Res Function(UserSearchResult) then,
  ) = _$UserSearchResultCopyWithImpl<$Res, UserSearchResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    String phone,
    int? grade,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
  });
}

/// @nodoc
class _$UserSearchResultCopyWithImpl<$Res, $Val extends UserSearchResult>
    implements $UserSearchResultCopyWith<$Res> {
  _$UserSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = null,
    Object? grade = freezed,
    Object? schoolName = freezed,
    Object? statusCode = freezed,
    Object? statusName = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolName: freezed == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusName: freezed == statusName
                ? _value.statusName
                : statusName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSearchResultImplCopyWith<$Res>
    implements $UserSearchResultCopyWith<$Res> {
  factory _$$UserSearchResultImplCopyWith(
    _$UserSearchResultImpl value,
    $Res Function(_$UserSearchResultImpl) then,
  ) = __$$UserSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    String phone,
    int? grade,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'status_name') String? statusName,
  });
}

/// @nodoc
class __$$UserSearchResultImplCopyWithImpl<$Res>
    extends _$UserSearchResultCopyWithImpl<$Res, _$UserSearchResultImpl>
    implements _$$UserSearchResultImplCopyWith<$Res> {
  __$$UserSearchResultImplCopyWithImpl(
    _$UserSearchResultImpl _value,
    $Res Function(_$UserSearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = null,
    Object? grade = freezed,
    Object? schoolName = freezed,
    Object? statusCode = freezed,
    Object? statusName = freezed,
  }) {
    return _then(
      _$UserSearchResultImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolName: freezed == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusName: freezed == statusName
            ? _value.statusName
            : statusName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSearchResultImpl implements _UserSearchResult {
  const _$UserSearchResultImpl({
    @JsonKey(name: 'user_id') required this.userId,
    required this.name,
    required this.phone,
    this.grade,
    @JsonKey(name: 'school_name') this.schoolName,
    @JsonKey(name: 'status_code') this.statusCode,
    @JsonKey(name: 'status_name') this.statusName,
  });

  factory _$UserSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSearchResultImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String name;
  @override
  final String phone;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @override
  @JsonKey(name: 'status_name')
  final String? statusName;

  @override
  String toString() {
    return 'UserSearchResult(userId: $userId, name: $name, phone: $phone, grade: $grade, schoolName: $schoolName, statusCode: $statusCode, statusName: $statusName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSearchResultImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    name,
    phone,
    grade,
    schoolName,
    statusCode,
    statusName,
  );

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      __$$UserSearchResultImplCopyWithImpl<_$UserSearchResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSearchResultImplToJson(this);
  }
}

abstract class _UserSearchResult implements UserSearchResult {
  const factory _UserSearchResult({
    @JsonKey(name: 'user_id') required final int userId,
    required final String name,
    required final String phone,
    final int? grade,
    @JsonKey(name: 'school_name') final String? schoolName,
    @JsonKey(name: 'status_code') final String? statusCode,
    @JsonKey(name: 'status_name') final String? statusName,
  }) = _$UserSearchResultImpl;

  factory _UserSearchResult.fromJson(Map<String, dynamic> json) =
      _$UserSearchResultImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get name;
  @override
  String get phone;
  @override
  int? get grade;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
  @JsonKey(name: 'status_code')
  String? get statusCode;
  @override
  @JsonKey(name: 'status_name')
  String? get statusName;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
