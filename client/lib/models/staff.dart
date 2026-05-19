import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.freezed.dart';
part 'staff.g.dart';

@freezed
class Staff with _$Staff {
  const factory Staff({
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    required int kind,
    @JsonKey(name: 'kind_name') required String kindName,
    required String phone,
    String? email,
    @JsonKey(name: 'first_contact_date') String? firstContactDate,
    @JsonKey(name: 'reg_dt') required String regDt,
    @JsonKey(name: 'last_login_dt') String? lastLoginDt,
    @JsonKey(name: 'active_flag') @Default(1) int activeFlag,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}

@freezed
class StaffCreate with _$StaffCreate {
  const factory StaffCreate({
    required String name,
    required String phone,
    required int kind,
  }) = _StaffCreate;

  factory StaffCreate.fromJson(Map<String, dynamic> json) =>
      _$StaffCreateFromJson(json);
}

@freezed
class StaffListParams with _$StaffListParams {
  const factory StaffListParams({
    @Default(1) int page,
    @Default(200) int perPage,  // 직원은 100명 미만이므로 전체 표시
    String? sort,
    String? order,
    String? search,
  }) = _StaffListParams;

  factory StaffListParams.fromJson(Map<String, dynamic> json) =>
      _$StaffListParamsFromJson(json);
}

// kind 값에 따른 역할명
String getKindName(int kind) {
  switch (kind) {
    case 1:
      return '관리자';
    case 3:
      return '선생님';
    case 5:
      return '상담원';
    case 6:
      return '사감';
    case 7:
      return '일반직원';
    default:
      return '알 수 없음';
  }
}

// 역할 목록 (직원 등록 시 사용)
const List<Map<String, dynamic>> staffKindOptions = [
  {'kind': 1, 'name': '관리자'},
  {'kind': 3, 'name': '선생님'},
  {'kind': 5, 'name': '상담원'},
  {'kind': 6, 'name': '사감'},
  {'kind': 7, 'name': '일반직원'},
];
