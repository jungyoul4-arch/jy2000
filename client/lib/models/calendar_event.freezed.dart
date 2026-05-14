// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  return _CalendarEvent.fromJson(json);
}

/// @nodoc
mixin _$CalendarEvent {
  int get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'consult', 'next_consult', 'promotion'
  String get date => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_name')
  String? get tcName => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_id')
  int? get promotionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotion_name')
  String? get promotionName => throw _privateConstructorUsedError;

  /// Serializes this CalendarEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarEventCopyWith<CalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
    CalendarEvent value,
    $Res Function(CalendarEvent) then,
  ) = _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
  @useResult
  $Res call({
    int id,
    String type,
    String date,
    String title,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'promotion_id') int? promotionId,
    @JsonKey(name: 'promotion_name') String? promotionName,
  });
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? title = null,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? promotionId = freezed,
    Object? promotionName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            tcName: freezed == tcName
                ? _value.tcName
                : tcName // ignore: cast_nullable_to_non_nullable
                      as String?,
            promotionId: freezed == promotionId
                ? _value.promotionId
                : promotionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            promotionName: freezed == promotionName
                ? _value.promotionName
                : promotionName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalendarEventImplCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$CalendarEventImplCopyWith(
    _$CalendarEventImpl value,
    $Res Function(_$CalendarEventImpl) then,
  ) = __$$CalendarEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    String date,
    String title,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'promotion_id') int? promotionId,
    @JsonKey(name: 'promotion_name') String? promotionName,
  });
}

/// @nodoc
class __$$CalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$CalendarEventImpl>
    implements _$$CalendarEventImplCopyWith<$Res> {
  __$$CalendarEventImplCopyWithImpl(
    _$CalendarEventImpl _value,
    $Res Function(_$CalendarEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? title = null,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? promotionId = freezed,
    Object? promotionName = freezed,
  }) {
    return _then(
      _$CalendarEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        tcName: freezed == tcName
            ? _value.tcName
            : tcName // ignore: cast_nullable_to_non_nullable
                  as String?,
        promotionId: freezed == promotionId
            ? _value.promotionId
            : promotionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        promotionName: freezed == promotionName
            ? _value.promotionName
            : promotionName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarEventImpl implements _CalendarEvent {
  const _$CalendarEventImpl({
    required this.id,
    required this.type,
    required this.date,
    required this.title,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'student_name') this.studentName,
    @JsonKey(name: 'tc_id') this.tcId,
    @JsonKey(name: 'tc_name') this.tcName,
    @JsonKey(name: 'promotion_id') this.promotionId,
    @JsonKey(name: 'promotion_name') this.promotionName,
  });

  factory _$CalendarEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarEventImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  // 'consult', 'next_consult', 'promotion'
  @override
  final String date;
  @override
  final String title;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'student_name')
  final String? studentName;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  @JsonKey(name: 'tc_name')
  final String? tcName;
  @override
  @JsonKey(name: 'promotion_id')
  final int? promotionId;
  @override
  @JsonKey(name: 'promotion_name')
  final String? promotionName;

  @override
  String toString() {
    return 'CalendarEvent(id: $id, type: $type, date: $date, title: $title, studentId: $studentId, studentName: $studentName, tcId: $tcId, tcName: $tcName, promotionId: $promotionId, promotionName: $promotionName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.tcName, tcName) || other.tcName == tcName) &&
            (identical(other.promotionId, promotionId) ||
                other.promotionId == promotionId) &&
            (identical(other.promotionName, promotionName) ||
                other.promotionName == promotionName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    date,
    title,
    studentId,
    studentName,
    tcId,
    tcName,
    promotionId,
    promotionName,
  );

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      __$$CalendarEventImplCopyWithImpl<_$CalendarEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarEventImplToJson(this);
  }
}

abstract class _CalendarEvent implements CalendarEvent {
  const factory _CalendarEvent({
    required final int id,
    required final String type,
    required final String date,
    required final String title,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'student_name') final String? studentName,
    @JsonKey(name: 'tc_id') final int? tcId,
    @JsonKey(name: 'tc_name') final String? tcName,
    @JsonKey(name: 'promotion_id') final int? promotionId,
    @JsonKey(name: 'promotion_name') final String? promotionName,
  }) = _$CalendarEventImpl;

  factory _CalendarEvent.fromJson(Map<String, dynamic> json) =
      _$CalendarEventImpl.fromJson;

  @override
  int get id;
  @override
  String get type; // 'consult', 'next_consult', 'promotion'
  @override
  String get date;
  @override
  String get title;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'student_name')
  String? get studentName;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  @JsonKey(name: 'tc_name')
  String? get tcName;
  @override
  @JsonKey(name: 'promotion_id')
  int? get promotionId;
  @override
  @JsonKey(name: 'promotion_name')
  String? get promotionName;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
