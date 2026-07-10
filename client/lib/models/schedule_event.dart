import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_event.freezed.dart';
part 'schedule_event.g.dart';

/// 일정 이벤트 모델
@freezed
class ScheduleEvent with _$ScheduleEvent {
  const ScheduleEvent._();

  const factory ScheduleEvent({
    @JsonKey(name: 'event_id') required int eventId,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_type') String? categoryType,
    @JsonKey(name: 'event_type_id') required int eventTypeId,
    @JsonKey(name: 'event_type_name') String? eventTypeName,
    @JsonKey(name: 'color_code') String? colorCode,
    @JsonKey(name: 'event_date') required String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'consult_id') int? consultId,
    @JsonKey(name: 'created_by') required int createdBy,
    @JsonKey(name: 'created_by_name') String? createdByName,
    @JsonKey(name: 'updated_by') int? updatedBy,
    @JsonKey(name: 'updated_by_name') String? updatedByName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ScheduleEvent;

  factory ScheduleEvent.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventFromJson(json);

  /// Color 객체로 변환
  Color get color {
    if (colorCode == null) return Colors.grey;
    try {
      final hex = colorCode!.replaceFirst('#', '');
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

  /// 학생 연동 여부
  bool get hasStudent => studentId != null;

  /// 상담 연동 여부
  bool get hasConsult => consultId != null;

  /// 표시용 짧은 내용 (최대 50자)
  String get shortContent {
    if (content == null || content!.isEmpty) return '';
    return content!.length > 50 ? '${content!.substring(0, 50)}...' : content!;
  }
}

/// 일정 생성 DTO
@freezed
class ScheduleEventCreate with _$ScheduleEventCreate {
  const factory ScheduleEventCreate({
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'event_type_id') required int eventTypeId,
    @JsonKey(name: 'event_date') required String eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  }) = _ScheduleEventCreate;

  factory ScheduleEventCreate.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventCreateFromJson(json);
}

/// 일정 수정 DTO
@freezed
class ScheduleEventUpdate with _$ScheduleEventUpdate {
  const factory ScheduleEventUpdate({
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'event_date') String? eventDate,
    String? content,
    @JsonKey(name: 'student_id') int? studentId,
  }) = _ScheduleEventUpdate;

  factory ScheduleEventUpdate.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventUpdateFromJson(json);
}

/// 일정 목록 조회 파라미터
@freezed
class ScheduleEventListParams with _$ScheduleEventListParams {
  const factory ScheduleEventListParams({
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'event_type_id') int? eventTypeId,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'created_by') int? createdBy,
    @Default(1) int page,
    @Default(1000) int perPage,
  }) = _ScheduleEventListParams;

  factory ScheduleEventListParams.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventListParamsFromJson(json);
}
