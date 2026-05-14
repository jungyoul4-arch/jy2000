import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calendar_event.dart';
import '../repositories/calendar_repository.dart';

// Repository Provider
final calendarRepositoryProvider = Provider((ref) => CalendarRepository());

// 선택된 년월 Provider
final selectedYearMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

// 선택된 날짜 Provider
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// 월별 이벤트 Provider
final monthlyEventsProvider = FutureProvider.autoDispose<List<CalendarEvent>>((ref) async {
  final selectedDate = ref.watch(selectedYearMonthProvider);
  final repository = ref.read(calendarRepositoryProvider);
  return repository.getMonthlyEvents(selectedDate.year, selectedDate.month);
});

// 선택된 날짜의 이벤트 Provider
final dailyEventsProvider = FutureProvider.autoDispose<List<CalendarEvent>>((ref) async {
  final selectedDate = ref.watch(selectedDateProvider);
  if (selectedDate == null) return [];

  final repository = ref.read(calendarRepositoryProvider);
  final dateStr = '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
  return repository.getDailyEvents(dateStr);
});

// 날짜별 이벤트 그룹핑 Helper
Map<String, List<CalendarEvent>> groupEventsByDate(List<CalendarEvent> events) {
  final Map<String, List<CalendarEvent>> grouped = {};
  for (final event in events) {
    grouped.putIfAbsent(event.date, () => []);
    grouped[event.date]!.add(event);
  }
  return grouped;
}
