import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_category.dart' show IntToBoolConverter;

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
    @JsonKey(name: 'event_hour') int? eventHour,
    @JsonKey(name: 'event_minute') @Default(0) int eventMinute,
    String? content,
    @JsonKey(name: 'is_important')
    @IntToBoolConverter()
    @Default(false)
    bool isImportant,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'student_phone') String? studentPhone,
    @JsonKey(name: 'student_grade') int? studentGrade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @JsonKey(name: 'school_name') String? schoolName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'consult_id') int? consultId,
    @JsonKey(name: 'consult_date') String? consultDate,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
    @JsonKey(name: 'consult_type_name') String? consultTypeName,
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

  /// 중요 일정 표시용 텍스트 색상 (중요 일정은 빨간색)
  Color get displayTextColor => isImportant ? Colors.red : textColor;

  /// 중요 일정 표시용 글자 굵기 (중요 일정은 볼드)
  FontWeight get displayFontWeight =>
      isImportant ? FontWeight.bold : FontWeight.normal;

  /// 시간대(TIME_SLOT) 카테고리 일정 여부 - 분 지정이 가능한 카테고리
  bool get isTimeSlot => categoryType == 'TIME_SLOT';

  /// 상담(전화상담) 카테고리 일정 여부 - 시:분을 직접 갖는 카테고리
  bool get isConsultCategory => categoryType == 'CONSULT';

  /// 학생 연동 여부
  bool get hasStudent => studentId != null;

  /// 상담 연동 여부
  bool get hasConsult => consultId != null;

  /// 표시용 짧은 내용 (최대 50자)
  String get shortContent {
    if (content == null || content!.isEmpty) return '';
    return content!.length > 50 ? '${content!.substring(0, 50)}...' : content!;
  }

  /// 시각 접두사
  ///
  /// - 시간대 슬롯: 분만 표시 (0분도 표시) 예) `00'`, `30'`
  /// - 전화상담: 시:분 표시 예) `14:30`
  String get minutePrefix {
    if (isConsultCategory) {
      if (eventHour == null) return '';
      return '${eventHour.toString().padLeft(2, '0')}:${eventMinute.toString().padLeft(2, '0')}';
    }

    return isTimeSlot ? "${eventMinute.toString().padLeft(2, '0')}'" : '';
  }

  /// 캘린더 표시용 텍스트: [분]' [학생명]([학교명][학년])-[내용]
  /// 예: 30' 김민재(중원고3)-수학테스트, 00' 상담
  String get displayText {
    final parts = <String>[];

    // 학생명 추가
    if (studentName != null && studentName!.isNotEmpty) {
      var studentPart = studentName!;

      // 학교명과 학년 추가
      if (schoolName != null || gradeName != null) {
        final schoolInfo = <String>[];
        if (schoolName != null) schoolInfo.add(schoolName!);
        if (gradeName != null) schoolInfo.add(gradeName!);
        studentPart += '(${schoolInfo.join('')})';
      }

      parts.add(studentPart);
    }

    // 내용 추가
    if (content != null && content!.isNotEmpty) {
      parts.add(content!);
    }

    final body = parts.join('-');
    final prefix = minutePrefix;

    if (prefix.isEmpty) return body;
    return body.isEmpty ? prefix : '$prefix $body';
  }
}

/// 일정 생성 DTO
@freezed
class ScheduleEventCreate with _$ScheduleEventCreate {
  const factory ScheduleEventCreate({
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'event_type_id') required int eventTypeId,
    @JsonKey(name: 'event_date') required String eventDate,
    @JsonKey(name: 'event_hour') int? eventHour,
    @JsonKey(name: 'event_minute') @Default(0) int eventMinute,
    String? content,
    @JsonKey(name: 'is_important') @Default(false) bool isImportant,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
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
    @JsonKey(name: 'event_hour') int? eventHour,
    @JsonKey(name: 'event_minute') int? eventMinute,
    String? content,
    @JsonKey(name: 'is_important') bool? isImportant,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'consult_type_code') String? consultTypeCode,
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
