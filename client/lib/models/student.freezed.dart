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
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'grade_name')
  String? get gradeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_name')
  String? get guardianName => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_phone')
  String? get guardianPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'guardian_relation')
  String? get guardianRelation => throw _privateConstructorUsedError;
  @JsonKey(name: 'relation_name')
  String? get relationName => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'source_code')
  String? get sourceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_name')
  String? get sourceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_detail')
  String? get sourceDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_id')
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
  @JsonKey(name: 'withdraw_date')
  String? get withdrawDate => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation') String? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
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
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? statusCode = null,
    Object? statusName = freezed,
    Object? subStatusCode = freezed,
    Object? subStatusName = freezed,
    Object? sourceCode = freezed,
    Object? sourceName = freezed,
    Object? sourceDetail = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? firstContactDate = freezed,
    Object? consultDate = freezed,
    Object? registerDate = freezed,
    Object? enrollDate = freezed,
    Object? withdrawDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
                      as String?,
            relationName: freezed == relationName
                ? _value.relationName
                : relationName // ignore: cast_nullable_to_non_nullable
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
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'guardian_name') String? guardianName,
    @JsonKey(name: 'guardian_phone') String? guardianPhone,
    @JsonKey(name: 'guardian_relation') String? guardianRelation,
    @JsonKey(name: 'relation_name') String? relationName,
    String? address,
    @JsonKey(name: 'address_detail') String? addressDetail,
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'sub_status_code') String? subStatusCode,
    @JsonKey(name: 'sub_status_name') String? subStatusName,
    @JsonKey(name: 'source_code') String? sourceCode,
    @JsonKey(name: 'source_name') String? sourceName,
    @JsonKey(name: 'source_detail') String? sourceDetail,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'register_date') String? registerDate,
    @JsonKey(name: 'enroll_date') String? enrollDate,
    @JsonKey(name: 'withdraw_date') String? withdrawDate,
    String? memo,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
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
    Object? address = freezed,
    Object? addressDetail = freezed,
    Object? statusCode = null,
    Object? statusName = freezed,
    Object? subStatusCode = freezed,
    Object? subStatusName = freezed,
    Object? sourceCode = freezed,
    Object? sourceName = freezed,
    Object? sourceDetail = freezed,
    Object? tcId = freezed,
    Object? tcName = freezed,
    Object? firstContactDate = freezed,
    Object? consultDate = freezed,
    Object? registerDate = freezed,
    Object? enrollDate = freezed,
    Object? withdrawDate = freezed,
    Object? memo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
                  as String?,
        relationName: freezed == relationName
            ? _value.relationName
            : relationName // ignore: cast_nullable_to_non_nullable
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
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'grade_name') this.gradeName,
    @JsonKey(name: 'guardian_name') this.guardianName,
    @JsonKey(name: 'guardian_phone') this.guardianPhone,
    @JsonKey(name: 'guardian_relation') this.guardianRelation,
    @JsonKey(name: 'relation_name') this.relationName,
    this.address,
    @JsonKey(name: 'address_detail') this.addressDetail,
    @JsonKey(name: 'status_code') required this.statusCode,
    @JsonKey(name: 'status_name') this.statusName,
    @JsonKey(name: 'sub_status_code') this.subStatusCode,
    @JsonKey(name: 'sub_status_name') this.subStatusName,
    @JsonKey(name: 'source_code') this.sourceCode,
    @JsonKey(name: 'source_name') this.sourceName,
    @JsonKey(name: 'source_detail') this.sourceDetail,
    @JsonKey(name: 'tc_id') this.tcId,
    @JsonKey(name: 'tc_name') this.tcName,
    @JsonKey(name: 'first_contact_date') this.firstContactDate,
    @JsonKey(name: 'consult_date') this.consultDate,
    @JsonKey(name: 'register_date') this.registerDate,
    @JsonKey(name: 'enroll_date') this.enrollDate,
    @JsonKey(name: 'withdraw_date') this.withdrawDate,
    this.memo,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

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
  final int? schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @override
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
  final String? guardianRelation;
  @override
  @JsonKey(name: 'relation_name')
  final String? relationName;
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

  @override
  String toString() {
    return 'Student(studentId: $studentId, studentName: $studentName, phone: $phone, phoneSub: $phoneSub, email: $email, birthDate: $birthDate, genderCode: $genderCode, genderName: $genderName, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, gradeName: $gradeName, guardianName: $guardianName, guardianPhone: $guardianPhone, guardianRelation: $guardianRelation, relationName: $relationName, address: $address, addressDetail: $addressDetail, statusCode: $statusCode, statusName: $statusName, subStatusCode: $subStatusCode, subStatusName: $subStatusName, sourceCode: $sourceCode, sourceName: $sourceName, sourceDetail: $sourceDetail, tcId: $tcId, tcName: $tcName, firstContactDate: $firstContactDate, consultDate: $consultDate, registerDate: $registerDate, enrollDate: $enrollDate, withdrawDate: $withdrawDate, memo: $memo, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            (identical(other.withdrawDate, withdrawDate) ||
                other.withdrawDate == withdrawDate) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
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
    address,
    addressDetail,
    statusCode,
    statusName,
    subStatusCode,
    subStatusName,
    sourceCode,
    sourceName,
    sourceDetail,
    tcId,
    tcName,
    firstContactDate,
    consultDate,
    registerDate,
    enrollDate,
    withdrawDate,
    memo,
    createdAt,
    updatedAt,
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
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'grade_name') final String? gradeName,
    @JsonKey(name: 'guardian_name') final String? guardianName,
    @JsonKey(name: 'guardian_phone') final String? guardianPhone,
    @JsonKey(name: 'guardian_relation') final String? guardianRelation,
    @JsonKey(name: 'relation_name') final String? relationName,
    final String? address,
    @JsonKey(name: 'address_detail') final String? addressDetail,
    @JsonKey(name: 'status_code') required final String statusCode,
    @JsonKey(name: 'status_name') final String? statusName,
    @JsonKey(name: 'sub_status_code') final String? subStatusCode,
    @JsonKey(name: 'sub_status_name') final String? subStatusName,
    @JsonKey(name: 'source_code') final String? sourceCode,
    @JsonKey(name: 'source_name') final String? sourceName,
    @JsonKey(name: 'source_detail') final String? sourceDetail,
    @JsonKey(name: 'tc_id') final int? tcId,
    @JsonKey(name: 'tc_name') final String? tcName,
    @JsonKey(name: 'first_contact_date') final String? firstContactDate,
    @JsonKey(name: 'consult_date') final String? consultDate,
    @JsonKey(name: 'register_date') final String? registerDate,
    @JsonKey(name: 'enroll_date') final String? enrollDate,
    @JsonKey(name: 'withdraw_date') final String? withdrawDate,
    final String? memo,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
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
  int? get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName;
  @override
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
  String? get guardianRelation;
  @override
  @JsonKey(name: 'relation_name')
  String? get relationName;
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

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
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
  @JsonKey(name: 'tc_id')
  int? get tcId => throw _privateConstructorUsedError;
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
    @JsonKey(name: 'tc_id') int? tcId,
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
    Object? tcId = freezed,
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
            tcId: freezed == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
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
    @JsonKey(name: 'tc_id') int? tcId,
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
    Object? tcId = freezed,
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
        tcId: freezed == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
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
    this.perPage = 20,
    this.sort,
    this.order,
    this.search,
    @JsonKey(name: 'status_code') this.statusCode,
    this.grade,
    @JsonKey(name: 'tc_id') this.tcId,
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
  final String? sort;
  @override
  final String? order;
  @override
  final String? search;
  @override
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @override
  final int? grade;
  @override
  @JsonKey(name: 'tc_id')
  final int? tcId;
  @override
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String? toDate;

  @override
  String toString() {
    return 'StudentListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search, statusCode: $statusCode, grade: $grade, tcId: $tcId, fromDate: $fromDate, toDate: $toDate)';
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
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
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
    tcId,
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
    @JsonKey(name: 'tc_id') final int? tcId,
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
  @JsonKey(name: 'tc_id')
  int? get tcId;
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
