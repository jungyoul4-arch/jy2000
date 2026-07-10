// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleCategory _$ScheduleCategoryFromJson(Map<String, dynamic> json) {
  return _ScheduleCategory.fromJson(json);
}

/// @nodoc
mixin _$ScheduleCategory {
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_type')
  String get categoryType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ScheduleCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleCategoryCopyWith<ScheduleCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCategoryCopyWith<$Res> {
  factory $ScheduleCategoryCopyWith(
    ScheduleCategory value,
    $Res Function(ScheduleCategory) then,
  ) = _$ScheduleCategoryCopyWithImpl<$Res, ScheduleCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'category_type') String categoryType,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
  });
}

/// @nodoc
class _$ScheduleCategoryCopyWithImpl<$Res, $Val extends ScheduleCategory>
    implements $ScheduleCategoryCopyWith<$Res> {
  _$ScheduleCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryType = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryType: null == categoryType
                ? _value.categoryType
                : categoryType // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleCategoryImplCopyWith<$Res>
    implements $ScheduleCategoryCopyWith<$Res> {
  factory _$$ScheduleCategoryImplCopyWith(
    _$ScheduleCategoryImpl value,
    $Res Function(_$ScheduleCategoryImpl) then,
  ) = __$$ScheduleCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'category_type') String categoryType,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
  });
}

/// @nodoc
class __$$ScheduleCategoryImplCopyWithImpl<$Res>
    extends _$ScheduleCategoryCopyWithImpl<$Res, _$ScheduleCategoryImpl>
    implements _$$ScheduleCategoryImplCopyWith<$Res> {
  __$$ScheduleCategoryImplCopyWithImpl(
    _$ScheduleCategoryImpl _value,
    $Res Function(_$ScheduleCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryType = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ScheduleCategoryImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryType: null == categoryType
            ? _value.categoryType
            : categoryType // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleCategoryImpl extends _ScheduleCategory {
  const _$ScheduleCategoryImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    @JsonKey(name: 'category_type') required this.categoryType,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') @IntToBoolConverter() this.isActive = true,
  }) : super._();

  factory _$ScheduleCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'category_type')
  final String categoryType;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  final bool isActive;

  @override
  String toString() {
    return 'ScheduleCategory(categoryId: $categoryId, categoryName: $categoryName, categoryType: $categoryType, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleCategoryImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryType, categoryType) ||
                other.categoryType == categoryType) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    categoryType,
    sortOrder,
    isActive,
  );

  /// Create a copy of ScheduleCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleCategoryImplCopyWith<_$ScheduleCategoryImpl> get copyWith =>
      __$$ScheduleCategoryImplCopyWithImpl<_$ScheduleCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleCategoryImplToJson(this);
  }
}

abstract class _ScheduleCategory extends ScheduleCategory {
  const factory _ScheduleCategory({
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    @JsonKey(name: 'category_type') required final String categoryType,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() final bool isActive,
  }) = _$ScheduleCategoryImpl;
  const _ScheduleCategory._() : super._();

  factory _ScheduleCategory.fromJson(Map<String, dynamic> json) =
      _$ScheduleCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'category_type')
  String get categoryType;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive;

  /// Create a copy of ScheduleCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleCategoryImplCopyWith<_$ScheduleCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
