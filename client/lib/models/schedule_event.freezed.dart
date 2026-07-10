// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleEvent _$ScheduleEventFromJson(Map<String, dynamic> json) {
  return _ScheduleEvent.fromJson(json);
}

/// @nodoc
mixin _$ScheduleEvent {
  @JsonKey(name: 'event_id')
  int get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_type')
  String? get categoryType => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_id')
  int get eventTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_name')
  String? get eventTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_code')
  String? get colorCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  String get eventDate => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_phone')
  String? get studentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_id')
  int? get consultId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  int get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by_name')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_by')
  int? get updatedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_by_name')
  String? get updatedByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ScheduleEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleEventCopyWith<ScheduleEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleEventCopyWith<$Res> {
  factory $ScheduleEventCopyWith(
    ScheduleEvent value,
    $Res Function(ScheduleEvent) then,
  ) = _$ScheduleEventCopyWithImpl<$Res, ScheduleEvent>;
  @useResult
  $Res call({
    @JsonKey(name: 'event_id') int eventId,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_type') String? categoryType,
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_type_name') String? eventTypeName,
    @JsonKey(name: 'color_code') String? colorCode,
    @JsonKey(name: 'event_date') String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_id') int? consultId,
    @JsonKey(name: 'created_by') int createdBy,
    @JsonKey(name: 'created_by_name') String? createdByName,
    @JsonKey(name: 'updated_by') int? updatedBy,
    @JsonKey(name: 'updated_by_name') String? updatedByName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$ScheduleEventCopyWithImpl<$Res, $Val extends ScheduleEvent>
    implements $ScheduleEventCopyWith<$Res> {
  _$ScheduleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? categoryType = freezed,
    Object? eventTypeId = null,
    Object? eventTypeName = freezed,
    Object? colorCode = freezed,
    Object? eventDate = null,
    Object? content = freezed,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? consultId = freezed,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? updatedBy = freezed,
    Object? updatedByName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            eventId: null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryType: freezed == categoryType
                ? _value.categoryType
                : categoryType // ignore: cast_nullable_to_non_nullable
                      as String?,
            eventTypeId: null == eventTypeId
                ? _value.eventTypeId
                : eventTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            eventTypeName: freezed == eventTypeName
                ? _value.eventTypeName
                : eventTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            colorCode: freezed == colorCode
                ? _value.colorCode
                : colorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentPhone: freezed == studentPhone
                ? _value.studentPhone
                : studentPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultId: freezed == consultId
                ? _value.consultId
                : consultId // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as int,
            createdByName: freezed == createdByName
                ? _value.createdByName
                : createdByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedBy: freezed == updatedBy
                ? _value.updatedBy
                : updatedBy // ignore: cast_nullable_to_non_nullable
                      as int?,
            updatedByName: freezed == updatedByName
                ? _value.updatedByName
                : updatedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ScheduleEventImplCopyWith<$Res>
    implements $ScheduleEventCopyWith<$Res> {
  factory _$$ScheduleEventImplCopyWith(
    _$ScheduleEventImpl value,
    $Res Function(_$ScheduleEventImpl) then,
  ) = __$$ScheduleEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'event_id') int eventId,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_type') String? categoryType,
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_type_name') String? eventTypeName,
    @JsonKey(name: 'color_code') String? colorCode,
    @JsonKey(name: 'event_date') String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_id') int? consultId,
    @JsonKey(name: 'created_by') int createdBy,
    @JsonKey(name: 'created_by_name') String? createdByName,
    @JsonKey(name: 'updated_by') int? updatedBy,
    @JsonKey(name: 'updated_by_name') String? updatedByName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$ScheduleEventImplCopyWithImpl<$Res>
    extends _$ScheduleEventCopyWithImpl<$Res, _$ScheduleEventImpl>
    implements _$$ScheduleEventImplCopyWith<$Res> {
  __$$ScheduleEventImplCopyWithImpl(
    _$ScheduleEventImpl _value,
    $Res Function(_$ScheduleEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? categoryType = freezed,
    Object? eventTypeId = null,
    Object? eventTypeName = freezed,
    Object? colorCode = freezed,
    Object? eventDate = null,
    Object? content = freezed,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? consultId = freezed,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? updatedBy = freezed,
    Object? updatedByName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ScheduleEventImpl(
        eventId: null == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryType: freezed == categoryType
            ? _value.categoryType
            : categoryType // ignore: cast_nullable_to_non_nullable
                  as String?,
        eventTypeId: null == eventTypeId
            ? _value.eventTypeId
            : eventTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        eventTypeName: freezed == eventTypeName
            ? _value.eventTypeName
            : eventTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        colorCode: freezed == colorCode
            ? _value.colorCode
            : colorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentPhone: freezed == studentPhone
            ? _value.studentPhone
            : studentPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultId: freezed == consultId
            ? _value.consultId
            : consultId // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as int,
        createdByName: freezed == createdByName
            ? _value.createdByName
            : createdByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedBy: freezed == updatedBy
            ? _value.updatedBy
            : updatedBy // ignore: cast_nullable_to_non_nullable
                  as int?,
        updatedByName: freezed == updatedByName
            ? _value.updatedByName
            : updatedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ScheduleEventImpl extends _ScheduleEvent {
  const _$ScheduleEventImpl({
    @JsonKey(name: 'event_id') required this.eventId,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'category_type') this.categoryType,
    @JsonKey(name: 'event_type_id') required this.eventTypeId,
    @JsonKey(name: 'event_type_name') this.eventTypeName,
    @JsonKey(name: 'color_code') this.colorCode,
    @JsonKey(name: 'event_date') required this.eventDate,
    this.content,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'student_name') this.studentName,
    @JsonKey(name: 'student_phone') this.studentPhone,
    @JsonKey(name: 'consult_id') this.consultId,
    @JsonKey(name: 'created_by') required this.createdBy,
    @JsonKey(name: 'created_by_name') this.createdByName,
    @JsonKey(name: 'updated_by') this.updatedBy,
    @JsonKey(name: 'updated_by_name') this.updatedByName,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : super._();

  factory _$ScheduleEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleEventImplFromJson(json);

  @override
  @JsonKey(name: 'event_id')
  final int eventId;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_type')
  final String? categoryType;
  @override
  @JsonKey(name: 'event_type_id')
  final int eventTypeId;
  @override
  @JsonKey(name: 'event_type_name')
  final String? eventTypeName;
  @override
  @JsonKey(name: 'color_code')
  final String? colorCode;
  @override
  @JsonKey(name: 'event_date')
  final String eventDate;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'student_name')
  final String? studentName;
  @override
  @JsonKey(name: 'student_phone')
  final String? studentPhone;
  @override
  @JsonKey(name: 'consult_id')
  final int? consultId;
  @override
  @JsonKey(name: 'created_by')
  final int createdBy;
  @override
  @JsonKey(name: 'created_by_name')
  final String? createdByName;
  @override
  @JsonKey(name: 'updated_by')
  final int? updatedBy;
  @override
  @JsonKey(name: 'updated_by_name')
  final String? updatedByName;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'ScheduleEvent(eventId: $eventId, categoryId: $categoryId, categoryName: $categoryName, categoryType: $categoryType, eventTypeId: $eventTypeId, eventTypeName: $eventTypeName, colorCode: $colorCode, eventDate: $eventDate, content: $content, studentId: $studentId, studentName: $studentName, studentPhone: $studentPhone, consultId: $consultId, createdBy: $createdBy, createdByName: $createdByName, updatedBy: $updatedBy, updatedByName: $updatedByName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleEventImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryType, categoryType) ||
                other.categoryType == categoryType) &&
            (identical(other.eventTypeId, eventTypeId) ||
                other.eventTypeId == eventTypeId) &&
            (identical(other.eventTypeName, eventTypeName) ||
                other.eventTypeName == eventTypeName) &&
            (identical(other.colorCode, colorCode) ||
                other.colorCode == colorCode) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentPhone, studentPhone) ||
                other.studentPhone == studentPhone) &&
            (identical(other.consultId, consultId) ||
                other.consultId == consultId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdByName, createdByName) ||
                other.createdByName == createdByName) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.updatedByName, updatedByName) ||
                other.updatedByName == updatedByName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    eventId,
    categoryId,
    categoryName,
    categoryType,
    eventTypeId,
    eventTypeName,
    colorCode,
    eventDate,
    content,
    studentId,
    studentName,
    studentPhone,
    consultId,
    createdBy,
    createdByName,
    updatedBy,
    updatedByName,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of ScheduleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleEventImplCopyWith<_$ScheduleEventImpl> get copyWith =>
      __$$ScheduleEventImplCopyWithImpl<_$ScheduleEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleEventImplToJson(this);
  }
}

abstract class _ScheduleEvent extends ScheduleEvent {
  const factory _ScheduleEvent({
    @JsonKey(name: 'event_id') required final int eventId,
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'category_type') final String? categoryType,
    @JsonKey(name: 'event_type_id') required final int eventTypeId,
    @JsonKey(name: 'event_type_name') final String? eventTypeName,
    @JsonKey(name: 'color_code') final String? colorCode,
    @JsonKey(name: 'event_date') required final String eventDate,
    final String? content,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'student_name') final String? studentName,
    @JsonKey(name: 'student_phone') final String? studentPhone,
    @JsonKey(name: 'consult_id') final int? consultId,
    @JsonKey(name: 'created_by') required final int createdBy,
    @JsonKey(name: 'created_by_name') final String? createdByName,
    @JsonKey(name: 'updated_by') final int? updatedBy,
    @JsonKey(name: 'updated_by_name') final String? updatedByName,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$ScheduleEventImpl;
  const _ScheduleEvent._() : super._();

  factory _ScheduleEvent.fromJson(Map<String, dynamic> json) =
      _$ScheduleEventImpl.fromJson;

  @override
  @JsonKey(name: 'event_id')
  int get eventId;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_type')
  String? get categoryType;
  @override
  @JsonKey(name: 'event_type_id')
  int get eventTypeId;
  @override
  @JsonKey(name: 'event_type_name')
  String? get eventTypeName;
  @override
  @JsonKey(name: 'color_code')
  String? get colorCode;
  @override
  @JsonKey(name: 'event_date')
  String get eventDate;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'student_name')
  String? get studentName;
  @override
  @JsonKey(name: 'student_phone')
  String? get studentPhone;
  @override
  @JsonKey(name: 'consult_id')
  int? get consultId;
  @override
  @JsonKey(name: 'created_by')
  int get createdBy;
  @override
  @JsonKey(name: 'created_by_name')
  String? get createdByName;
  @override
  @JsonKey(name: 'updated_by')
  int? get updatedBy;
  @override
  @JsonKey(name: 'updated_by_name')
  String? get updatedByName;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of ScheduleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleEventImplCopyWith<_$ScheduleEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleEventCreate _$ScheduleEventCreateFromJson(Map<String, dynamic> json) {
  return _ScheduleEventCreate.fromJson(json);
}

/// @nodoc
mixin _$ScheduleEventCreate {
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_id')
  int get eventTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  String get eventDate => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;

  /// Serializes this ScheduleEventCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleEventCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleEventCreateCopyWith<ScheduleEventCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleEventCreateCopyWith<$Res> {
  factory $ScheduleEventCreateCopyWith(
    ScheduleEventCreate value,
    $Res Function(ScheduleEventCreate) then,
  ) = _$ScheduleEventCreateCopyWithImpl<$Res, ScheduleEventCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_date') String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  });
}

/// @nodoc
class _$ScheduleEventCreateCopyWithImpl<$Res, $Val extends ScheduleEventCreate>
    implements $ScheduleEventCreateCopyWith<$Res> {
  _$ScheduleEventCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleEventCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? eventTypeId = null,
    Object? eventDate = null,
    Object? content = freezed,
    Object? studentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            eventTypeId: null == eventTypeId
                ? _value.eventTypeId
                : eventTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleEventCreateImplCopyWith<$Res>
    implements $ScheduleEventCreateCopyWith<$Res> {
  factory _$$ScheduleEventCreateImplCopyWith(
    _$ScheduleEventCreateImpl value,
    $Res Function(_$ScheduleEventCreateImpl) then,
  ) = __$$ScheduleEventCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'event_type_id') int eventTypeId,
    @JsonKey(name: 'event_date') String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  });
}

/// @nodoc
class __$$ScheduleEventCreateImplCopyWithImpl<$Res>
    extends _$ScheduleEventCreateCopyWithImpl<$Res, _$ScheduleEventCreateImpl>
    implements _$$ScheduleEventCreateImplCopyWith<$Res> {
  __$$ScheduleEventCreateImplCopyWithImpl(
    _$ScheduleEventCreateImpl _value,
    $Res Function(_$ScheduleEventCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleEventCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? eventTypeId = null,
    Object? eventDate = null,
    Object? content = freezed,
    Object? studentId = freezed,
  }) {
    return _then(
      _$ScheduleEventCreateImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        eventTypeId: null == eventTypeId
            ? _value.eventTypeId
            : eventTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleEventCreateImpl implements _ScheduleEventCreate {
  const _$ScheduleEventCreateImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'event_type_id') required this.eventTypeId,
    @JsonKey(name: 'event_date') required this.eventDate,
    this.content,
    @JsonKey(name: 'student_id') this.studentId,
  });

  factory _$ScheduleEventCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleEventCreateImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  final int eventTypeId;
  @override
  @JsonKey(name: 'event_date')
  final String eventDate;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;

  @override
  String toString() {
    return 'ScheduleEventCreate(categoryId: $categoryId, eventTypeId: $eventTypeId, eventDate: $eventDate, content: $content, studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleEventCreateImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.eventTypeId, eventTypeId) ||
                other.eventTypeId == eventTypeId) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    eventTypeId,
    eventDate,
    content,
    studentId,
  );

  /// Create a copy of ScheduleEventCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleEventCreateImplCopyWith<_$ScheduleEventCreateImpl> get copyWith =>
      __$$ScheduleEventCreateImplCopyWithImpl<_$ScheduleEventCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleEventCreateImplToJson(this);
  }
}

abstract class _ScheduleEventCreate implements ScheduleEventCreate {
  const factory _ScheduleEventCreate({
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'event_type_id') required final int eventTypeId,
    @JsonKey(name: 'event_date') required final String eventDate,
    final String? content,
    @JsonKey(name: 'student_id') final int? studentId,
  }) = _$ScheduleEventCreateImpl;

  factory _ScheduleEventCreate.fromJson(Map<String, dynamic> json) =
      _$ScheduleEventCreateImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  int get eventTypeId;
  @override
  @JsonKey(name: 'event_date')
  String get eventDate;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;

  /// Create a copy of ScheduleEventCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleEventCreateImplCopyWith<_$ScheduleEventCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleEventUpdate _$ScheduleEventUpdateFromJson(Map<String, dynamic> json) {
  return _ScheduleEventUpdate.fromJson(json);
}

/// @nodoc
mixin _$ScheduleEventUpdate {
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_id')
  int? get eventTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  String? get eventDate => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;

  /// Serializes this ScheduleEventUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleEventUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleEventUpdateCopyWith<ScheduleEventUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleEventUpdateCopyWith<$Res> {
  factory $ScheduleEventUpdateCopyWith(
    ScheduleEventUpdate value,
    $Res Function(ScheduleEventUpdate) then,
  ) = _$ScheduleEventUpdateCopyWithImpl<$Res, ScheduleEventUpdate>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'event_date') String? eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  });
}

/// @nodoc
class _$ScheduleEventUpdateCopyWithImpl<$Res, $Val extends ScheduleEventUpdate>
    implements $ScheduleEventUpdateCopyWith<$Res> {
  _$ScheduleEventUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleEventUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? eventTypeId = freezed,
    Object? eventDate = freezed,
    Object? content = freezed,
    Object? studentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            eventTypeId: freezed == eventTypeId
                ? _value.eventTypeId
                : eventTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            eventDate: freezed == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleEventUpdateImplCopyWith<$Res>
    implements $ScheduleEventUpdateCopyWith<$Res> {
  factory _$$ScheduleEventUpdateImplCopyWith(
    _$ScheduleEventUpdateImpl value,
    $Res Function(_$ScheduleEventUpdateImpl) then,
  ) = __$$ScheduleEventUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'event_date') String? eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  });
}

/// @nodoc
class __$$ScheduleEventUpdateImplCopyWithImpl<$Res>
    extends _$ScheduleEventUpdateCopyWithImpl<$Res, _$ScheduleEventUpdateImpl>
    implements _$$ScheduleEventUpdateImplCopyWith<$Res> {
  __$$ScheduleEventUpdateImplCopyWithImpl(
    _$ScheduleEventUpdateImpl _value,
    $Res Function(_$ScheduleEventUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleEventUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? eventTypeId = freezed,
    Object? eventDate = freezed,
    Object? content = freezed,
    Object? studentId = freezed,
  }) {
    return _then(
      _$ScheduleEventUpdateImpl(
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        eventTypeId: freezed == eventTypeId
            ? _value.eventTypeId
            : eventTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        eventDate: freezed == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleEventUpdateImpl implements _ScheduleEventUpdate {
  const _$ScheduleEventUpdateImpl({
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'event_type_id') this.eventTypeId,
    @JsonKey(name: 'event_date') this.eventDate,
    this.content,
    @JsonKey(name: 'student_id') this.studentId,
  });

  factory _$ScheduleEventUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleEventUpdateImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  final int? eventTypeId;
  @override
  @JsonKey(name: 'event_date')
  final String? eventDate;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;

  @override
  String toString() {
    return 'ScheduleEventUpdate(categoryId: $categoryId, eventTypeId: $eventTypeId, eventDate: $eventDate, content: $content, studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleEventUpdateImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.eventTypeId, eventTypeId) ||
                other.eventTypeId == eventTypeId) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    eventTypeId,
    eventDate,
    content,
    studentId,
  );

  /// Create a copy of ScheduleEventUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleEventUpdateImplCopyWith<_$ScheduleEventUpdateImpl> get copyWith =>
      __$$ScheduleEventUpdateImplCopyWithImpl<_$ScheduleEventUpdateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleEventUpdateImplToJson(this);
  }
}

abstract class _ScheduleEventUpdate implements ScheduleEventUpdate {
  const factory _ScheduleEventUpdate({
    @JsonKey(name: 'category_id') final int? categoryId,
    @JsonKey(name: 'event_type_id') final int? eventTypeId,
    @JsonKey(name: 'event_date') final String? eventDate,
    final String? content,
    @JsonKey(name: 'student_id') final int? studentId,
  }) = _$ScheduleEventUpdateImpl;

  factory _ScheduleEventUpdate.fromJson(Map<String, dynamic> json) =
      _$ScheduleEventUpdateImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  int? get eventTypeId;
  @override
  @JsonKey(name: 'event_date')
  String? get eventDate;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;

  /// Create a copy of ScheduleEventUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleEventUpdateImplCopyWith<_$ScheduleEventUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleEventListParams _$ScheduleEventListParamsFromJson(
  Map<String, dynamic> json,
) {
  return _ScheduleEventListParams.fromJson(json);
}

/// @nodoc
mixin _$ScheduleEventListParams {
  @JsonKey(name: 'from_date')
  String? get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String? get toDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type_id')
  int? get eventTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  int? get createdBy => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this ScheduleEventListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleEventListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleEventListParamsCopyWith<ScheduleEventListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleEventListParamsCopyWith<$Res> {
  factory $ScheduleEventListParamsCopyWith(
    ScheduleEventListParams value,
    $Res Function(ScheduleEventListParams) then,
  ) = _$ScheduleEventListParamsCopyWithImpl<$Res, ScheduleEventListParams>;
  @useResult
  $Res call({
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'created_by') int? createdBy,
    int page,
    int perPage,
  });
}

/// @nodoc
class _$ScheduleEventListParamsCopyWithImpl<
  $Res,
  $Val extends ScheduleEventListParams
>
    implements $ScheduleEventListParamsCopyWith<$Res> {
  _$ScheduleEventListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleEventListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? categoryId = freezed,
    Object? eventTypeId = freezed,
    Object? studentId = freezed,
    Object? createdBy = freezed,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _value.copyWith(
            fromDate: freezed == fromDate
                ? _value.fromDate
                : fromDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            toDate: freezed == toDate
                ? _value.toDate
                : toDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            eventTypeId: freezed == eventTypeId
                ? _value.eventTypeId
                : eventTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as int?,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleEventListParamsImplCopyWith<$Res>
    implements $ScheduleEventListParamsCopyWith<$Res> {
  factory _$$ScheduleEventListParamsImplCopyWith(
    _$ScheduleEventListParamsImpl value,
    $Res Function(_$ScheduleEventListParamsImpl) then,
  ) = __$$ScheduleEventListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'created_by') int? createdBy,
    int page,
    int perPage,
  });
}

/// @nodoc
class __$$ScheduleEventListParamsImplCopyWithImpl<$Res>
    extends
        _$ScheduleEventListParamsCopyWithImpl<
          $Res,
          _$ScheduleEventListParamsImpl
        >
    implements _$$ScheduleEventListParamsImplCopyWith<$Res> {
  __$$ScheduleEventListParamsImplCopyWithImpl(
    _$ScheduleEventListParamsImpl _value,
    $Res Function(_$ScheduleEventListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleEventListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? categoryId = freezed,
    Object? eventTypeId = freezed,
    Object? studentId = freezed,
    Object? createdBy = freezed,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _$ScheduleEventListParamsImpl(
        fromDate: freezed == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        toDate: freezed == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        eventTypeId: freezed == eventTypeId
            ? _value.eventTypeId
            : eventTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as int?,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleEventListParamsImpl implements _ScheduleEventListParams {
  const _$ScheduleEventListParamsImpl({
    @JsonKey(name: 'from_date') this.fromDate,
    @JsonKey(name: 'to_date') this.toDate,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'event_type_id') this.eventTypeId,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'created_by') this.createdBy,
    this.page = 1,
    this.perPage = 1000,
  });

  factory _$ScheduleEventListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleEventListParamsImplFromJson(json);

  @override
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String? toDate;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  final int? eventTypeId;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'created_by')
  final int? createdBy;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int perPage;

  @override
  String toString() {
    return 'ScheduleEventListParams(fromDate: $fromDate, toDate: $toDate, categoryId: $categoryId, eventTypeId: $eventTypeId, studentId: $studentId, createdBy: $createdBy, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleEventListParamsImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.eventTypeId, eventTypeId) ||
                other.eventTypeId == eventTypeId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fromDate,
    toDate,
    categoryId,
    eventTypeId,
    studentId,
    createdBy,
    page,
    perPage,
  );

  /// Create a copy of ScheduleEventListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleEventListParamsImplCopyWith<_$ScheduleEventListParamsImpl>
  get copyWith =>
      __$$ScheduleEventListParamsImplCopyWithImpl<
        _$ScheduleEventListParamsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleEventListParamsImplToJson(this);
  }
}

abstract class _ScheduleEventListParams implements ScheduleEventListParams {
  const factory _ScheduleEventListParams({
    @JsonKey(name: 'from_date') final String? fromDate,
    @JsonKey(name: 'to_date') final String? toDate,
    @JsonKey(name: 'category_id') final int? categoryId,
    @JsonKey(name: 'event_type_id') final int? eventTypeId,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'created_by') final int? createdBy,
    final int page,
    final int perPage,
  }) = _$ScheduleEventListParamsImpl;

  factory _ScheduleEventListParams.fromJson(Map<String, dynamic> json) =
      _$ScheduleEventListParamsImpl.fromJson;

  @override
  @JsonKey(name: 'from_date')
  String? get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String? get toDate;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'event_type_id')
  int? get eventTypeId;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'created_by')
  int? get createdBy;
  @override
  int get page;
  @override
  int get perPage;

  /// Create a copy of ScheduleEventListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleEventListParamsImplCopyWith<_$ScheduleEventListParamsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
