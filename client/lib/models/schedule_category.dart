import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_category.freezed.dart';
part 'schedule_category.g.dart';

// int를 bool로 변환하는 컨버터
class IntToBoolConverter implements JsonConverter<bool, dynamic> {
  const IntToBoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is int) return json == 1;
    return false;
  }

  @override
  dynamic toJson(bool object) => object ? 1 : 0;
}

/// 일정 카테고리 모델
/// category_type: INFO, TIME_SLOT, ISSUE, OTHER
@freezed
class ScheduleCategory with _$ScheduleCategory {
  const ScheduleCategory._();

  const factory ScheduleCategory({
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'category_type') required String categoryType,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() @Default(true) bool isActive,
  }) = _ScheduleCategory;

  factory ScheduleCategory.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCategoryFromJson(json);

  /// 시간대 슬롯인지 확인
  bool get isTimeSlot => categoryType == 'TIME_SLOT';

  /// 정보성 카테고리인지 확인
  bool get isInfo => categoryType == 'INFO';

  /// 이슈 카테고리인지 확인
  bool get isIssue => categoryType == 'ISSUE';

  /// 설명회 카테고리인지 확인
  bool get isPromotion => categoryType == 'PROMOTION';

  /// 상담 카테고리(전화상담)인지 확인
  bool get isConsult => categoryType == 'CONSULT';
}
