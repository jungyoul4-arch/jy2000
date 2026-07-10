import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_event_type.freezed.dart';
part 'schedule_event_type.g.dart';

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

/// 일정 유형 (색상) 모델
@freezed
class ScheduleEventType with _$ScheduleEventType {
  const ScheduleEventType._();

  const factory ScheduleEventType({
    @JsonKey(name: 'event_type_id') required int eventTypeId,
    @JsonKey(name: 'event_type_name') required String eventTypeName,
    @JsonKey(name: 'color_code') required String colorCode,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @IntToBoolConverter() @Default(true) bool isActive,
  }) = _ScheduleEventType;

  factory ScheduleEventType.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventTypeFromJson(json);

  /// Color 객체로 변환
  Color get color {
    try {
      final hex = colorCode.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }

  /// 텍스트 색상 (배경색에 따라 검정 또는 흰색)
  Color get textColor {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
