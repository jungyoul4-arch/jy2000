// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mgmt_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MgmtData _$MgmtDataFromJson(Map<String, dynamic> json) {
  return _MgmtData.fromJson(json);
}

/// @nodoc
mixin _$MgmtData {
  @JsonKey(name: 'mgmt_data_id')
  int get mgmtDataId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String? get studentName => throw _privateConstructorUsedError; // JOIN으로 가져옴
  @JsonKey(name: 'school_id')
  int? get schoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_name')
  String? get schoolName => throw _privateConstructorUsedError; // JOIN으로 가져옴
  int? get grade =>
      throw _privateConstructorUsedError; // 1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3
  @JsonKey(name: 'enrollment_count')
  @StringToDoubleConverter()
  double get enrollmentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comp_class_type')
  String? get compClassType => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_id')
  int? get teacherId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_name')
  String? get teacherName => throw _privateConstructorUsedError; // JOIN으로 가져옴
  @JsonKey(name: 'class_name1')
  String? get className1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_id')
  int? get classTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_name')
  String? get classTypeName => throw _privateConstructorUsedError; // JOIN으로 가져옴
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MgmtData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MgmtData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MgmtDataCopyWith<MgmtData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MgmtDataCopyWith<$Res> {
  factory $MgmtDataCopyWith(MgmtData value, $Res Function(MgmtData) then) =
      _$MgmtDataCopyWithImpl<$Res, MgmtData>;
  @useResult
  $Res call({
    @JsonKey(name: 'mgmt_data_id') int mgmtDataId,
    int year,
    int month,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'enrollment_count')
    @StringToDoubleConverter()
    double enrollmentCount,
    @JsonKey(name: 'comp_class_type') String? compClassType,
    String? subject,
    @JsonKey(name: 'teacher_id') int? teacherId,
    @JsonKey(name: 'teacher_name') String? teacherName,
    @JsonKey(name: 'class_name1') String? className1,
    @JsonKey(name: 'class_type_id') int? classTypeId,
    @JsonKey(name: 'class_type_name') String? classTypeName,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$MgmtDataCopyWithImpl<$Res, $Val extends MgmtData>
    implements $MgmtDataCopyWith<$Res> {
  _$MgmtDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MgmtData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mgmtDataId = null,
    Object? year = null,
    Object? month = null,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? enrollmentCount = null,
    Object? compClassType = freezed,
    Object? subject = freezed,
    Object? teacherId = freezed,
    Object? teacherName = freezed,
    Object? className1 = freezed,
    Object? classTypeId = freezed,
    Object? classTypeName = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            mgmtDataId: null == mgmtDataId
                ? _value.mgmtDataId
                : mgmtDataId // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentName: freezed == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
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
            enrollmentCount: null == enrollmentCount
                ? _value.enrollmentCount
                : enrollmentCount // ignore: cast_nullable_to_non_nullable
                      as double,
            compClassType: freezed == compClassType
                ? _value.compClassType
                : compClassType // ignore: cast_nullable_to_non_nullable
                      as String?,
            subject: freezed == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String?,
            teacherId: freezed == teacherId
                ? _value.teacherId
                : teacherId // ignore: cast_nullable_to_non_nullable
                      as int?,
            teacherName: freezed == teacherName
                ? _value.teacherName
                : teacherName // ignore: cast_nullable_to_non_nullable
                      as String?,
            className1: freezed == className1
                ? _value.className1
                : className1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            classTypeId: freezed == classTypeId
                ? _value.classTypeId
                : classTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            classTypeName: freezed == classTypeName
                ? _value.classTypeName
                : classTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MgmtDataImplCopyWith<$Res>
    implements $MgmtDataCopyWith<$Res> {
  factory _$$MgmtDataImplCopyWith(
    _$MgmtDataImpl value,
    $Res Function(_$MgmtDataImpl) then,
  ) = __$$MgmtDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'mgmt_data_id') int mgmtDataId,
    int year,
    int month,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'school_name') String? schoolName,
    int? grade,
    @JsonKey(name: 'enrollment_count')
    @StringToDoubleConverter()
    double enrollmentCount,
    @JsonKey(name: 'comp_class_type') String? compClassType,
    String? subject,
    @JsonKey(name: 'teacher_id') int? teacherId,
    @JsonKey(name: 'teacher_name') String? teacherName,
    @JsonKey(name: 'class_name1') String? className1,
    @JsonKey(name: 'class_type_id') int? classTypeId,
    @JsonKey(name: 'class_type_name') String? classTypeName,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$MgmtDataImplCopyWithImpl<$Res>
    extends _$MgmtDataCopyWithImpl<$Res, _$MgmtDataImpl>
    implements _$$MgmtDataImplCopyWith<$Res> {
  __$$MgmtDataImplCopyWithImpl(
    _$MgmtDataImpl _value,
    $Res Function(_$MgmtDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MgmtData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mgmtDataId = null,
    Object? year = null,
    Object? month = null,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? schoolId = freezed,
    Object? schoolName = freezed,
    Object? grade = freezed,
    Object? enrollmentCount = null,
    Object? compClassType = freezed,
    Object? subject = freezed,
    Object? teacherId = freezed,
    Object? teacherName = freezed,
    Object? className1 = freezed,
    Object? classTypeId = freezed,
    Object? classTypeName = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MgmtDataImpl(
        mgmtDataId: null == mgmtDataId
            ? _value.mgmtDataId
            : mgmtDataId // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentName: freezed == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
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
        enrollmentCount: null == enrollmentCount
            ? _value.enrollmentCount
            : enrollmentCount // ignore: cast_nullable_to_non_nullable
                  as double,
        compClassType: freezed == compClassType
            ? _value.compClassType
            : compClassType // ignore: cast_nullable_to_non_nullable
                  as String?,
        subject: freezed == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String?,
        teacherId: freezed == teacherId
            ? _value.teacherId
            : teacherId // ignore: cast_nullable_to_non_nullable
                  as int?,
        teacherName: freezed == teacherName
            ? _value.teacherName
            : teacherName // ignore: cast_nullable_to_non_nullable
                  as String?,
        className1: freezed == className1
            ? _value.className1
            : className1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        classTypeId: freezed == classTypeId
            ? _value.classTypeId
            : classTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        classTypeName: freezed == classTypeName
            ? _value.classTypeName
            : classTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MgmtDataImpl extends _MgmtData {
  const _$MgmtDataImpl({
    @JsonKey(name: 'mgmt_data_id') required this.mgmtDataId,
    required this.year,
    required this.month,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'student_name') this.studentName,
    @JsonKey(name: 'school_id') this.schoolId,
    @JsonKey(name: 'school_name') this.schoolName,
    this.grade,
    @JsonKey(name: 'enrollment_count')
    @StringToDoubleConverter()
    this.enrollmentCount = 1.0,
    @JsonKey(name: 'comp_class_type') this.compClassType,
    this.subject,
    @JsonKey(name: 'teacher_id') this.teacherId,
    @JsonKey(name: 'teacher_name') this.teacherName,
    @JsonKey(name: 'class_name1') this.className1,
    @JsonKey(name: 'class_type_id') this.classTypeId,
    @JsonKey(name: 'class_type_name') this.classTypeName,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : super._();

  factory _$MgmtDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MgmtDataImplFromJson(json);

  @override
  @JsonKey(name: 'mgmt_data_id')
  final int mgmtDataId;
  @override
  final int year;
  @override
  final int month;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'student_name')
  final String? studentName;
  // JOIN으로 가져옴
  @override
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @override
  @JsonKey(name: 'school_name')
  final String? schoolName;
  // JOIN으로 가져옴
  @override
  final int? grade;
  // 1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3
  @override
  @JsonKey(name: 'enrollment_count')
  @StringToDoubleConverter()
  final double enrollmentCount;
  @override
  @JsonKey(name: 'comp_class_type')
  final String? compClassType;
  @override
  final String? subject;
  @override
  @JsonKey(name: 'teacher_id')
  final int? teacherId;
  @override
  @JsonKey(name: 'teacher_name')
  final String? teacherName;
  // JOIN으로 가져옴
  @override
  @JsonKey(name: 'class_name1')
  final String? className1;
  @override
  @JsonKey(name: 'class_type_id')
  final int? classTypeId;
  @override
  @JsonKey(name: 'class_type_name')
  final String? classTypeName;
  // JOIN으로 가져옴
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'MgmtData(mgmtDataId: $mgmtDataId, year: $year, month: $month, studentId: $studentId, studentName: $studentName, schoolId: $schoolId, schoolName: $schoolName, grade: $grade, enrollmentCount: $enrollmentCount, compClassType: $compClassType, subject: $subject, teacherId: $teacherId, teacherName: $teacherName, className1: $className1, classTypeId: $classTypeId, classTypeName: $classTypeName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MgmtDataImpl &&
            (identical(other.mgmtDataId, mgmtDataId) ||
                other.mgmtDataId == mgmtDataId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.enrollmentCount, enrollmentCount) ||
                other.enrollmentCount == enrollmentCount) &&
            (identical(other.compClassType, compClassType) ||
                other.compClassType == compClassType) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            (identical(other.className1, className1) ||
                other.className1 == className1) &&
            (identical(other.classTypeId, classTypeId) ||
                other.classTypeId == classTypeId) &&
            (identical(other.classTypeName, classTypeName) ||
                other.classTypeName == classTypeName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mgmtDataId,
    year,
    month,
    studentId,
    studentName,
    schoolId,
    schoolName,
    grade,
    enrollmentCount,
    compClassType,
    subject,
    teacherId,
    teacherName,
    className1,
    classTypeId,
    classTypeName,
    createdAt,
  );

  /// Create a copy of MgmtData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MgmtDataImplCopyWith<_$MgmtDataImpl> get copyWith =>
      __$$MgmtDataImplCopyWithImpl<_$MgmtDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MgmtDataImplToJson(this);
  }
}

abstract class _MgmtData extends MgmtData {
  const factory _MgmtData({
    @JsonKey(name: 'mgmt_data_id') required final int mgmtDataId,
    required final int year,
    required final int month,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'student_name') final String? studentName,
    @JsonKey(name: 'school_id') final int? schoolId,
    @JsonKey(name: 'school_name') final String? schoolName,
    final int? grade,
    @JsonKey(name: 'enrollment_count')
    @StringToDoubleConverter()
    final double enrollmentCount,
    @JsonKey(name: 'comp_class_type') final String? compClassType,
    final String? subject,
    @JsonKey(name: 'teacher_id') final int? teacherId,
    @JsonKey(name: 'teacher_name') final String? teacherName,
    @JsonKey(name: 'class_name1') final String? className1,
    @JsonKey(name: 'class_type_id') final int? classTypeId,
    @JsonKey(name: 'class_type_name') final String? classTypeName,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$MgmtDataImpl;
  const _MgmtData._() : super._();

  factory _MgmtData.fromJson(Map<String, dynamic> json) =
      _$MgmtDataImpl.fromJson;

  @override
  @JsonKey(name: 'mgmt_data_id')
  int get mgmtDataId;
  @override
  int get year;
  @override
  int get month;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'student_name')
  String? get studentName; // JOIN으로 가져옴
  @override
  @JsonKey(name: 'school_id')
  int? get schoolId;
  @override
  @JsonKey(name: 'school_name')
  String? get schoolName; // JOIN으로 가져옴
  @override
  int? get grade; // 1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3
  @override
  @JsonKey(name: 'enrollment_count')
  @StringToDoubleConverter()
  double get enrollmentCount;
  @override
  @JsonKey(name: 'comp_class_type')
  String? get compClassType;
  @override
  String? get subject;
  @override
  @JsonKey(name: 'teacher_id')
  int? get teacherId;
  @override
  @JsonKey(name: 'teacher_name')
  String? get teacherName; // JOIN으로 가져옴
  @override
  @JsonKey(name: 'class_name1')
  String? get className1;
  @override
  @JsonKey(name: 'class_type_id')
  int? get classTypeId;
  @override
  @JsonKey(name: 'class_type_name')
  String? get classTypeName; // JOIN으로 가져옴
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of MgmtData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MgmtDataImplCopyWith<_$MgmtDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YearMonth _$YearMonthFromJson(Map<String, dynamic> json) {
  return _YearMonth.fromJson(json);
}

/// @nodoc
mixin _$YearMonth {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;

  /// Serializes this YearMonth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearMonthCopyWith<YearMonth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearMonthCopyWith<$Res> {
  factory $YearMonthCopyWith(YearMonth value, $Res Function(YearMonth) then) =
      _$YearMonthCopyWithImpl<$Res, YearMonth>;
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class _$YearMonthCopyWithImpl<$Res, $Val extends YearMonth>
    implements $YearMonthCopyWith<$Res> {
  _$YearMonthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YearMonthImplCopyWith<$Res>
    implements $YearMonthCopyWith<$Res> {
  factory _$$YearMonthImplCopyWith(
    _$YearMonthImpl value,
    $Res Function(_$YearMonthImpl) then,
  ) = __$$YearMonthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class __$$YearMonthImplCopyWithImpl<$Res>
    extends _$YearMonthCopyWithImpl<$Res, _$YearMonthImpl>
    implements _$$YearMonthImplCopyWith<$Res> {
  __$$YearMonthImplCopyWithImpl(
    _$YearMonthImpl _value,
    $Res Function(_$YearMonthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _$YearMonthImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearMonthImpl implements _YearMonth {
  const _$YearMonthImpl({required this.year, required this.month});

  factory _$YearMonthImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearMonthImplFromJson(json);

  @override
  final int year;
  @override
  final int month;

  @override
  String toString() {
    return 'YearMonth(year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearMonthImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, month);

  /// Create a copy of YearMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearMonthImplCopyWith<_$YearMonthImpl> get copyWith =>
      __$$YearMonthImplCopyWithImpl<_$YearMonthImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YearMonthImplToJson(this);
  }
}

abstract class _YearMonth implements YearMonth {
  const factory _YearMonth({
    required final int year,
    required final int month,
  }) = _$YearMonthImpl;

  factory _YearMonth.fromJson(Map<String, dynamic> json) =
      _$YearMonthImpl.fromJson;

  @override
  int get year;
  @override
  int get month;

  /// Create a copy of YearMonth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearMonthImplCopyWith<_$YearMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
