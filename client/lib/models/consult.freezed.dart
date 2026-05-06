// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Consult _$ConsultFromJson(Map<String, dynamic> json) {
  return _Consult.fromJson(json);
}

/// @nodoc
mixin _$Consult {
  @JsonKey(name: 'consult_id')
  int get consultId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_phone')
  String? get studentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_type_code')
  String get consultTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_type_name')
  String? get consultTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_date')
  String get consultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_duration')
  int? get consultDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_code')
  String? get channelCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_name')
  String? get channelName => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_name')
  String? get tcName => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_needs')
  String? get studentNeeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_result_name')
  String? get consultResultName => throw _privateConstructorUsedError;
  @JsonKey(name: 'result_detail')
  String? get resultDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_name')
  String? get nextActionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_subject')
  String? get interestSubject => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_program')
  String? get interestProgram => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Consult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Consult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultCopyWith<Consult> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultCopyWith<$Res> {
  factory $ConsultCopyWith(Consult value, $Res Function(Consult) then) =
      _$ConsultCopyWithImpl<$Res, Consult>;
  @useResult
  $Res call({
    @JsonKey(name: 'consult_id') int consultId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_type_code') String consultTypeCode,
    @JsonKey(name: 'consult_type_name') String? consultTypeName,
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'channel_name') String? channelName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'consult_result_name') String? consultResultName,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_name') String? nextActionName,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$ConsultCopyWithImpl<$Res, $Val extends Consult>
    implements $ConsultCopyWith<$Res> {
  _$ConsultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Consult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultId = null,
    Object? studentId = null,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? consultTypeCode = null,
    Object? consultTypeName = freezed,
    Object? consultDate = null,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? channelName = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? consultResultName = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionName = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            consultId: null == consultId
                ? _value.consultId
                : consultId // ignore: cast_nullable_to_non_nullable
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
            consultTypeCode: null == consultTypeCode
                ? _value.consultTypeCode
                : consultTypeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            consultTypeName: freezed == consultTypeName
                ? _value.consultTypeName
                : consultTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultDate: null == consultDate
                ? _value.consultDate
                : consultDate // ignore: cast_nullable_to_non_nullable
                      as String,
            consultDuration: freezed == consultDuration
                ? _value.consultDuration
                : consultDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
            channelCode: freezed == channelCode
                ? _value.channelCode
                : channelCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            channelName: freezed == channelName
                ? _value.channelName
                : channelName // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            tcName: freezed == tcName
                ? _value.tcName
                : tcName // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentNeeds: freezed == studentNeeds
                ? _value.studentNeeds
                : studentNeeds // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultResultCode: freezed == consultResultCode
                ? _value.consultResultCode
                : consultResultCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultResultName: freezed == consultResultName
                ? _value.consultResultName
                : consultResultName // ignore: cast_nullable_to_non_nullable
                      as String?,
            resultDetail: freezed == resultDetail
                ? _value.resultDetail
                : resultDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionCode: freezed == nextActionCode
                ? _value.nextActionCode
                : nextActionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionName: freezed == nextActionName
                ? _value.nextActionName
                : nextActionName // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionDetail: freezed == nextActionDetail
                ? _value.nextActionDetail
                : nextActionDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextConsultDate: freezed == nextConsultDate
                ? _value.nextConsultDate
                : nextConsultDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestSubject: freezed == interestSubject
                ? _value.interestSubject
                : interestSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestProgram: freezed == interestProgram
                ? _value.interestProgram
                : interestProgram // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ConsultImplCopyWith<$Res> implements $ConsultCopyWith<$Res> {
  factory _$$ConsultImplCopyWith(
    _$ConsultImpl value,
    $Res Function(_$ConsultImpl) then,
  ) = __$$ConsultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'consult_id') int consultId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_type_code') String consultTypeCode,
    @JsonKey(name: 'consult_type_name') String? consultTypeName,
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'channel_name') String? channelName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'consult_result_name') String? consultResultName,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_name') String? nextActionName,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$ConsultImplCopyWithImpl<$Res>
    extends _$ConsultCopyWithImpl<$Res, _$ConsultImpl>
    implements _$$ConsultImplCopyWith<$Res> {
  __$$ConsultImplCopyWithImpl(
    _$ConsultImpl _value,
    $Res Function(_$ConsultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Consult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultId = null,
    Object? studentId = null,
    Object? studentName = freezed,
    Object? studentPhone = freezed,
    Object? consultTypeCode = null,
    Object? consultTypeName = freezed,
    Object? consultDate = null,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? channelName = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? consultResultName = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionName = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ConsultImpl(
        consultId: null == consultId
            ? _value.consultId
            : consultId // ignore: cast_nullable_to_non_nullable
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
        consultTypeCode: null == consultTypeCode
            ? _value.consultTypeCode
            : consultTypeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        consultTypeName: freezed == consultTypeName
            ? _value.consultTypeName
            : consultTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultDate: null == consultDate
            ? _value.consultDate
            : consultDate // ignore: cast_nullable_to_non_nullable
                  as String,
        consultDuration: freezed == consultDuration
            ? _value.consultDuration
            : consultDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
        channelCode: freezed == channelCode
            ? _value.channelCode
            : channelCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        channelName: freezed == channelName
            ? _value.channelName
            : channelName // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        tcName: freezed == tcName
            ? _value.tcName
            : tcName // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentNeeds: freezed == studentNeeds
            ? _value.studentNeeds
            : studentNeeds // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultResultCode: freezed == consultResultCode
            ? _value.consultResultCode
            : consultResultCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultResultName: freezed == consultResultName
            ? _value.consultResultName
            : consultResultName // ignore: cast_nullable_to_non_nullable
                  as String?,
        resultDetail: freezed == resultDetail
            ? _value.resultDetail
            : resultDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionCode: freezed == nextActionCode
            ? _value.nextActionCode
            : nextActionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionName: freezed == nextActionName
            ? _value.nextActionName
            : nextActionName // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionDetail: freezed == nextActionDetail
            ? _value.nextActionDetail
            : nextActionDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextConsultDate: freezed == nextConsultDate
            ? _value.nextConsultDate
            : nextConsultDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestSubject: freezed == interestSubject
            ? _value.interestSubject
            : interestSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestProgram: freezed == interestProgram
            ? _value.interestProgram
            : interestProgram // ignore: cast_nullable_to_non_nullable
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
class _$ConsultImpl implements _Consult {
  const _$ConsultImpl({
    @JsonKey(name: 'consult_id') required this.consultId,
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'student_name') this.studentName,
    @JsonKey(name: 'student_phone') this.studentPhone,
    @JsonKey(name: 'consult_type_code') required this.consultTypeCode,
    @JsonKey(name: 'consult_type_name') this.consultTypeName,
    @JsonKey(name: 'consult_date') required this.consultDate,
    @JsonKey(name: 'consult_duration') this.consultDuration,
    @JsonKey(name: 'channel_code') this.channelCode,
    @JsonKey(name: 'channel_name') this.channelName,
    @JsonKey(name: 'tc_id') this.tcId,
    @JsonKey(name: 'tc_name') this.tcName,
    this.content,
    @JsonKey(name: 'student_needs') this.studentNeeds,
    @JsonKey(name: 'consult_result_code') this.consultResultCode,
    @JsonKey(name: 'consult_result_name') this.consultResultName,
    @JsonKey(name: 'result_detail') this.resultDetail,
    @JsonKey(name: 'next_action_code') this.nextActionCode,
    @JsonKey(name: 'next_action_name') this.nextActionName,
    @JsonKey(name: 'next_action_detail') this.nextActionDetail,
    @JsonKey(name: 'next_consult_date') this.nextConsultDate,
    @JsonKey(name: 'interest_subject') this.interestSubject,
    @JsonKey(name: 'interest_program') this.interestProgram,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$ConsultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultImplFromJson(json);

  @override
  @JsonKey(name: 'consult_id')
  final int consultId;
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
  @JsonKey(name: 'consult_type_code')
  final String consultTypeCode;
  @override
  @JsonKey(name: 'consult_type_name')
  final String? consultTypeName;
  @override
  @JsonKey(name: 'consult_date')
  final String consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  final int? consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @override
  @JsonKey(name: 'channel_name')
  final String? channelName;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  @JsonKey(name: 'tc_name')
  final String? tcName;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_needs')
  final String? studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  final String? consultResultCode;
  @override
  @JsonKey(name: 'consult_result_name')
  final String? consultResultName;
  @override
  @JsonKey(name: 'result_detail')
  final String? resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  final String? nextActionCode;
  @override
  @JsonKey(name: 'next_action_name')
  final String? nextActionName;
  @override
  @JsonKey(name: 'next_action_detail')
  final String? nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  final String? nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  final String? interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  final String? interestProgram;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Consult(consultId: $consultId, studentId: $studentId, studentName: $studentName, studentPhone: $studentPhone, consultTypeCode: $consultTypeCode, consultTypeName: $consultTypeName, consultDate: $consultDate, consultDuration: $consultDuration, channelCode: $channelCode, channelName: $channelName, tcId: $tcId, tcName: $tcName, content: $content, studentNeeds: $studentNeeds, consultResultCode: $consultResultCode, consultResultName: $consultResultName, resultDetail: $resultDetail, nextActionCode: $nextActionCode, nextActionName: $nextActionName, nextActionDetail: $nextActionDetail, nextConsultDate: $nextConsultDate, interestSubject: $interestSubject, interestProgram: $interestProgram, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultImpl &&
            (identical(other.consultId, consultId) ||
                other.consultId == consultId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentPhone, studentPhone) ||
                other.studentPhone == studentPhone) &&
            (identical(other.consultTypeCode, consultTypeCode) ||
                other.consultTypeCode == consultTypeCode) &&
            (identical(other.consultTypeName, consultTypeName) ||
                other.consultTypeName == consultTypeName) &&
            (identical(other.consultDate, consultDate) ||
                other.consultDate == consultDate) &&
            (identical(other.consultDuration, consultDuration) ||
                other.consultDuration == consultDuration) &&
            (identical(other.channelCode, channelCode) ||
                other.channelCode == channelCode) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.tcName, tcName) || other.tcName == tcName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentNeeds, studentNeeds) ||
                other.studentNeeds == studentNeeds) &&
            (identical(other.consultResultCode, consultResultCode) ||
                other.consultResultCode == consultResultCode) &&
            (identical(other.consultResultName, consultResultName) ||
                other.consultResultName == consultResultName) &&
            (identical(other.resultDetail, resultDetail) ||
                other.resultDetail == resultDetail) &&
            (identical(other.nextActionCode, nextActionCode) ||
                other.nextActionCode == nextActionCode) &&
            (identical(other.nextActionName, nextActionName) ||
                other.nextActionName == nextActionName) &&
            (identical(other.nextActionDetail, nextActionDetail) ||
                other.nextActionDetail == nextActionDetail) &&
            (identical(other.nextConsultDate, nextConsultDate) ||
                other.nextConsultDate == nextConsultDate) &&
            (identical(other.interestSubject, interestSubject) ||
                other.interestSubject == interestSubject) &&
            (identical(other.interestProgram, interestProgram) ||
                other.interestProgram == interestProgram) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    consultId,
    studentId,
    studentName,
    studentPhone,
    consultTypeCode,
    consultTypeName,
    consultDate,
    consultDuration,
    channelCode,
    channelName,
    tcId,
    tcName,
    content,
    studentNeeds,
    consultResultCode,
    consultResultName,
    resultDetail,
    nextActionCode,
    nextActionName,
    nextActionDetail,
    nextConsultDate,
    interestSubject,
    interestProgram,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Consult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultImplCopyWith<_$ConsultImpl> get copyWith =>
      __$$ConsultImplCopyWithImpl<_$ConsultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultImplToJson(this);
  }
}

abstract class _Consult implements Consult {
  const factory _Consult({
    @JsonKey(name: 'consult_id') required final int consultId,
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'student_name') final String? studentName,
    @JsonKey(name: 'student_phone') final String? studentPhone,
    @JsonKey(name: 'consult_type_code') required final String consultTypeCode,
    @JsonKey(name: 'consult_type_name') final String? consultTypeName,
    @JsonKey(name: 'consult_date') required final String consultDate,
    @JsonKey(name: 'consult_duration') final int? consultDuration,
    @JsonKey(name: 'channel_code') final String? channelCode,
    @JsonKey(name: 'channel_name') final String? channelName,
    @JsonKey(name: 'tc_id') final int? tcId,
    @JsonKey(name: 'tc_name') final String? tcName,
    final String? content,
    @JsonKey(name: 'student_needs') final String? studentNeeds,
    @JsonKey(name: 'consult_result_code') final String? consultResultCode,
    @JsonKey(name: 'consult_result_name') final String? consultResultName,
    @JsonKey(name: 'result_detail') final String? resultDetail,
    @JsonKey(name: 'next_action_code') final String? nextActionCode,
    @JsonKey(name: 'next_action_name') final String? nextActionName,
    @JsonKey(name: 'next_action_detail') final String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') final String? nextConsultDate,
    @JsonKey(name: 'interest_subject') final String? interestSubject,
    @JsonKey(name: 'interest_program') final String? interestProgram,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$ConsultImpl;

  factory _Consult.fromJson(Map<String, dynamic> json) = _$ConsultImpl.fromJson;

  @override
  @JsonKey(name: 'consult_id')
  int get consultId;
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
  @JsonKey(name: 'consult_type_code')
  String get consultTypeCode;
  @override
  @JsonKey(name: 'consult_type_name')
  String? get consultTypeName;
  @override
  @JsonKey(name: 'consult_date')
  String get consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  int? get consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  String? get channelCode;
  @override
  @JsonKey(name: 'channel_name')
  String? get channelName;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  @JsonKey(name: 'tc_name')
  String? get tcName;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_needs')
  String? get studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode;
  @override
  @JsonKey(name: 'consult_result_name')
  String? get consultResultName;
  @override
  @JsonKey(name: 'result_detail')
  String? get resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode;
  @override
  @JsonKey(name: 'next_action_name')
  String? get nextActionName;
  @override
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  String? get interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  String? get interestProgram;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of Consult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultImplCopyWith<_$ConsultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsultCreate _$ConsultCreateFromJson(Map<String, dynamic> json) {
  return _ConsultCreate.fromJson(json);
}

/// @nodoc
mixin _$ConsultCreate {
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_type_code')
  String get consultTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_date')
  String get consultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_duration')
  int? get consultDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_code')
  String? get channelCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_needs')
  String? get studentNeeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'result_detail')
  String? get resultDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_subject')
  String? get interestSubject => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_program')
  String? get interestProgram => throw _privateConstructorUsedError;

  /// Serializes this ConsultCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultCreateCopyWith<ConsultCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultCreateCopyWith<$Res> {
  factory $ConsultCreateCopyWith(
    ConsultCreate value,
    $Res Function(ConsultCreate) then,
  ) = _$ConsultCreateCopyWithImpl<$Res, ConsultCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'consult_type_code') String consultTypeCode,
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  });
}

/// @nodoc
class _$ConsultCreateCopyWithImpl<$Res, $Val extends ConsultCreate>
    implements $ConsultCreateCopyWith<$Res> {
  _$ConsultCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? consultTypeCode = null,
    Object? consultDate = null,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? tcId = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            consultTypeCode: null == consultTypeCode
                ? _value.consultTypeCode
                : consultTypeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            consultDate: null == consultDate
                ? _value.consultDate
                : consultDate // ignore: cast_nullable_to_non_nullable
                      as String,
            consultDuration: freezed == consultDuration
                ? _value.consultDuration
                : consultDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
            channelCode: freezed == channelCode
                ? _value.channelCode
                : channelCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentNeeds: freezed == studentNeeds
                ? _value.studentNeeds
                : studentNeeds // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultResultCode: freezed == consultResultCode
                ? _value.consultResultCode
                : consultResultCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            resultDetail: freezed == resultDetail
                ? _value.resultDetail
                : resultDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionCode: freezed == nextActionCode
                ? _value.nextActionCode
                : nextActionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionDetail: freezed == nextActionDetail
                ? _value.nextActionDetail
                : nextActionDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextConsultDate: freezed == nextConsultDate
                ? _value.nextConsultDate
                : nextConsultDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestSubject: freezed == interestSubject
                ? _value.interestSubject
                : interestSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestProgram: freezed == interestProgram
                ? _value.interestProgram
                : interestProgram // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsultCreateImplCopyWith<$Res>
    implements $ConsultCreateCopyWith<$Res> {
  factory _$$ConsultCreateImplCopyWith(
    _$ConsultCreateImpl value,
    $Res Function(_$ConsultCreateImpl) then,
  ) = __$$ConsultCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'consult_type_code') String consultTypeCode,
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  });
}

/// @nodoc
class __$$ConsultCreateImplCopyWithImpl<$Res>
    extends _$ConsultCreateCopyWithImpl<$Res, _$ConsultCreateImpl>
    implements _$$ConsultCreateImplCopyWith<$Res> {
  __$$ConsultCreateImplCopyWithImpl(
    _$ConsultCreateImpl _value,
    $Res Function(_$ConsultCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsultCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? consultTypeCode = null,
    Object? consultDate = null,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? tcId = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
  }) {
    return _then(
      _$ConsultCreateImpl(
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        consultTypeCode: null == consultTypeCode
            ? _value.consultTypeCode
            : consultTypeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        consultDate: null == consultDate
            ? _value.consultDate
            : consultDate // ignore: cast_nullable_to_non_nullable
                  as String,
        consultDuration: freezed == consultDuration
            ? _value.consultDuration
            : consultDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
        channelCode: freezed == channelCode
            ? _value.channelCode
            : channelCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentNeeds: freezed == studentNeeds
            ? _value.studentNeeds
            : studentNeeds // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultResultCode: freezed == consultResultCode
            ? _value.consultResultCode
            : consultResultCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        resultDetail: freezed == resultDetail
            ? _value.resultDetail
            : resultDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionCode: freezed == nextActionCode
            ? _value.nextActionCode
            : nextActionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionDetail: freezed == nextActionDetail
            ? _value.nextActionDetail
            : nextActionDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextConsultDate: freezed == nextConsultDate
            ? _value.nextConsultDate
            : nextConsultDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestSubject: freezed == interestSubject
            ? _value.interestSubject
            : interestSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestProgram: freezed == interestProgram
            ? _value.interestProgram
            : interestProgram // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultCreateImpl implements _ConsultCreate {
  const _$ConsultCreateImpl({
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'consult_type_code') required this.consultTypeCode,
    @JsonKey(name: 'consult_date') required this.consultDate,
    @JsonKey(name: 'consult_duration') this.consultDuration,
    @JsonKey(name: 'channel_code') this.channelCode,
    @JsonKey(name: 'tc_id') this.tcId,
    this.content,
    @JsonKey(name: 'student_needs') this.studentNeeds,
    @JsonKey(name: 'consult_result_code') this.consultResultCode,
    @JsonKey(name: 'result_detail') this.resultDetail,
    @JsonKey(name: 'next_action_code') this.nextActionCode,
    @JsonKey(name: 'next_action_detail') this.nextActionDetail,
    @JsonKey(name: 'next_consult_date') this.nextConsultDate,
    @JsonKey(name: 'interest_subject') this.interestSubject,
    @JsonKey(name: 'interest_program') this.interestProgram,
  });

  factory _$ConsultCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultCreateImplFromJson(json);

  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'consult_type_code')
  final String consultTypeCode;
  @override
  @JsonKey(name: 'consult_date')
  final String consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  final int? consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_needs')
  final String? studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  final String? consultResultCode;
  @override
  @JsonKey(name: 'result_detail')
  final String? resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  final String? nextActionCode;
  @override
  @JsonKey(name: 'next_action_detail')
  final String? nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  final String? nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  final String? interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  final String? interestProgram;

  @override
  String toString() {
    return 'ConsultCreate(studentId: $studentId, consultTypeCode: $consultTypeCode, consultDate: $consultDate, consultDuration: $consultDuration, channelCode: $channelCode, tcId: $tcId, content: $content, studentNeeds: $studentNeeds, consultResultCode: $consultResultCode, resultDetail: $resultDetail, nextActionCode: $nextActionCode, nextActionDetail: $nextActionDetail, nextConsultDate: $nextConsultDate, interestSubject: $interestSubject, interestProgram: $interestProgram)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultCreateImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.consultTypeCode, consultTypeCode) ||
                other.consultTypeCode == consultTypeCode) &&
            (identical(other.consultDate, consultDate) ||
                other.consultDate == consultDate) &&
            (identical(other.consultDuration, consultDuration) ||
                other.consultDuration == consultDuration) &&
            (identical(other.channelCode, channelCode) ||
                other.channelCode == channelCode) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentNeeds, studentNeeds) ||
                other.studentNeeds == studentNeeds) &&
            (identical(other.consultResultCode, consultResultCode) ||
                other.consultResultCode == consultResultCode) &&
            (identical(other.resultDetail, resultDetail) ||
                other.resultDetail == resultDetail) &&
            (identical(other.nextActionCode, nextActionCode) ||
                other.nextActionCode == nextActionCode) &&
            (identical(other.nextActionDetail, nextActionDetail) ||
                other.nextActionDetail == nextActionDetail) &&
            (identical(other.nextConsultDate, nextConsultDate) ||
                other.nextConsultDate == nextConsultDate) &&
            (identical(other.interestSubject, interestSubject) ||
                other.interestSubject == interestSubject) &&
            (identical(other.interestProgram, interestProgram) ||
                other.interestProgram == interestProgram));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    studentId,
    consultTypeCode,
    consultDate,
    consultDuration,
    channelCode,
    tcId,
    content,
    studentNeeds,
    consultResultCode,
    resultDetail,
    nextActionCode,
    nextActionDetail,
    nextConsultDate,
    interestSubject,
    interestProgram,
  );

  /// Create a copy of ConsultCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultCreateImplCopyWith<_$ConsultCreateImpl> get copyWith =>
      __$$ConsultCreateImplCopyWithImpl<_$ConsultCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultCreateImplToJson(this);
  }
}

abstract class _ConsultCreate implements ConsultCreate {
  const factory _ConsultCreate({
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'consult_type_code') required final String consultTypeCode,
    @JsonKey(name: 'consult_date') required final String consultDate,
    @JsonKey(name: 'consult_duration') final int? consultDuration,
    @JsonKey(name: 'channel_code') final String? channelCode,
    @JsonKey(name: 'tc_id') final int? tcId,
    final String? content,
    @JsonKey(name: 'student_needs') final String? studentNeeds,
    @JsonKey(name: 'consult_result_code') final String? consultResultCode,
    @JsonKey(name: 'result_detail') final String? resultDetail,
    @JsonKey(name: 'next_action_code') final String? nextActionCode,
    @JsonKey(name: 'next_action_detail') final String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') final String? nextConsultDate,
    @JsonKey(name: 'interest_subject') final String? interestSubject,
    @JsonKey(name: 'interest_program') final String? interestProgram,
  }) = _$ConsultCreateImpl;

  factory _ConsultCreate.fromJson(Map<String, dynamic> json) =
      _$ConsultCreateImpl.fromJson;

  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'consult_type_code')
  String get consultTypeCode;
  @override
  @JsonKey(name: 'consult_date')
  String get consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  int? get consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  String? get channelCode;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_needs')
  String? get studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode;
  @override
  @JsonKey(name: 'result_detail')
  String? get resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode;
  @override
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  String? get interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  String? get interestProgram;

  /// Create a copy of ConsultCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultCreateImplCopyWith<_$ConsultCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsultListParams _$ConsultListParamsFromJson(Map<String, dynamic> json) {
  return _ConsultListParams.fromJson(json);
}

/// @nodoc
mixin _$ConsultListParams {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  String? get sort => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_type_code')
  String? get consultTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String? get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String? get toDate => throw _privateConstructorUsedError;

  /// Serializes this ConsultListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultListParamsCopyWith<ConsultListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultListParamsCopyWith<$Res> {
  factory $ConsultListParamsCopyWith(
    ConsultListParams value,
    $Res Function(ConsultListParams) then,
  ) = _$ConsultListParamsCopyWithImpl<$Res, ConsultListParams>;
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  });
}

/// @nodoc
class _$ConsultListParamsCopyWithImpl<$Res, $Val extends ConsultListParams>
    implements $ConsultListParamsCopyWith<$Res> {
  _$ConsultListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? studentId = freezed,
    Object? tcId = freezed,
    Object? consultTypeCode = freezed,
    Object? consultResultCode = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
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
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            consultTypeCode: freezed == consultTypeCode
                ? _value.consultTypeCode
                : consultTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultResultCode: freezed == consultResultCode
                ? _value.consultResultCode
                : consultResultCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            fromDate: freezed == fromDate
                ? _value.fromDate
                : fromDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            toDate: freezed == toDate
                ? _value.toDate
                : toDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsultListParamsImplCopyWith<$Res>
    implements $ConsultListParamsCopyWith<$Res> {
  factory _$$ConsultListParamsImplCopyWith(
    _$ConsultListParamsImpl value,
    $Res Function(_$ConsultListParamsImpl) then,
  ) = __$$ConsultListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  });
}

/// @nodoc
class __$$ConsultListParamsImplCopyWithImpl<$Res>
    extends _$ConsultListParamsCopyWithImpl<$Res, _$ConsultListParamsImpl>
    implements _$$ConsultListParamsImplCopyWith<$Res> {
  __$$ConsultListParamsImplCopyWithImpl(
    _$ConsultListParamsImpl _value,
    $Res Function(_$ConsultListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsultListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? studentId = freezed,
    Object? tcId = freezed,
    Object? consultTypeCode = freezed,
    Object? consultResultCode = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
  }) {
    return _then(
      _$ConsultListParamsImpl(
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
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        consultTypeCode: freezed == consultTypeCode
            ? _value.consultTypeCode
            : consultTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultResultCode: freezed == consultResultCode
            ? _value.consultResultCode
            : consultResultCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        fromDate: freezed == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        toDate: freezed == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultListParamsImpl implements _ConsultListParams {
  const _$ConsultListParamsImpl({
    this.page = 1,
    this.perPage = 20,
    this.sort,
    this.order,
    this.search,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'tc_id') this.tcId,
    @JsonKey(name: 'consult_type_code') this.consultTypeCode,
    @JsonKey(name: 'consult_result_code') this.consultResultCode,
    @JsonKey(name: 'from_date') this.fromDate,
    @JsonKey(name: 'to_date') this.toDate,
  });

  factory _$ConsultListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultListParamsImplFromJson(json);

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
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  @JsonKey(name: 'consult_type_code')
  final String? consultTypeCode;
  @override
  @JsonKey(name: 'consult_result_code')
  final String? consultResultCode;
  @override
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String? toDate;

  @override
  String toString() {
    return 'ConsultListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search, studentId: $studentId, tcId: $tcId, consultTypeCode: $consultTypeCode, consultResultCode: $consultResultCode, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultListParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.consultTypeCode, consultTypeCode) ||
                other.consultTypeCode == consultTypeCode) &&
            (identical(other.consultResultCode, consultResultCode) ||
                other.consultResultCode == consultResultCode) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    page,
    perPage,
    sort,
    order,
    search,
    studentId,
    tcId,
    consultTypeCode,
    consultResultCode,
    fromDate,
    toDate,
  );

  /// Create a copy of ConsultListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultListParamsImplCopyWith<_$ConsultListParamsImpl> get copyWith =>
      __$$ConsultListParamsImplCopyWithImpl<_$ConsultListParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultListParamsImplToJson(this);
  }
}

abstract class _ConsultListParams implements ConsultListParams {
  const factory _ConsultListParams({
    final int page,
    final int perPage,
    final String? sort,
    final String? order,
    final String? search,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'tc_id') final int? tcId,
    @JsonKey(name: 'consult_type_code') final String? consultTypeCode,
    @JsonKey(name: 'consult_result_code') final String? consultResultCode,
    @JsonKey(name: 'from_date') final String? fromDate,
    @JsonKey(name: 'to_date') final String? toDate,
  }) = _$ConsultListParamsImpl;

  factory _ConsultListParams.fromJson(Map<String, dynamic> json) =
      _$ConsultListParamsImpl.fromJson;

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
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  @JsonKey(name: 'consult_type_code')
  String? get consultTypeCode;
  @override
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode;
  @override
  @JsonKey(name: 'from_date')
  String? get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String? get toDate;

  /// Create a copy of ConsultListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultListParamsImplCopyWith<_$ConsultListParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsultUpdate _$ConsultUpdateFromJson(Map<String, dynamic> json) {
  return _ConsultUpdate.fromJson(json);
}

/// @nodoc
mixin _$ConsultUpdate {
  @JsonKey(name: 'consult_type_code')
  String? get consultTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_date')
  String? get consultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_duration')
  int? get consultDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'channel_code')
  String? get channelCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_needs')
  String? get studentNeeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'result_detail')
  String? get resultDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_subject')
  String? get interestSubject => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest_program')
  String? get interestProgram => throw _privateConstructorUsedError;

  /// Serializes this ConsultUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultUpdateCopyWith<ConsultUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultUpdateCopyWith<$Res> {
  factory $ConsultUpdateCopyWith(
    ConsultUpdate value,
    $Res Function(ConsultUpdate) then,
  ) = _$ConsultUpdateCopyWithImpl<$Res, ConsultUpdate>;
  @useResult
  $Res call({
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  });
}

/// @nodoc
class _$ConsultUpdateCopyWithImpl<$Res, $Val extends ConsultUpdate>
    implements $ConsultUpdateCopyWith<$Res> {
  _$ConsultUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultTypeCode = freezed,
    Object? consultDate = freezed,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? tcId = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
  }) {
    return _then(
      _value.copyWith(
            consultTypeCode: freezed == consultTypeCode
                ? _value.consultTypeCode
                : consultTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultDate: freezed == consultDate
                ? _value.consultDate
                : consultDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultDuration: freezed == consultDuration
                ? _value.consultDuration
                : consultDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
            channelCode: freezed == channelCode
                ? _value.channelCode
                : channelCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentNeeds: freezed == studentNeeds
                ? _value.studentNeeds
                : studentNeeds // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultResultCode: freezed == consultResultCode
                ? _value.consultResultCode
                : consultResultCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            resultDetail: freezed == resultDetail
                ? _value.resultDetail
                : resultDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionCode: freezed == nextActionCode
                ? _value.nextActionCode
                : nextActionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextActionDetail: freezed == nextActionDetail
                ? _value.nextActionDetail
                : nextActionDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextConsultDate: freezed == nextConsultDate
                ? _value.nextConsultDate
                : nextConsultDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestSubject: freezed == interestSubject
                ? _value.interestSubject
                : interestSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
            interestProgram: freezed == interestProgram
                ? _value.interestProgram
                : interestProgram // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsultUpdateImplCopyWith<$Res>
    implements $ConsultUpdateCopyWith<$Res> {
  factory _$$ConsultUpdateImplCopyWith(
    _$ConsultUpdateImpl value,
    $Res Function(_$ConsultUpdateImpl) then,
  ) = __$$ConsultUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'consult_duration') int? consultDuration,
    @JsonKey(name: 'channel_code') String? channelCode,
    @JsonKey(name: 'tc_id') int? tcId,
    String? content,
    @JsonKey(name: 'student_needs') String? studentNeeds,
    @JsonKey(name: 'consult_result_code') String? consultResultCode,
    @JsonKey(name: 'result_detail') String? resultDetail,
    @JsonKey(name: 'next_action_code') String? nextActionCode,
    @JsonKey(name: 'next_action_detail') String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') String? nextConsultDate,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'interest_program') String? interestProgram,
  });
}

/// @nodoc
class __$$ConsultUpdateImplCopyWithImpl<$Res>
    extends _$ConsultUpdateCopyWithImpl<$Res, _$ConsultUpdateImpl>
    implements _$$ConsultUpdateImplCopyWith<$Res> {
  __$$ConsultUpdateImplCopyWithImpl(
    _$ConsultUpdateImpl _value,
    $Res Function(_$ConsultUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsultUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultTypeCode = freezed,
    Object? consultDate = freezed,
    Object? consultDuration = freezed,
    Object? channelCode = freezed,
    Object? tcId = freezed,
    Object? content = freezed,
    Object? studentNeeds = freezed,
    Object? consultResultCode = freezed,
    Object? resultDetail = freezed,
    Object? nextActionCode = freezed,
    Object? nextActionDetail = freezed,
    Object? nextConsultDate = freezed,
    Object? interestSubject = freezed,
    Object? interestProgram = freezed,
  }) {
    return _then(
      _$ConsultUpdateImpl(
        consultTypeCode: freezed == consultTypeCode
            ? _value.consultTypeCode
            : consultTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultDate: freezed == consultDate
            ? _value.consultDate
            : consultDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultDuration: freezed == consultDuration
            ? _value.consultDuration
            : consultDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
        channelCode: freezed == channelCode
            ? _value.channelCode
            : channelCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentNeeds: freezed == studentNeeds
            ? _value.studentNeeds
            : studentNeeds // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultResultCode: freezed == consultResultCode
            ? _value.consultResultCode
            : consultResultCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        resultDetail: freezed == resultDetail
            ? _value.resultDetail
            : resultDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionCode: freezed == nextActionCode
            ? _value.nextActionCode
            : nextActionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextActionDetail: freezed == nextActionDetail
            ? _value.nextActionDetail
            : nextActionDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextConsultDate: freezed == nextConsultDate
            ? _value.nextConsultDate
            : nextConsultDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestSubject: freezed == interestSubject
            ? _value.interestSubject
            : interestSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
        interestProgram: freezed == interestProgram
            ? _value.interestProgram
            : interestProgram // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultUpdateImpl implements _ConsultUpdate {
  const _$ConsultUpdateImpl({
    @JsonKey(name: 'consult_type_code') this.consultTypeCode,
    @JsonKey(name: 'consult_date') this.consultDate,
    @JsonKey(name: 'consult_duration') this.consultDuration,
    @JsonKey(name: 'channel_code') this.channelCode,
    @JsonKey(name: 'tc_id') this.tcId,
    this.content,
    @JsonKey(name: 'student_needs') this.studentNeeds,
    @JsonKey(name: 'consult_result_code') this.consultResultCode,
    @JsonKey(name: 'result_detail') this.resultDetail,
    @JsonKey(name: 'next_action_code') this.nextActionCode,
    @JsonKey(name: 'next_action_detail') this.nextActionDetail,
    @JsonKey(name: 'next_consult_date') this.nextConsultDate,
    @JsonKey(name: 'interest_subject') this.interestSubject,
    @JsonKey(name: 'interest_program') this.interestProgram,
  });

  factory _$ConsultUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultUpdateImplFromJson(json);

  @override
  @JsonKey(name: 'consult_type_code')
  final String? consultTypeCode;
  @override
  @JsonKey(name: 'consult_date')
  final String? consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  final int? consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  final String? content;
  @override
  @JsonKey(name: 'student_needs')
  final String? studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  final String? consultResultCode;
  @override
  @JsonKey(name: 'result_detail')
  final String? resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  final String? nextActionCode;
  @override
  @JsonKey(name: 'next_action_detail')
  final String? nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  final String? nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  final String? interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  final String? interestProgram;

  @override
  String toString() {
    return 'ConsultUpdate(consultTypeCode: $consultTypeCode, consultDate: $consultDate, consultDuration: $consultDuration, channelCode: $channelCode, tcId: $tcId, content: $content, studentNeeds: $studentNeeds, consultResultCode: $consultResultCode, resultDetail: $resultDetail, nextActionCode: $nextActionCode, nextActionDetail: $nextActionDetail, nextConsultDate: $nextConsultDate, interestSubject: $interestSubject, interestProgram: $interestProgram)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultUpdateImpl &&
            (identical(other.consultTypeCode, consultTypeCode) ||
                other.consultTypeCode == consultTypeCode) &&
            (identical(other.consultDate, consultDate) ||
                other.consultDate == consultDate) &&
            (identical(other.consultDuration, consultDuration) ||
                other.consultDuration == consultDuration) &&
            (identical(other.channelCode, channelCode) ||
                other.channelCode == channelCode) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.studentNeeds, studentNeeds) ||
                other.studentNeeds == studentNeeds) &&
            (identical(other.consultResultCode, consultResultCode) ||
                other.consultResultCode == consultResultCode) &&
            (identical(other.resultDetail, resultDetail) ||
                other.resultDetail == resultDetail) &&
            (identical(other.nextActionCode, nextActionCode) ||
                other.nextActionCode == nextActionCode) &&
            (identical(other.nextActionDetail, nextActionDetail) ||
                other.nextActionDetail == nextActionDetail) &&
            (identical(other.nextConsultDate, nextConsultDate) ||
                other.nextConsultDate == nextConsultDate) &&
            (identical(other.interestSubject, interestSubject) ||
                other.interestSubject == interestSubject) &&
            (identical(other.interestProgram, interestProgram) ||
                other.interestProgram == interestProgram));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    consultTypeCode,
    consultDate,
    consultDuration,
    channelCode,
    tcId,
    content,
    studentNeeds,
    consultResultCode,
    resultDetail,
    nextActionCode,
    nextActionDetail,
    nextConsultDate,
    interestSubject,
    interestProgram,
  );

  /// Create a copy of ConsultUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultUpdateImplCopyWith<_$ConsultUpdateImpl> get copyWith =>
      __$$ConsultUpdateImplCopyWithImpl<_$ConsultUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultUpdateImplToJson(this);
  }
}

abstract class _ConsultUpdate implements ConsultUpdate {
  const factory _ConsultUpdate({
    @JsonKey(name: 'consult_type_code') final String? consultTypeCode,
    @JsonKey(name: 'consult_date') final String? consultDate,
    @JsonKey(name: 'consult_duration') final int? consultDuration,
    @JsonKey(name: 'channel_code') final String? channelCode,
    @JsonKey(name: 'tc_id') final int? tcId,
    final String? content,
    @JsonKey(name: 'student_needs') final String? studentNeeds,
    @JsonKey(name: 'consult_result_code') final String? consultResultCode,
    @JsonKey(name: 'result_detail') final String? resultDetail,
    @JsonKey(name: 'next_action_code') final String? nextActionCode,
    @JsonKey(name: 'next_action_detail') final String? nextActionDetail,
    @JsonKey(name: 'next_consult_date') final String? nextConsultDate,
    @JsonKey(name: 'interest_subject') final String? interestSubject,
    @JsonKey(name: 'interest_program') final String? interestProgram,
  }) = _$ConsultUpdateImpl;

  factory _ConsultUpdate.fromJson(Map<String, dynamic> json) =
      _$ConsultUpdateImpl.fromJson;

  @override
  @JsonKey(name: 'consult_type_code')
  String? get consultTypeCode;
  @override
  @JsonKey(name: 'consult_date')
  String? get consultDate;
  @override
  @JsonKey(name: 'consult_duration')
  int? get consultDuration;
  @override
  @JsonKey(name: 'channel_code')
  String? get channelCode;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  String? get content;
  @override
  @JsonKey(name: 'student_needs')
  String? get studentNeeds;
  @override
  @JsonKey(name: 'consult_result_code')
  String? get consultResultCode;
  @override
  @JsonKey(name: 'result_detail')
  String? get resultDetail;
  @override
  @JsonKey(name: 'next_action_code')
  String? get nextActionCode;
  @override
  @JsonKey(name: 'next_action_detail')
  String? get nextActionDetail;
  @override
  @JsonKey(name: 'next_consult_date')
  String? get nextConsultDate;
  @override
  @JsonKey(name: 'interest_subject')
  String? get interestSubject;
  @override
  @JsonKey(name: 'interest_program')
  String? get interestProgram;

  /// Create a copy of ConsultUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultUpdateImplCopyWith<_$ConsultUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
