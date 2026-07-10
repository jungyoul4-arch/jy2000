// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_event_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleEventType _$ScheduleEventTypeFromJson(Map<String, dynamic> json) {
  return _ScheduleEventType.fromJson(json);
}

/// @nodoc
mixin _$ScheduleEventType {
  @JsonKey(name: 'event_type_id')
  int get eventTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_name')
  String get eventTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_code')
  String get colorCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ScheduleEventType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleEventType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleEventTypeCopyWith<ScheduleEventType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleEventTypeCopyWith<$Res> {
  factory $ScheduleEventTypeCopyWith(
    ScheduleEventType value,
    $Res Function(ScheduleEventType) then,
  ) = _$ScheduleEventTypeCopyWithImpl<$Res, ScheduleEventType>;
  @useResult
  $Res call({
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_type_name') String eventTypeName,
    @JsonKey(name: 'color_code') String colorCode,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
  });
}

/// @nodoc
class _$ScheduleEventTypeCopyWithImpl<$Res, $Val extends ScheduleEventType>
    implements $ScheduleEventTypeCopyWith<$Res> {
  _$ScheduleEventTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleEventType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTypeId = null,
    Object? eventTypeName = null,
    Object? colorCode = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            eventTypeId: null == eventTypeId
                ? _value.eventTypeId
                : eventTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            eventTypeName: null == eventTypeName
                ? _value.eventTypeName
                : eventTypeName // ignore: cast_nullable_to_non_nullable
                      as String,
            colorCode: null == colorCode
                ? _value.colorCode
                : colorCode // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ScheduleEventTypeImplCopyWith<$Res>
    implements $ScheduleEventTypeCopyWith<$Res> {
  factory _$$ScheduleEventTypeImplCopyWith(
    _$ScheduleEventTypeImpl value,
    $Res Function(_$ScheduleEventTypeImpl) then,
  ) = __$$ScheduleEventTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_type_name') String eventTypeName,
    @JsonKey(name: 'color_code') String colorCode,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
  });
}

/// @nodoc
class __$$ScheduleEventTypeImplCopyWithImpl<$Res>
    extends _$ScheduleEventTypeCopyWithImpl<$Res, _$ScheduleEventTypeImpl>
    implements _$$ScheduleEventTypeImplCopyWith<$Res> {
  __$$ScheduleEventTypeImplCopyWithImpl(
    _$ScheduleEventTypeImpl _value,
    $Res Function(_$ScheduleEventTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleEventType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTypeId = null,
    Object? eventTypeName = null,
    Object? colorCode = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ScheduleEventTypeImpl(
        eventTypeId: null == eventTypeId
            ? _value.eventTypeId
            : eventTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        eventTypeName: null == eventTypeName
            ? _value.eventTypeName
            : eventTypeName // ignore: cast_nullable_to_non_nullable
                  as String,
        colorCode: null == colorCode
            ? _value.colorCode
            : colorCode // ignore: cast_nullable_to_non_nullable
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
class _$ScheduleEventTypeImpl extends _ScheduleEventType {
  const _$ScheduleEventTypeImpl({
    @JsonKey(name: 'event_type_id') required this.eventTypeId,
    @JsonKey(name: 'event_type_name') required this.eventTypeName,
    @JsonKey(name: 'color_code') required this.colorCode,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') @IntToBoolConverter() this.isActive = true,
  }) : super._();

  factory _$ScheduleEventTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleEventTypeImplFromJson(json);

  @override
  @JsonKey(name: 'event_type_id')
  final int eventTypeId;
  @override
  @JsonKey(name: 'event_type_name')
  final String eventTypeName;
  @override
  @JsonKey(name: 'color_code')
  final String colorCode;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  final bool isActive;

  @override
  String toString() {
    return 'ScheduleEventType(eventTypeId: $eventTypeId, eventTypeName: $eventTypeName, colorCode: $colorCode, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleEventTypeImpl &&
            (identical(other.eventTypeId, eventTypeId) ||
                other.eventTypeId == eventTypeId) &&
            (identical(other.eventTypeName, eventTypeName) ||
                other.eventTypeName == eventTypeName) &&
            (identical(other.colorCode, colorCode) ||
                other.colorCode == colorCode) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    eventTypeId,
    eventTypeName,
    colorCode,
    sortOrder,
    isActive,
  );

  /// Create a copy of ScheduleEventType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleEventTypeImplCopyWith<_$ScheduleEventTypeImpl> get copyWith =>
      __$$ScheduleEventTypeImplCopyWithImpl<_$ScheduleEventTypeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleEventTypeImplToJson(this);
  }
}

abstract class _ScheduleEventType extends ScheduleEventType {
  const factory _ScheduleEventType({
    @JsonKey(name: 'event_type_id') required final int eventTypeId,
    @JsonKey(name: 'event_type_name') required final String eventTypeName,
    @JsonKey(name: 'color_code') required final String colorCode,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() final bool isActive,
  }) = _$ScheduleEventTypeImpl;
  const _ScheduleEventType._() : super._();

  factory _ScheduleEventType.fromJson(Map<String, dynamic> json) =
      _$ScheduleEventTypeImpl.fromJson;

  @override
  @JsonKey(name: 'event_type_id')
  int get eventTypeId;
  @override
  @JsonKey(name: 'event_type_name')
  String get eventTypeName;
  @override
  @JsonKey(name: 'color_code')
  String get colorCode;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive;

  /// Create a copy of ScheduleEventType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleEventTypeImplCopyWith<_$ScheduleEventTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
