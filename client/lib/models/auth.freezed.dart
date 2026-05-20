// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return _AuthUser.fromJson(json);
}

/// @nodoc
mixin _$AuthUser {
  @JsonKey(name: 'userId')
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  /// Serializes this AuthUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res, AuthUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'userId') int userId,
    String name,
    int kind,
    String phone,
    String? email,
    bool isAdmin,
  });
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res, $Val extends AuthUser>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? kind = null,
    Object? phone = null,
    Object? email = freezed,
    Object? isAdmin = null,
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
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAdmin: null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthUserImplCopyWith<$Res>
    implements $AuthUserCopyWith<$Res> {
  factory _$$AuthUserImplCopyWith(
    _$AuthUserImpl value,
    $Res Function(_$AuthUserImpl) then,
  ) = __$$AuthUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'userId') int userId,
    String name,
    int kind,
    String phone,
    String? email,
    bool isAdmin,
  });
}

/// @nodoc
class __$$AuthUserImplCopyWithImpl<$Res>
    extends _$AuthUserCopyWithImpl<$Res, _$AuthUserImpl>
    implements _$$AuthUserImplCopyWith<$Res> {
  __$$AuthUserImplCopyWithImpl(
    _$AuthUserImpl _value,
    $Res Function(_$AuthUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? kind = null,
    Object? phone = null,
    Object? email = freezed,
    Object? isAdmin = null,
  }) {
    return _then(
      _$AuthUserImpl(
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
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAdmin: null == isAdmin
            ? _value.isAdmin
            : isAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserImpl implements _AuthUser {
  const _$AuthUserImpl({
    @JsonKey(name: 'userId') required this.userId,
    required this.name,
    required this.kind,
    required this.phone,
    this.email,
    this.isAdmin = false,
  });

  factory _$AuthUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserImplFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final int userId;
  @override
  final String name;
  @override
  final int kind;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey()
  final bool isAdmin;

  @override
  String toString() {
    return 'AuthUser(userId: $userId, name: $name, kind: $kind, phone: $phone, email: $email, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, name, kind, phone, email, isAdmin);

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      __$$AuthUserImplCopyWithImpl<_$AuthUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserImplToJson(this);
  }
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser({
    @JsonKey(name: 'userId') required final int userId,
    required final String name,
    required final int kind,
    required final String phone,
    final String? email,
    final bool isAdmin,
  }) = _$AuthUserImpl;

  factory _AuthUser.fromJson(Map<String, dynamic> json) =
      _$AuthUserImpl.fromJson;

  @override
  @JsonKey(name: 'userId')
  int get userId;
  @override
  String get name;
  @override
  int get kind;
  @override
  String get phone;
  @override
  String? get email;
  @override
  bool get isAdmin;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestCodeResponse _$RequestCodeResponseFromJson(Map<String, dynamic> json) {
  return _RequestCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$RequestCodeResponse {
  int get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this RequestCodeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestCodeResponseCopyWith<RequestCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestCodeResponseCopyWith<$Res> {
  factory $RequestCodeResponseCopyWith(
    RequestCodeResponse value,
    $Res Function(RequestCodeResponse) then,
  ) = _$RequestCodeResponseCopyWithImpl<$Res, RequestCodeResponse>;
  @useResult
  $Res call({int userId, String userName, String message});
}

/// @nodoc
class _$RequestCodeResponseCopyWithImpl<$Res, $Val extends RequestCodeResponse>
    implements $RequestCodeResponseCopyWith<$Res> {
  _$RequestCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? message = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestCodeResponseImplCopyWith<$Res>
    implements $RequestCodeResponseCopyWith<$Res> {
  factory _$$RequestCodeResponseImplCopyWith(
    _$RequestCodeResponseImpl value,
    $Res Function(_$RequestCodeResponseImpl) then,
  ) = __$$RequestCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, String userName, String message});
}

/// @nodoc
class __$$RequestCodeResponseImplCopyWithImpl<$Res>
    extends _$RequestCodeResponseCopyWithImpl<$Res, _$RequestCodeResponseImpl>
    implements _$$RequestCodeResponseImplCopyWith<$Res> {
  __$$RequestCodeResponseImplCopyWithImpl(
    _$RequestCodeResponseImpl _value,
    $Res Function(_$RequestCodeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? message = null,
  }) {
    return _then(
      _$RequestCodeResponseImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestCodeResponseImpl implements _RequestCodeResponse {
  const _$RequestCodeResponseImpl({
    required this.userId,
    required this.userName,
    required this.message,
  });

  factory _$RequestCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestCodeResponseImplFromJson(json);

  @override
  final int userId;
  @override
  final String userName;
  @override
  final String message;

  @override
  String toString() {
    return 'RequestCodeResponse(userId: $userId, userName: $userName, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestCodeResponseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, userName, message);

  /// Create a copy of RequestCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestCodeResponseImplCopyWith<_$RequestCodeResponseImpl> get copyWith =>
      __$$RequestCodeResponseImplCopyWithImpl<_$RequestCodeResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestCodeResponseImplToJson(this);
  }
}

abstract class _RequestCodeResponse implements RequestCodeResponse {
  const factory _RequestCodeResponse({
    required final int userId,
    required final String userName,
    required final String message,
  }) = _$RequestCodeResponseImpl;

  factory _RequestCodeResponse.fromJson(Map<String, dynamic> json) =
      _$RequestCodeResponseImpl.fromJson;

  @override
  int get userId;
  @override
  String get userName;
  @override
  String get message;

  /// Create a copy of RequestCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestCodeResponseImplCopyWith<_$RequestCodeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyCodeResponse _$VerifyCodeResponseFromJson(Map<String, dynamic> json) {
  return _VerifyCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$VerifyCodeResponse {
  AuthUser get user => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this VerifyCodeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyCodeResponseCopyWith<VerifyCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyCodeResponseCopyWith<$Res> {
  factory $VerifyCodeResponseCopyWith(
    VerifyCodeResponse value,
    $Res Function(VerifyCodeResponse) then,
  ) = _$VerifyCodeResponseCopyWithImpl<$Res, VerifyCodeResponse>;
  @useResult
  $Res call({AuthUser user, String message});

  $AuthUserCopyWith<$Res> get user;
}

/// @nodoc
class _$VerifyCodeResponseCopyWithImpl<$Res, $Val extends VerifyCodeResponse>
    implements $VerifyCodeResponseCopyWith<$Res> {
  _$VerifyCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthUser,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res> get user {
    return $AuthUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifyCodeResponseImplCopyWith<$Res>
    implements $VerifyCodeResponseCopyWith<$Res> {
  factory _$$VerifyCodeResponseImplCopyWith(
    _$VerifyCodeResponseImpl value,
    $Res Function(_$VerifyCodeResponseImpl) then,
  ) = __$$VerifyCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthUser user, String message});

  @override
  $AuthUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$VerifyCodeResponseImplCopyWithImpl<$Res>
    extends _$VerifyCodeResponseCopyWithImpl<$Res, _$VerifyCodeResponseImpl>
    implements _$$VerifyCodeResponseImplCopyWith<$Res> {
  __$$VerifyCodeResponseImplCopyWithImpl(
    _$VerifyCodeResponseImpl _value,
    $Res Function(_$VerifyCodeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? message = null}) {
    return _then(
      _$VerifyCodeResponseImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthUser,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyCodeResponseImpl implements _VerifyCodeResponse {
  const _$VerifyCodeResponseImpl({required this.user, required this.message});

  factory _$VerifyCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyCodeResponseImplFromJson(json);

  @override
  final AuthUser user;
  @override
  final String message;

  @override
  String toString() {
    return 'VerifyCodeResponse(user: $user, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyCodeResponseImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, message);

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyCodeResponseImplCopyWith<_$VerifyCodeResponseImpl> get copyWith =>
      __$$VerifyCodeResponseImplCopyWithImpl<_$VerifyCodeResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyCodeResponseImplToJson(this);
  }
}

abstract class _VerifyCodeResponse implements VerifyCodeResponse {
  const factory _VerifyCodeResponse({
    required final AuthUser user,
    required final String message,
  }) = _$VerifyCodeResponseImpl;

  factory _VerifyCodeResponse.fromJson(Map<String, dynamic> json) =
      _$VerifyCodeResponseImpl.fromJson;

  @override
  AuthUser get user;
  @override
  String get message;

  /// Create a copy of VerifyCodeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyCodeResponseImplCopyWith<_$VerifyCodeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
