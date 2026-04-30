// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

School _$SchoolFromJson(Map<String, dynamic> json) {
  return _School.fromJson(json);
}

/// @nodoc
mixin _$School {
  @JsonKey(name: 'school_id')
  int get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String get schoolName => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_kind')
  int get schoolKind => throw _privateConstructorUsedError; // 1=중학교, 2=고등학교
  @JsonKey(name: 'region_kind')
  int get regionKind => throw _privateConstructorUsedError; // 1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this School to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of School
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchoolCopyWith<School> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolCopyWith<$Res> {
  factory $SchoolCopyWith(School value, $Res Function(School) then) =
      _$SchoolCopyWithImpl<$Res, School>;
  @useResult
  $Res call({
    @JsonKey(name: 'school_id') int schoolId,
    @JsonKey(name: 'school_name') String schoolName,
    @JsonKey(name: 'school_kind') int schoolKind,
    @JsonKey(name: 'region_kind') int regionKind,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$SchoolCopyWithImpl<$Res, $Val extends School>
    implements $SchoolCopyWith<$Res> {
  _$SchoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of School
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = null,
    Object? schoolName = null,
    Object? schoolKind = null,
    Object? regionKind = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            schoolId: null == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            schoolKind: null == schoolKind
                ? _value.schoolKind
                : schoolKind // ignore: cast_nullable_to_non_nullable
                      as int,
            regionKind: null == regionKind
                ? _value.regionKind
                : regionKind // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$SchoolImplCopyWith<$Res> implements $SchoolCopyWith<$Res> {
  factory _$$SchoolImplCopyWith(
    _$SchoolImpl value,
    $Res Function(_$SchoolImpl) then,
  ) = __$$SchoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'school_id') int schoolId,
    @JsonKey(name: 'school_name') String schoolName,
    @JsonKey(name: 'school_kind') int schoolKind,
    @JsonKey(name: 'region_kind') int regionKind,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$SchoolImplCopyWithImpl<$Res>
    extends _$SchoolCopyWithImpl<$Res, _$SchoolImpl>
    implements _$$SchoolImplCopyWith<$Res> {
  __$$SchoolImplCopyWithImpl(
    _$SchoolImpl _value,
    $Res Function(_$SchoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of School
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = null,
    Object? schoolName = null,
    Object? schoolKind = null,
    Object? regionKind = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$SchoolImpl(
        schoolId: null == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        schoolKind: null == schoolKind
            ? _value.schoolKind
            : schoolKind // ignore: cast_nullable_to_non_nullable
                  as int,
        regionKind: null == regionKind
            ? _value.regionKind
            : regionKind // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$SchoolImpl implements _School {
  const _$SchoolImpl({
    @JsonKey(name: 'school_id') required this.schoolId,
    @JsonKey(name: 'school_name') required this.schoolName,
    @JsonKey(name: 'school_kind') required this.schoolKind,
    @JsonKey(name: 'region_kind') required this.regionKind,
    @JsonKey(name: 'is_active') @IntToBoolConverter() this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$SchoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchoolImplFromJson(json);

  @override
  @JsonKey(name: 'school_id')
  final int schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String schoolName;
  @override
  @JsonKey(name: 'school_kind')
  final int schoolKind;
  // 1=중학교, 2=고등학교
  @override
  @JsonKey(name: 'region_kind')
  final int regionKind;
  // 1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'School(schoolId: $schoolId, schoolName: $schoolName, schoolKind: $schoolKind, regionKind: $regionKind, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchoolImpl &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.schoolKind, schoolKind) ||
                other.schoolKind == schoolKind) &&
            (identical(other.regionKind, regionKind) ||
                other.regionKind == regionKind) &&
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
    schoolId,
    schoolName,
    schoolKind,
    regionKind,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of School
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchoolImplCopyWith<_$SchoolImpl> get copyWith =>
      __$$SchoolImplCopyWithImpl<_$SchoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchoolImplToJson(this);
  }
}

abstract class _School implements School {
  const factory _School({
    @JsonKey(name: 'school_id') required final int schoolId,
    @JsonKey(name: 'school_name') required final String schoolName,
    @JsonKey(name: 'school_kind') required final int schoolKind,
    @JsonKey(name: 'region_kind') required final int regionKind,
    @JsonKey(name: 'is_active') @IntToBoolConverter() final bool isActive,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$SchoolImpl;

  factory _School.fromJson(Map<String, dynamic> json) = _$SchoolImpl.fromJson;

  @override
  @JsonKey(name: 'school_id')
  int get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String get schoolName;
  @override
  @JsonKey(name: 'school_kind')
  int get schoolKind; // 1=중학교, 2=고등학교
  @override
  @JsonKey(name: 'region_kind')
  int get regionKind; // 1=원미권, 2=소사권, 3=오정권, 4=인천권, 5=서울권, 6=경기기타권, 99=기타
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of School
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchoolImplCopyWith<_$SchoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
