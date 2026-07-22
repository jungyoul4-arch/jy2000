import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/schedule_category.dart';
import '../models/schedule_event_type.dart';
import '../models/schedule_event.dart';
import '../repositories/schedule_repository.dart';

// Repository Provider
final scheduleRepositoryProvider = Provider((ref) => ScheduleRepository());

// ============================================================
// 카테고리 Provider
// ============================================================

final scheduleCategoriesProvider = FutureProvider<List<ScheduleCategory>>((ref) async {
  final repository = ref.read(scheduleRepositoryProvider);
  return repository.getCategories();
});

// ============================================================
// 일정 유형 Provider
// ============================================================

final scheduleEventTypesProvider = FutureProvider<List<ScheduleEventType>>((ref) async {
  final repository = ref.read(scheduleRepositoryProvider);
  return repository.getEventTypes();
});

// ============================================================
// 일정 목록 상태 및 Provider
// ============================================================

class ScheduleEventsState {
  final List<ScheduleEvent> events;
  final bool isLoading;
  final String? error;
  final DateTime selectedMonth;

  ScheduleEventsState({
    this.events = const [],
    this.isLoading = false,
    this.error,
    DateTime? selectedMonth,
  }) : selectedMonth = selectedMonth ?? DateTime.now();

  ScheduleEventsState copyWith({
    List<ScheduleEvent>? events,
    bool? isLoading,
    String? error,
    DateTime? selectedMonth,
  }) {
    return ScheduleEventsState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }

  /// 특정 날짜의 일정 목록
  List<ScheduleEvent> eventsForDate(DateTime date) {
    final dateStr = _formatDate(date);
    return events.where((e) => _normalizeDate(e.eventDate) == dateStr).toList();
  }

  /// 특정 카테고리 + 날짜의 일정 목록
  List<ScheduleEvent> eventsForCategoryAndDate(int categoryId, DateTime date) {
    final dateStr = _formatDate(date);
    return events.where((e) =>
      e.categoryId == categoryId && _normalizeDate(e.eventDate) == dateStr
    ).toList();
  }

  /// 날짜 포맷 (YYYY-MM-DD)
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 서버에서 온 날짜 문자열을 YYYY-MM-DD 형식으로 정규화
  String _normalizeDate(String dateStr) {
    // "2024-07-10T00:00:00.000Z" 또는 "2024-07-10" 형식 처리
    if (dateStr.contains('T')) {
      return dateStr.split('T')[0];
    }
    return dateStr.substring(0, 10); // 앞 10자리만 (YYYY-MM-DD)
  }

  /// 현재 월의 첫 날
  DateTime get firstDayOfMonth => DateTime(selectedMonth.year, selectedMonth.month, 1);

  /// 현재 월의 마지막 날
  DateTime get lastDayOfMonth => DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

  /// 현재 월의 날짜 수
  int get daysInMonth => lastDayOfMonth.day;
}

class ScheduleEventsNotifier extends StateNotifier<ScheduleEventsState> {
  final ScheduleRepository _repository;

  ScheduleEventsNotifier(this._repository) : super(ScheduleEventsState());

  /// 월 변경
  void changeMonth(DateTime month) {
    state = state.copyWith(selectedMonth: month);
    loadEvents();
  }

  /// 이전 월로 이동
  void previousMonth() {
    final prev = DateTime(state.selectedMonth.year, state.selectedMonth.month - 1);
    changeMonth(prev);
  }

  /// 다음 월로 이동
  void nextMonth() {
    final next = DateTime(state.selectedMonth.year, state.selectedMonth.month + 1);
    changeMonth(next);
  }

  /// 일정 목록 로드
  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final fromDate = _formatDate(state.firstDayOfMonth);
      final toDate = _formatDate(state.lastDayOfMonth);

      final events = await _repository.getEvents(
        fromDate: fromDate,
        toDate: toDate,
      );
      state = state.copyWith(events: events, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 일정 등록
  Future<bool> createEvent({
    required int categoryId,
    required int eventTypeId,
    required DateTime eventDate,
    String? content,
    int? studentId,
  }) async {
    try {
      await _repository.createEvent(
        categoryId: categoryId,
        eventTypeId: eventTypeId,
        eventDate: _formatDate(eventDate),
        content: content,
        studentId: studentId,
      );
      // 전체 목록 다시 로드 (조인된 정보를 포함하여)
      await loadEvents();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// 일정 수정
  Future<bool> updateEvent({
    required int eventId,
    int? categoryId,
    int? eventTypeId,
    DateTime? eventDate,
    String? content,
    int? studentId,
  }) async {
    try {
      await _repository.updateEvent(
        eventId,
        categoryId: categoryId,
        eventTypeId: eventTypeId,
        eventDate: eventDate != null ? _formatDate(eventDate) : null,
        content: content,
        studentId: studentId,
      );
      // 전체 목록 다시 로드 (조인된 정보를 포함하여)
      await loadEvents();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// 일정 삭제
  Future<bool> deleteEvent(int eventId) async {
    try {
      await _repository.deleteEvent(eventId);
      // 전체 목록 다시 로드
      await loadEvents();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 새로고침
  Future<void> refresh() async {
    await loadEvents();
  }

  /// 날짜 포맷 (YYYY-MM-DD)
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// Provider
final scheduleEventsProvider =
    StateNotifierProvider<ScheduleEventsNotifier, ScheduleEventsState>((ref) {
  return ScheduleEventsNotifier(ref.read(scheduleRepositoryProvider));
});
