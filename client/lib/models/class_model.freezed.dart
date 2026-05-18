// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassModel _$ClassModelFromJson(Map<String, dynamic> json) {
  return _ClassModel.fromJson(json);
}

/// @nodoc
mixin _$ClassModel {
  @JsonKey(name: 'class_id')
  int get classId => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_name')
  String get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_id')
  int get genreId => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_name')
  String? get genreName => throw _privateConstructorUsedError;
  @JsonKey(name: 'reg_dt')
  String get regDt => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'grade_name')
  String? get gradeName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int? get curriculum => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int? get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_name')
  String? get levelName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int? get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  int? get monthlyFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_dates')
  String? get lectureDates => throw _privateConstructorUsedError;
  List<ClassTeacher>? get teachers => throw _privateConstructorUsedError;

  /// Serializes this ClassModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassModelCopyWith<ClassModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassModelCopyWith<$Res> {
  factory $ClassModelCopyWith(
    ClassModel value,
    $Res Function(ClassModel) then,
  ) = _$ClassModelCopyWithImpl<$Res, ClassModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    @JsonKey(name: 'class_name') String className,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'genre_id') int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') String regDt,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @FlexibleIntConverter() int? curriculum,
    @FlexibleIntConverter() int? level,
    @JsonKey(name: 'level_name') String? levelName,
    @FlexibleIntConverter() int? year,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
    @JsonKey(name: 'lecture_dates') String? lectureDates,
    List<ClassTeacher>? teachers,
  });
}

/// @nodoc
class _$ClassModelCopyWithImpl<$Res, $Val extends ClassModel>
    implements $ClassModelCopyWith<$Res> {
  _$ClassModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? className = null,
    Object? isActive = null,
    Object? genreId = null,
    Object? genreName = freezed,
    Object? regDt = null,
    Object? grade = freezed,
    Object? gradeName = freezed,
    Object? curriculum = freezed,
    Object? level = freezed,
    Object? levelName = freezed,
    Object? year = freezed,
    Object? monthlyFee = freezed,
    Object? lectureDates = freezed,
    Object? teachers = freezed,
  }) {
    return _then(
      _value.copyWith(
            classId: null == classId
                ? _value.classId
                : classId // ignore: cast_nullable_to_non_nullable
                      as int,
            className: null == className
                ? _value.className
                : className // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as int,
            genreId: null == genreId
                ? _value.genreId
                : genreId // ignore: cast_nullable_to_non_nullable
                      as int,
            genreName: freezed == genreName
                ? _value.genreName
                : genreName // ignore: cast_nullable_to_non_nullable
                      as String?,
            regDt: null == regDt
                ? _value.regDt
                : regDt // ignore: cast_nullable_to_non_nullable
                      as String,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            gradeName: freezed == gradeName
                ? _value.gradeName
                : gradeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            curriculum: freezed == curriculum
                ? _value.curriculum
                : curriculum // ignore: cast_nullable_to_non_nullable
                      as int?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int?,
            levelName: freezed == levelName
                ? _value.levelName
                : levelName // ignore: cast_nullable_to_non_nullable
                      as String?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            monthlyFee: freezed == monthlyFee
                ? _value.monthlyFee
                : monthlyFee // ignore: cast_nullable_to_non_nullable
                      as int?,
            lectureDates: freezed == lectureDates
                ? _value.lectureDates
                : lectureDates // ignore: cast_nullable_to_non_nullable
                      as String?,
            teachers: freezed == teachers
                ? _value.teachers
                : teachers // ignore: cast_nullable_to_non_nullable
                      as List<ClassTeacher>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassModelImplCopyWith<$Res>
    implements $ClassModelCopyWith<$Res> {
  factory _$$ClassModelImplCopyWith(
    _$ClassModelImpl value,
    $Res Function(_$ClassModelImpl) then,
  ) = __$$ClassModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    @JsonKey(name: 'class_name') String className,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'genre_id') int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') String regDt,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @FlexibleIntConverter() int? curriculum,
    @FlexibleIntConverter() int? level,
    @JsonKey(name: 'level_name') String? levelName,
    @FlexibleIntConverter() int? year,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
    @JsonKey(name: 'lecture_dates') String? lectureDates,
    List<ClassTeacher>? teachers,
  });
}

/// @nodoc
class __$$ClassModelImplCopyWithImpl<$Res>
    extends _$ClassModelCopyWithImpl<$Res, _$ClassModelImpl>
    implements _$$ClassModelImplCopyWith<$Res> {
  __$$ClassModelImplCopyWithImpl(
    _$ClassModelImpl _value,
    $Res Function(_$ClassModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? className = null,
    Object? isActive = null,
    Object? genreId = null,
    Object? genreName = freezed,
    Object? regDt = null,
    Object? grade = freezed,
    Object? gradeName = freezed,
    Object? curriculum = freezed,
    Object? level = freezed,
    Object? levelName = freezed,
    Object? year = freezed,
    Object? monthlyFee = freezed,
    Object? lectureDates = freezed,
    Object? teachers = freezed,
  }) {
    return _then(
      _$ClassModelImpl(
        classId: null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as int,
        className: null == className
            ? _value.className
            : className // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as int,
        genreId: null == genreId
            ? _value.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int,
        genreName: freezed == genreName
            ? _value.genreName
            : genreName // ignore: cast_nullable_to_non_nullable
                  as String?,
        regDt: null == regDt
            ? _value.regDt
            : regDt // ignore: cast_nullable_to_non_nullable
                  as String,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        gradeName: freezed == gradeName
            ? _value.gradeName
            : gradeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        curriculum: freezed == curriculum
            ? _value.curriculum
            : curriculum // ignore: cast_nullable_to_non_nullable
                  as int?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int?,
        levelName: freezed == levelName
            ? _value.levelName
            : levelName // ignore: cast_nullable_to_non_nullable
                  as String?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        monthlyFee: freezed == monthlyFee
            ? _value.monthlyFee
            : monthlyFee // ignore: cast_nullable_to_non_nullable
                  as int?,
        lectureDates: freezed == lectureDates
            ? _value.lectureDates
            : lectureDates // ignore: cast_nullable_to_non_nullable
                  as String?,
        teachers: freezed == teachers
            ? _value._teachers
            : teachers // ignore: cast_nullable_to_non_nullable
                  as List<ClassTeacher>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassModelImpl implements _ClassModel {
  const _$ClassModelImpl({
    @JsonKey(name: 'class_id') required this.classId,
    @JsonKey(name: 'class_name') required this.className,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'genre_id') required this.genreId,
    @JsonKey(name: 'genre_name') this.genreName,
    @JsonKey(name: 'reg_dt') required this.regDt,
    @FlexibleIntConverter() this.grade,
    @JsonKey(name: 'grade_name') this.gradeName,
    @FlexibleIntConverter() this.curriculum,
    @FlexibleIntConverter() this.level,
    @JsonKey(name: 'level_name') this.levelName,
    @FlexibleIntConverter() this.year,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() this.monthlyFee,
    @JsonKey(name: 'lecture_dates') this.lectureDates,
    final List<ClassTeacher>? teachers,
  }) : _teachers = teachers;

  factory _$ClassModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassModelImplFromJson(json);

  @override
  @JsonKey(name: 'class_id')
  final int classId;
  @override
  @JsonKey(name: 'class_name')
  final String className;
  @override
  @JsonKey(name: 'is_active')
  final int isActive;
  @override
  @JsonKey(name: 'genre_id')
  final int genreId;
  @override
  @JsonKey(name: 'genre_name')
  final String? genreName;
  @override
  @JsonKey(name: 'reg_dt')
  final String regDt;
  @override
  @FlexibleIntConverter()
  final int? grade;
  @override
  @JsonKey(name: 'grade_name')
  final String? gradeName;
  @override
  @FlexibleIntConverter()
  final int? curriculum;
  @override
  @FlexibleIntConverter()
  final int? level;
  @override
  @JsonKey(name: 'level_name')
  final String? levelName;
  @override
  @FlexibleIntConverter()
  final int? year;
  @override
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  final int? monthlyFee;
  @override
  @JsonKey(name: 'lecture_dates')
  final String? lectureDates;
  final List<ClassTeacher>? _teachers;
  @override
  List<ClassTeacher>? get teachers {
    final value = _teachers;
    if (value == null) return null;
    if (_teachers is EqualUnmodifiableListView) return _teachers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ClassModel(classId: $classId, className: $className, isActive: $isActive, genreId: $genreId, genreName: $genreName, regDt: $regDt, grade: $grade, gradeName: $gradeName, curriculum: $curriculum, level: $level, levelName: $levelName, year: $year, monthlyFee: $monthlyFee, lectureDates: $lectureDates, teachers: $teachers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassModelImpl &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.genreName, genreName) ||
                other.genreName == genreName) &&
            (identical(other.regDt, regDt) || other.regDt == regDt) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.gradeName, gradeName) ||
                other.gradeName == gradeName) &&
            (identical(other.curriculum, curriculum) ||
                other.curriculum == curriculum) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.monthlyFee, monthlyFee) ||
                other.monthlyFee == monthlyFee) &&
            (identical(other.lectureDates, lectureDates) ||
                other.lectureDates == lectureDates) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classId,
    className,
    isActive,
    genreId,
    genreName,
    regDt,
    grade,
    gradeName,
    curriculum,
    level,
    levelName,
    year,
    monthlyFee,
    lectureDates,
    const DeepCollectionEquality().hash(_teachers),
  );

  /// Create a copy of ClassModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassModelImplCopyWith<_$ClassModelImpl> get copyWith =>
      __$$ClassModelImplCopyWithImpl<_$ClassModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassModelImplToJson(this);
  }
}

abstract class _ClassModel implements ClassModel {
  const factory _ClassModel({
    @JsonKey(name: 'class_id') required final int classId,
    @JsonKey(name: 'class_name') required final String className,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'genre_id') required final int genreId,
    @JsonKey(name: 'genre_name') final String? genreName,
    @JsonKey(name: 'reg_dt') required final String regDt,
    @FlexibleIntConverter() final int? grade,
    @JsonKey(name: 'grade_name') final String? gradeName,
    @FlexibleIntConverter() final int? curriculum,
    @FlexibleIntConverter() final int? level,
    @JsonKey(name: 'level_name') final String? levelName,
    @FlexibleIntConverter() final int? year,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() final int? monthlyFee,
    @JsonKey(name: 'lecture_dates') final String? lectureDates,
    final List<ClassTeacher>? teachers,
  }) = _$ClassModelImpl;

  factory _ClassModel.fromJson(Map<String, dynamic> json) =
      _$ClassModelImpl.fromJson;

  @override
  @JsonKey(name: 'class_id')
  int get classId;
  @override
  @JsonKey(name: 'class_name')
  String get className;
  @override
  @JsonKey(name: 'is_active')
  int get isActive;
  @override
  @JsonKey(name: 'genre_id')
  int get genreId;
  @override
  @JsonKey(name: 'genre_name')
  String? get genreName;
  @override
  @JsonKey(name: 'reg_dt')
  String get regDt;
  @override
  @FlexibleIntConverter()
  int? get grade;
  @override
  @JsonKey(name: 'grade_name')
  String? get gradeName;
  @override
  @FlexibleIntConverter()
  int? get curriculum;
  @override
  @FlexibleIntConverter()
  int? get level;
  @override
  @JsonKey(name: 'level_name')
  String? get levelName;
  @override
  @FlexibleIntConverter()
  int? get year;
  @override
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  int? get monthlyFee;
  @override
  @JsonKey(name: 'lecture_dates')
  String? get lectureDates;
  @override
  List<ClassTeacher>? get teachers;

  /// Create a copy of ClassModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassModelImplCopyWith<_$ClassModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassDetail _$ClassDetailFromJson(Map<String, dynamic> json) {
  return _ClassDetail.fromJson(json);
}

/// @nodoc
mixin _$ClassDetail {
  @JsonKey(name: 'class_id')
  int get classId => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_name')
  String get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_id')
  int get genreId => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_name')
  String? get genreName => throw _privateConstructorUsedError;
  @JsonKey(name: 'reg_dt')
  String get regDt => throw _privateConstructorUsedError;
  ClassInfo get info => throw _privateConstructorUsedError;
  List<ClassMember> get teachers => throw _privateConstructorUsedError;
  List<ClassMember> get students => throw _privateConstructorUsedError;

  /// Serializes this ClassDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassDetailCopyWith<ClassDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassDetailCopyWith<$Res> {
  factory $ClassDetailCopyWith(
    ClassDetail value,
    $Res Function(ClassDetail) then,
  ) = _$ClassDetailCopyWithImpl<$Res, ClassDetail>;
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    @JsonKey(name: 'class_name') String className,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'genre_id') int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') String regDt,
    ClassInfo info,
    List<ClassMember> teachers,
    List<ClassMember> students,
  });

  $ClassInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$ClassDetailCopyWithImpl<$Res, $Val extends ClassDetail>
    implements $ClassDetailCopyWith<$Res> {
  _$ClassDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? className = null,
    Object? isActive = null,
    Object? genreId = null,
    Object? genreName = freezed,
    Object? regDt = null,
    Object? info = null,
    Object? teachers = null,
    Object? students = null,
  }) {
    return _then(
      _value.copyWith(
            classId: null == classId
                ? _value.classId
                : classId // ignore: cast_nullable_to_non_nullable
                      as int,
            className: null == className
                ? _value.className
                : className // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as int,
            genreId: null == genreId
                ? _value.genreId
                : genreId // ignore: cast_nullable_to_non_nullable
                      as int,
            genreName: freezed == genreName
                ? _value.genreName
                : genreName // ignore: cast_nullable_to_non_nullable
                      as String?,
            regDt: null == regDt
                ? _value.regDt
                : regDt // ignore: cast_nullable_to_non_nullable
                      as String,
            info: null == info
                ? _value.info
                : info // ignore: cast_nullable_to_non_nullable
                      as ClassInfo,
            teachers: null == teachers
                ? _value.teachers
                : teachers // ignore: cast_nullable_to_non_nullable
                      as List<ClassMember>,
            students: null == students
                ? _value.students
                : students // ignore: cast_nullable_to_non_nullable
                      as List<ClassMember>,
          )
          as $Val,
    );
  }

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClassInfoCopyWith<$Res> get info {
    return $ClassInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClassDetailImplCopyWith<$Res>
    implements $ClassDetailCopyWith<$Res> {
  factory _$$ClassDetailImplCopyWith(
    _$ClassDetailImpl value,
    $Res Function(_$ClassDetailImpl) then,
  ) = __$$ClassDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    @JsonKey(name: 'class_name') String className,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'genre_id') int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') String regDt,
    ClassInfo info,
    List<ClassMember> teachers,
    List<ClassMember> students,
  });

  @override
  $ClassInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$ClassDetailImplCopyWithImpl<$Res>
    extends _$ClassDetailCopyWithImpl<$Res, _$ClassDetailImpl>
    implements _$$ClassDetailImplCopyWith<$Res> {
  __$$ClassDetailImplCopyWithImpl(
    _$ClassDetailImpl _value,
    $Res Function(_$ClassDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? className = null,
    Object? isActive = null,
    Object? genreId = null,
    Object? genreName = freezed,
    Object? regDt = null,
    Object? info = null,
    Object? teachers = null,
    Object? students = null,
  }) {
    return _then(
      _$ClassDetailImpl(
        classId: null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as int,
        className: null == className
            ? _value.className
            : className // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as int,
        genreId: null == genreId
            ? _value.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int,
        genreName: freezed == genreName
            ? _value.genreName
            : genreName // ignore: cast_nullable_to_non_nullable
                  as String?,
        regDt: null == regDt
            ? _value.regDt
            : regDt // ignore: cast_nullable_to_non_nullable
                  as String,
        info: null == info
            ? _value.info
            : info // ignore: cast_nullable_to_non_nullable
                  as ClassInfo,
        teachers: null == teachers
            ? _value._teachers
            : teachers // ignore: cast_nullable_to_non_nullable
                  as List<ClassMember>,
        students: null == students
            ? _value._students
            : students // ignore: cast_nullable_to_non_nullable
                  as List<ClassMember>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassDetailImpl implements _ClassDetail {
  const _$ClassDetailImpl({
    @JsonKey(name: 'class_id') required this.classId,
    @JsonKey(name: 'class_name') required this.className,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'genre_id') required this.genreId,
    @JsonKey(name: 'genre_name') this.genreName,
    @JsonKey(name: 'reg_dt') required this.regDt,
    required this.info,
    required final List<ClassMember> teachers,
    required final List<ClassMember> students,
  }) : _teachers = teachers,
       _students = students;

  factory _$ClassDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassDetailImplFromJson(json);

  @override
  @JsonKey(name: 'class_id')
  final int classId;
  @override
  @JsonKey(name: 'class_name')
  final String className;
  @override
  @JsonKey(name: 'is_active')
  final int isActive;
  @override
  @JsonKey(name: 'genre_id')
  final int genreId;
  @override
  @JsonKey(name: 'genre_name')
  final String? genreName;
  @override
  @JsonKey(name: 'reg_dt')
  final String regDt;
  @override
  final ClassInfo info;
  final List<ClassMember> _teachers;
  @override
  List<ClassMember> get teachers {
    if (_teachers is EqualUnmodifiableListView) return _teachers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teachers);
  }

  final List<ClassMember> _students;
  @override
  List<ClassMember> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  String toString() {
    return 'ClassDetail(classId: $classId, className: $className, isActive: $isActive, genreId: $genreId, genreName: $genreName, regDt: $regDt, info: $info, teachers: $teachers, students: $students)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassDetailImpl &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.genreName, genreName) ||
                other.genreName == genreName) &&
            (identical(other.regDt, regDt) || other.regDt == regDt) &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers) &&
            const DeepCollectionEquality().equals(other._students, _students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classId,
    className,
    isActive,
    genreId,
    genreName,
    regDt,
    info,
    const DeepCollectionEquality().hash(_teachers),
    const DeepCollectionEquality().hash(_students),
  );

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassDetailImplCopyWith<_$ClassDetailImpl> get copyWith =>
      __$$ClassDetailImplCopyWithImpl<_$ClassDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassDetailImplToJson(this);
  }
}

abstract class _ClassDetail implements ClassDetail {
  const factory _ClassDetail({
    @JsonKey(name: 'class_id') required final int classId,
    @JsonKey(name: 'class_name') required final String className,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'genre_id') required final int genreId,
    @JsonKey(name: 'genre_name') final String? genreName,
    @JsonKey(name: 'reg_dt') required final String regDt,
    required final ClassInfo info,
    required final List<ClassMember> teachers,
    required final List<ClassMember> students,
  }) = _$ClassDetailImpl;

  factory _ClassDetail.fromJson(Map<String, dynamic> json) =
      _$ClassDetailImpl.fromJson;

  @override
  @JsonKey(name: 'class_id')
  int get classId;
  @override
  @JsonKey(name: 'class_name')
  String get className;
  @override
  @JsonKey(name: 'is_active')
  int get isActive;
  @override
  @JsonKey(name: 'genre_id')
  int get genreId;
  @override
  @JsonKey(name: 'genre_name')
  String? get genreName;
  @override
  @JsonKey(name: 'reg_dt')
  String get regDt;
  @override
  ClassInfo get info;
  @override
  List<ClassMember> get teachers;
  @override
  List<ClassMember> get students;

  /// Create a copy of ClassDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassDetailImplCopyWith<_$ClassDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassInfo _$ClassInfoFromJson(Map<String, dynamic> json) {
  return _ClassInfo.fromJson(json);
}

/// @nodoc
mixin _$ClassInfo {
  @JsonKey(name: 'class_id')
  int get classId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  int get curriculum => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_start')
  String? get termStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_end')
  String? get termEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_date1')
  String? get lectureDate1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_date2')
  String? get lectureDate2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_date3')
  String? get lectureDate3 => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_date4')
  String? get lectureDate4 => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_date5')
  String? get lectureDate5 => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  int? get monthlyFee => throw _privateConstructorUsedError;

  /// Serializes this ClassInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassInfoCopyWith<ClassInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassInfoCopyWith<$Res> {
  factory $ClassInfoCopyWith(ClassInfo value, $Res Function(ClassInfo) then) =
      _$ClassInfoCopyWithImpl<$Res, ClassInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    int grade,
    int curriculum,
    int level,
    int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_date1') String? lectureDate1,
    @JsonKey(name: 'lecture_date2') String? lectureDate2,
    @JsonKey(name: 'lecture_date3') String? lectureDate3,
    @JsonKey(name: 'lecture_date4') String? lectureDate4,
    @JsonKey(name: 'lecture_date5') String? lectureDate5,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
  });
}

/// @nodoc
class _$ClassInfoCopyWithImpl<$Res, $Val extends ClassInfo>
    implements $ClassInfoCopyWith<$Res> {
  _$ClassInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? grade = null,
    Object? curriculum = null,
    Object? level = null,
    Object? year = null,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDate1 = freezed,
    Object? lectureDate2 = freezed,
    Object? lectureDate3 = freezed,
    Object? lectureDate4 = freezed,
    Object? lectureDate5 = freezed,
    Object? monthlyFee = freezed,
  }) {
    return _then(
      _value.copyWith(
            classId: null == classId
                ? _value.classId
                : classId // ignore: cast_nullable_to_non_nullable
                      as int,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            curriculum: null == curriculum
                ? _value.curriculum
                : curriculum // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            termStart: freezed == termStart
                ? _value.termStart
                : termStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            termEnd: freezed == termEnd
                ? _value.termEnd
                : termEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDate1: freezed == lectureDate1
                ? _value.lectureDate1
                : lectureDate1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDate2: freezed == lectureDate2
                ? _value.lectureDate2
                : lectureDate2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDate3: freezed == lectureDate3
                ? _value.lectureDate3
                : lectureDate3 // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDate4: freezed == lectureDate4
                ? _value.lectureDate4
                : lectureDate4 // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDate5: freezed == lectureDate5
                ? _value.lectureDate5
                : lectureDate5 // ignore: cast_nullable_to_non_nullable
                      as String?,
            monthlyFee: freezed == monthlyFee
                ? _value.monthlyFee
                : monthlyFee // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassInfoImplCopyWith<$Res>
    implements $ClassInfoCopyWith<$Res> {
  factory _$$ClassInfoImplCopyWith(
    _$ClassInfoImpl value,
    $Res Function(_$ClassInfoImpl) then,
  ) = __$$ClassInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'class_id') int classId,
    int grade,
    int curriculum,
    int level,
    int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_date1') String? lectureDate1,
    @JsonKey(name: 'lecture_date2') String? lectureDate2,
    @JsonKey(name: 'lecture_date3') String? lectureDate3,
    @JsonKey(name: 'lecture_date4') String? lectureDate4,
    @JsonKey(name: 'lecture_date5') String? lectureDate5,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
  });
}

/// @nodoc
class __$$ClassInfoImplCopyWithImpl<$Res>
    extends _$ClassInfoCopyWithImpl<$Res, _$ClassInfoImpl>
    implements _$$ClassInfoImplCopyWith<$Res> {
  __$$ClassInfoImplCopyWithImpl(
    _$ClassInfoImpl _value,
    $Res Function(_$ClassInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? grade = null,
    Object? curriculum = null,
    Object? level = null,
    Object? year = null,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDate1 = freezed,
    Object? lectureDate2 = freezed,
    Object? lectureDate3 = freezed,
    Object? lectureDate4 = freezed,
    Object? lectureDate5 = freezed,
    Object? monthlyFee = freezed,
  }) {
    return _then(
      _$ClassInfoImpl(
        classId: null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as int,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        curriculum: null == curriculum
            ? _value.curriculum
            : curriculum // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        termStart: freezed == termStart
            ? _value.termStart
            : termStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        termEnd: freezed == termEnd
            ? _value.termEnd
            : termEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDate1: freezed == lectureDate1
            ? _value.lectureDate1
            : lectureDate1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDate2: freezed == lectureDate2
            ? _value.lectureDate2
            : lectureDate2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDate3: freezed == lectureDate3
            ? _value.lectureDate3
            : lectureDate3 // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDate4: freezed == lectureDate4
            ? _value.lectureDate4
            : lectureDate4 // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDate5: freezed == lectureDate5
            ? _value.lectureDate5
            : lectureDate5 // ignore: cast_nullable_to_non_nullable
                  as String?,
        monthlyFee: freezed == monthlyFee
            ? _value.monthlyFee
            : monthlyFee // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassInfoImpl implements _ClassInfo {
  const _$ClassInfoImpl({
    @JsonKey(name: 'class_id') required this.classId,
    required this.grade,
    required this.curriculum,
    required this.level,
    required this.year,
    @JsonKey(name: 'term_start') this.termStart,
    @JsonKey(name: 'term_end') this.termEnd,
    @JsonKey(name: 'lecture_date1') this.lectureDate1,
    @JsonKey(name: 'lecture_date2') this.lectureDate2,
    @JsonKey(name: 'lecture_date3') this.lectureDate3,
    @JsonKey(name: 'lecture_date4') this.lectureDate4,
    @JsonKey(name: 'lecture_date5') this.lectureDate5,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() this.monthlyFee,
  });

  factory _$ClassInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassInfoImplFromJson(json);

  @override
  @JsonKey(name: 'class_id')
  final int classId;
  @override
  final int grade;
  @override
  final int curriculum;
  @override
  final int level;
  @override
  final int year;
  @override
  @JsonKey(name: 'term_start')
  final String? termStart;
  @override
  @JsonKey(name: 'term_end')
  final String? termEnd;
  @override
  @JsonKey(name: 'lecture_date1')
  final String? lectureDate1;
  @override
  @JsonKey(name: 'lecture_date2')
  final String? lectureDate2;
  @override
  @JsonKey(name: 'lecture_date3')
  final String? lectureDate3;
  @override
  @JsonKey(name: 'lecture_date4')
  final String? lectureDate4;
  @override
  @JsonKey(name: 'lecture_date5')
  final String? lectureDate5;
  @override
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  final int? monthlyFee;

  @override
  String toString() {
    return 'ClassInfo(classId: $classId, grade: $grade, curriculum: $curriculum, level: $level, year: $year, termStart: $termStart, termEnd: $termEnd, lectureDate1: $lectureDate1, lectureDate2: $lectureDate2, lectureDate3: $lectureDate3, lectureDate4: $lectureDate4, lectureDate5: $lectureDate5, monthlyFee: $monthlyFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassInfoImpl &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.curriculum, curriculum) ||
                other.curriculum == curriculum) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.termStart, termStart) ||
                other.termStart == termStart) &&
            (identical(other.termEnd, termEnd) || other.termEnd == termEnd) &&
            (identical(other.lectureDate1, lectureDate1) ||
                other.lectureDate1 == lectureDate1) &&
            (identical(other.lectureDate2, lectureDate2) ||
                other.lectureDate2 == lectureDate2) &&
            (identical(other.lectureDate3, lectureDate3) ||
                other.lectureDate3 == lectureDate3) &&
            (identical(other.lectureDate4, lectureDate4) ||
                other.lectureDate4 == lectureDate4) &&
            (identical(other.lectureDate5, lectureDate5) ||
                other.lectureDate5 == lectureDate5) &&
            (identical(other.monthlyFee, monthlyFee) ||
                other.monthlyFee == monthlyFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classId,
    grade,
    curriculum,
    level,
    year,
    termStart,
    termEnd,
    lectureDate1,
    lectureDate2,
    lectureDate3,
    lectureDate4,
    lectureDate5,
    monthlyFee,
  );

  /// Create a copy of ClassInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassInfoImplCopyWith<_$ClassInfoImpl> get copyWith =>
      __$$ClassInfoImplCopyWithImpl<_$ClassInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassInfoImplToJson(this);
  }
}

abstract class _ClassInfo implements ClassInfo {
  const factory _ClassInfo({
    @JsonKey(name: 'class_id') required final int classId,
    required final int grade,
    required final int curriculum,
    required final int level,
    required final int year,
    @JsonKey(name: 'term_start') final String? termStart,
    @JsonKey(name: 'term_end') final String? termEnd,
    @JsonKey(name: 'lecture_date1') final String? lectureDate1,
    @JsonKey(name: 'lecture_date2') final String? lectureDate2,
    @JsonKey(name: 'lecture_date3') final String? lectureDate3,
    @JsonKey(name: 'lecture_date4') final String? lectureDate4,
    @JsonKey(name: 'lecture_date5') final String? lectureDate5,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() final int? monthlyFee,
  }) = _$ClassInfoImpl;

  factory _ClassInfo.fromJson(Map<String, dynamic> json) =
      _$ClassInfoImpl.fromJson;

  @override
  @JsonKey(name: 'class_id')
  int get classId;
  @override
  int get grade;
  @override
  int get curriculum;
  @override
  int get level;
  @override
  int get year;
  @override
  @JsonKey(name: 'term_start')
  String? get termStart;
  @override
  @JsonKey(name: 'term_end')
  String? get termEnd;
  @override
  @JsonKey(name: 'lecture_date1')
  String? get lectureDate1;
  @override
  @JsonKey(name: 'lecture_date2')
  String? get lectureDate2;
  @override
  @JsonKey(name: 'lecture_date3')
  String? get lectureDate3;
  @override
  @JsonKey(name: 'lecture_date4')
  String? get lectureDate4;
  @override
  @JsonKey(name: 'lecture_date5')
  String? get lectureDate5;
  @override
  @JsonKey(name: 'monthly_fee')
  @FlexibleIntConverter()
  int? get monthlyFee;

  /// Create a copy of ClassInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassInfoImplCopyWith<_$ClassInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassMember _$ClassMemberFromJson(Map<String, dynamic> json) {
  return _ClassMember.fromJson(json);
}

/// @nodoc
mixin _$ClassMember {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_id')
  int get classId => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError; // 2=학생, 3=선생님
  @JsonKey(name: 'active_flag')
  int get activeFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this ClassMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassMemberCopyWith<ClassMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassMemberCopyWith<$Res> {
  factory $ClassMemberCopyWith(
    ClassMember value,
    $Res Function(ClassMember) then,
  ) = _$ClassMemberCopyWithImpl<$Res, ClassMember>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'class_id') int classId,
    int kind,
    @JsonKey(name: 'active_flag') int activeFlag,
    @JsonKey(name: 'user_name') String? userName,
    String? phone,
  });
}

/// @nodoc
class _$ClassMemberCopyWithImpl<$Res, $Val extends ClassMember>
    implements $ClassMemberCopyWith<$Res> {
  _$ClassMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? classId = null,
    Object? kind = null,
    Object? activeFlag = null,
    Object? userName = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            classId: null == classId
                ? _value.classId
                : classId // ignore: cast_nullable_to_non_nullable
                      as int,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as int,
            activeFlag: null == activeFlag
                ? _value.activeFlag
                : activeFlag // ignore: cast_nullable_to_non_nullable
                      as int,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassMemberImplCopyWith<$Res>
    implements $ClassMemberCopyWith<$Res> {
  factory _$$ClassMemberImplCopyWith(
    _$ClassMemberImpl value,
    $Res Function(_$ClassMemberImpl) then,
  ) = __$$ClassMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'class_id') int classId,
    int kind,
    @JsonKey(name: 'active_flag') int activeFlag,
    @JsonKey(name: 'user_name') String? userName,
    String? phone,
  });
}

/// @nodoc
class __$$ClassMemberImplCopyWithImpl<$Res>
    extends _$ClassMemberCopyWithImpl<$Res, _$ClassMemberImpl>
    implements _$$ClassMemberImplCopyWith<$Res> {
  __$$ClassMemberImplCopyWithImpl(
    _$ClassMemberImpl _value,
    $Res Function(_$ClassMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? classId = null,
    Object? kind = null,
    Object? activeFlag = null,
    Object? userName = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _$ClassMemberImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        classId: null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as int,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as int,
        activeFlag: null == activeFlag
            ? _value.activeFlag
            : activeFlag // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassMemberImpl implements _ClassMember {
  const _$ClassMemberImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'class_id') required this.classId,
    required this.kind,
    @JsonKey(name: 'active_flag') required this.activeFlag,
    @JsonKey(name: 'user_name') this.userName,
    this.phone,
  });

  factory _$ClassMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassMemberImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'class_id')
  final int classId;
  @override
  final int kind;
  // 2=학생, 3=선생님
  @override
  @JsonKey(name: 'active_flag')
  final int activeFlag;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  final String? phone;

  @override
  String toString() {
    return 'ClassMember(userId: $userId, classId: $classId, kind: $kind, activeFlag: $activeFlag, userName: $userName, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassMemberImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.activeFlag, activeFlag) ||
                other.activeFlag == activeFlag) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    classId,
    kind,
    activeFlag,
    userName,
    phone,
  );

  /// Create a copy of ClassMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassMemberImplCopyWith<_$ClassMemberImpl> get copyWith =>
      __$$ClassMemberImplCopyWithImpl<_$ClassMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassMemberImplToJson(this);
  }
}

abstract class _ClassMember implements ClassMember {
  const factory _ClassMember({
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'class_id') required final int classId,
    required final int kind,
    @JsonKey(name: 'active_flag') required final int activeFlag,
    @JsonKey(name: 'user_name') final String? userName,
    final String? phone,
  }) = _$ClassMemberImpl;

  factory _ClassMember.fromJson(Map<String, dynamic> json) =
      _$ClassMemberImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'class_id')
  int get classId;
  @override
  int get kind; // 2=학생, 3=선생님
  @override
  @JsonKey(name: 'active_flag')
  int get activeFlag;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  String? get phone;

  /// Create a copy of ClassMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassMemberImplCopyWith<_$ClassMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassTeacher _$ClassTeacherFromJson(Map<String, dynamic> json) {
  return _ClassTeacher.fromJson(json);
}

/// @nodoc
mixin _$ClassTeacher {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this ClassTeacher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassTeacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassTeacherCopyWith<ClassTeacher> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassTeacherCopyWith<$Res> {
  factory $ClassTeacherCopyWith(
    ClassTeacher value,
    $Res Function(ClassTeacher) then,
  ) = _$ClassTeacherCopyWithImpl<$Res, ClassTeacher>;
  @useResult
  $Res call({@JsonKey(name: 'user_id') int userId, String name, String? phone});
}

/// @nodoc
class _$ClassTeacherCopyWithImpl<$Res, $Val extends ClassTeacher>
    implements $ClassTeacherCopyWith<$Res> {
  _$ClassTeacherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassTeacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassTeacherImplCopyWith<$Res>
    implements $ClassTeacherCopyWith<$Res> {
  factory _$$ClassTeacherImplCopyWith(
    _$ClassTeacherImpl value,
    $Res Function(_$ClassTeacherImpl) then,
  ) = __$$ClassTeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'user_id') int userId, String name, String? phone});
}

/// @nodoc
class __$$ClassTeacherImplCopyWithImpl<$Res>
    extends _$ClassTeacherCopyWithImpl<$Res, _$ClassTeacherImpl>
    implements _$$ClassTeacherImplCopyWith<$Res> {
  __$$ClassTeacherImplCopyWithImpl(
    _$ClassTeacherImpl _value,
    $Res Function(_$ClassTeacherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassTeacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = freezed,
  }) {
    return _then(
      _$ClassTeacherImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassTeacherImpl implements _ClassTeacher {
  const _$ClassTeacherImpl({
    @JsonKey(name: 'user_id') required this.userId,
    required this.name,
    this.phone,
  });

  factory _$ClassTeacherImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassTeacherImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'ClassTeacher(userId: $userId, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassTeacherImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, name, phone);

  /// Create a copy of ClassTeacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassTeacherImplCopyWith<_$ClassTeacherImpl> get copyWith =>
      __$$ClassTeacherImplCopyWithImpl<_$ClassTeacherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassTeacherImplToJson(this);
  }
}

abstract class _ClassTeacher implements ClassTeacher {
  const factory _ClassTeacher({
    @JsonKey(name: 'user_id') required final int userId,
    required final String name,
    final String? phone,
  }) = _$ClassTeacherImpl;

  factory _ClassTeacher.fromJson(Map<String, dynamic> json) =
      _$ClassTeacherImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get name;
  @override
  String? get phone;

  /// Create a copy of ClassTeacher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassTeacherImplCopyWith<_$ClassTeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LectureDate _$LectureDateFromJson(Map<String, dynamic> json) {
  return _LectureDate.fromJson(json);
}

/// @nodoc
mixin _$LectureDate {
  String get day => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  int get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  int? get endTime => throw _privateConstructorUsedError;

  /// Serializes this LectureDate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LectureDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectureDateCopyWith<LectureDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureDateCopyWith<$Res> {
  factory $LectureDateCopyWith(
    LectureDate value,
    $Res Function(LectureDate) then,
  ) = _$LectureDateCopyWithImpl<$Res, LectureDate>;
  @useResult
  $Res call({
    String day,
    @JsonKey(name: 'start_time') int startTime,
    @JsonKey(name: 'end_time') int? endTime,
  });
}

/// @nodoc
class _$LectureDateCopyWithImpl<$Res, $Val extends LectureDate>
    implements $LectureDateCopyWith<$Res> {
  _$LectureDateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LectureDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? startTime = null,
    Object? endTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            day: null == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as int,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LectureDateImplCopyWith<$Res>
    implements $LectureDateCopyWith<$Res> {
  factory _$$LectureDateImplCopyWith(
    _$LectureDateImpl value,
    $Res Function(_$LectureDateImpl) then,
  ) = __$$LectureDateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String day,
    @JsonKey(name: 'start_time') int startTime,
    @JsonKey(name: 'end_time') int? endTime,
  });
}

/// @nodoc
class __$$LectureDateImplCopyWithImpl<$Res>
    extends _$LectureDateCopyWithImpl<$Res, _$LectureDateImpl>
    implements _$$LectureDateImplCopyWith<$Res> {
  __$$LectureDateImplCopyWithImpl(
    _$LectureDateImpl _value,
    $Res Function(_$LectureDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LectureDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? startTime = null,
    Object? endTime = freezed,
  }) {
    return _then(
      _$LectureDateImpl(
        day: null == day
            ? _value.day
            : day // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as int,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LectureDateImpl implements _LectureDate {
  const _$LectureDateImpl({
    required this.day,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
  });

  factory _$LectureDateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureDateImplFromJson(json);

  @override
  final String day;
  @override
  @JsonKey(name: 'start_time')
  final int startTime;
  @override
  @JsonKey(name: 'end_time')
  final int? endTime;

  @override
  String toString() {
    return 'LectureDate(day: $day, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureDateImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, startTime, endTime);

  /// Create a copy of LectureDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureDateImplCopyWith<_$LectureDateImpl> get copyWith =>
      __$$LectureDateImplCopyWithImpl<_$LectureDateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureDateImplToJson(this);
  }
}

abstract class _LectureDate implements LectureDate {
  const factory _LectureDate({
    required final String day,
    @JsonKey(name: 'start_time') required final int startTime,
    @JsonKey(name: 'end_time') final int? endTime,
  }) = _$LectureDateImpl;

  factory _LectureDate.fromJson(Map<String, dynamic> json) =
      _$LectureDateImpl.fromJson;

  @override
  String get day;
  @override
  @JsonKey(name: 'start_time')
  int get startTime;
  @override
  @JsonKey(name: 'end_time')
  int? get endTime;

  /// Create a copy of LectureDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectureDateImplCopyWith<_$LectureDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassCreate _$ClassCreateFromJson(Map<String, dynamic> json) {
  return _ClassCreate.fromJson(json);
}

/// @nodoc
mixin _$ClassCreate {
  @JsonKey(name: 'genre_id')
  int get genreId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  int get curriculum => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_start')
  String? get termStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_end')
  String? get termEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_dates')
  List<LectureDate> get lectureDates => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_fee')
  int? get monthlyFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_name')
  String? get className => throw _privateConstructorUsedError;

  /// Serializes this ClassCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassCreateCopyWith<ClassCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassCreateCopyWith<$Res> {
  factory $ClassCreateCopyWith(
    ClassCreate value,
    $Res Function(ClassCreate) then,
  ) = _$ClassCreateCopyWithImpl<$Res, ClassCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'genre_id') int genreId,
    int grade,
    int curriculum,
    int level,
    int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') List<LectureDate> lectureDates,
    @JsonKey(name: 'teacher_ids') List<int> teacherIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'class_name') String? className,
  });
}

/// @nodoc
class _$ClassCreateCopyWithImpl<$Res, $Val extends ClassCreate>
    implements $ClassCreateCopyWith<$Res> {
  _$ClassCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genreId = null,
    Object? grade = null,
    Object? curriculum = null,
    Object? level = null,
    Object? year = null,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDates = null,
    Object? teacherIds = null,
    Object? monthlyFee = freezed,
    Object? className = freezed,
  }) {
    return _then(
      _value.copyWith(
            genreId: null == genreId
                ? _value.genreId
                : genreId // ignore: cast_nullable_to_non_nullable
                      as int,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            curriculum: null == curriculum
                ? _value.curriculum
                : curriculum // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            termStart: freezed == termStart
                ? _value.termStart
                : termStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            termEnd: freezed == termEnd
                ? _value.termEnd
                : termEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDates: null == lectureDates
                ? _value.lectureDates
                : lectureDates // ignore: cast_nullable_to_non_nullable
                      as List<LectureDate>,
            teacherIds: null == teacherIds
                ? _value.teacherIds
                : teacherIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            monthlyFee: freezed == monthlyFee
                ? _value.monthlyFee
                : monthlyFee // ignore: cast_nullable_to_non_nullable
                      as int?,
            className: freezed == className
                ? _value.className
                : className // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassCreateImplCopyWith<$Res>
    implements $ClassCreateCopyWith<$Res> {
  factory _$$ClassCreateImplCopyWith(
    _$ClassCreateImpl value,
    $Res Function(_$ClassCreateImpl) then,
  ) = __$$ClassCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'genre_id') int genreId,
    int grade,
    int curriculum,
    int level,
    int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') List<LectureDate> lectureDates,
    @JsonKey(name: 'teacher_ids') List<int> teacherIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'class_name') String? className,
  });
}

/// @nodoc
class __$$ClassCreateImplCopyWithImpl<$Res>
    extends _$ClassCreateCopyWithImpl<$Res, _$ClassCreateImpl>
    implements _$$ClassCreateImplCopyWith<$Res> {
  __$$ClassCreateImplCopyWithImpl(
    _$ClassCreateImpl _value,
    $Res Function(_$ClassCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genreId = null,
    Object? grade = null,
    Object? curriculum = null,
    Object? level = null,
    Object? year = null,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDates = null,
    Object? teacherIds = null,
    Object? monthlyFee = freezed,
    Object? className = freezed,
  }) {
    return _then(
      _$ClassCreateImpl(
        genreId: null == genreId
            ? _value.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        curriculum: null == curriculum
            ? _value.curriculum
            : curriculum // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        termStart: freezed == termStart
            ? _value.termStart
            : termStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        termEnd: freezed == termEnd
            ? _value.termEnd
            : termEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDates: null == lectureDates
            ? _value._lectureDates
            : lectureDates // ignore: cast_nullable_to_non_nullable
                  as List<LectureDate>,
        teacherIds: null == teacherIds
            ? _value._teacherIds
            : teacherIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        monthlyFee: freezed == monthlyFee
            ? _value.monthlyFee
            : monthlyFee // ignore: cast_nullable_to_non_nullable
                  as int?,
        className: freezed == className
            ? _value.className
            : className // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassCreateImpl implements _ClassCreate {
  const _$ClassCreateImpl({
    @JsonKey(name: 'genre_id') required this.genreId,
    required this.grade,
    required this.curriculum,
    required this.level,
    required this.year,
    @JsonKey(name: 'term_start') this.termStart,
    @JsonKey(name: 'term_end') this.termEnd,
    @JsonKey(name: 'lecture_dates')
    required final List<LectureDate> lectureDates,
    @JsonKey(name: 'teacher_ids') required final List<int> teacherIds,
    @JsonKey(name: 'monthly_fee') this.monthlyFee,
    @JsonKey(name: 'class_name') this.className,
  }) : _lectureDates = lectureDates,
       _teacherIds = teacherIds;

  factory _$ClassCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassCreateImplFromJson(json);

  @override
  @JsonKey(name: 'genre_id')
  final int genreId;
  @override
  final int grade;
  @override
  final int curriculum;
  @override
  final int level;
  @override
  final int year;
  @override
  @JsonKey(name: 'term_start')
  final String? termStart;
  @override
  @JsonKey(name: 'term_end')
  final String? termEnd;
  final List<LectureDate> _lectureDates;
  @override
  @JsonKey(name: 'lecture_dates')
  List<LectureDate> get lectureDates {
    if (_lectureDates is EqualUnmodifiableListView) return _lectureDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lectureDates);
  }

  final List<int> _teacherIds;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds {
    if (_teacherIds is EqualUnmodifiableListView) return _teacherIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teacherIds);
  }

  @override
  @JsonKey(name: 'monthly_fee')
  final int? monthlyFee;
  @override
  @JsonKey(name: 'class_name')
  final String? className;

  @override
  String toString() {
    return 'ClassCreate(genreId: $genreId, grade: $grade, curriculum: $curriculum, level: $level, year: $year, termStart: $termStart, termEnd: $termEnd, lectureDates: $lectureDates, teacherIds: $teacherIds, monthlyFee: $monthlyFee, className: $className)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassCreateImpl &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.curriculum, curriculum) ||
                other.curriculum == curriculum) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.termStart, termStart) ||
                other.termStart == termStart) &&
            (identical(other.termEnd, termEnd) || other.termEnd == termEnd) &&
            const DeepCollectionEquality().equals(
              other._lectureDates,
              _lectureDates,
            ) &&
            const DeepCollectionEquality().equals(
              other._teacherIds,
              _teacherIds,
            ) &&
            (identical(other.monthlyFee, monthlyFee) ||
                other.monthlyFee == monthlyFee) &&
            (identical(other.className, className) ||
                other.className == className));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    genreId,
    grade,
    curriculum,
    level,
    year,
    termStart,
    termEnd,
    const DeepCollectionEquality().hash(_lectureDates),
    const DeepCollectionEquality().hash(_teacherIds),
    monthlyFee,
    className,
  );

  /// Create a copy of ClassCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassCreateImplCopyWith<_$ClassCreateImpl> get copyWith =>
      __$$ClassCreateImplCopyWithImpl<_$ClassCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassCreateImplToJson(this);
  }
}

abstract class _ClassCreate implements ClassCreate {
  const factory _ClassCreate({
    @JsonKey(name: 'genre_id') required final int genreId,
    required final int grade,
    required final int curriculum,
    required final int level,
    required final int year,
    @JsonKey(name: 'term_start') final String? termStart,
    @JsonKey(name: 'term_end') final String? termEnd,
    @JsonKey(name: 'lecture_dates')
    required final List<LectureDate> lectureDates,
    @JsonKey(name: 'teacher_ids') required final List<int> teacherIds,
    @JsonKey(name: 'monthly_fee') final int? monthlyFee,
    @JsonKey(name: 'class_name') final String? className,
  }) = _$ClassCreateImpl;

  factory _ClassCreate.fromJson(Map<String, dynamic> json) =
      _$ClassCreateImpl.fromJson;

  @override
  @JsonKey(name: 'genre_id')
  int get genreId;
  @override
  int get grade;
  @override
  int get curriculum;
  @override
  int get level;
  @override
  int get year;
  @override
  @JsonKey(name: 'term_start')
  String? get termStart;
  @override
  @JsonKey(name: 'term_end')
  String? get termEnd;
  @override
  @JsonKey(name: 'lecture_dates')
  List<LectureDate> get lectureDates;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds;
  @override
  @JsonKey(name: 'monthly_fee')
  int? get monthlyFee;
  @override
  @JsonKey(name: 'class_name')
  String? get className;

  /// Create a copy of ClassCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassCreateImplCopyWith<_$ClassCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassUpdate _$ClassUpdateFromJson(Map<String, dynamic> json) {
  return _ClassUpdate.fromJson(json);
}

/// @nodoc
mixin _$ClassUpdate {
  @JsonKey(name: 'genre_id')
  int? get genreId => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  int? get curriculum => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_start')
  String? get termStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'term_end')
  String? get termEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'lecture_dates')
  List<LectureDate>? get lectureDates => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_ids')
  List<int>? get teacherIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_ids')
  List<int>? get studentIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_fee')
  int? get monthlyFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_name')
  String? get className => throw _privateConstructorUsedError;

  /// Serializes this ClassUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassUpdateCopyWith<ClassUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassUpdateCopyWith<$Res> {
  factory $ClassUpdateCopyWith(
    ClassUpdate value,
    $Res Function(ClassUpdate) then,
  ) = _$ClassUpdateCopyWithImpl<$Res, ClassUpdate>;
  @useResult
  $Res call({
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? curriculum,
    int? level,
    int? year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') List<LectureDate>? lectureDates,
    @JsonKey(name: 'teacher_ids') List<int>? teacherIds,
    @JsonKey(name: 'student_ids') List<int>? studentIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'is_active') int? isActive,
    @JsonKey(name: 'class_name') String? className,
  });
}

/// @nodoc
class _$ClassUpdateCopyWithImpl<$Res, $Val extends ClassUpdate>
    implements $ClassUpdateCopyWith<$Res> {
  _$ClassUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genreId = freezed,
    Object? grade = freezed,
    Object? curriculum = freezed,
    Object? level = freezed,
    Object? year = freezed,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDates = freezed,
    Object? teacherIds = freezed,
    Object? studentIds = freezed,
    Object? monthlyFee = freezed,
    Object? isActive = freezed,
    Object? className = freezed,
  }) {
    return _then(
      _value.copyWith(
            genreId: freezed == genreId
                ? _value.genreId
                : genreId // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            curriculum: freezed == curriculum
                ? _value.curriculum
                : curriculum // ignore: cast_nullable_to_non_nullable
                      as int?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            termStart: freezed == termStart
                ? _value.termStart
                : termStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            termEnd: freezed == termEnd
                ? _value.termEnd
                : termEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureDates: freezed == lectureDates
                ? _value.lectureDates
                : lectureDates // ignore: cast_nullable_to_non_nullable
                      as List<LectureDate>?,
            teacherIds: freezed == teacherIds
                ? _value.teacherIds
                : teacherIds // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            studentIds: freezed == studentIds
                ? _value.studentIds
                : studentIds // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            monthlyFee: freezed == monthlyFee
                ? _value.monthlyFee
                : monthlyFee // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as int?,
            className: freezed == className
                ? _value.className
                : className // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassUpdateImplCopyWith<$Res>
    implements $ClassUpdateCopyWith<$Res> {
  factory _$$ClassUpdateImplCopyWith(
    _$ClassUpdateImpl value,
    $Res Function(_$ClassUpdateImpl) then,
  ) = __$$ClassUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? curriculum,
    int? level,
    int? year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') List<LectureDate>? lectureDates,
    @JsonKey(name: 'teacher_ids') List<int>? teacherIds,
    @JsonKey(name: 'student_ids') List<int>? studentIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'is_active') int? isActive,
    @JsonKey(name: 'class_name') String? className,
  });
}

/// @nodoc
class __$$ClassUpdateImplCopyWithImpl<$Res>
    extends _$ClassUpdateCopyWithImpl<$Res, _$ClassUpdateImpl>
    implements _$$ClassUpdateImplCopyWith<$Res> {
  __$$ClassUpdateImplCopyWithImpl(
    _$ClassUpdateImpl _value,
    $Res Function(_$ClassUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genreId = freezed,
    Object? grade = freezed,
    Object? curriculum = freezed,
    Object? level = freezed,
    Object? year = freezed,
    Object? termStart = freezed,
    Object? termEnd = freezed,
    Object? lectureDates = freezed,
    Object? teacherIds = freezed,
    Object? studentIds = freezed,
    Object? monthlyFee = freezed,
    Object? isActive = freezed,
    Object? className = freezed,
  }) {
    return _then(
      _$ClassUpdateImpl(
        genreId: freezed == genreId
            ? _value.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        curriculum: freezed == curriculum
            ? _value.curriculum
            : curriculum // ignore: cast_nullable_to_non_nullable
                  as int?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        termStart: freezed == termStart
            ? _value.termStart
            : termStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        termEnd: freezed == termEnd
            ? _value.termEnd
            : termEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureDates: freezed == lectureDates
            ? _value._lectureDates
            : lectureDates // ignore: cast_nullable_to_non_nullable
                  as List<LectureDate>?,
        teacherIds: freezed == teacherIds
            ? _value._teacherIds
            : teacherIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        studentIds: freezed == studentIds
            ? _value._studentIds
            : studentIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        monthlyFee: freezed == monthlyFee
            ? _value.monthlyFee
            : monthlyFee // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as int?,
        className: freezed == className
            ? _value.className
            : className // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassUpdateImpl implements _ClassUpdate {
  const _$ClassUpdateImpl({
    @JsonKey(name: 'genre_id') this.genreId,
    this.grade,
    this.curriculum,
    this.level,
    this.year,
    @JsonKey(name: 'term_start') this.termStart,
    @JsonKey(name: 'term_end') this.termEnd,
    @JsonKey(name: 'lecture_dates') final List<LectureDate>? lectureDates,
    @JsonKey(name: 'teacher_ids') final List<int>? teacherIds,
    @JsonKey(name: 'student_ids') final List<int>? studentIds,
    @JsonKey(name: 'monthly_fee') this.monthlyFee,
    @JsonKey(name: 'is_active') this.isActive,
    @JsonKey(name: 'class_name') this.className,
  }) : _lectureDates = lectureDates,
       _teacherIds = teacherIds,
       _studentIds = studentIds;

  factory _$ClassUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassUpdateImplFromJson(json);

  @override
  @JsonKey(name: 'genre_id')
  final int? genreId;
  @override
  final int? grade;
  @override
  final int? curriculum;
  @override
  final int? level;
  @override
  final int? year;
  @override
  @JsonKey(name: 'term_start')
  final String? termStart;
  @override
  @JsonKey(name: 'term_end')
  final String? termEnd;
  final List<LectureDate>? _lectureDates;
  @override
  @JsonKey(name: 'lecture_dates')
  List<LectureDate>? get lectureDates {
    final value = _lectureDates;
    if (value == null) return null;
    if (_lectureDates is EqualUnmodifiableListView) return _lectureDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _teacherIds;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int>? get teacherIds {
    final value = _teacherIds;
    if (value == null) return null;
    if (_teacherIds is EqualUnmodifiableListView) return _teacherIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _studentIds;
  @override
  @JsonKey(name: 'student_ids')
  List<int>? get studentIds {
    final value = _studentIds;
    if (value == null) return null;
    if (_studentIds is EqualUnmodifiableListView) return _studentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'monthly_fee')
  final int? monthlyFee;
  @override
  @JsonKey(name: 'is_active')
  final int? isActive;
  @override
  @JsonKey(name: 'class_name')
  final String? className;

  @override
  String toString() {
    return 'ClassUpdate(genreId: $genreId, grade: $grade, curriculum: $curriculum, level: $level, year: $year, termStart: $termStart, termEnd: $termEnd, lectureDates: $lectureDates, teacherIds: $teacherIds, studentIds: $studentIds, monthlyFee: $monthlyFee, isActive: $isActive, className: $className)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassUpdateImpl &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.curriculum, curriculum) ||
                other.curriculum == curriculum) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.termStart, termStart) ||
                other.termStart == termStart) &&
            (identical(other.termEnd, termEnd) || other.termEnd == termEnd) &&
            const DeepCollectionEquality().equals(
              other._lectureDates,
              _lectureDates,
            ) &&
            const DeepCollectionEquality().equals(
              other._teacherIds,
              _teacherIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._studentIds,
              _studentIds,
            ) &&
            (identical(other.monthlyFee, monthlyFee) ||
                other.monthlyFee == monthlyFee) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.className, className) ||
                other.className == className));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    genreId,
    grade,
    curriculum,
    level,
    year,
    termStart,
    termEnd,
    const DeepCollectionEquality().hash(_lectureDates),
    const DeepCollectionEquality().hash(_teacherIds),
    const DeepCollectionEquality().hash(_studentIds),
    monthlyFee,
    isActive,
    className,
  );

  /// Create a copy of ClassUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassUpdateImplCopyWith<_$ClassUpdateImpl> get copyWith =>
      __$$ClassUpdateImplCopyWithImpl<_$ClassUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassUpdateImplToJson(this);
  }
}

abstract class _ClassUpdate implements ClassUpdate {
  const factory _ClassUpdate({
    @JsonKey(name: 'genre_id') final int? genreId,
    final int? grade,
    final int? curriculum,
    final int? level,
    final int? year,
    @JsonKey(name: 'term_start') final String? termStart,
    @JsonKey(name: 'term_end') final String? termEnd,
    @JsonKey(name: 'lecture_dates') final List<LectureDate>? lectureDates,
    @JsonKey(name: 'teacher_ids') final List<int>? teacherIds,
    @JsonKey(name: 'student_ids') final List<int>? studentIds,
    @JsonKey(name: 'monthly_fee') final int? monthlyFee,
    @JsonKey(name: 'is_active') final int? isActive,
    @JsonKey(name: 'class_name') final String? className,
  }) = _$ClassUpdateImpl;

  factory _ClassUpdate.fromJson(Map<String, dynamic> json) =
      _$ClassUpdateImpl.fromJson;

  @override
  @JsonKey(name: 'genre_id')
  int? get genreId;
  @override
  int? get grade;
  @override
  int? get curriculum;
  @override
  int? get level;
  @override
  int? get year;
  @override
  @JsonKey(name: 'term_start')
  String? get termStart;
  @override
  @JsonKey(name: 'term_end')
  String? get termEnd;
  @override
  @JsonKey(name: 'lecture_dates')
  List<LectureDate>? get lectureDates;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int>? get teacherIds;
  @override
  @JsonKey(name: 'student_ids')
  List<int>? get studentIds;
  @override
  @JsonKey(name: 'monthly_fee')
  int? get monthlyFee;
  @override
  @JsonKey(name: 'is_active')
  int? get isActive;
  @override
  @JsonKey(name: 'class_name')
  String? get className;

  /// Create a copy of ClassUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassUpdateImplCopyWith<_$ClassUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassListParams _$ClassListParamsFromJson(Map<String, dynamic> json) {
  return _ClassListParams.fromJson(json);
}

/// @nodoc
mixin _$ClassListParams {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  String? get sort => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_id')
  int? get genreId => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int? get isActive => throw _privateConstructorUsedError;

  /// Serializes this ClassListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassListParamsCopyWith<ClassListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassListParamsCopyWith<$Res> {
  factory $ClassListParamsCopyWith(
    ClassListParams value,
    $Res Function(ClassListParams) then,
  ) = _$ClassListParamsCopyWithImpl<$Res, ClassListParams>;
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? level,
    int? year,
    @JsonKey(name: 'is_active') int? isActive,
  });
}

/// @nodoc
class _$ClassListParamsCopyWithImpl<$Res, $Val extends ClassListParams>
    implements $ClassListParamsCopyWith<$Res> {
  _$ClassListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? genreId = freezed,
    Object? grade = freezed,
    Object? level = freezed,
    Object? year = freezed,
    Object? isActive = freezed,
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
            genreId: freezed == genreId
                ? _value.genreId
                : genreId // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassListParamsImplCopyWith<$Res>
    implements $ClassListParamsCopyWith<$Res> {
  factory _$$ClassListParamsImplCopyWith(
    _$ClassListParamsImpl value,
    $Res Function(_$ClassListParamsImpl) then,
  ) = __$$ClassListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? level,
    int? year,
    @JsonKey(name: 'is_active') int? isActive,
  });
}

/// @nodoc
class __$$ClassListParamsImplCopyWithImpl<$Res>
    extends _$ClassListParamsCopyWithImpl<$Res, _$ClassListParamsImpl>
    implements _$$ClassListParamsImplCopyWith<$Res> {
  __$$ClassListParamsImplCopyWithImpl(
    _$ClassListParamsImpl _value,
    $Res Function(_$ClassListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
    Object? genreId = freezed,
    Object? grade = freezed,
    Object? level = freezed,
    Object? year = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _$ClassListParamsImpl(
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
        genreId: freezed == genreId
            ? _value.genreId
            : genreId // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassListParamsImpl implements _ClassListParams {
  const _$ClassListParamsImpl({
    this.page = 1,
    this.perPage = 1000,
    this.sort = 'class_name',
    this.order = 'asc',
    this.search,
    @JsonKey(name: 'genre_id') this.genreId,
    this.grade,
    this.level,
    this.year,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$ClassListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassListParamsImplFromJson(json);

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
  @JsonKey(name: 'genre_id')
  final int? genreId;
  @override
  final int? grade;
  @override
  final int? level;
  @override
  final int? year;
  @override
  @JsonKey(name: 'is_active')
  final int? isActive;

  @override
  String toString() {
    return 'ClassListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search, genreId: $genreId, grade: $grade, level: $level, year: $year, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassListParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
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
    genreId,
    grade,
    level,
    year,
    isActive,
  );

  /// Create a copy of ClassListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassListParamsImplCopyWith<_$ClassListParamsImpl> get copyWith =>
      __$$ClassListParamsImplCopyWithImpl<_$ClassListParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassListParamsImplToJson(this);
  }
}

abstract class _ClassListParams implements ClassListParams {
  const factory _ClassListParams({
    final int page,
    final int perPage,
    final String? sort,
    final String? order,
    final String? search,
    @JsonKey(name: 'genre_id') final int? genreId,
    final int? grade,
    final int? level,
    final int? year,
    @JsonKey(name: 'is_active') final int? isActive,
  }) = _$ClassListParamsImpl;

  factory _ClassListParams.fromJson(Map<String, dynamic> json) =
      _$ClassListParamsImpl.fromJson;

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
  @JsonKey(name: 'genre_id')
  int? get genreId;
  @override
  int? get grade;
  @override
  int? get level;
  @override
  int? get year;
  @override
  @JsonKey(name: 'is_active')
  int? get isActive;

  /// Create a copy of ClassListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassListParamsImplCopyWith<_$ClassListParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSearchResult _$UserSearchResultFromJson(Map<String, dynamic> json) {
  return _UserSearchResult.fromJson(json);
}

/// @nodoc
mixin _$UserSearchResult {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError;

  /// Serializes this UserSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSearchResultCopyWith<UserSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSearchResultCopyWith<$Res> {
  factory $UserSearchResultCopyWith(
    UserSearchResult value,
    $Res Function(UserSearchResult) then,
  ) = _$UserSearchResultCopyWithImpl<$Res, UserSearchResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    String? phone,
    int kind,
  });
}

/// @nodoc
class _$UserSearchResultCopyWithImpl<$Res, $Val extends UserSearchResult>
    implements $UserSearchResultCopyWith<$Res> {
  _$UserSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = freezed,
    Object? kind = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSearchResultImplCopyWith<$Res>
    implements $UserSearchResultCopyWith<$Res> {
  factory _$$UserSearchResultImplCopyWith(
    _$UserSearchResultImpl value,
    $Res Function(_$UserSearchResultImpl) then,
  ) = __$$UserSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    String? phone,
    int kind,
  });
}

/// @nodoc
class __$$UserSearchResultImplCopyWithImpl<$Res>
    extends _$UserSearchResultCopyWithImpl<$Res, _$UserSearchResultImpl>
    implements _$$UserSearchResultImplCopyWith<$Res> {
  __$$UserSearchResultImplCopyWithImpl(
    _$UserSearchResultImpl _value,
    $Res Function(_$UserSearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? phone = freezed,
    Object? kind = null,
  }) {
    return _then(
      _$UserSearchResultImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSearchResultImpl implements _UserSearchResult {
  const _$UserSearchResultImpl({
    @JsonKey(name: 'user_id') required this.userId,
    required this.name,
    this.phone,
    required this.kind,
  });

  factory _$UserSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSearchResultImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final int kind;

  @override
  String toString() {
    return 'UserSearchResult(userId: $userId, name: $name, phone: $phone, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSearchResultImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, name, phone, kind);

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      __$$UserSearchResultImplCopyWithImpl<_$UserSearchResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSearchResultImplToJson(this);
  }
}

abstract class _UserSearchResult implements UserSearchResult {
  const factory _UserSearchResult({
    @JsonKey(name: 'user_id') required final int userId,
    required final String name,
    final String? phone,
    required final int kind,
  }) = _$UserSearchResultImpl;

  factory _UserSearchResult.fromJson(Map<String, dynamic> json) =
      _$UserSearchResultImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get name;
  @override
  String? get phone;
  @override
  int get kind;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
