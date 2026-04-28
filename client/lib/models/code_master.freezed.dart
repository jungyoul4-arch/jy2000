// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_master.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CodeMaster _$CodeMasterFromJson(Map<String, dynamic> json) {
  return _CodeMaster.fromJson(json);
}

/// @nodoc
mixin _$CodeMaster {
  @JsonKey(name: 'code_id')
  String get codeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_group')
  String get codeGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_value')
  String get codeValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_name')
  String get codeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_name_en')
  String? get codeNameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_code_id')
  String? get parentCodeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this CodeMaster to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CodeMaster
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeMasterCopyWith<CodeMaster> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeMasterCopyWith<$Res> {
  factory $CodeMasterCopyWith(
    CodeMaster value,
    $Res Function(CodeMaster) then,
  ) = _$CodeMasterCopyWithImpl<$Res, CodeMaster>;
  @useResult
  $Res call({
    @JsonKey(name: 'code_id') String codeId,
    @JsonKey(name: 'code_group') String codeGroup,
    @JsonKey(name: 'code_value') String codeValue,
    @JsonKey(name: 'code_name') String codeName,
    @JsonKey(name: 'code_name_en') String? codeNameEn,
    @JsonKey(name: 'parent_code_id') String? parentCodeId,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$CodeMasterCopyWithImpl<$Res, $Val extends CodeMaster>
    implements $CodeMasterCopyWith<$Res> {
  _$CodeMasterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeMaster
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeId = null,
    Object? codeGroup = null,
    Object? codeValue = null,
    Object? codeName = null,
    Object? codeNameEn = freezed,
    Object? parentCodeId = freezed,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            codeId: null == codeId
                ? _value.codeId
                : codeId // ignore: cast_nullable_to_non_nullable
                      as String,
            codeGroup: null == codeGroup
                ? _value.codeGroup
                : codeGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            codeValue: null == codeValue
                ? _value.codeValue
                : codeValue // ignore: cast_nullable_to_non_nullable
                      as String,
            codeName: null == codeName
                ? _value.codeName
                : codeName // ignore: cast_nullable_to_non_nullable
                      as String,
            codeNameEn: freezed == codeNameEn
                ? _value.codeNameEn
                : codeNameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            parentCodeId: freezed == parentCodeId
                ? _value.parentCodeId
                : parentCodeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CodeMasterImplCopyWith<$Res>
    implements $CodeMasterCopyWith<$Res> {
  factory _$$CodeMasterImplCopyWith(
    _$CodeMasterImpl value,
    $Res Function(_$CodeMasterImpl) then,
  ) = __$$CodeMasterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'code_id') String codeId,
    @JsonKey(name: 'code_group') String codeGroup,
    @JsonKey(name: 'code_value') String codeValue,
    @JsonKey(name: 'code_name') String codeName,
    @JsonKey(name: 'code_name_en') String? codeNameEn,
    @JsonKey(name: 'parent_code_id') String? parentCodeId,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$CodeMasterImplCopyWithImpl<$Res>
    extends _$CodeMasterCopyWithImpl<$Res, _$CodeMasterImpl>
    implements _$$CodeMasterImplCopyWith<$Res> {
  __$$CodeMasterImplCopyWithImpl(
    _$CodeMasterImpl _value,
    $Res Function(_$CodeMasterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CodeMaster
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeId = null,
    Object? codeGroup = null,
    Object? codeValue = null,
    Object? codeName = null,
    Object? codeNameEn = freezed,
    Object? parentCodeId = freezed,
    Object? sortOrder = null,
  }) {
    return _then(
      _$CodeMasterImpl(
        codeId: null == codeId
            ? _value.codeId
            : codeId // ignore: cast_nullable_to_non_nullable
                  as String,
        codeGroup: null == codeGroup
            ? _value.codeGroup
            : codeGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        codeValue: null == codeValue
            ? _value.codeValue
            : codeValue // ignore: cast_nullable_to_non_nullable
                  as String,
        codeName: null == codeName
            ? _value.codeName
            : codeName // ignore: cast_nullable_to_non_nullable
                  as String,
        codeNameEn: freezed == codeNameEn
            ? _value.codeNameEn
            : codeNameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        parentCodeId: freezed == parentCodeId
            ? _value.parentCodeId
            : parentCodeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CodeMasterImpl implements _CodeMaster {
  const _$CodeMasterImpl({
    @JsonKey(name: 'code_id') required this.codeId,
    @JsonKey(name: 'code_group') required this.codeGroup,
    @JsonKey(name: 'code_value') required this.codeValue,
    @JsonKey(name: 'code_name') required this.codeName,
    @JsonKey(name: 'code_name_en') this.codeNameEn,
    @JsonKey(name: 'parent_code_id') this.parentCodeId,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$CodeMasterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodeMasterImplFromJson(json);

  @override
  @JsonKey(name: 'code_id')
  final String codeId;
  @override
  @JsonKey(name: 'code_group')
  final String codeGroup;
  @override
  @JsonKey(name: 'code_value')
  final String codeValue;
  @override
  @JsonKey(name: 'code_name')
  final String codeName;
  @override
  @JsonKey(name: 'code_name_en')
  final String? codeNameEn;
  @override
  @JsonKey(name: 'parent_code_id')
  final String? parentCodeId;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'CodeMaster(codeId: $codeId, codeGroup: $codeGroup, codeValue: $codeValue, codeName: $codeName, codeNameEn: $codeNameEn, parentCodeId: $parentCodeId, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeMasterImpl &&
            (identical(other.codeId, codeId) || other.codeId == codeId) &&
            (identical(other.codeGroup, codeGroup) ||
                other.codeGroup == codeGroup) &&
            (identical(other.codeValue, codeValue) ||
                other.codeValue == codeValue) &&
            (identical(other.codeName, codeName) ||
                other.codeName == codeName) &&
            (identical(other.codeNameEn, codeNameEn) ||
                other.codeNameEn == codeNameEn) &&
            (identical(other.parentCodeId, parentCodeId) ||
                other.parentCodeId == parentCodeId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    codeId,
    codeGroup,
    codeValue,
    codeName,
    codeNameEn,
    parentCodeId,
    sortOrder,
  );

  /// Create a copy of CodeMaster
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeMasterImplCopyWith<_$CodeMasterImpl> get copyWith =>
      __$$CodeMasterImplCopyWithImpl<_$CodeMasterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CodeMasterImplToJson(this);
  }
}

abstract class _CodeMaster implements CodeMaster {
  const factory _CodeMaster({
    @JsonKey(name: 'code_id') required final String codeId,
    @JsonKey(name: 'code_group') required final String codeGroup,
    @JsonKey(name: 'code_value') required final String codeValue,
    @JsonKey(name: 'code_name') required final String codeName,
    @JsonKey(name: 'code_name_en') final String? codeNameEn,
    @JsonKey(name: 'parent_code_id') final String? parentCodeId,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$CodeMasterImpl;

  factory _CodeMaster.fromJson(Map<String, dynamic> json) =
      _$CodeMasterImpl.fromJson;

  @override
  @JsonKey(name: 'code_id')
  String get codeId;
  @override
  @JsonKey(name: 'code_group')
  String get codeGroup;
  @override
  @JsonKey(name: 'code_value')
  String get codeValue;
  @override
  @JsonKey(name: 'code_name')
  String get codeName;
  @override
  @JsonKey(name: 'code_name_en')
  String? get codeNameEn;
  @override
  @JsonKey(name: 'parent_code_id')
  String? get parentCodeId;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of CodeMaster
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeMasterImplCopyWith<_$CodeMasterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
