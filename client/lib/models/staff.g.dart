// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
  kind: (json['kind'] as num).toInt(),
  kindName: json['kind_name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  firstContactDate: json['first_contact_date'] as String?,
  regDt: json['reg_dt'] as String,
  lastLoginDt: json['last_login_dt'] as String?,
  activeFlag: (json['active_flag'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'kind': instance.kind,
      'kind_name': instance.kindName,
      'phone': instance.phone,
      'email': instance.email,
      'first_contact_date': instance.firstContactDate,
      'reg_dt': instance.regDt,
      'last_login_dt': instance.lastLoginDt,
      'active_flag': instance.activeFlag,
    };

_$StaffCreateImpl _$$StaffCreateImplFromJson(Map<String, dynamic> json) =>
    _$StaffCreateImpl(
      name: json['name'] as String,
      phone: json['phone'] as String,
      kind: (json['kind'] as num).toInt(),
    );

Map<String, dynamic> _$$StaffCreateImplToJson(_$StaffCreateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'kind': instance.kind,
    };

_$StaffListParamsImpl _$$StaffListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$StaffListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 200,
  sort: json['sort'] as String?,
  order: json['order'] as String?,
  search: json['search'] as String?,
);

Map<String, dynamic> _$$StaffListParamsImplToJson(
  _$StaffListParamsImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'sort': instance.sort,
  'order': instance.order,
  'search': instance.search,
};
