// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError;
  @JsonKey(name: 'kind_name')
  String get kindName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_contact_date')
  String? get firstContactDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'reg_dt')
  String get regDt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_dt')
  String? get lastLoginDt => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_flag')
  int get activeFlag => throw _privateConstructorUsedError;

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    int kind,
    @JsonKey(name: 'kind_name') String kindName,
    String phone,
    String? email,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'reg_dt') String regDt,
    @JsonKey(name: 'last_login_dt') String? lastLoginDt,
    @JsonKey(name: 'active_flag') int activeFlag,
  });
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? kind = null,
    Object? kindName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? firstContactDate = freezed,
    Object? regDt = null,
    Object? lastLoginDt = freezed,
    Object? activeFlag = null,
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
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as int,
            kindName: null == kindName
                ? _value.kindName
                : kindName // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstContactDate: freezed == firstContactDate
                ? _value.firstContactDate
                : firstContactDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            regDt: null == regDt
                ? _value.regDt
                : regDt // ignore: cast_nullable_to_non_nullable
                      as String,
            lastLoginDt: freezed == lastLoginDt
                ? _value.lastLoginDt
                : lastLoginDt // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeFlag: null == activeFlag
                ? _value.activeFlag
                : activeFlag // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
    _$StaffImpl value,
    $Res Function(_$StaffImpl) then,
  ) = __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    String name,
    int kind,
    @JsonKey(name: 'kind_name') String kindName,
    String phone,
    String? email,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'reg_dt') String regDt,
    @JsonKey(name: 'last_login_dt') String? lastLoginDt,
    @JsonKey(name: 'active_flag') int activeFlag,
  });
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
    _$StaffImpl _value,
    $Res Function(_$StaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? kind = null,
    Object? kindName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? firstContactDate = freezed,
    Object? regDt = null,
    Object? lastLoginDt = freezed,
    Object? activeFlag = null,
  }) {
    return _then(
      _$StaffImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as int,
        kindName: null == kindName
            ? _value.kindName
            : kindName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstContactDate: freezed == firstContactDate
            ? _value.firstContactDate
            : firstContactDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        regDt: null == regDt
            ? _value.regDt
            : regDt // ignore: cast_nullable_to_non_nullable
                  as String,
        lastLoginDt: freezed == lastLoginDt
            ? _value.lastLoginDt
            : lastLoginDt // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeFlag: null == activeFlag
            ? _value.activeFlag
            : activeFlag // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl implements _Staff {
  const _$StaffImpl({
    @JsonKey(name: 'user_id') required this.userId,
    required this.name,
    required this.kind,
    @JsonKey(name: 'kind_name') required this.kindName,
    required this.phone,
    this.email,
    @JsonKey(name: 'first_contact_date') this.firstContactDate,
    @JsonKey(name: 'reg_dt') required this.regDt,
    @JsonKey(name: 'last_login_dt') this.lastLoginDt,
    @JsonKey(name: 'active_flag') this.activeFlag = 1,
  });

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String name;
  @override
  final int kind;
  @override
  @JsonKey(name: 'kind_name')
  final String kindName;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'first_contact_date')
  final String? firstContactDate;
  @override
  @JsonKey(name: 'reg_dt')
  final String regDt;
  @override
  @JsonKey(name: 'last_login_dt')
  final String? lastLoginDt;
  @override
  @JsonKey(name: 'active_flag')
  final int activeFlag;

  @override
  String toString() {
    return 'Staff(userId: $userId, name: $name, kind: $kind, kindName: $kindName, phone: $phone, email: $email, firstContactDate: $firstContactDate, regDt: $regDt, lastLoginDt: $lastLoginDt, activeFlag: $activeFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.kindName, kindName) ||
                other.kindName == kindName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstContactDate, firstContactDate) ||
                other.firstContactDate == firstContactDate) &&
            (identical(other.regDt, regDt) || other.regDt == regDt) &&
            (identical(other.lastLoginDt, lastLoginDt) ||
                other.lastLoginDt == lastLoginDt) &&
            (identical(other.activeFlag, activeFlag) ||
                other.activeFlag == activeFlag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    name,
    kind,
    kindName,
    phone,
    email,
    firstContactDate,
    regDt,
    lastLoginDt,
    activeFlag,
  );

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(this);
  }
}

abstract class _Staff implements Staff {
  const factory _Staff({
    @JsonKey(name: 'user_id') required final int userId,
    required final String name,
    required final int kind,
    @JsonKey(name: 'kind_name') required final String kindName,
    required final String phone,
    final String? email,
    @JsonKey(name: 'first_contact_date') final String? firstContactDate,
    @JsonKey(name: 'reg_dt') required final String regDt,
    @JsonKey(name: 'last_login_dt') final String? lastLoginDt,
    @JsonKey(name: 'active_flag') final int activeFlag,
  }) = _$StaffImpl;

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get name;
  @override
  int get kind;
  @override
  @JsonKey(name: 'kind_name')
  String get kindName;
  @override
  String get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'first_contact_date')
  String? get firstContactDate;
  @override
  @JsonKey(name: 'reg_dt')
  String get regDt;
  @override
  @JsonKey(name: 'last_login_dt')
  String? get lastLoginDt;
  @override
  @JsonKey(name: 'active_flag')
  int get activeFlag;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffCreate _$StaffCreateFromJson(Map<String, dynamic> json) {
  return _StaffCreate.fromJson(json);
}

/// @nodoc
mixin _$StaffCreate {
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError;

  /// Serializes this StaffCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCreateCopyWith<StaffCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCreateCopyWith<$Res> {
  factory $StaffCreateCopyWith(
    StaffCreate value,
    $Res Function(StaffCreate) then,
  ) = _$StaffCreateCopyWithImpl<$Res, StaffCreate>;
  @useResult
  $Res call({String name, String phone, int kind});
}

/// @nodoc
class _$StaffCreateCopyWithImpl<$Res, $Val extends StaffCreate>
    implements $StaffCreateCopyWith<$Res> {
  _$StaffCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? phone = null, Object? kind = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$StaffCreateImplCopyWith<$Res>
    implements $StaffCreateCopyWith<$Res> {
  factory _$$StaffCreateImplCopyWith(
    _$StaffCreateImpl value,
    $Res Function(_$StaffCreateImpl) then,
  ) = __$$StaffCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String phone, int kind});
}

/// @nodoc
class __$$StaffCreateImplCopyWithImpl<$Res>
    extends _$StaffCreateCopyWithImpl<$Res, _$StaffCreateImpl>
    implements _$$StaffCreateImplCopyWith<$Res> {
  __$$StaffCreateImplCopyWithImpl(
    _$StaffCreateImpl _value,
    $Res Function(_$StaffCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? phone = null, Object? kind = null}) {
    return _then(
      _$StaffCreateImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$StaffCreateImpl implements _StaffCreate {
  const _$StaffCreateImpl({
    required this.name,
    required this.phone,
    required this.kind,
  });

  factory _$StaffCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffCreateImplFromJson(json);

  @override
  final String name;
  @override
  final String phone;
  @override
  final int kind;

  @override
  String toString() {
    return 'StaffCreate(name: $name, phone: $phone, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffCreateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, phone, kind);

  /// Create a copy of StaffCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffCreateImplCopyWith<_$StaffCreateImpl> get copyWith =>
      __$$StaffCreateImplCopyWithImpl<_$StaffCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffCreateImplToJson(this);
  }
}

abstract class _StaffCreate implements StaffCreate {
  const factory _StaffCreate({
    required final String name,
    required final String phone,
    required final int kind,
  }) = _$StaffCreateImpl;

  factory _StaffCreate.fromJson(Map<String, dynamic> json) =
      _$StaffCreateImpl.fromJson;

  @override
  String get name;
  @override
  String get phone;
  @override
  int get kind;

  /// Create a copy of StaffCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffCreateImplCopyWith<_$StaffCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffListParams _$StaffListParamsFromJson(Map<String, dynamic> json) {
  return _StaffListParams.fromJson(json);
}

/// @nodoc
mixin _$StaffListParams {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError; // 직원은 100명 미만이므로 전체 표시
  String? get sort => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;

  /// Serializes this StaffListParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffListParamsCopyWith<StaffListParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffListParamsCopyWith<$Res> {
  factory $StaffListParamsCopyWith(
    StaffListParams value,
    $Res Function(StaffListParams) then,
  ) = _$StaffListParamsCopyWithImpl<$Res, StaffListParams>;
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
  });
}

/// @nodoc
class _$StaffListParamsCopyWithImpl<$Res, $Val extends StaffListParams>
    implements $StaffListParamsCopyWith<$Res> {
  _$StaffListParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffListParamsImplCopyWith<$Res>
    implements $StaffListParamsCopyWith<$Res> {
  factory _$$StaffListParamsImplCopyWith(
    _$StaffListParamsImpl value,
    $Res Function(_$StaffListParamsImpl) then,
  ) = __$$StaffListParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    int perPage,
    String? sort,
    String? order,
    String? search,
  });
}

/// @nodoc
class __$$StaffListParamsImplCopyWithImpl<$Res>
    extends _$StaffListParamsCopyWithImpl<$Res, _$StaffListParamsImpl>
    implements _$$StaffListParamsImplCopyWith<$Res> {
  __$$StaffListParamsImplCopyWithImpl(
    _$StaffListParamsImpl _value,
    $Res Function(_$StaffListParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? sort = freezed,
    Object? order = freezed,
    Object? search = freezed,
  }) {
    return _then(
      _$StaffListParamsImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffListParamsImpl implements _StaffListParams {
  const _$StaffListParamsImpl({
    this.page = 1,
    this.perPage = 200,
    this.sort,
    this.order,
    this.search,
  });

  factory _$StaffListParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffListParamsImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int perPage;
  // 직원은 100명 미만이므로 전체 표시
  @override
  final String? sort;
  @override
  final String? order;
  @override
  final String? search;

  @override
  String toString() {
    return 'StaffListParams(page: $page, perPage: $perPage, sort: $sort, order: $order, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffListParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.search, search) || other.search == search));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, page, perPage, sort, order, search);

  /// Create a copy of StaffListParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffListParamsImplCopyWith<_$StaffListParamsImpl> get copyWith =>
      __$$StaffListParamsImplCopyWithImpl<_$StaffListParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffListParamsImplToJson(this);
  }
}

abstract class _StaffListParams implements StaffListParams {
  const factory _StaffListParams({
    final int page,
    final int perPage,
    final String? sort,
    final String? order,
    final String? search,
  }) = _$StaffListParamsImpl;

  factory _StaffListParams.fromJson(Map<String, dynamic> json) =
      _$StaffListParamsImpl.fromJson;

  @override
  int get page;
  @override
  int get perPage; // 직원은 100명 미만이므로 전체 표시
  @override
  String? get sort;
  @override
  String? get order;
  @override
  String? get search;

  /// Create a copy of StaffListParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffListParamsImplCopyWith<_$StaffListParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
