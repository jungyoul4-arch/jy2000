import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    @JsonKey(name: 'userId') required int userId,
    required String name,
    required int kind,
    required String phone,
    String? email,
    @Default(false) bool isAdmin,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@freezed
class RequestCodeResponse with _$RequestCodeResponse {
  const factory RequestCodeResponse({
    required int userId,
    required String userName,
    required String message,
  }) = _RequestCodeResponse;

  factory RequestCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestCodeResponseFromJson(json);
}

@freezed
class VerifyCodeResponse with _$VerifyCodeResponse {
  const factory VerifyCodeResponse({
    required AuthUser user,
    required String message,
  }) = _VerifyCodeResponse;

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);
}
