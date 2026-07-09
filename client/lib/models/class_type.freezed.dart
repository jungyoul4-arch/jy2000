// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassTypeTeacher _$ClassTypeTeacherFromJson(Map<String, dynamic> json) {
  return _ClassTypeTeacher.fromJson(json);
}

/// @nodoc
mixin _$ClassTypeTeacher {
  @JsonKey(name: 'teacher_id')
  int get teacherId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_name')
  String get teacherName => throw _privateConstructorUsedError;

  /// Serializes this ClassTypeTeacher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassTypeTeacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassTypeTeacherCopyWith<ClassTypeTeacher> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassTypeTeacherCopyWith<$Res> {
  factory $ClassTypeTeacherCopyWith(
    ClassTypeTeacher value,
    $Res Function(ClassTypeTeacher) then,
  ) = _$ClassTypeTeacherCopyWithImpl<$Res, ClassTypeTeacher>;
  @useResult
  $Res call({
    @JsonKey(name: 'teacher_id') int teacherId,
    @JsonKey(name: 'teacher_name') String teacherName,
  });
}

/// @nodoc
class _$ClassTypeTeacherCopyWithImpl<$Res, $Val extends ClassTypeTeacher>
    implements $ClassTypeTeacherCopyWith<$Res> {
  _$ClassTypeTeacherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassTypeTeacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? teacherId = null, Object? teacherName = null}) {
    return _then(
      _value.copyWith(
            teacherId: null == teacherId
                ? _value.teacherId
                : teacherId // ignore: cast_nullable_to_non_nullable
                      as int,
            teacherName: null == teacherName
                ? _value.teacherName
                : teacherName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassTypeTeacherImplCopyWith<$Res>
    implements $ClassTypeTeacherCopyWith<$Res> {
  factory _$$ClassTypeTeacherImplCopyWith(
    _$ClassTypeTeacherImpl value,
    $Res Function(_$ClassTypeTeacherImpl) then,
  ) = __$$ClassTypeTeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'teacher_id') int teacherId,
    @JsonKey(name: 'teacher_name') String teacherName,
  });
}

/// @nodoc
class __$$ClassTypeTeacherImplCopyWithImpl<$Res>
    extends _$ClassTypeTeacherCopyWithImpl<$Res, _$ClassTypeTeacherImpl>
    implements _$$ClassTypeTeacherImplCopyWith<$Res> {
  __$$ClassTypeTeacherImplCopyWithImpl(
    _$ClassTypeTeacherImpl _value,
    $Res Function(_$ClassTypeTeacherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassTypeTeacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? teacherId = null, Object? teacherName = null}) {
    return _then(
      _$ClassTypeTeacherImpl(
        teacherId: null == teacherId
            ? _value.teacherId
            : teacherId // ignore: cast_nullable_to_non_nullable
                  as int,
        teacherName: null == teacherName
            ? _value.teacherName
            : teacherName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassTypeTeacherImpl implements _ClassTypeTeacher {
  const _$ClassTypeTeacherImpl({
    @JsonKey(name: 'teacher_id') required this.teacherId,
    @JsonKey(name: 'teacher_name') this.teacherName = '',
  });

  factory _$ClassTypeTeacherImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassTypeTeacherImplFromJson(json);

  @override
  @JsonKey(name: 'teacher_id')
  final int teacherId;
  @override
  @JsonKey(name: 'teacher_name')
  final String teacherName;

  @override
  String toString() {
    return 'ClassTypeTeacher(teacherId: $teacherId, teacherName: $teacherName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassTypeTeacherImpl &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, teacherId, teacherName);

  /// Create a copy of ClassTypeTeacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassTypeTeacherImplCopyWith<_$ClassTypeTeacherImpl> get copyWith =>
      __$$ClassTypeTeacherImplCopyWithImpl<_$ClassTypeTeacherImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassTypeTeacherImplToJson(this);
  }
}

abstract class _ClassTypeTeacher implements ClassTypeTeacher {
  const factory _ClassTypeTeacher({
    @JsonKey(name: 'teacher_id') required final int teacherId,
    @JsonKey(name: 'teacher_name') final String teacherName,
  }) = _$ClassTypeTeacherImpl;

  factory _ClassTypeTeacher.fromJson(Map<String, dynamic> json) =
      _$ClassTypeTeacherImpl.fromJson;

  @override
  @JsonKey(name: 'teacher_id')
  int get teacherId;
  @override
  @JsonKey(name: 'teacher_name')
  String get teacherName;

  /// Create a copy of ClassTypeTeacher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassTypeTeacherImplCopyWith<_$ClassTypeTeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassType _$ClassTypeFromJson(Map<String, dynamic> json) {
  return _ClassType.fromJson(json);
}

/// @nodoc
mixin _$ClassType {
  @JsonKey(name: 'class_type_id')
  int get classTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_type_name')
  String get classTypeName => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  int get subject => throw _privateConstructorUsedError;
  int? get format => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  int get unitPrice => throw _privateConstructorUsedError;
  List<ClassTypeTeacher> get teachers => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ClassType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassTypeCopyWith<ClassType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassTypeCopyWith<$Res> {
  factory $ClassTypeCopyWith(ClassType value, $Res Function(ClassType) then) =
      _$ClassTypeCopyWithImpl<$Res, ClassType>;
  @useResult
  $Res call({
    @JsonKey(name: 'class_type_id') int classTypeId,
    @JsonKey(name: 'class_type_name') String classTypeName,
    int? year,
    int grade,
    int subject,
    int? format,
    @JsonKey(name: 'unit_price') int unitPrice,
    List<ClassTypeTeacher> teachers,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$ClassTypeCopyWithImpl<$Res, $Val extends ClassType>
    implements $ClassTypeCopyWith<$Res> {
  _$ClassTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeId = null,
    Object? classTypeName = null,
    Object? year = freezed,
    Object? grade = null,
    Object? subject = null,
    Object? format = freezed,
    Object? unitPrice = null,
    Object? teachers = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            classTypeId: null == classTypeId
                ? _value.classTypeId
                : classTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            classTypeName: null == classTypeName
                ? _value.classTypeName
                : classTypeName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as int,
            format: freezed == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as int?,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            teachers: null == teachers
                ? _value.teachers
                : teachers // ignore: cast_nullable_to_non_nullable
                      as List<ClassTypeTeacher>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ClassTypeImplCopyWith<$Res>
    implements $ClassTypeCopyWith<$Res> {
  factory _$$ClassTypeImplCopyWith(
    _$ClassTypeImpl value,
    $Res Function(_$ClassTypeImpl) then,
  ) = __$$ClassTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'class_type_id') int classTypeId,
    @JsonKey(name: 'class_type_name') String classTypeName,
    int? year,
    int grade,
    int subject,
    int? format,
    @JsonKey(name: 'unit_price') int unitPrice,
    List<ClassTypeTeacher> teachers,
    @JsonKey(name: 'is_active') @IntToBoolConverter() bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$ClassTypeImplCopyWithImpl<$Res>
    extends _$ClassTypeCopyWithImpl<$Res, _$ClassTypeImpl>
    implements _$$ClassTypeImplCopyWith<$Res> {
  __$$ClassTypeImplCopyWithImpl(
    _$ClassTypeImpl _value,
    $Res Function(_$ClassTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeId = null,
    Object? classTypeName = null,
    Object? year = freezed,
    Object? grade = null,
    Object? subject = null,
    Object? format = freezed,
    Object? unitPrice = null,
    Object? teachers = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ClassTypeImpl(
        classTypeId: null == classTypeId
            ? _value.classTypeId
            : classTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        classTypeName: null == classTypeName
            ? _value.classTypeName
            : classTypeName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as int,
        format: freezed == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as int?,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        teachers: null == teachers
            ? _value._teachers
            : teachers // ignore: cast_nullable_to_non_nullable
                  as List<ClassTypeTeacher>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ClassTypeImpl extends _ClassType {
  const _$ClassTypeImpl({
    @JsonKey(name: 'class_type_id') required this.classTypeId,
    @JsonKey(name: 'class_type_name') required this.classTypeName,
    this.year,
    required this.grade,
    required this.subject,
    this.format,
    @JsonKey(name: 'unit_price') this.unitPrice = 0,
    final List<ClassTypeTeacher> teachers = const [],
    @JsonKey(name: 'is_active') @IntToBoolConverter() this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _teachers = teachers,
       super._();

  factory _$ClassTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassTypeImplFromJson(json);

  @override
  @JsonKey(name: 'class_type_id')
  final int classTypeId;
  @override
  @JsonKey(name: 'class_type_name')
  final String classTypeName;
  @override
  final int? year;
  @override
  final int grade;
  @override
  final int subject;
  @override
  final int? format;
  @override
  @JsonKey(name: 'unit_price')
  final int unitPrice;
  final List<ClassTypeTeacher> _teachers;
  @override
  @JsonKey()
  List<ClassTypeTeacher> get teachers {
    if (_teachers is EqualUnmodifiableListView) return _teachers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teachers);
  }

  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'ClassType(classTypeId: $classTypeId, classTypeName: $classTypeName, year: $year, grade: $grade, subject: $subject, format: $format, unitPrice: $unitPrice, teachers: $teachers, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassTypeImpl &&
            (identical(other.classTypeId, classTypeId) ||
                other.classTypeId == classTypeId) &&
            (identical(other.classTypeName, classTypeName) ||
                other.classTypeName == classTypeName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classTypeId,
    classTypeName,
    year,
    grade,
    subject,
    format,
    unitPrice,
    const DeepCollectionEquality().hash(_teachers),
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ClassType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassTypeImplCopyWith<_$ClassTypeImpl> get copyWith =>
      __$$ClassTypeImplCopyWithImpl<_$ClassTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassTypeImplToJson(this);
  }
}

abstract class _ClassType extends ClassType {
  const factory _ClassType({
    @JsonKey(name: 'class_type_id') required final int classTypeId,
    @JsonKey(name: 'class_type_name') required final String classTypeName,
    final int? year,
    required final int grade,
    required final int subject,
    final int? format,
    @JsonKey(name: 'unit_price') final int unitPrice,
    final List<ClassTypeTeacher> teachers,
    @JsonKey(name: 'is_active') @IntToBoolConverter() final bool isActive,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$ClassTypeImpl;
  const _ClassType._() : super._();

  factory _ClassType.fromJson(Map<String, dynamic> json) =
      _$ClassTypeImpl.fromJson;

  @override
  @JsonKey(name: 'class_type_id')
  int get classTypeId;
  @override
  @JsonKey(name: 'class_type_name')
  String get classTypeName;
  @override
  int? get year;
  @override
  int get grade;
  @override
  int get subject;
  @override
  int? get format;
  @override
  @JsonKey(name: 'unit_price')
  int get unitPrice;
  @override
  List<ClassTypeTeacher> get teachers;
  @override
  @JsonKey(name: 'is_active')
  @IntToBoolConverter()
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of ClassType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassTypeImplCopyWith<_$ClassTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassTypeCreate _$ClassTypeCreateFromJson(Map<String, dynamic> json) {
  return _ClassTypeCreate.fromJson(json);
}

/// @nodoc
mixin _$ClassTypeCreate {
  @JsonKey(name: 'class_type_name')
  String get classTypeName => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  int get subject => throw _privateConstructorUsedError;
  int? get format => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  int get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_names')
  List<String> get teacherNames => throw _privateConstructorUsedError;

  /// Serializes this ClassTypeCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassTypeCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassTypeCreateCopyWith<ClassTypeCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassTypeCreateCopyWith<$Res> {
  factory $ClassTypeCreateCopyWith(
    ClassTypeCreate value,
    $Res Function(ClassTypeCreate) then,
  ) = _$ClassTypeCreateCopyWithImpl<$Res, ClassTypeCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'class_type_name') String classTypeName,
    int? year,
    int grade,
    int subject,
    int? format,
    @JsonKey(name: 'unit_price') int unitPrice,
    @JsonKey(name: 'teacher_ids') List<int> teacherIds,
    @JsonKey(name: 'teacher_names') List<String> teacherNames,
  });
}

/// @nodoc
class _$ClassTypeCreateCopyWithImpl<$Res, $Val extends ClassTypeCreate>
    implements $ClassTypeCreateCopyWith<$Res> {
  _$ClassTypeCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassTypeCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeName = null,
    Object? year = freezed,
    Object? grade = null,
    Object? subject = null,
    Object? format = freezed,
    Object? unitPrice = null,
    Object? teacherIds = null,
    Object? teacherNames = null,
  }) {
    return _then(
      _value.copyWith(
            classTypeName: null == classTypeName
                ? _value.classTypeName
                : classTypeName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as int,
            format: freezed == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as int?,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            teacherIds: null == teacherIds
                ? _value.teacherIds
                : teacherIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            teacherNames: null == teacherNames
                ? _value.teacherNames
                : teacherNames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassTypeCreateImplCopyWith<$Res>
    implements $ClassTypeCreateCopyWith<$Res> {
  factory _$$ClassTypeCreateImplCopyWith(
    _$ClassTypeCreateImpl value,
    $Res Function(_$ClassTypeCreateImpl) then,
  ) = __$$ClassTypeCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'class_type_name') String classTypeName,
    int? year,
    int grade,
    int subject,
    int? format,
    @JsonKey(name: 'unit_price') int unitPrice,
    @JsonKey(name: 'teacher_ids') List<int> teacherIds,
    @JsonKey(name: 'teacher_names') List<String> teacherNames,
  });
}

/// @nodoc
class __$$ClassTypeCreateImplCopyWithImpl<$Res>
    extends _$ClassTypeCreateCopyWithImpl<$Res, _$ClassTypeCreateImpl>
    implements _$$ClassTypeCreateImplCopyWith<$Res> {
  __$$ClassTypeCreateImplCopyWithImpl(
    _$ClassTypeCreateImpl _value,
    $Res Function(_$ClassTypeCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassTypeCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeName = null,
    Object? year = freezed,
    Object? grade = null,
    Object? subject = null,
    Object? format = freezed,
    Object? unitPrice = null,
    Object? teacherIds = null,
    Object? teacherNames = null,
  }) {
    return _then(
      _$ClassTypeCreateImpl(
        classTypeName: null == classTypeName
            ? _value.classTypeName
            : classTypeName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as int,
        format: freezed == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as int?,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        teacherIds: null == teacherIds
            ? _value._teacherIds
            : teacherIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        teacherNames: null == teacherNames
            ? _value._teacherNames
            : teacherNames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassTypeCreateImpl implements _ClassTypeCreate {
  const _$ClassTypeCreateImpl({
    @JsonKey(name: 'class_type_name') required this.classTypeName,
    this.year,
    required this.grade,
    required this.subject,
    this.format,
    @JsonKey(name: 'unit_price') this.unitPrice = 0,
    @JsonKey(name: 'teacher_ids') final List<int> teacherIds = const [],
    @JsonKey(name: 'teacher_names') final List<String> teacherNames = const [],
  }) : _teacherIds = teacherIds,
       _teacherNames = teacherNames;

  factory _$ClassTypeCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassTypeCreateImplFromJson(json);

  @override
  @JsonKey(name: 'class_type_name')
  final String classTypeName;
  @override
  final int? year;
  @override
  final int grade;
  @override
  final int subject;
  @override
  final int? format;
  @override
  @JsonKey(name: 'unit_price')
  final int unitPrice;
  final List<int> _teacherIds;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds {
    if (_teacherIds is EqualUnmodifiableListView) return _teacherIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teacherIds);
  }

  final List<String> _teacherNames;
  @override
  @JsonKey(name: 'teacher_names')
  List<String> get teacherNames {
    if (_teacherNames is EqualUnmodifiableListView) return _teacherNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teacherNames);
  }

  @override
  String toString() {
    return 'ClassTypeCreate(classTypeName: $classTypeName, year: $year, grade: $grade, subject: $subject, format: $format, unitPrice: $unitPrice, teacherIds: $teacherIds, teacherNames: $teacherNames)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassTypeCreateImpl &&
            (identical(other.classTypeName, classTypeName) ||
                other.classTypeName == classTypeName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            const DeepCollectionEquality().equals(
              other._teacherIds,
              _teacherIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._teacherNames,
              _teacherNames,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classTypeName,
    year,
    grade,
    subject,
    format,
    unitPrice,
    const DeepCollectionEquality().hash(_teacherIds),
    const DeepCollectionEquality().hash(_teacherNames),
  );

  /// Create a copy of ClassTypeCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassTypeCreateImplCopyWith<_$ClassTypeCreateImpl> get copyWith =>
      __$$ClassTypeCreateImplCopyWithImpl<_$ClassTypeCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassTypeCreateImplToJson(this);
  }
}

abstract class _ClassTypeCreate implements ClassTypeCreate {
  const factory _ClassTypeCreate({
    @JsonKey(name: 'class_type_name') required final String classTypeName,
    final int? year,
    required final int grade,
    required final int subject,
    final int? format,
    @JsonKey(name: 'unit_price') final int unitPrice,
    @JsonKey(name: 'teacher_ids') final List<int> teacherIds,
    @JsonKey(name: 'teacher_names') final List<String> teacherNames,
  }) = _$ClassTypeCreateImpl;

  factory _ClassTypeCreate.fromJson(Map<String, dynamic> json) =
      _$ClassTypeCreateImpl.fromJson;

  @override
  @JsonKey(name: 'class_type_name')
  String get classTypeName;
  @override
  int? get year;
  @override
  int get grade;
  @override
  int get subject;
  @override
  int? get format;
  @override
  @JsonKey(name: 'unit_price')
  int get unitPrice;
  @override
  @JsonKey(name: 'teacher_ids')
  List<int> get teacherIds;
  @override
  @JsonKey(name: 'teacher_names')
  List<String> get teacherNames;

  /// Create a copy of ClassTypeCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassTypeCreateImplCopyWith<_$ClassTypeCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
