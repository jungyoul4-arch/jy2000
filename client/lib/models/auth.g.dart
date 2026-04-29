// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      kind: (json['kind'] as num).toInt(),
      phone: json['phone'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'kind': instance.kind,
      'phone': instance.phone,
      'email': instance.email,
    };

_$RequestCodeResponseImpl _$$RequestCodeResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RequestCodeResponseImpl(
  userId: (json['userId'] as num).toInt(),
  userName: json['userName'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$$RequestCodeResponseImplToJson(
  _$RequestCodeResponseImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'userName': instance.userName,
  'message': instance.message,
};

_$VerifyCodeResponseImpl _$$VerifyCodeResponseImplFromJson(
  Map<String, dynamic> json,
) => _$VerifyCodeResponseImpl(
  user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
  message: json['message'] as String,
);

Map<String, dynamic> _$$VerifyCodeResponseImplToJson(
  _$VerifyCodeResponseImpl instance,
) => <String, dynamic>{'user': instance.user, 'message': instance.message};
