// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_sub')
  String? get phoneSub => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get birthDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_name')
  String? get genderName => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  @FlexibleIntConverter()
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'grade_name')
  String? get gradeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_name')
  String? get guardianName => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_relation')
  @FlexibleIntConverter()
  int? get guardianRelation => throw _privateConstructorUsedError;
  @JsonKey(name: 'relation_name')
  String? get relationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'zip_code')
  String? get zipCode => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_detail')
  String? get addressDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  String get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String? get statusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_status_code')
  String? get subStatusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_status_name')
  String? get subStatusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_name')
  String? get classTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_code')
  @FlexibleIntConverter()
  int? get subjectCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_code')
  String? get sourceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_name')
  String? get sourceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_detail')
  String? get sourceDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  @FlexibleIntConverter()
  int? get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_name')
  String? get tcName => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_contact_date')
  String? get firstContactDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_date')
  String? get consultDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'register_date')
  String? get registerDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_date')
  String? get enrollDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'withdraw_date')
  String? get withdrawDate => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  List<ParentInfo>? get parents => throw _privateConstructorUsedError;

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    String phone,
    @JsonKey(name: 'phone_sub') String? phoneSub,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'gender_name') String? genderName,
    @JsonKey(name: 'school_id') @FlexibleIntConverter() int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation')
    @FlexibleIntConverter()
    int? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'class_type_name') String? classTypeName,
    @JsonKey(name: 'subject_code') @FlexibleIntConverter() int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') @FlexibleIntConverter() int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<ParentInfo>? parents,
  });
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? studentName = null,
    Object? phone = null,
    Object? phoneSub = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? genderName = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? gradeName = freezed,
    Object? guardianName = freezed,
    Object? guardianPhone = freezed,
    Object? guardianRelation = freezed,
    Object? relationName = freezed,
    Object? zipCode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? statusCode = null,
    Object? statusName = freezed,
    Object? subStatusCode = freezed,
    Object? subStatusName = freezed,
    Object? classTypeCode = freezed,
    Object? classTypeName = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? sourceName = freezed,
    Object? sourceDetail = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? firstContactDate = freezed,
    Object? consultDate = freezed,
    Object? registerDate = freezed,
    Object? enrollDate = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? withdrawDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? parents = freezed,
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
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneSub: freezed == phoneSub
                ? _value.phoneSub
                : phoneSub // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            genderCode: freezed == genderCode
                ? _value.genderCode
                : genderCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            genderName: freezed == genderName
                ? _value.genderName
                : genderName // ignore: cast_nullable_to_non_nullable
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
            gradeName: freezed == gradeName
                ? _value.gradeName
                : gradeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianName: freezed == guardianName
                ? _value.guardianName
                : guardianName // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianPhone: freezed == guardianPhone
                ? _value.guardianPhone
                : guardianPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianRelation: freezed == guardianRelation
                ? _value.guardianRelation
                : guardianRelation // ignore: cast_nullable_to_non_nullable
                      as int?,
            relationName: freezed == relationName
                ? _value.relationName
                : relationName // ignore: cast_nullable_to_non_nullable
                      as String?,
            zipCode: freezed == zipCode
                ? _value.zipCode
                : zipCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressDetail: freezed == addressDetail
                ? _value.addressDetail
                : addressDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusCode: null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String,
            statusName: freezed == statusName
                ? _value.statusName
                : statusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subStatusCode: freezed == subStatusCode
                ? _value.subStatusCode
                : subStatusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            subStatusName: freezed == subStatusName
                ? _value.subStatusName
                : subStatusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            classTypeCode: freezed == classTypeCode
                ? _value.classTypeCode
                : classTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            classTypeName: freezed == classTypeName
                ? _value.classTypeName
                : classTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            sourceCode: freezed == sourceCode
                ? _value.sourceCode
                : sourceCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceName: freezed == sourceName
                ? _value.sourceName
                : sourceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceDetail: freezed == sourceDetail
                ? _value.sourceDetail
                : sourceDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            tcName: freezed == tcName
                ? _value.tcName
                : tcName // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstContactDate: freezed == firstContactDate
                ? _value.firstContactDate
                : firstContactDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultDate: freezed == consultDate
                ? _value.consultDate
                : consultDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            registerDate: freezed == registerDate
                ? _value.registerDate
                : registerDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollDate: freezed == enrollDate
                ? _value.enrollDate
                : enrollDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollStartDate: freezed == enrollStartDate
                ? _value.enrollStartDate
                : enrollStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollEndDate: freezed == enrollEndDate
                ? _value.enrollEndDate
                : enrollEndDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            withdrawDate: freezed == withdrawDate
                ? _value.withdrawDate
                : withdrawDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            parents: freezed == parents
                ? _value.parents
                : parents // ignore: cast_nullable_to_non_nullable
                      as List<ParentInfo>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
    _$StudentImpl value,
    $Res Function(_$StudentImpl) then,
  ) = __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'student_name') String studentName,
    String phone,
    @JsonKey(name: 'phone_sub') String? phoneSub,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'gender_name') String? genderName,
    @JsonKey(name: 'school_id') @FlexibleIntConverter() int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation')
    @FlexibleIntConverter()
    int? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'class_type_name') String? classTypeName,
    @JsonKey(name: 'subject_code') @FlexibleIntConverter() int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') @FlexibleIntConverter() int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<ParentInfo>? parents,
  });
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
    _$StudentImpl _value,
    $Res Function(_$StudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? studentName = null,
    Object? phone = null,
    Object? phoneSub = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? genderName = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? gradeName = freezed,
    Object? guardianName = freezed,
    Object? guardianPhone = freezed,
    Object? guardianRelation = freezed,
    Object? relationName = freezed,
    Object? zipCode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? statusCode = null,
    Object? statusName = freezed,
    Object? subStatusCode = freezed,
    Object? subStatusName = freezed,
    Object? classTypeCode = freezed,
    Object? classTypeName = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? sourceName = freezed,
    Object? sourceDetail = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? firstContactDate = freezed,
    Object? consultDate = freezed,
    Object? registerDate = freezed,
    Object? enrollDate = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? withdrawDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? parents = freezed,
  }) {
    return _then(
      _$StudentImpl(
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneSub: freezed == phoneSub
            ? _value.phoneSub
            : phoneSub // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        genderCode: freezed == genderCode
            ? _value.genderCode
            : genderCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        genderName: freezed == genderName
            ? _value.genderName
            : genderName // ignore: cast_nullable_to_non_nullable
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
        gradeName: freezed == gradeName
            ? _value.gradeName
            : gradeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianName: freezed == guardianName
            ? _value.guardianName
            : guardianName // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianPhone: freezed == guardianPhone
            ? _value.guardianPhone
            : guardianPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianRelation: freezed == guardianRelation
            ? _value.guardianRelation
            : guardianRelation // ignore: cast_nullable_to_non_nullable
                  as int?,
        relationName: freezed == relationName
            ? _value.relationName
            : relationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        zipCode: freezed == zipCode
            ? _value.zipCode
            : zipCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressDetail: freezed == addressDetail
            ? _value.addressDetail
            : addressDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String,
        statusName: freezed == statusName
            ? _value.statusName
            : statusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subStatusCode: freezed == subStatusCode
            ? _value.subStatusCode
            : subStatusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        subStatusName: freezed == subStatusName
            ? _value.subStatusName
            : subStatusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        classTypeCode: freezed == classTypeCode
            ? _value.classTypeCode
            : classTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        classTypeName: freezed == classTypeName
            ? _value.classTypeName
            : classTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        sourceCode: freezed == sourceCode
            ? _value.sourceCode
            : sourceCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceName: freezed == sourceName
            ? _value.sourceName
            : sourceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceDetail: freezed == sourceDetail
            ? _value.sourceDetail
            : sourceDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        tcName: freezed == tcName
            ? _value.tcName
            : tcName // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstContactDate: freezed == firstContactDate
            ? _value.firstContactDate
            : firstContactDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultDate: freezed == consultDate
            ? _value.consultDate
            : consultDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        registerDate: freezed == registerDate
            ? _value.registerDate
            : registerDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollDate: freezed == enrollDate
            ? _value.enrollDate
            : enrollDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollStartDate: freezed == enrollStartDate
            ? _value.enrollStartDate
            : enrollStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollEndDate: freezed == enrollEndDate
            ? _value.enrollEndDate
            : enrollEndDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        withdrawDate: freezed == withdrawDate
            ? _value.withdrawDate
            : withdrawDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        parents: freezed == parents
            ? _value._parents
            : parents // ignore: cast_nullable_to_non_nullable
                  as List<ParentInfo>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl implements _Student {
  const _$StudentImpl({
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'student_name') required this.studentName,
    required this.phone,
    @JsonKey(name: 'phone_sub') this.phoneSub,
    this.email,
    @JsonKey(name: 'birth_date') this.birthDate,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'gender_name') this.genderName,
    @JsonKey(name: 'school_id') @FlexibleIntConverter() this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    @FlexibleIntConverter() this.grade,
    @JsonKey(name: 'grade_name') this.gradeName,
    @JsonKey(name: 'guardian_name') this.guardianName,
    @JsonKey(name: 'guardian_phone') this.guardianPhone,
    @JsonKey(name: 'guardian_relation')
    @FlexibleIntConverter()
    this.guardianRelation,
    @JsonKey(name: 'relation_name') this.relationName,
    @JsonKey(name: 'zip_code') this.zipCode,
    this.address,
    @JsonKey(name: 'address_detail') this.addressDetail,
    @JsonKey(name: 'status_code') required this.statusCode,
    @JsonKey(name: 'status_name') this.statusName,
    @JsonKey(name: 'sub_status_code') this.subStatusCode,
    @JsonKey(name: 'sub_status_name') this.subStatusName,
    @JsonKey(name: 'class_type_code') this.classTypeCode,
    @JsonKey(name: 'class_type_name') this.classTypeName,
    @JsonKey(name: 'subject_code') @FlexibleIntConverter() this.subjectCode,
    @JsonKey(name: 'source_code') this.sourceCode,
    @JsonKey(name: 'source_name') this.sourceName,
    @JsonKey(name: 'source_detail') this.sourceDetail,
    @JsonKey(name: 'tc_id') @FlexibleIntConverter() this.tcId,
    @JsonKey(name: 'tc_name') this.tcName,
    @JsonKey(name: 'first_contact_date') this.firstContactDate,
    @JsonKey(name: 'consult_date') this.consultDate,
    @JsonKey(name: 'register_date') this.registerDate,
    @JsonKey(name: 'enroll_date') this.enrollDate,
    @JsonKey(name: 'enroll_start_date') this.enrollStartDate,
    @JsonKey(name: 'enroll_end_date') this.enrollEndDate,
    @JsonKey(name: 'withdraw_date') this.withdrawDate,
    this.memo,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    final List<ParentInfo>? parents,
  }) : _parents = parents;

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  final String phone;
  @override
  @JsonKey(name: 'phone_sub')
  final String? phoneSub;
  @override
  final String? email;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @override
  @JsonKey(name: 'gender_code')
  final String? genderCode;
  @override
  @JsonKey(name: 'gender_name')
  final String? genderName;
  @override
  @JsonKey(name: 'school_id')
  @FlexibleIntConverter()
  final int? schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
  @FlexibleIntConverter()
  final int? grade;
  @override
  @JsonKey(name: 'grade_name')
  final String? gradeName;
  @override
  @JsonKey(name: 'guardian_name')
  final String? guardianName;
  @override
  @JsonKey(name: 'guardian_phone')
  final String? guardianPhone;
  @override
  @JsonKey(name: 'guardian_relation')
  @FlexibleIntConverter()
  final int? guardianRelation;
  @override
  @JsonKey(name: 'relation_name')
  final String? relationName;
  @override
  @JsonKey(name: 'zip_code')
  final String? zipCode;
  @override
  final String? address;
  @override
  @JsonKey(name: 'address_detail')
  final String? addressDetail;
  @override
  @JsonKey(name: 'status_code')
  final String statusCode;
  @override
  @JsonKey(name: 'status_name')
  final String? statusName;
  @override
  @JsonKey(name: 'sub_status_code')
  final String? subStatusCode;
  @override
  @JsonKey(name: 'sub_status_name')
  final String? subStatusName;
  @override
  @JsonKey(name: 'class_type_code')
  final String? classTypeCode;
  @override
  @JsonKey(name: 'class_type_name')
  final String? classTypeName;
  @override
  @JsonKey(name: 'subject_code')
  @FlexibleIntConverter()
  final int? subjectCode;
  @override
  @JsonKey(name: 'source_code')
  final String? sourceCode;
  @override
  @JsonKey(name: 'source_name')
  final String? sourceName;
  @override
  @JsonKey(name: 'source_detail')
  final String? sourceDetail;
  @override
  @JsonKey(name: 'tc_id')
  @FlexibleIntConverter()
  final int? tcId;
  @override
  @JsonKey(name: 'tc_name')
  final String? tcName;
  @override
  @JsonKey(name: 'first_contact_date')
  final String? firstContactDate;
  @override
  @JsonKey(name: 'consult_date')
  final String? consultDate;
  @override
  @JsonKey(name: 'register_date')
  final String? registerDate;
  @override
  @JsonKey(name: 'enroll_date')
  final String? enrollDate;
  @override
  @JsonKey(name: 'enroll_start_date')
  final String? enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  final String? enrollEndDate;
  @override
  @JsonKey(name: 'withdraw_date')
  final String? withdrawDate;
  @override
  final String? memo;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final List<ParentInfo>? _parents;
  @override
  List<ParentInfo>? get parents {
    final value = _parents;
    if (value == null) return null;
    if (_parents is EqualUnmodifiableListView) return _parents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Student(studentId: $studentId, studentName: $studentName, phone: $phone, phoneSub: $phoneSub, email: $email, birthDate: $birthDate, genderCode: $genderCode, genderName: $genderName, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, gradeName: $gradeName, guardianName: $guardianName, guardianPhone: $guardianPhone, guardianRelation: $guardianRelation, relationName: $relationName, zipCode: $zipCode, address: $address, addressDetail: $addressDetail, statusCode: $statusCode, statusName: $statusName, subStatusCode: $subStatusCode, subStatusName: $subStatusName, classTypeCode: $classTypeCode, classTypeName: $classTypeName, subjectCode: $subjectCode, sourceCode: $sourceCode, sourceName: $sourceName, sourceDetail: $sourceDetail, tcId: $tcId, tcName: $tcName, firstContactDate: $firstContactDate, consultDate: $consultDate, registerDate: $registerDate, enrollDate: $enrollDate, enrollStartDate: $enrollStartDate, enrollEndDate: $enrollEndDate, withdrawDate: $withdrawDate, memo: $memo, createdAt: $createdAt, updatedAt: $updatedAt, parents: $parents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.phoneSub, phoneSub) ||
                other.phoneSub == phoneSub) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.genderName, genderName) ||
                other.genderName == genderName) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.gradeName, gradeName) ||
                other.gradeName == gradeName) &&
            (identical(other.guardianName, guardianName) ||
                other.guardianName == guardianName) &&
            (identical(other.guardianPhone, guardianPhone) ||
                other.guardianPhone == guardianPhone) &&
            (identical(other.guardianRelation, guardianRelation) ||
                other.guardianRelation == guardianRelation) &&
            (identical(other.relationName, relationName) ||
                other.relationName == relationName) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressDetail, addressDetail) ||
                other.addressDetail == addressDetail) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.subStatusCode, subStatusCode) ||
                other.subStatusCode == subStatusCode) &&
            (identical(other.subStatusName, subStatusName) ||
                other.subStatusName == subStatusName) &&
            (identical(other.classTypeCode, classTypeCode) ||
                other.classTypeCode == classTypeCode) &&
            (identical(other.classTypeName, classTypeName) ||
                other.classTypeName == classTypeName) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.sourceCode, sourceCode) ||
                other.sourceCode == sourceCode) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.sourceDetail, sourceDetail) ||
                other.sourceDetail == sourceDetail) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.tcName, tcName) || other.tcName == tcName) &&
            (identical(other.firstContactDate, firstContactDate) ||
                other.firstContactDate == firstContactDate) &&
            (identical(other.consultDate, consultDate) ||
                other.consultDate == consultDate) &&
            (identical(other.registerDate, registerDate) ||
                other.registerDate == registerDate) &&
            (identical(other.enrollDate, enrollDate) ||
                other.enrollDate == enrollDate) &&
            (identical(other.enrollStartDate, enrollStartDate) ||
                other.enrollStartDate == enrollStartDate) &&
            (identical(other.enrollEndDate, enrollEndDate) ||
                other.enrollEndDate == enrollEndDate) &&
            (identical(other.withdrawDate, withdrawDate) ||
                other.withdrawDate == withdrawDate) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._parents, _parents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    studentId,
    studentName,
    phone,
    phoneSub,
    email,
    birthDate,
    genderCode,
    genderName,
    schoolId,
    schoolName,
    grade,
    gradeName,
    guardianName,
    guardianPhone,
    guardianRelation,
    relationName,
    zipCode,
    address,
    addressDetail,
    statusCode,
    statusName,
    subStatusCode,
    subStatusName,
    classTypeCode,
    classTypeName,
    subjectCode,
    sourceCode,
    sourceName,
    sourceDetail,
    tcId,
    tcName,
    firstContactDate,
    consultDate,
    registerDate,
    enrollDate,
    enrollStartDate,
    enrollEndDate,
    withdrawDate,
    memo,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_parents),
  ]);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(this);
  }
}

abstract class _Student implements Student {
  const factory _Student({
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'student_name') required final String studentName,
    required final String phone,
    @JsonKey(name: 'phone_sub') final String? phoneSub,
    final String? email,
    @JsonKey(name: 'birth_date') final String? birthDate,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'gender_name') final String? genderName,
    @JsonKey(name: 'school_id') @FlexibleIntConverter() final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    @FlexibleIntConverter() final int? grade,
    @JsonKey(name: 'grade_name') final String? gradeName,
    @JsonKey(name: 'guardian_name') final String? guardianName,
    @JsonKey(name: 'guardian_phone') final String? guardianPhone,
    @JsonKey(name: 'guardian_relation')
    @FlexibleIntConverter()
    final int? guardianRelation,
    @JsonKey(name: 'relation_name') final String? relationName,
    @JsonKey(name: 'zip_code') final String? zipCode,
    final String? address,
    @JsonKey(name: 'address_detail') final String? addressDetail,
    @JsonKey(name: 'status_code') required final String statusCode,
    @JsonKey(name: 'status_name') final String? statusName,
    @JsonKey(name: 'sub_status_code') final String? subStatusCode,
    @JsonKey(name: 'sub_status_name') final String? subStatusName,
    @JsonKey(name: 'class_type_code') final String? classTypeCode,
    @JsonKey(name: 'class_type_name') final String? classTypeName,
    @JsonKey(name: 'subject_code')
    @FlexibleIntConverter()
    final int? subjectCode,
    @JsonKey(name: 'source_code') final String? sourceCode,
    @JsonKey(name: 'source_name') final String? sourceName,
    @JsonKey(name: 'source_detail') final String? sourceDetail,
    @JsonKey(name: 'tc_id') @FlexibleIntConverter() final int? tcId,
    @JsonKey(name: 'tc_name') final String? tcName,
    @JsonKey(name: 'first_contact_date') final String? firstContactDate,
    @JsonKey(name: 'consult_date') final String? consultDate,
    @JsonKey(name: 'register_date') final String? registerDate,
    @JsonKey(name: 'enroll_date') final String? enrollDate,
    @JsonKey(name: 'enroll_start_date') final String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') final String? enrollEndDate,
    @JsonKey(name: 'withdraw_date') final String? withdrawDate,
    final String? memo,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    final List<ParentInfo>? parents,
  }) = _$StudentImpl;

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  String get phone;
  @override
  @JsonKey(name: 'phone_sub')
  String? get phoneSub;
  @override
  String? get email;
  @override
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @override
  @JsonKey(name: 'gender_code')
  String? get genderCode;
  @override
  @JsonKey(name: 'gender_name')
  String? get genderName;
  @override
  @JsonKey(name: 'school_id')
  @FlexibleIntConverter()
  int? get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
  @FlexibleIntConverter()
  int? get grade;
  @override
  @JsonKey(name: 'grade_name')
  String? get gradeName;
  @override
  @JsonKey(name: 'guardian_name')
  String? get guardianName;
  @override
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone;
  @override
  @JsonKey(name: 'guardian_relation')
  @FlexibleIntConverter()
  int? get guardianRelation;
  @override
  @JsonKey(name: 'relation_name')
  String? get relationName;
  @override
  @JsonKey(name: 'zip_code')
  String? get zipCode;
  @override
  String? get address;
  @override
  @JsonKey(name: 'address_detail')
  String? get addressDetail;
  @override
  @JsonKey(name: 'status_code')
  String get statusCode;
  @override
  @JsonKey(name: 'status_name')
  String? get statusName;
  @override
  @JsonKey(name: 'sub_status_code')
  String? get subStatusCode;
  @override
  @JsonKey(name: 'sub_status_name')
  String? get subStatusName;
  @override
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode;
  @override
  @JsonKey(name: 'class_type_name')
  String? get classTypeName;
  @override
  @JsonKey(name: 'subject_code')
  @FlexibleIntConverter()
  int? get subjectCode;
  @override
  @JsonKey(name: 'source_code')
  String? get sourceCode;
  @override
  @JsonKey(name: 'source_name')
  String? get sourceName;
  @override
  @JsonKey(name: 'source_detail')
  String? get sourceDetail;
  @override
  @JsonKey(name: 'tc_id')
  @FlexibleIntConverter()
  int? get tcId;
  @override
  @JsonKey(name: 'tc_name')
  String? get tcName;
  @override
  @JsonKey(name: 'first_contact_date')
  String? get firstContactDate;
  @override
  @JsonKey(name: 'consult_date')
  String? get consultDate;
  @override
  @JsonKey(name: 'register_date')
  String? get registerDate;
  @override
  @JsonKey(name: 'enroll_date')
  String? get enrollDate;
  @override
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate;
  @override
  @JsonKey(name: 'withdraw_date')
  String? get withdrawDate;
  @override
  String? get memo;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  List<ParentInfo>? get parents;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParentInfo _$ParentInfoFromJson(Map<String, dynamic> json) {
  return _ParentInfo.fromJson(json);
}

/// @nodoc
mixin _$ParentInfo {
  @JsonKey(name: 'parent_id')
  int? get parentId => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_kind')
  int get parentKind => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this ParentInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParentInfoCopyWith<ParentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParentInfoCopyWith<$Res> {
  factory $ParentInfoCopyWith(
    ParentInfo value,
    $Res Function(ParentInfo) then,
  ) = _$ParentInfoCopyWithImpl<$Res, ParentInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'parent_id') int? parentId,
    String phone,
    int seq,
    @JsonKey(name: 'parent_kind') int parentKind,
    String? name,
  });
}

/// @nodoc
class _$ParentInfoCopyWithImpl<$Res, $Val extends ParentInfo>
    implements $ParentInfoCopyWith<$Res> {
  _$ParentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentId = freezed,
    Object? phone = null,
    Object? seq = null,
    Object? parentKind = null,
    Object? name = freezed,
  }) {
    return _then(
      _value.copyWith(
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            seq: null == seq
                ? _value.seq
                : seq // ignore: cast_nullable_to_non_nullable
                      as int,
            parentKind: null == parentKind
                ? _value.parentKind
                : parentKind // ignore: cast_nullable_to_non_nullable
                      as int,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParentInfoImplCopyWith<$Res>
    implements $ParentInfoCopyWith<$Res> {
  factory _$$ParentInfoImplCopyWith(
    _$ParentInfoImpl value,
    $Res Function(_$ParentInfoImpl) then,
  ) = __$$ParentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'parent_id') int? parentId,
    String phone,
    int seq,
    @JsonKey(name: 'parent_kind') int parentKind,
    String? name,
  });
}

/// @nodoc
class __$$ParentInfoImplCopyWithImpl<$Res>
    extends _$ParentInfoCopyWithImpl<$Res, _$ParentInfoImpl>
    implements _$$ParentInfoImplCopyWith<$Res> {
  __$$ParentInfoImplCopyWithImpl(
    _$ParentInfoImpl _value,
    $Res Function(_$ParentInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentId = freezed,
    Object? phone = null,
    Object? seq = null,
    Object? parentKind = null,
    Object? name = freezed,
  }) {
    return _then(
      _$ParentInfoImpl(
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        seq: null == seq
            ? _value.seq
            : seq // ignore: cast_nullable_to_non_nullable
                  as int,
        parentKind: null == parentKind
            ? _value.parentKind
            : parentKind // ignore: cast_nullable_to_non_nullable
                  as int,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParentInfoImpl implements _ParentInfo {
  const _$ParentInfoImpl({
    @JsonKey(name: 'parent_id') this.parentId,
    required this.phone,
    this.seq = 1,
    @JsonKey(name: 'parent_kind') this.parentKind = 2,
    this.name,
  });

  factory _$ParentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParentInfoImplFromJson(json);

  @override
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @override
  final String phone;
  @override
  @JsonKey()
  final int seq;
  @override
  @JsonKey(name: 'parent_kind')
  final int parentKind;
  @override
  final String? name;

  @override
  String toString() {
    return 'ParentInfo(parentId: $parentId, phone: $phone, seq: $seq, parentKind: $parentKind, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParentInfoImpl &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.parentKind, parentKind) ||
                other.parentKind == parentKind) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, parentId, phone, seq, parentKind, name);

  /// Create a copy of ParentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParentInfoImplCopyWith<_$ParentInfoImpl> get copyWith =>
      __$$ParentInfoImplCopyWithImpl<_$ParentInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParentInfoImplToJson(this);
  }
}

abstract class _ParentInfo implements ParentInfo {
  const factory _ParentInfo({
    @JsonKey(name: 'parent_id') final int? parentId,
    required final String phone,
    final int seq,
    @JsonKey(name: 'parent_kind') final int parentKind,
    final String? name,
  }) = _$ParentInfoImpl;

  factory _ParentInfo.fromJson(Map<String, dynamic> json) =
      _$ParentInfoImpl.fromJson;

  @override
  @JsonKey(name: 'parent_id')
  int? get parentId;
  @override
  String get phone;
  @override
  int get seq;
  @override
  @JsonKey(name: 'parent_kind')
  int get parentKind;
  @override
  String? get name;

  /// Create a copy of ParentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParentInfoImplCopyWith<_$ParentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentUpdate _$StudentUpdateFromJson(Map<String, dynamic> json) {
  return _StudentUpdate.fromJson(json);
}

/// @nodoc
mixin _$StudentUpdate {
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get birthDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_code')
  int? get subjectCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_code')
  String? get sourceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'zip_code')
  String? get zipCode => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_detail')
  String? get addressDetail => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  List<ParentInfo>? get parents => throw _privateConstructorUsedError;

  /// Serializes this StudentUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentUpdateCopyWith<StudentUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentUpdateCopyWith<$Res> {
  factory $StudentUpdateCopyWith(
    StudentUpdate value,
    $Res Function(StudentUpdate) then,
  ) = _$StudentUpdateCopyWithImpl<$Res, StudentUpdate>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_name') String? studentName,
    String? phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    String? memo,
    List<ParentInfo>? parents,
  });
}

/// @nodoc
class _$StudentUpdateCopyWithImpl<$Res, $Val extends StudentUpdate>
    implements $StudentUpdateCopyWith<$Res> {
  _$StudentUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? zipCode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? memo = freezed,
    Object? parents = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            classTypeCode: freezed == classTypeCode
                ? _value.classTypeCode
                : classTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            sourceCode: freezed == sourceCode
                ? _value.sourceCode
                : sourceCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollStartDate: freezed == enrollStartDate
                ? _value.enrollStartDate
                : enrollStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollEndDate: freezed == enrollEndDate
                ? _value.enrollEndDate
                : enrollEndDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            zipCode: freezed == zipCode
                ? _value.zipCode
                : zipCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressDetail: freezed == addressDetail
                ? _value.addressDetail
                : addressDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            parents: freezed == parents
                ? _value.parents
                : parents // ignore: cast_nullable_to_non_nullable
                      as List<ParentInfo>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentUpdateImplCopyWith<$Res>
    implements $StudentUpdateCopyWith<$Res> {
  factory _$$StudentUpdateImplCopyWith(
    _$StudentUpdateImpl value,
    $Res Function(_$StudentUpdateImpl) then,
  ) = __$$StudentUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_name') String? studentName,
    String? phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    String? memo,
    List<ParentInfo>? parents,
  });
}

/// @nodoc
class __$$StudentUpdateImplCopyWithImpl<$Res>
    extends _$StudentUpdateCopyWithImpl<$Res, _$StudentUpdateImpl>
    implements _$$StudentUpdateImplCopyWith<$Res> {
  __$$StudentUpdateImplCopyWithImpl(
    _$StudentUpdateImpl _value,
    $Res Function(_$StudentUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? zipCode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? memo = freezed,
    Object? parents = freezed,
  }) {
    return _then(
      _$StudentUpdateImpl(
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        classTypeCode: freezed == classTypeCode
            ? _value.classTypeCode
            : classTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        sourceCode: freezed == sourceCode
            ? _value.sourceCode
            : sourceCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollStartDate: freezed == enrollStartDate
            ? _value.enrollStartDate
            : enrollStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollEndDate: freezed == enrollEndDate
            ? _value.enrollEndDate
            : enrollEndDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        zipCode: freezed == zipCode
            ? _value.zipCode
            : zipCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressDetail: freezed == addressDetail
            ? _value.addressDetail
            : addressDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        parents: freezed == parents
            ? _value._parents
            : parents // ignore: cast_nullable_to_non_nullable
                  as List<ParentInfo>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentUpdateImpl implements _StudentUpdate {
  const _$StudentUpdateImpl({
    @JsonKey(name: 'student_name') this.studentName,
    this.phone,
    this.email,
    @JsonKey(name: 'birth_date') this.birthDate,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'class_type_code') this.classTypeCode,
    @JsonKey(name: 'subject_code') this.subjectCode,
    @JsonKey(name: 'source_code') this.sourceCode,
    @JsonKey(name: 'enroll_start_date') this.enrollStartDate,
    @JsonKey(name: 'enroll_end_date') this.enrollEndDate,
    @JsonKey(name: 'zip_code') this.zipCode,
    this.address,
    @JsonKey(name: 'address_detail') this.addressDetail,
    this.memo,
    final List<ParentInfo>? parents,
  }) : _parents = parents;

  factory _$StudentUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentUpdateImplFromJson(json);

  @override
  @JsonKey(name: 'student_name')
  final String? studentName;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
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
  @JsonKey(name: 'class_type_code')
  final String? classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  final int? subjectCode;
  @override
  @JsonKey(name: 'source_code')
  final String? sourceCode;
  @override
  @JsonKey(name: 'enroll_start_date')
  final String? enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  final String? enrollEndDate;
  @override
  @JsonKey(name: 'zip_code')
  final String? zipCode;
  @override
  final String? address;
  @override
  @JsonKey(name: 'address_detail')
  final String? addressDetail;
  @override
  final String? memo;
  final List<ParentInfo>? _parents;
  @override
  List<ParentInfo>? get parents {
    final value = _parents;
    if (value == null) return null;
    if (_parents is EqualUnmodifiableListView) return _parents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StudentUpdate(studentName: $studentName, phone: $phone, email: $email, birthDate: $birthDate, genderCode: $genderCode, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, classTypeCode: $classTypeCode, subjectCode: $subjectCode, sourceCode: $sourceCode, enrollStartDate: $enrollStartDate, enrollEndDate: $enrollEndDate, zipCode: $zipCode, address: $address, addressDetail: $addressDetail, memo: $memo, parents: $parents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentUpdateImpl &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.classTypeCode, classTypeCode) ||
                other.classTypeCode == classTypeCode) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.sourceCode, sourceCode) ||
                other.sourceCode == sourceCode) &&
            (identical(other.enrollStartDate, enrollStartDate) ||
                other.enrollStartDate == enrollStartDate) &&
            (identical(other.enrollEndDate, enrollEndDate) ||
                other.enrollEndDate == enrollEndDate) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressDetail, addressDetail) ||
                other.addressDetail == addressDetail) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            const DeepCollectionEquality().equals(other._parents, _parents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    studentName,
    phone,
    email,
    birthDate,
    genderCode,
    schoolId,
    schoolName,
    grade,
    classTypeCode,
    subjectCode,
    sourceCode,
    enrollStartDate,
    enrollEndDate,
    zipCode,
    address,
    addressDetail,
    memo,
    const DeepCollectionEquality().hash(_parents),
  );

  /// Create a copy of StudentUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentUpdateImplCopyWith<_$StudentUpdateImpl> get copyWith =>
      __$$StudentUpdateImplCopyWithImpl<_$StudentUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentUpdateImplToJson(this);
  }
}

abstract class _StudentUpdate implements StudentUpdate {
  const factory _StudentUpdate({
    @JsonKey(name: 'student_name') final String? studentName,
    final String? phone,
    final String? email,
    @JsonKey(name: 'birth_date') final String? birthDate,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'class_type_code') final String? classTypeCode,
    @JsonKey(name: 'subject_code') final int? subjectCode,
    @JsonKey(name: 'source_code') final String? sourceCode,
    @JsonKey(name: 'enroll_start_date') final String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') final String? enrollEndDate,
    @JsonKey(name: 'zip_code') final String? zipCode,
    final String? address,
    @JsonKey(name: 'address_detail') final String? addressDetail,
    final String? memo,
    final List<ParentInfo>? parents,
  }) = _$StudentUpdateImpl;

  factory _StudentUpdate.fromJson(Map<String, dynamic> json) =
      _$StudentUpdateImpl.fromJson;

  @override
  @JsonKey(name: 'student_name')
  String? get studentName;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'birth_date')
  String? get birthDate;
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
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  int? get subjectCode;
  @override
  @JsonKey(name: 'source_code')
  String? get sourceCode;
  @override
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate;
  @override
  @JsonKey(name: 'zip_code')
  String? get zipCode;
  @override
  String? get address;
  @override
  @JsonKey(name: 'address_detail')
  String? get addressDetail;
  @override
  String? get memo;
  @override
  List<ParentInfo>? get parents;

  /// Create a copy of StudentUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentUpdateImplCopyWith<_$StudentUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentStateChange _$StudentStateChangeFromJson(Map<String, dynamic> json) {
  return _StudentStateChange.fromJson(json);
}

/// @nodoc
mixin _$StudentStateChange {
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_status_code')
  String get newStatusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_sub_status_code')
  String? get newSubStatusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_reason')
  String? get changeReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_tc_id')
  int? get newTcId => throw _privateConstructorUsedError;

  /// Serializes this StudentStateChange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentStateChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentStateChangeCopyWith<StudentStateChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentStateChangeCopyWith<$Res> {
  factory $StudentStateChangeCopyWith(
    StudentStateChange value,
    $Res Function(StudentStateChange) then,
  ) = _$StudentStateChangeCopyWithImpl<$Res, StudentStateChange>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'new_status_code') String newStatusCode,
    @JsonKey(name: 'new_sub_status_code') String? newSubStatusCode,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'new_tc_id') int? newTcId,
  });
}

/// @nodoc
class _$StudentStateChangeCopyWithImpl<$Res, $Val extends StudentStateChange>
    implements $StudentStateChangeCopyWith<$Res> {
  _$StudentStateChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentStateChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? newStatusCode = null,
    Object? newSubStatusCode = freezed,
    Object? changeReason = freezed,
    Object? newTcId = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            newStatusCode: null == newStatusCode
                ? _value.newStatusCode
                : newStatusCode // ignore: cast_nullable_to_non_nullable
                      as String,
            newSubStatusCode: freezed == newSubStatusCode
                ? _value.newSubStatusCode
                : newSubStatusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            changeReason: freezed == changeReason
                ? _value.changeReason
                : changeReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            newTcId: freezed == newTcId
                ? _value.newTcId
                : newTcId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentStateChangeImplCopyWith<$Res>
    implements $StudentStateChangeCopyWith<$Res> {
  factory _$$StudentStateChangeImplCopyWith(
    _$StudentStateChangeImpl value,
    $Res Function(_$StudentStateChangeImpl) then,
  ) = __$$StudentStateChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'new_status_code') String newStatusCode,
    @JsonKey(name: 'new_sub_status_code') String? newSubStatusCode,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'new_tc_id') int? newTcId,
  });
}

/// @nodoc
class __$$StudentStateChangeImplCopyWithImpl<$Res>
    extends _$StudentStateChangeCopyWithImpl<$Res, _$StudentStateChangeImpl>
    implements _$$StudentStateChangeImplCopyWith<$Res> {
  __$$StudentStateChangeImplCopyWithImpl(
    _$StudentStateChangeImpl _value,
    $Res Function(_$StudentStateChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentStateChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? newStatusCode = null,
    Object? newSubStatusCode = freezed,
    Object? changeReason = freezed,
    Object? newTcId = freezed,
  }) {
    return _then(
      _$StudentStateChangeImpl(
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        newStatusCode: null == newStatusCode
            ? _value.newStatusCode
            : newStatusCode // ignore: cast_nullable_to_non_nullable
                  as String,
        newSubStatusCode: freezed == newSubStatusCode
            ? _value.newSubStatusCode
            : newSubStatusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        changeReason: freezed == changeReason
            ? _value.changeReason
            : changeReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        newTcId: freezed == newTcId
            ? _value.newTcId
            : newTcId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentStateChangeImpl implements _StudentStateChange {
  const _$StudentStateChangeImpl({
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'new_status_code') required this.newStatusCode,
    @JsonKey(name: 'new_sub_status_code') this.newSubStatusCode,
    @JsonKey(name: 'change_reason') this.changeReason,
    @JsonKey(name: 'new_tc_id') this.newTcId,
  });

  factory _$StudentStateChangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentStateChangeImplFromJson(json);

  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'new_status_code')
  final String newStatusCode;
  @override
  @JsonKey(name: 'new_sub_status_code')
  final String? newSubStatusCode;
  @override
  @JsonKey(name: 'change_reason')
  final String? changeReason;
  @override
  @JsonKey(name: 'new_tc_id')
  final int? newTcId;

  @override
  String toString() {
    return 'StudentStateChange(studentId: $studentId, newStatusCode: $newStatusCode, newSubStatusCode: $newSubStatusCode, changeReason: $changeReason, newTcId: $newTcId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentStateChangeImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.newStatusCode, newStatusCode) ||
                other.newStatusCode == newStatusCode) &&
            (identical(other.newSubStatusCode, newSubStatusCode) ||
                other.newSubStatusCode == newSubStatusCode) &&
            (identical(other.changeReason, changeReason) ||
                other.changeReason == changeReason) &&
            (identical(other.newTcId, newTcId) || other.newTcId == newTcId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    studentId,
    newStatusCode,
    newSubStatusCode,
    changeReason,
    newTcId,
  );

  /// Create a copy of StudentStateChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentStateChangeImplCopyWith<_$StudentStateChangeImpl> get copyWith =>
      __$$StudentStateChangeImplCopyWithImpl<_$StudentStateChangeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentStateChangeImplToJson(this);
  }
}

abstract class _StudentStateChange implements StudentStateChange {
  const factory _StudentStateChange({
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'new_status_code') required final String newStatusCode,
    @JsonKey(name: 'new_sub_status_code') final String? newSubStatusCode,
    @JsonKey(name: 'change_reason') final String? changeReason,
    @JsonKey(name: 'new_tc_id') final int? newTcId,
  }) = _$StudentStateChangeImpl;

  factory _StudentStateChange.fromJson(Map<String, dynamic> json) =
      _$StudentStateChangeImpl.fromJson;

  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'new_status_code')
  String get newStatusCode;
  @override
  @JsonKey(name: 'new_sub_status_code')
  String? get newSubStatusCode;
  @override
  @JsonKey(name: 'change_reason')
  String? get changeReason;
  @override
  @JsonKey(name: 'new_tc_id')
  int? get newTcId;

  /// Create a copy of StudentStateChange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentStateChangeImplCopyWith<_$StudentStateChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentCreate _$StudentCreateFromJson(Map<String, dynamic> json) {
  return _StudentCreate.fromJson(json);
}

/// @nodoc
mixin _$StudentCreate {
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get birthDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_code')
  int? get subjectCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  String? get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_code')
  String? get sourceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_detail')
  String? get sourceDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_name')
  String? get guardianName => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_kind')
  int? get parentKind => throw _privateConstructorUsedError;

  /// Serializes this StudentCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCreateCopyWith<StudentCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCreateCopyWith<$Res> {
  factory $StudentCreateCopyWith(
    StudentCreate value,
    $Res Function(StudentCreate) then,
  ) = _$StudentCreateCopyWithImpl<$Res, StudentCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'student_name') String studentName,
    String phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'tc_id') int? tcId,
    String? memo,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'parent_kind') int? parentKind,
  });
}

/// @nodoc
class _$StudentCreateCopyWithImpl<$Res, $Val extends StudentCreate>
    implements $StudentCreateCopyWith<$Res> {
  _$StudentCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? statusCode = freezed,
    Object? sourceCode = freezed,
    Object? sourceDetail = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? tcId = freezed,
    Object? memo = freezed,
    Object? guardianName = freezed,
    Object? guardianPhone = freezed,
    Object? parentKind = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentName: null == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            classTypeCode: freezed == classTypeCode
                ? _value.classTypeCode
                : classTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceCode: freezed == sourceCode
                ? _value.sourceCode
                : sourceCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceDetail: freezed == sourceDetail
                ? _value.sourceDetail
                : sourceDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollStartDate: freezed == enrollStartDate
                ? _value.enrollStartDate
                : enrollStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrollEndDate: freezed == enrollEndDate
                ? _value.enrollEndDate
                : enrollEndDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianName: freezed == guardianName
                ? _value.guardianName
                : guardianName // ignore: cast_nullable_to_non_nullable
                      as String?,
            guardianPhone: freezed == guardianPhone
                ? _value.guardianPhone
                : guardianPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            parentKind: freezed == parentKind
                ? _value.parentKind
                : parentKind // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentCreateImplCopyWith<$Res>
    implements $StudentCreateCopyWith<$Res> {
  factory _$$StudentCreateImplCopyWith(
    _$StudentCreateImpl value,
    $Res Function(_$StudentCreateImpl) then,
  ) = __$$StudentCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'student_name') String studentName,
    String phone,
    String? email,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'enroll_start_date') String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') String? enrollEndDate,
    @JsonKey(name: 'tc_id') int? tcId,
    String? memo,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'parent_kind') int? parentKind,
  });
}

/// @nodoc
class __$$StudentCreateImplCopyWithImpl<$Res>
    extends _$StudentCreateCopyWithImpl<$Res, _$StudentCreateImpl>
    implements _$$StudentCreateImplCopyWith<$Res> {
  __$$StudentCreateImplCopyWithImpl(
    _$StudentCreateImpl _value,
    $Res Function(_$StudentCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? genderCode = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? statusCode = freezed,
    Object? sourceCode = freezed,
    Object? sourceDetail = freezed,
    Object? enrollStartDate = freezed,
    Object? enrollEndDate = freezed,
    Object? tcId = freezed,
    Object? memo = freezed,
    Object? guardianName = freezed,
    Object? guardianPhone = freezed,
    Object? parentKind = freezed,
  }) {
    return _then(
      _$StudentCreateImpl(
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        classTypeCode: freezed == classTypeCode
            ? _value.classTypeCode
            : classTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceCode: freezed == sourceCode
            ? _value.sourceCode
            : sourceCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceDetail: freezed == sourceDetail
            ? _value.sourceDetail
            : sourceDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollStartDate: freezed == enrollStartDate
            ? _value.enrollStartDate
            : enrollStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrollEndDate: freezed == enrollEndDate
            ? _value.enrollEndDate
            : enrollEndDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianName: freezed == guardianName
            ? _value.guardianName
            : guardianName // ignore: cast_nullable_to_non_nullable
                  as String?,
        guardianPhone: freezed == guardianPhone
            ? _value.guardianPhone
            : guardianPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        parentKind: freezed == parentKind
            ? _value.parentKind
            : parentKind // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentCreateImpl implements _StudentCreate {
  const _$StudentCreateImpl({
    @JsonKey(name: 'student_name') required this.studentName,
    required this.phone,
    this.email,
    @JsonKey(name: 'birth_date') this.birthDate,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'class_type_code') this.classTypeCode,
    @JsonKey(name: 'subject_code') this.subjectCode,
    @JsonKey(name: 'status_code') this.statusCode,
    @JsonKey(name: 'source_code') this.sourceCode,
    @JsonKey(name: 'source_detail') this.sourceDetail,
    @JsonKey(name: 'enroll_start_date') this.enrollStartDate,
    @JsonKey(name: 'enroll_end_date') this.enrollEndDate,
    @JsonKey(name: 'tc_id') this.tcId,
    this.memo,
    @JsonKey(name: 'guardian_name') this.guardianName,
    @JsonKey(name: 'guardian_phone') this.guardianPhone,
    @JsonKey(name: 'parent_kind') this.parentKind,
  });

  factory _$StudentCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentCreateImplFromJson(json);

  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
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
  @JsonKey(name: 'class_type_code')
  final String? classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  final int? subjectCode;
  @override
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @override
  @JsonKey(name: 'source_code')
  final String? sourceCode;
  @override
  @JsonKey(name: 'source_detail')
  final String? sourceDetail;
  @override
  @JsonKey(name: 'enroll_start_date')
  final String? enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  final String? enrollEndDate;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  final String? memo;
  @override
  @JsonKey(name: 'guardian_name')
  final String? guardianName;
  @override
  @JsonKey(name: 'guardian_phone')
  final String? guardianPhone;
  @override
  @JsonKey(name: 'parent_kind')
  final int? parentKind;

  @override
  String toString() {
    return 'StudentCreate(studentName: $studentName, phone: $phone, email: $email, birthDate: $birthDate, genderCode: $genderCode, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, classTypeCode: $classTypeCode, subjectCode: $subjectCode, statusCode: $statusCode, sourceCode: $sourceCode, sourceDetail: $sourceDetail, enrollStartDate: $enrollStartDate, enrollEndDate: $enrollEndDate, tcId: $tcId, memo: $memo, guardianName: $guardianName, guardianPhone: $guardianPhone, parentKind: $parentKind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentCreateImpl &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.classTypeCode, classTypeCode) ||
                other.classTypeCode == classTypeCode) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.sourceCode, sourceCode) ||
                other.sourceCode == sourceCode) &&
            (identical(other.sourceDetail, sourceDetail) ||
                other.sourceDetail == sourceDetail) &&
            (identical(other.enrollStartDate, enrollStartDate) ||
                other.enrollStartDate == enrollStartDate) &&
            (identical(other.enrollEndDate, enrollEndDate) ||
                other.enrollEndDate == enrollEndDate) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.guardianName, guardianName) ||
                other.guardianName == guardianName) &&
            (identical(other.guardianPhone, guardianPhone) ||
                other.guardianPhone == guardianPhone) &&
            (identical(other.parentKind, parentKind) ||
                other.parentKind == parentKind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    studentName,
    phone,
    email,
    birthDate,
    genderCode,
    schoolId,
    schoolName,
    grade,
    classTypeCode,
    subjectCode,
    statusCode,
    sourceCode,
    sourceDetail,
    enrollStartDate,
    enrollEndDate,
    tcId,
    memo,
    guardianName,
    guardianPhone,
    parentKind,
  ]);

  /// Create a copy of StudentCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentCreateImplCopyWith<_$StudentCreateImpl> get copyWith =>
      __$$StudentCreateImplCopyWithImpl<_$StudentCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentCreateImplToJson(this);
  }
}

abstract class _StudentCreate implements StudentCreate {
  const factory _StudentCreate({
    @JsonKey(name: 'student_name') required final String studentName,
    required final String phone,
    final String? email,
    @JsonKey(name: 'birth_date') final String? birthDate,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'class_type_code') final String? classTypeCode,
    @JsonKey(name: 'subject_code') final int? subjectCode,
    @JsonKey(name: 'status_code') final String? statusCode,
    @JsonKey(name: 'source_code') final String? sourceCode,
    @JsonKey(name: 'source_detail') final String? sourceDetail,
    @JsonKey(name: 'enroll_start_date') final String? enrollStartDate,
    @JsonKey(name: 'enroll_end_date') final String? enrollEndDate,
    @JsonKey(name: 'tc_id') final int? tcId,
    final String? memo,
    @JsonKey(name: 'guardian_name') final String? guardianName,
    @JsonKey(name: 'guardian_phone') final String? guardianPhone,
    @JsonKey(name: 'parent_kind') final int? parentKind,
  }) = _$StudentCreateImpl;

  factory _StudentCreate.fromJson(Map<String, dynamic> json) =
      _$StudentCreateImpl.fromJson;

  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  String get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'birth_date')
  String? get birthDate;
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
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  int? get subjectCode;
  @override
  @JsonKey(name: 'status_code')
  String? get statusCode;
  @override
  @JsonKey(name: 'source_code')
  String? get sourceCode;
  @override
  @JsonKey(name: 'source_detail')
  String? get sourceDetail;
  @override
  @JsonKey(name: 'enroll_start_date')
  String? get enrollStartDate;
  @override
  @JsonKey(name: 'enroll_end_date')
  String? get enrollEndDate;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  String? get memo;
  @override
  @JsonKey(name: 'guardian_name')
  String? get guardianName;
  @override
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone;
  @override
  @JsonKey(name: 'parent_kind')
  int? get parentKind;

  /// Create a copy of StudentCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentCreateImplCopyWith<_$StudentCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentListParams _$StudentListParamsFromJson(Map<String, dynamic> json) {
  return _StudentListParams.fromJson(json);
}

/// @nodoc
mixin _$StudentListParams {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  String? get sort => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  String? get statusCode => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_code')
  int? get subjectCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_code')
  String? get sourceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String? get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String? get toDate => throw _privateConstructorUsedError;

  /// Serializes this StudentListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentListParamsCopyWith<StudentListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentListParamsCopyWith<$Res> {
  factory $StudentListParamsCopyWith(
    StudentListParams value,
    $Res Function(StudentListParams) then,
  ) = _$StudentListParamsCopyWithImpl<$Res, StudentListParams>;
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'status_code') String? statusCode,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  });
}

/// @nodoc
class _$StudentListParamsCopyWithImpl<$Res, $Val extends StudentListParams>
    implements $StudentListParamsCopyWith<$Res> {
  _$StudentListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? statusCode = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? tcId = freezed,
    Object? schoolId = freezed,
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
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            classTypeCode: freezed == classTypeCode
                ? _value.classTypeCode
                : classTypeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjectCode: freezed == subjectCode
                ? _value.subjectCode
                : subjectCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            sourceCode: freezed == sourceCode
                ? _value.sourceCode
                : sourceCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$StudentListParamsImplCopyWith<$Res>
    implements $StudentListParamsCopyWith<$Res> {
  factory _$$StudentListParamsImplCopyWith(
    _$StudentListParamsImpl value,
    $Res Function(_$StudentListParamsImpl) then,
  ) = __$$StudentListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'status_code') String? statusCode,
    int? grade,
    @JsonKey(name: 'class_type_code') String? classTypeCode,
    @JsonKey(name: 'subject_code') int? subjectCode,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
  });
}

/// @nodoc
class __$$StudentListParamsImplCopyWithImpl<$Res>
    extends _$StudentListParamsCopyWithImpl<$Res, _$StudentListParamsImpl>
    implements _$$StudentListParamsImplCopyWith<$Res> {
  __$$StudentListParamsImplCopyWithImpl(
    _$StudentListParamsImpl _value,
    $Res Function(_$StudentListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? statusCode = freezed,
    Object? grade = freezed,
    Object? classTypeCode = freezed,
    Object? subjectCode = freezed,
    Object? sourceCode = freezed,
    Object? tcId = freezed,
    Object? schoolId = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
  }) {
    return _then(
      _$StudentListParamsImpl(
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
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        classTypeCode: freezed == classTypeCode
            ? _value.classTypeCode
            : classTypeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjectCode: freezed == subjectCode
            ? _value.subjectCode
            : subjectCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        sourceCode: freezed == sourceCode
            ? _value.sourceCode
            : sourceCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$StudentListParamsImpl implements _StudentListParams {
  const _$StudentListParamsImpl({
    this.page = 1,
    this.perPage = 500,
    this.sort = 'student_name',
    this.order = 'asc',
    this.search,
    @JsonKey(name: 'status_code') this.statusCode,
    this.grade,
    @JsonKey(name: 'class_type_code') this.classTypeCode,
    @JsonKey(name: 'subject_code') this.subjectCode,
    @JsonKey(name: 'source_code') this.sourceCode,
    @JsonKey(name: 'tc_id') this.tcId,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'from_date') this.fromDate,
    @JsonKey(name: 'to_date') this.toDate,
  });

  factory _$StudentListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentListParamsImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int perPage;
  @override
  @JsonKey()
  final String? sort;
  @override
  @JsonKey()
  final String? order;
  @override
  final String? search;
  @override
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'class_type_code')
  final String? classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  final int? subjectCode;
  @override
  @JsonKey(name: 'source_code')
  final String? sourceCode;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @override
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String? toDate;

  @override
  String toString() {
    return 'StudentListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search, statusCode: $statusCode, grade: $grade, classTypeCode: $classTypeCode, subjectCode: $subjectCode, sourceCode: $sourceCode, tcId: $tcId, schoolId: $schoolId, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentListParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.classTypeCode, classTypeCode) ||
                other.classTypeCode == classTypeCode) &&
            (identical(other.subjectCode, subjectCode) ||
                other.subjectCode == subjectCode) &&
            (identical(other.sourceCode, sourceCode) ||
                other.sourceCode == sourceCode) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
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
    statusCode,
    grade,
    classTypeCode,
    subjectCode,
    sourceCode,
    tcId,
    schoolId,
    fromDate,
    toDate,
  );

  /// Create a copy of StudentListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentListParamsImplCopyWith<_$StudentListParamsImpl> get copyWith =>
      __$$StudentListParamsImplCopyWithImpl<_$StudentListParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentListParamsImplToJson(this);
  }
}

abstract class _StudentListParams implements StudentListParams {
  const factory _StudentListParams({
    final int page,
    final int perPage,
    final String? sort,
    final String? order,
    final String? search,
    @JsonKey(name: 'status_code') final String? statusCode,
    final int? grade,
    @JsonKey(name: 'class_type_code') final String? classTypeCode,
    @JsonKey(name: 'subject_code') final int? subjectCode,
    @JsonKey(name: 'source_code') final String? sourceCode,
    @JsonKey(name: 'tc_id') final int? tcId,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'from_date') final String? fromDate,
    @JsonKey(name: 'to_date') final String? toDate,
  }) = _$StudentListParamsImpl;

  factory _StudentListParams.fromJson(Map<String, dynamic> json) =
      _$StudentListParamsImpl.fromJson;

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
  @JsonKey(name: 'status_code')
  String? get statusCode;
  @override
  int? get grade;
  @override
  @JsonKey(name: 'class_type_code')
  String? get classTypeCode;
  @override
  @JsonKey(name: 'subject_code')
  int? get subjectCode;
  @override
  @JsonKey(name: 'source_code')
  String? get sourceCode;
  @override
  @JsonKey(name: 'tc_id')
  int? get tcId;
  @override
  @JsonKey(name: 'school_id')
  int? get schoolId;
  @override
  @JsonKey(name: 'from_date')
  String? get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String? get toDate;

  /// Create a copy of StudentListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentListParamsImplCopyWith<_$StudentListParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentHistory _$StudentHistoryFromJson(Map<String, dynamic> json) {
  return _StudentHistory.fromJson(json);
}

/// @nodoc
mixin _$StudentHistory {
  @JsonKey(name: 'history_id')
  int get historyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_status_code')
  String? get prevStatusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_status_name')
  String? get prevStatusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_status_code')
  String get newStatusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_status_name')
  String? get newStatusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_sub_status')
  String? get prevSubStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_sub_status_name')
  String? get prevSubStatusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_sub_status')
  String? get newSubStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_sub_status_name')
  String? get newSubStatusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_type_code')
  String get changeTypeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_type_name')
  String? get changeTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_reason_code')
  String? get changeReasonCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_reason_name')
  String? get changeReasonName => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_reason')
  String? get changeReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_tc_id')
  int? get prevTcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_tc_name')
  String? get prevTcName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_tc_id')
  int? get newTcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_tc_name')
  String? get newTcName => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_by')
  int get changedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_by_name')
  String? get changedByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  String get changedAt => throw _privateConstructorUsedError;

  /// Serializes this StudentHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentHistoryCopyWith<StudentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentHistoryCopyWith<$Res> {
  factory $StudentHistoryCopyWith(
    StudentHistory value,
    $Res Function(StudentHistory) then,
  ) = _$StudentHistoryCopyWithImpl<$Res, StudentHistory>;
  @useResult
  $Res call({
    @JsonKey(name: 'history_id') int historyId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'prev_status_code') String? prevStatusCode,
    @JsonKey(name: 'prev_status_name') String? prevStatusName,
    @JsonKey(name: 'new_status_code') String newStatusCode,
    @JsonKey(name: 'new_status_name') String? newStatusName,
    @JsonKey(name: 'prev_sub_status') String? prevSubStatus,
    @JsonKey(name: 'prev_sub_status_name') String? prevSubStatusName,
    @JsonKey(name: 'new_sub_status') String? newSubStatus,
    @JsonKey(name: 'new_sub_status_name') String? newSubStatusName,
    @JsonKey(name: 'change_type_code') String changeTypeCode,
    @JsonKey(name: 'change_type_name') String? changeTypeName,
    @JsonKey(name: 'change_reason_code') String? changeReasonCode,
    @JsonKey(name: 'change_reason_name') String? changeReasonName,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'prev_tc_id') int? prevTcId,
    @JsonKey(name: 'prev_tc_name') String? prevTcName,
    @JsonKey(name: 'new_tc_id') int? newTcId,
    @JsonKey(name: 'new_tc_name') String? newTcName,
    @JsonKey(name: 'changed_by') int changedBy,
    @JsonKey(name: 'changed_by_name') String? changedByName,
    @JsonKey(name: 'changed_at') String changedAt,
  });
}

/// @nodoc
class _$StudentHistoryCopyWithImpl<$Res, $Val extends StudentHistory>
    implements $StudentHistoryCopyWith<$Res> {
  _$StudentHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historyId = null,
    Object? studentId = null,
    Object? prevStatusCode = freezed,
    Object? prevStatusName = freezed,
    Object? newStatusCode = null,
    Object? newStatusName = freezed,
    Object? prevSubStatus = freezed,
    Object? prevSubStatusName = freezed,
    Object? newSubStatus = freezed,
    Object? newSubStatusName = freezed,
    Object? changeTypeCode = null,
    Object? changeTypeName = freezed,
    Object? changeReasonCode = freezed,
    Object? changeReasonName = freezed,
    Object? changeReason = freezed,
    Object? prevTcId = freezed,
    Object? prevTcName = freezed,
    Object? newTcId = freezed,
    Object? newTcName = freezed,
    Object? changedBy = null,
    Object? changedByName = freezed,
    Object? changedAt = null,
  }) {
    return _then(
      _value.copyWith(
            historyId: null == historyId
                ? _value.historyId
                : historyId // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            prevStatusCode: freezed == prevStatusCode
                ? _value.prevStatusCode
                : prevStatusCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevStatusName: freezed == prevStatusName
                ? _value.prevStatusName
                : prevStatusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            newStatusCode: null == newStatusCode
                ? _value.newStatusCode
                : newStatusCode // ignore: cast_nullable_to_non_nullable
                      as String,
            newStatusName: freezed == newStatusName
                ? _value.newStatusName
                : newStatusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevSubStatus: freezed == prevSubStatus
                ? _value.prevSubStatus
                : prevSubStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevSubStatusName: freezed == prevSubStatusName
                ? _value.prevSubStatusName
                : prevSubStatusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            newSubStatus: freezed == newSubStatus
                ? _value.newSubStatus
                : newSubStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            newSubStatusName: freezed == newSubStatusName
                ? _value.newSubStatusName
                : newSubStatusName // ignore: cast_nullable_to_non_nullable
                      as String?,
            changeTypeCode: null == changeTypeCode
                ? _value.changeTypeCode
                : changeTypeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            changeTypeName: freezed == changeTypeName
                ? _value.changeTypeName
                : changeTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            changeReasonCode: freezed == changeReasonCode
                ? _value.changeReasonCode
                : changeReasonCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            changeReasonName: freezed == changeReasonName
                ? _value.changeReasonName
                : changeReasonName // ignore: cast_nullable_to_non_nullable
                      as String?,
            changeReason: freezed == changeReason
                ? _value.changeReason
                : changeReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevTcId: freezed == prevTcId
                ? _value.prevTcId
                : prevTcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            prevTcName: freezed == prevTcName
                ? _value.prevTcName
                : prevTcName // ignore: cast_nullable_to_non_nullable
                      as String?,
            newTcId: freezed == newTcId
                ? _value.newTcId
                : newTcId // ignore: cast_nullable_to_non_nullable
                      as int?,
            newTcName: freezed == newTcName
                ? _value.newTcName
                : newTcName // ignore: cast_nullable_to_non_nullable
                      as String?,
            changedBy: null == changedBy
                ? _value.changedBy
                : changedBy // ignore: cast_nullable_to_non_nullable
                      as int,
            changedByName: freezed == changedByName
                ? _value.changedByName
                : changedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            changedAt: null == changedAt
                ? _value.changedAt
                : changedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentHistoryImplCopyWith<$Res>
    implements $StudentHistoryCopyWith<$Res> {
  factory _$$StudentHistoryImplCopyWith(
    _$StudentHistoryImpl value,
    $Res Function(_$StudentHistoryImpl) then,
  ) = __$$StudentHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'history_id') int historyId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'prev_status_code') String? prevStatusCode,
    @JsonKey(name: 'prev_status_name') String? prevStatusName,
    @JsonKey(name: 'new_status_code') String newStatusCode,
    @JsonKey(name: 'new_status_name') String? newStatusName,
    @JsonKey(name: 'prev_sub_status') String? prevSubStatus,
    @JsonKey(name: 'prev_sub_status_name') String? prevSubStatusName,
    @JsonKey(name: 'new_sub_status') String? newSubStatus,
    @JsonKey(name: 'new_sub_status_name') String? newSubStatusName,
    @JsonKey(name: 'change_type_code') String changeTypeCode,
    @JsonKey(name: 'change_type_name') String? changeTypeName,
    @JsonKey(name: 'change_reason_code') String? changeReasonCode,
    @JsonKey(name: 'change_reason_name') String? changeReasonName,
    @JsonKey(name: 'change_reason') String? changeReason,
    @JsonKey(name: 'prev_tc_id') int? prevTcId,
    @JsonKey(name: 'prev_tc_name') String? prevTcName,
    @JsonKey(name: 'new_tc_id') int? newTcId,
    @JsonKey(name: 'new_tc_name') String? newTcName,
    @JsonKey(name: 'changed_by') int changedBy,
    @JsonKey(name: 'changed_by_name') String? changedByName,
    @JsonKey(name: 'changed_at') String changedAt,
  });
}

/// @nodoc
class __$$StudentHistoryImplCopyWithImpl<$Res>
    extends _$StudentHistoryCopyWithImpl<$Res, _$StudentHistoryImpl>
    implements _$$StudentHistoryImplCopyWith<$Res> {
  __$$StudentHistoryImplCopyWithImpl(
    _$StudentHistoryImpl _value,
    $Res Function(_$StudentHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? historyId = null,
    Object? studentId = null,
    Object? prevStatusCode = freezed,
    Object? prevStatusName = freezed,
    Object? newStatusCode = null,
    Object? newStatusName = freezed,
    Object? prevSubStatus = freezed,
    Object? prevSubStatusName = freezed,
    Object? newSubStatus = freezed,
    Object? newSubStatusName = freezed,
    Object? changeTypeCode = null,
    Object? changeTypeName = freezed,
    Object? changeReasonCode = freezed,
    Object? changeReasonName = freezed,
    Object? changeReason = freezed,
    Object? prevTcId = freezed,
    Object? prevTcName = freezed,
    Object? newTcId = freezed,
    Object? newTcName = freezed,
    Object? changedBy = null,
    Object? changedByName = freezed,
    Object? changedAt = null,
  }) {
    return _then(
      _$StudentHistoryImpl(
        historyId: null == historyId
            ? _value.historyId
            : historyId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        prevStatusCode: freezed == prevStatusCode
            ? _value.prevStatusCode
            : prevStatusCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevStatusName: freezed == prevStatusName
            ? _value.prevStatusName
            : prevStatusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        newStatusCode: null == newStatusCode
            ? _value.newStatusCode
            : newStatusCode // ignore: cast_nullable_to_non_nullable
                  as String,
        newStatusName: freezed == newStatusName
            ? _value.newStatusName
            : newStatusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevSubStatus: freezed == prevSubStatus
            ? _value.prevSubStatus
            : prevSubStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevSubStatusName: freezed == prevSubStatusName
            ? _value.prevSubStatusName
            : prevSubStatusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        newSubStatus: freezed == newSubStatus
            ? _value.newSubStatus
            : newSubStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        newSubStatusName: freezed == newSubStatusName
            ? _value.newSubStatusName
            : newSubStatusName // ignore: cast_nullable_to_non_nullable
                  as String?,
        changeTypeCode: null == changeTypeCode
            ? _value.changeTypeCode
            : changeTypeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        changeTypeName: freezed == changeTypeName
            ? _value.changeTypeName
            : changeTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        changeReasonCode: freezed == changeReasonCode
            ? _value.changeReasonCode
            : changeReasonCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        changeReasonName: freezed == changeReasonName
            ? _value.changeReasonName
            : changeReasonName // ignore: cast_nullable_to_non_nullable
                  as String?,
        changeReason: freezed == changeReason
            ? _value.changeReason
            : changeReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevTcId: freezed == prevTcId
            ? _value.prevTcId
            : prevTcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        prevTcName: freezed == prevTcName
            ? _value.prevTcName
            : prevTcName // ignore: cast_nullable_to_non_nullable
                  as String?,
        newTcId: freezed == newTcId
            ? _value.newTcId
            : newTcId // ignore: cast_nullable_to_non_nullable
                  as int?,
        newTcName: freezed == newTcName
            ? _value.newTcName
            : newTcName // ignore: cast_nullable_to_non_nullable
                  as String?,
        changedBy: null == changedBy
            ? _value.changedBy
            : changedBy // ignore: cast_nullable_to_non_nullable
                  as int,
        changedByName: freezed == changedByName
            ? _value.changedByName
            : changedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        changedAt: null == changedAt
            ? _value.changedAt
            : changedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentHistoryImpl implements _StudentHistory {
  const _$StudentHistoryImpl({
    @JsonKey(name: 'history_id') required this.historyId,
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'prev_status_code') this.prevStatusCode,
    @JsonKey(name: 'prev_status_name') this.prevStatusName,
    @JsonKey(name: 'new_status_code') required this.newStatusCode,
    @JsonKey(name: 'new_status_name') this.newStatusName,
    @JsonKey(name: 'prev_sub_status') this.prevSubStatus,
    @JsonKey(name: 'prev_sub_status_name') this.prevSubStatusName,
    @JsonKey(name: 'new_sub_status') this.newSubStatus,
    @JsonKey(name: 'new_sub_status_name') this.newSubStatusName,
    @JsonKey(name: 'change_type_code') required this.changeTypeCode,
    @JsonKey(name: 'change_type_name') this.changeTypeName,
    @JsonKey(name: 'change_reason_code') this.changeReasonCode,
    @JsonKey(name: 'change_reason_name') this.changeReasonName,
    @JsonKey(name: 'change_reason') this.changeReason,
    @JsonKey(name: 'prev_tc_id') this.prevTcId,
    @JsonKey(name: 'prev_tc_name') this.prevTcName,
    @JsonKey(name: 'new_tc_id') this.newTcId,
    @JsonKey(name: 'new_tc_name') this.newTcName,
    @JsonKey(name: 'changed_by') required this.changedBy,
    @JsonKey(name: 'changed_by_name') this.changedByName,
    @JsonKey(name: 'changed_at') required this.changedAt,
  });

  factory _$StudentHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentHistoryImplFromJson(json);

  @override
  @JsonKey(name: 'history_id')
  final int historyId;
  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'prev_status_code')
  final String? prevStatusCode;
  @override
  @JsonKey(name: 'prev_status_name')
  final String? prevStatusName;
  @override
  @JsonKey(name: 'new_status_code')
  final String newStatusCode;
  @override
  @JsonKey(name: 'new_status_name')
  final String? newStatusName;
  @override
  @JsonKey(name: 'prev_sub_status')
  final String? prevSubStatus;
  @override
  @JsonKey(name: 'prev_sub_status_name')
  final String? prevSubStatusName;
  @override
  @JsonKey(name: 'new_sub_status')
  final String? newSubStatus;
  @override
  @JsonKey(name: 'new_sub_status_name')
  final String? newSubStatusName;
  @override
  @JsonKey(name: 'change_type_code')
  final String changeTypeCode;
  @override
  @JsonKey(name: 'change_type_name')
  final String? changeTypeName;
  @override
  @JsonKey(name: 'change_reason_code')
  final String? changeReasonCode;
  @override
  @JsonKey(name: 'change_reason_name')
  final String? changeReasonName;
  @override
  @JsonKey(name: 'change_reason')
  final String? changeReason;
  @override
  @JsonKey(name: 'prev_tc_id')
  final int? prevTcId;
  @override
  @JsonKey(name: 'prev_tc_name')
  final String? prevTcName;
  @override
  @JsonKey(name: 'new_tc_id')
  final int? newTcId;
  @override
  @JsonKey(name: 'new_tc_name')
  final String? newTcName;
  @override
  @JsonKey(name: 'changed_by')
  final int changedBy;
  @override
  @JsonKey(name: 'changed_by_name')
  final String? changedByName;
  @override
  @JsonKey(name: 'changed_at')
  final String changedAt;

  @override
  String toString() {
    return 'StudentHistory(historyId: $historyId, studentId: $studentId, prevStatusCode: $prevStatusCode, prevStatusName: $prevStatusName, newStatusCode: $newStatusCode, newStatusName: $newStatusName, prevSubStatus: $prevSubStatus, prevSubStatusName: $prevSubStatusName, newSubStatus: $newSubStatus, newSubStatusName: $newSubStatusName, changeTypeCode: $changeTypeCode, changeTypeName: $changeTypeName, changeReasonCode: $changeReasonCode, changeReasonName: $changeReasonName, changeReason: $changeReason, prevTcId: $prevTcId, prevTcName: $prevTcName, newTcId: $newTcId, newTcName: $newTcName, changedBy: $changedBy, changedByName: $changedByName, changedAt: $changedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentHistoryImpl &&
            (identical(other.historyId, historyId) ||
                other.historyId == historyId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.prevStatusCode, prevStatusCode) ||
                other.prevStatusCode == prevStatusCode) &&
            (identical(other.prevStatusName, prevStatusName) ||
                other.prevStatusName == prevStatusName) &&
            (identical(other.newStatusCode, newStatusCode) ||
                other.newStatusCode == newStatusCode) &&
            (identical(other.newStatusName, newStatusName) ||
                other.newStatusName == newStatusName) &&
            (identical(other.prevSubStatus, prevSubStatus) ||
                other.prevSubStatus == prevSubStatus) &&
            (identical(other.prevSubStatusName, prevSubStatusName) ||
                other.prevSubStatusName == prevSubStatusName) &&
            (identical(other.newSubStatus, newSubStatus) ||
                other.newSubStatus == newSubStatus) &&
            (identical(other.newSubStatusName, newSubStatusName) ||
                other.newSubStatusName == newSubStatusName) &&
            (identical(other.changeTypeCode, changeTypeCode) ||
                other.changeTypeCode == changeTypeCode) &&
            (identical(other.changeTypeName, changeTypeName) ||
                other.changeTypeName == changeTypeName) &&
            (identical(other.changeReasonCode, changeReasonCode) ||
                other.changeReasonCode == changeReasonCode) &&
            (identical(other.changeReasonName, changeReasonName) ||
                other.changeReasonName == changeReasonName) &&
            (identical(other.changeReason, changeReason) ||
                other.changeReason == changeReason) &&
            (identical(other.prevTcId, prevTcId) ||
                other.prevTcId == prevTcId) &&
            (identical(other.prevTcName, prevTcName) ||
                other.prevTcName == prevTcName) &&
            (identical(other.newTcId, newTcId) || other.newTcId == newTcId) &&
            (identical(other.newTcName, newTcName) ||
                other.newTcName == newTcName) &&
            (identical(other.changedBy, changedBy) ||
                other.changedBy == changedBy) &&
            (identical(other.changedByName, changedByName) ||
                other.changedByName == changedByName) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    historyId,
    studentId,
    prevStatusCode,
    prevStatusName,
    newStatusCode,
    newStatusName,
    prevSubStatus,
    prevSubStatusName,
    newSubStatus,
    newSubStatusName,
    changeTypeCode,
    changeTypeName,
    changeReasonCode,
    changeReasonName,
    changeReason,
    prevTcId,
    prevTcName,
    newTcId,
    newTcName,
    changedBy,
    changedByName,
    changedAt,
  ]);

  /// Create a copy of StudentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentHistoryImplCopyWith<_$StudentHistoryImpl> get copyWith =>
      __$$StudentHistoryImplCopyWithImpl<_$StudentHistoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentHistoryImplToJson(this);
  }
}

abstract class _StudentHistory implements StudentHistory {
  const factory _StudentHistory({
    @JsonKey(name: 'history_id') required final int historyId,
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'prev_status_code') final String? prevStatusCode,
    @JsonKey(name: 'prev_status_name') final String? prevStatusName,
    @JsonKey(name: 'new_status_code') required final String newStatusCode,
    @JsonKey(name: 'new_status_name') final String? newStatusName,
    @JsonKey(name: 'prev_sub_status') final String? prevSubStatus,
    @JsonKey(name: 'prev_sub_status_name') final String? prevSubStatusName,
    @JsonKey(name: 'new_sub_status') final String? newSubStatus,
    @JsonKey(name: 'new_sub_status_name') final String? newSubStatusName,
    @JsonKey(name: 'change_type_code') required final String changeTypeCode,
    @JsonKey(name: 'change_type_name') final String? changeTypeName,
    @JsonKey(name: 'change_reason_code') final String? changeReasonCode,
    @JsonKey(name: 'change_reason_name') final String? changeReasonName,
    @JsonKey(name: 'change_reason') final String? changeReason,
    @JsonKey(name: 'prev_tc_id') final int? prevTcId,
    @JsonKey(name: 'prev_tc_name') final String? prevTcName,
    @JsonKey(name: 'new_tc_id') final int? newTcId,
    @JsonKey(name: 'new_tc_name') final String? newTcName,
    @JsonKey(name: 'changed_by') required final int changedBy,
    @JsonKey(name: 'changed_by_name') final String? changedByName,
    @JsonKey(name: 'changed_at') required final String changedAt,
  }) = _$StudentHistoryImpl;

  factory _StudentHistory.fromJson(Map<String, dynamic> json) =
      _$StudentHistoryImpl.fromJson;

  @override
  @JsonKey(name: 'history_id')
  int get historyId;
  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'prev_status_code')
  String? get prevStatusCode;
  @override
  @JsonKey(name: 'prev_status_name')
  String? get prevStatusName;
  @override
  @JsonKey(name: 'new_status_code')
  String get newStatusCode;
  @override
  @JsonKey(name: 'new_status_name')
  String? get newStatusName;
  @override
  @JsonKey(name: 'prev_sub_status')
  String? get prevSubStatus;
  @override
  @JsonKey(name: 'prev_sub_status_name')
  String? get prevSubStatusName;
  @override
  @JsonKey(name: 'new_sub_status')
  String? get newSubStatus;
  @override
  @JsonKey(name: 'new_sub_status_name')
  String? get newSubStatusName;
  @override
  @JsonKey(name: 'change_type_code')
  String get changeTypeCode;
  @override
  @JsonKey(name: 'change_type_name')
  String? get changeTypeName;
  @override
  @JsonKey(name: 'change_reason_code')
  String? get changeReasonCode;
  @override
  @JsonKey(name: 'change_reason_name')
  String? get changeReasonName;
  @override
  @JsonKey(name: 'change_reason')
  String? get changeReason;
  @override
  @JsonKey(name: 'prev_tc_id')
  int? get prevTcId;
  @override
  @JsonKey(name: 'prev_tc_name')
  String? get prevTcName;
  @override
  @JsonKey(name: 'new_tc_id')
  int? get newTcId;
  @override
  @JsonKey(name: 'new_tc_name')
  String? get newTcName;
  @override
  @JsonKey(name: 'changed_by')
  int get changedBy;
  @override
  @JsonKey(name: 'changed_by_name')
  String? get changedByName;
  @override
  @JsonKey(name: 'changed_at')
  String get changedAt;

  /// Create a copy of StudentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentHistoryImplCopyWith<_$StudentHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
