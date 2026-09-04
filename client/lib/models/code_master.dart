import 'package:freezed_annotation/freezed_annotation.dart';

part 'code_master.freezed.dart';
part 'code_master.g.dart';

@freezed
class CodeMaster with _$CodeMaster {
  const factory CodeMaster({
    @JsonKey(name: 'code_id') required String codeId,
    @JsonKey(name: 'code_group') required String codeGroup,
    @JsonKey(name: 'code_value') required String codeValue,
    @JsonKey(name: 'code_name') required String codeName,
    @JsonKey(name: 'code_name_en') String? codeNameEn,
    @JsonKey(name: 'parent_code_id') String? parentCodeId,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _CodeMaster;

  factory CodeMaster.fromJson(Map<String, dynamic> json) =>
      _$CodeMasterFromJson(json);
}

// 코드 그룹 상수
class CodeGroup {
  static const String role = 'ROLE';
  static const String gender = 'GENDER';
  static const String grade = 'GRADE';
  static const String status = 'STATUS';
  static const String subStatus = 'SUB_STATUS';
  static const String consultType = 'CONSULT_TYPE';
  static const String channel = 'CHANNEL';
  static const String consultResult = 'CONSULT_RESULT';
  static const String nextAction = 'NEXT_ACTION';
  static const String source = 'SOURCE';
  static const String inquirySource = 'INQUIRY_SOURCE';
  static const String relation = 'RELATION';
  static const String tcType = 'TC_TYPE';
  static const String branch = 'BRANCH';
  static const String promotionType = 'PROMOTION_TYPE';
  static const String discountType = 'DISCOUNT_TYPE';
}
