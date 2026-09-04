// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_inquiry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NewInquiryCreate _$NewInquiryCreateFromJson(Map<String, dynamic> json) {
  return _NewInquiryCreate.fromJson(json);
}

/// @nodoc
mixin _$NewInquiryCreate {
  /// 문의 날짜 (YYYY-MM-DD)
  @JsonKey(name: 'consult_date')
  String get consultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;

  /// 기존 학생을 타입어헤드로 고른 경우에만 값이 있다
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'inquiry_source_code')
  String? get inquirySourceCode => throw _privateConstructorUsedError;

  /// 문의 과목 비트마스크
  @JsonKey(name: 'subject_code')
  int? get subjectCode => throw _privateConstructorUsedError;

  /// 문의 과목 표시명 콤마 문자열
  @JsonKey(name: 'interest_subject')
  String? get interestSubject => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_phone')
  String? get studentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'selector_name')
  String? get selectorName => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  /// Serializes this NewInquiryCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewInquiryCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewInquiryCreateCopyWith<NewInquiryCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewInquiryCreateCopyWith<$Res> {
  factory $NewInquiryCreateCopyWith(
    NewInquiryCreate value,
    $Res Function(NewInquiryCreate) then,
  ) = _$NewInquiryCreateCopyWithImpl<$Res, NewInquiryCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'student_name') String studentName,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'inquiry_source_code') String? inquirySourceCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'selector_name') String? selectorName,
    String? content,
  });
}

/// @nodoc
class _$NewInquiryCreateCopyWithImpl<$Res, $Val extends NewInquiryCreate>
    implements $NewInquiryCreateCopyWith<$Res> {
  _$NewInquiryCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewInquiryCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultDate = null,
    Object? studentName = null,
    Object? studentId = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? inquirySourceCode = freezed,
    Object? subjectCode = freezed,
    Object? interestSubject = freezed,
    Object? studentPhone = freezed,
    Object? guardianPhone = freezed,
    Object? selectorName = freezed,
    Object? content = freezed,
  }) {
    return _then(
      _value.copyWith(
            consultDate: null == consultDate
                ? _value.consultDate
                : consultDate // ignore: cast_nullable_to_non_nullable
                      as String,
            studentName: null == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            genderCode: freezed == genderCode
                ? _value.genderCode
                : genderCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolName: freezed == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            inquirySourceCode: freezed == inquirySourceCode
                ? _value.inquirySourceCode
                : inquirySourceCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            interestSubject: freezed == interestSubject
                ? _value.interestSubject
                : interestSubject // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentPhone: freezed == studentPhone
                ? _value.studentPhone
                : studentPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianPhone: freezed == guardianPhone
                ? _value.guardianPhone
                : guardianPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectorName: freezed == selectorName
                ? _value.selectorName
                : selectorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewInquiryCreateImplCopyWith<$Res>
    implements $NewInquiryCreateCopyWith<$Res> {
  factory _$$NewInquiryCreateImplCopyWith(
    _$NewInquiryCreateImpl value,
    $Res Function(_$NewInquiryCreateImpl) then,
  ) = __$$NewInquiryCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'consult_date') String consultDate,
    @JsonKey(name: 'student_name') String studentName,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'inquiry_source_code') String? inquirySourceCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'interest_subject') String? interestSubject,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'selector_name') String? selectorName,
    String? content,
  });
}

/// @nodoc
class __$$NewInquiryCreateImplCopyWithImpl<$Res>
    extends _$NewInquiryCreateCopyWithImpl<$Res, _$NewInquiryCreateImpl>
    implements _$$NewInquiryCreateImplCopyWith<$Res> {
  __$$NewInquiryCreateImplCopyWithImpl(
    _$NewInquiryCreateImpl _value,
    $Res Function(_$NewInquiryCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewInquiryCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultDate = null,
    Object? studentName = null,
    Object? studentId = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? inquirySourceCode = freezed,
    Object? subjectCode = freezed,
    Object? interestSubject = freezed,
    Object? studentPhone = freezed,
    Object? guardianPhone = freezed,
    Object? selectorName = freezed,
    Object? content = freezed,
  }) {
    return _then(
      _$NewInquiryCreateImpl(
        consultDate: null == consultDate
            ? _value.consultDate
            : consultDate // ignore: cast_nullable_to_non_nullable
                  as String,
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        genderCode: freezed == genderCode
            ? _value.genderCode
            : genderCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolName: freezed == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        inquirySourceCode: freezed == inquirySourceCode
            ? _value.inquirySourceCode
            : inquirySourceCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        interestSubject: freezed == interestSubject
            ? _value.interestSubject
            : interestSubject // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentPhone: freezed == studentPhone
            ? _value.studentPhone
            : studentPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianPhone: freezed == guardianPhone
            ? _value.guardianPhone
            : guardianPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectorName: freezed == selectorName
            ? _value.selectorName
            : selectorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewInquiryCreateImpl implements _NewInquiryCreate {
  const _$NewInquiryCreateImpl({
    @JsonKey(name: 'consult_date') required this.consultDate,
    @JsonKey(name: 'student_name') required this.studentName,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'inquiry_source_code') this.inquirySourceCode,
    @JsonKey(name: 'subject_code') this.subjectCode,
    @JsonKey(name: 'interest_subject') this.interestSubject,
    @JsonKey(name: 'student_phone') this.studentPhone,
    @JsonKey(name: 'guardian_phone') this.guardianPhone,
    @JsonKey(name: 'selector_name') this.selectorName,
    this.content,
  });

  factory _$NewInquiryCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewInquiryCreateImplFromJson(json);

  /// 문의 날짜 (YYYY-MM-DD)
  @override
  @JsonKey(name: 'consult_date')
  final String consultDate;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;

  /// 기존 학생을 타입어헤드로 고른 경우에만 값이 있다
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'gender_code')
  final String? genderCode;
  @override
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'inquiry_source_code')
  final String? inquirySourceCode;

  /// 문의 과목 비트마스크
  @override
  @JsonKey(name: 'subject_code')
  final int? subjectCode;

  /// 문의 과목 표시명 콤마 문자열
  @override
  @JsonKey(name: 'interest_subject')
  final String? interestSubject;
  @override
  @JsonKey(name: 'student_phone')
  final String? studentPhone;
  @override
  @JsonKey(name: 'guardian_phone')
  final String? guardianPhone;
  @override
  @JsonKey(name: 'selector_name')
  final String? selectorName;
  @override
  final String? content;

  @override
  String toString() {
    return 'NewInquiryCreate(consultDate: $consultDate, studentName: $studentName, studentId: $studentId, genderCode: $genderCode, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, inquirySourceCode: $inquirySourceCode, subjectCode: $subjectCode, interestSubject: $interestSubject, studentPhone: $studentPhone, guardianPhone: $guardianPhone, selectorName: $selectorName, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewInquiryCreateImpl &&
            (identical(other.consultDate, consultDate) ||
                other.consultDate == consultDate) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.inquirySourceCode, inquirySourceCode) ||
                other.inquirySourceCode == inquirySourceCode) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.interestSubject, interestSubject) ||
                other.interestSubject == interestSubject) &&
            (identical(other.studentPhone, studentPhone) ||
                other.studentPhone == studentPhone) &&
            (identical(other.guardianPhone, guardianPhone) ||
                other.guardianPhone == guardianPhone) &&
            (identical(other.selectorName, selectorName) ||
                other.selectorName == selectorName) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    consultDate,
    studentName,
    studentId,
    genderCode,
    schoolId,
    schoolName,
    grade,
    inquirySourceCode,
    subjectCode,
    interestSubject,
    studentPhone,
    guardianPhone,
    selectorName,
    content,
  );

  /// Create a copy of NewInquiryCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewInquiryCreateImplCopyWith<_$NewInquiryCreateImpl> get copyWith =>
      __$$NewInquiryCreateImplCopyWithImpl<_$NewInquiryCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewInquiryCreateImplToJson(this);
  }
}

abstract class _NewInquiryCreate implements NewInquiryCreate {
  const factory _NewInquiryCreate({
    @JsonKey(name: 'consult_date') required final String consultDate,
    @JsonKey(name: 'student_name') required final String studentName,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'inquiry_source_code') final String? inquirySourceCode,
    @JsonKey(name: 'subject_code') final int? subjectCode,
    @JsonKey(name: 'interest_subject') final String? interestSubject,
    @JsonKey(name: 'student_phone') final String? studentPhone,
    @JsonKey(name: 'guardian_phone') final String? guardianPhone,
    @JsonKey(name: 'selector_name') final String? selectorName,
    final String? content,
  }) = _$NewInquiryCreateImpl;

  factory _NewInquiryCreate.fromJson(Map<String, dynamic> json) =
      _$NewInquiryCreateImpl.fromJson;

  /// 문의 날짜 (YYYY-MM-DD)
  @override
  @JsonKey(name: 'consult_date')
  String get consultDate;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;

  /// 기존 학생을 타입어헤드로 고른 경우에만 값이 있다
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'gender_code')
  String? get genderCode;
  @override
  @JsonKey(name: 'school_id')
  int? get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
  int? get grade;
  @override
  @JsonKey(name: 'inquiry_source_code')
  String? get inquirySourceCode;

  /// 문의 과목 비트마스크
  @override
  @JsonKey(name: 'subject_code')
  int? get subjectCode;

  /// 문의 과목 표시명 콤마 문자열
  @override
  @JsonKey(name: 'interest_subject')
  String? get interestSubject;
  @override
  @JsonKey(name: 'student_phone')
  String? get studentPhone;
  @override
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone;
  @override
  @JsonKey(name: 'selector_name')
  String? get selectorName;
  @override
  String? get content;

  /// Create a copy of NewInquiryCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewInquiryCreateImplCopyWith<_$NewInquiryCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewInquiryResult _$NewInquiryResultFromJson(Map<String, dynamic> json) {
  return _NewInquiryResult.fromJson(json);
}

/// @nodoc
mixin _$NewInquiryResult {
  @JsonKey(name: 'consult_id')
  int get consultId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new_student')
  bool get isNewStudent => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_created')
  bool get guardianCreated => throw _privateConstructorUsedError;

  /// Serializes this NewInquiryResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewInquiryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewInquiryResultCopyWith<NewInquiryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewInquiryResultCopyWith<$Res> {
  factory $NewInquiryResultCopyWith(
    NewInquiryResult value,
    $Res Function(NewInquiryResult) then,
  ) = _$NewInquiryResultCopyWithImpl<$Res, NewInquiryResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'consult_id') int consultId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    @JsonKey(name: 'is_new_student') bool isNewStudent,
    @JsonKey(name: 'guardian_created') bool guardianCreated,
  });
}

/// @nodoc
class _$NewInquiryResultCopyWithImpl<$Res, $Val extends NewInquiryResult>
    implements $NewInquiryResultCopyWith<$Res> {
  _$NewInquiryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewInquiryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultId = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? isNewStudent = null,
    Object? guardianCreated = null,
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
            studentName: null == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String,
            isNewStudent: null == isNewStudent
                ? _value.isNewStudent
                : isNewStudent // ignore: cast_nullable_to_non_nullable
                      as bool,
            guardianCreated: null == guardianCreated
                ? _value.guardianCreated
                : guardianCreated // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewInquiryResultImplCopyWith<$Res>
    implements $NewInquiryResultCopyWith<$Res> {
  factory _$$NewInquiryResultImplCopyWith(
    _$NewInquiryResultImpl value,
    $Res Function(_$NewInquiryResultImpl) then,
  ) = __$$NewInquiryResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'consult_id') int consultId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    @JsonKey(name: 'is_new_student') bool isNewStudent,
    @JsonKey(name: 'guardian_created') bool guardianCreated,
  });
}

/// @nodoc
class __$$NewInquiryResultImplCopyWithImpl<$Res>
    extends _$NewInquiryResultCopyWithImpl<$Res, _$NewInquiryResultImpl>
    implements _$$NewInquiryResultImplCopyWith<$Res> {
  __$$NewInquiryResultImplCopyWithImpl(
    _$NewInquiryResultImpl _value,
    $Res Function(_$NewInquiryResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewInquiryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultId = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? isNewStudent = null,
    Object? guardianCreated = null,
  }) {
    return _then(
      _$NewInquiryResultImpl(
        consultId: null == consultId
            ? _value.consultId
            : consultId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        isNewStudent: null == isNewStudent
            ? _value.isNewStudent
            : isNewStudent // ignore: cast_nullable_to_non_nullable
                  as bool,
        guardianCreated: null == guardianCreated
            ? _value.guardianCreated
            : guardianCreated // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewInquiryResultImpl implements _NewInquiryResult {
  const _$NewInquiryResultImpl({
    @JsonKey(name: 'consult_id') required this.consultId,
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'student_name') required this.studentName,
    @JsonKey(name: 'is_new_student') this.isNewStudent = false,
    @JsonKey(name: 'guardian_created') this.guardianCreated = false,
  });

  factory _$NewInquiryResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewInquiryResultImplFromJson(json);

  @override
  @JsonKey(name: 'consult_id')
  final int consultId;
  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  @JsonKey(name: 'is_new_student')
  final bool isNewStudent;
  @override
  @JsonKey(name: 'guardian_created')
  final bool guardianCreated;

  @override
  String toString() {
    return 'NewInquiryResult(consultId: $consultId, studentId: $studentId, studentName: $studentName, isNewStudent: $isNewStudent, guardianCreated: $guardianCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewInquiryResultImpl &&
            (identical(other.consultId, consultId) ||
                other.consultId == consultId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.isNewStudent, isNewStudent) ||
                other.isNewStudent == isNewStudent) &&
            (identical(other.guardianCreated, guardianCreated) ||
                other.guardianCreated == guardianCreated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    consultId,
    studentId,
    studentName,
    isNewStudent,
    guardianCreated,
  );

  /// Create a copy of NewInquiryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewInquiryResultImplCopyWith<_$NewInquiryResultImpl> get copyWith =>
      __$$NewInquiryResultImplCopyWithImpl<_$NewInquiryResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewInquiryResultImplToJson(this);
  }
}

abstract class _NewInquiryResult implements NewInquiryResult {
  const factory _NewInquiryResult({
    @JsonKey(name: 'consult_id') required final int consultId,
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'student_name') required final String studentName,
    @JsonKey(name: 'is_new_student') final bool isNewStudent,
    @JsonKey(name: 'guardian_created') final bool guardianCreated,
  }) = _$NewInquiryResultImpl;

  factory _NewInquiryResult.fromJson(Map<String, dynamic> json) =
      _$NewInquiryResultImpl.fromJson;

  @override
  @JsonKey(name: 'consult_id')
  int get consultId;
  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  @JsonKey(name: 'is_new_student')
  bool get isNewStudent;
  @override
  @JsonKey(name: 'guardian_created')
  bool get guardianCreated;

  /// Create a copy of NewInquiryResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewInquiryResultImplCopyWith<_$NewInquiryResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InquiryStudentLookup _$InquiryStudentLookupFromJson(Map<String, dynamic> json) {
  return _InquiryStudentLookup.fromJson(json);
}

/// @nodoc
mixin _$InquiryStudentLookup {
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// 1이면 현재 재원중
  @JsonKey(name: 'active_flag')
  int get activeFlag => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_code')
  int? get subjectCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone => throw _privateConstructorUsedError;

  /// Serializes this InquiryStudentLookup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InquiryStudentLookup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InquiryStudentLookupCopyWith<InquiryStudentLookup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InquiryStudentLookupCopyWith<$Res> {
  factory $InquiryStudentLookupCopyWith(
    InquiryStudentLookup value,
    $Res Function(InquiryStudentLookup) then,
  ) = _$InquiryStudentLookupCopyWithImpl<$Res, InquiryStudentLookup>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    String? phone,
    @JsonKey(name: 'active_flag') int activeFlag,
    int? grade,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
  });
}

/// @nodoc
class _$InquiryStudentLookupCopyWithImpl<
  $Res,
  $Val extends InquiryStudentLookup
>
    implements $InquiryStudentLookupCopyWith<$Res> {
  _$InquiryStudentLookupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InquiryStudentLookup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? studentName = null,
    Object? phone = freezed,
    Object? activeFlag = null,
    Object? grade = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? subjectCode = freezed,
    Object? guardianPhone = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            studentName: null == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeFlag: null == activeFlag
                ? _value.activeFlag
                : activeFlag // ignore: cast_nullable_to_non_nullable
                      as int,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            genderCode: freezed == genderCode
                ? _value.genderCode
                : genderCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolName: freezed == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            guardianPhone: freezed == guardianPhone
                ? _value.guardianPhone
                : guardianPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InquiryStudentLookupImplCopyWith<$Res>
    implements $InquiryStudentLookupCopyWith<$Res> {
  factory _$$InquiryStudentLookupImplCopyWith(
    _$InquiryStudentLookupImpl value,
    $Res Function(_$InquiryStudentLookupImpl) then,
  ) = __$$InquiryStudentLookupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    String? phone,
    @JsonKey(name: 'active_flag') int activeFlag,
    int? grade,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
  });
}

/// @nodoc
class __$$InquiryStudentLookupImplCopyWithImpl<$Res>
    extends _$InquiryStudentLookupCopyWithImpl<$Res, _$InquiryStudentLookupImpl>
    implements _$$InquiryStudentLookupImplCopyWith<$Res> {
  __$$InquiryStudentLookupImplCopyWithImpl(
    _$InquiryStudentLookupImpl _value,
    $Res Function(_$InquiryStudentLookupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InquiryStudentLookup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? studentName = null,
    Object? phone = freezed,
    Object? activeFlag = null,
    Object? grade = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? subjectCode = freezed,
    Object? guardianPhone = freezed,
  }) {
    return _then(
      _$InquiryStudentLookupImpl(
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeFlag: null == activeFlag
            ? _value.activeFlag
            : activeFlag // ignore: cast_nullable_to_non_nullable
                  as int,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        genderCode: freezed == genderCode
            ? _value.genderCode
            : genderCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolName: freezed == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        guardianPhone: freezed == guardianPhone
            ? _value.guardianPhone
            : guardianPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InquiryStudentLookupImpl extends _InquiryStudentLookup {
  const _$InquiryStudentLookupImpl({
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'student_name') required this.studentName,
    this.phone,
    @JsonKey(name: 'active_flag') this.activeFlag = 0,
    this.grade,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    @JsonKey(name: 'subject_code') this.subjectCode,
    @JsonKey(name: 'guardian_phone') this.guardianPhone,
  }) : super._();

  factory _$InquiryStudentLookupImpl.fromJson(Map<String, dynamic> json) =>
      _$$InquiryStudentLookupImplFromJson(json);

  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  final String? phone;

  /// 1이면 현재 재원중
  @override
  @JsonKey(name: 'active_flag')
  final int activeFlag;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'gender_code')
  final String? genderCode;
  @override
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
  @JsonKey(name: 'subject_code')
  final int? subjectCode;
  @override
  @JsonKey(name: 'guardian_phone')
  final String? guardianPhone;

  @override
  String toString() {
    return 'InquiryStudentLookup(studentId: $studentId, studentName: $studentName, phone: $phone, activeFlag: $activeFlag, grade: $grade, genderCode: $genderCode, schoolId: $schoolId, schoolName: $schoolName, subjectCode: $subjectCode, guardianPhone: $guardianPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InquiryStudentLookupImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.activeFlag, activeFlag) ||
                other.activeFlag == activeFlag) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.guardianPhone, guardianPhone) ||
                other.guardianPhone == guardianPhone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    studentId,
    studentName,
    phone,
    activeFlag,
    grade,
    genderCode,
    schoolId,
    schoolName,
    subjectCode,
    guardianPhone,
  );

  /// Create a copy of InquiryStudentLookup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InquiryStudentLookupImplCopyWith<_$InquiryStudentLookupImpl>
  get copyWith =>
      __$$InquiryStudentLookupImplCopyWithImpl<_$InquiryStudentLookupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InquiryStudentLookupImplToJson(this);
  }
}

abstract class _InquiryStudentLookup extends InquiryStudentLookup {
  const factory _InquiryStudentLookup({
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'student_name') required final String studentName,
    final String? phone,
    @JsonKey(name: 'active_flag') final int activeFlag,
    final int? grade,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    @JsonKey(name: 'subject_code') final int? subjectCode,
    @JsonKey(name: 'guardian_phone') final String? guardianPhone,
  }) = _$InquiryStudentLookupImpl;
  const _InquiryStudentLookup._() : super._();

  factory _InquiryStudentLookup.fromJson(Map<String, dynamic> json) =
      _$InquiryStudentLookupImpl.fromJson;

  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  String? get phone;

  /// 1이면 현재 재원중
  @override
  @JsonKey(name: 'active_flag')
  int get activeFlag;
  @override
  int? get grade;
  @override
  @JsonKey(name: 'gender_code')
  String? get genderCode;
  @override
  @JsonKey(name: 'school_id')
  int? get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
  @JsonKey(name: 'subject_code')
  int? get subjectCode;
  @override
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone;

  /// Create a copy of InquiryStudentLookup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InquiryStudentLookupImplCopyWith<_$InquiryStudentLookupImpl>
  get copyWith => throw _privateConstructorUsedError;
}
