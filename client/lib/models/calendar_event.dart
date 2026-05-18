import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required int id,
    required String type, // 'consult', 'next_consult', 'promotion'
    required String date,
    String? time, // HH:mm 형식 (24시간)
    required String title,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'student_name') String? studentName,
    @JsonKey(name: 'tc_id') int? tcId,
    @JsonKey(name: 'tc_name') String? tcName,
    @JsonKey(name: 'promotion_id') int? promotionId,
    @JsonKey(name: 'promotion_name') String? promotionName,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}
