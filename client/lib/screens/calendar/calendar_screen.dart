import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/calendar_event.dart';
import '../../providers/calendar_provider.dart';

// 한국 공휴일 데이터 (2024-2026)
final Map<String, String> koreanHolidays = {
  // 2024
  '2024-01-01': '신정',
  '2024-02-09': '설날 연휴',
  '2024-02-10': '설날',
  '2024-02-11': '설날 연휴',
  '2024-02-12': '대체공휴일',
  '2024-03-01': '삼일절',
  '2024-04-10': '국회의원선거일',
  '2024-05-05': '어린이날',
  '2024-05-06': '대체공휴일',
  '2024-05-15': '부처님오신날',
  '2024-06-06': '현충일',
  '2024-08-15': '광복절',
  '2024-09-16': '추석 연휴',
  '2024-09-17': '추석',
  '2024-09-18': '추석 연휴',
  '2024-10-03': '개천절',
  '2024-10-09': '한글날',
  '2024-12-25': '크리스마스',
  // 2025
  '2025-01-01': '신정',
  '2025-01-28': '설날 연휴',
  '2025-01-29': '설날',
  '2025-01-30': '설날 연휴',
  '2025-03-01': '삼일절',
  '2025-05-05': '어린이날',
  '2025-05-05': '부처님오신날',
  '2025-06-06': '현충일',
  '2025-08-15': '광복절',
  '2025-10-03': '개천절',
  '2025-10-05': '추석 연휴',
  '2025-10-06': '추석',
  '2025-10-07': '추석 연휴',
  '2025-10-09': '한글날',
  '2025-12-25': '크리스마스',
  // 2026
  '2026-01-01': '신정',
  '2026-02-16': '설날 연휴',
  '2026-02-17': '설날',
  '2026-02-18': '설날 연휴',
  '2026-03-01': '삼일절',
  '2026-03-02': '대체공휴일',
  '2026-05-05': '어린이날',
  '2026-05-24': '부처님오신날',
  '2026-06-06': '현충일',
  '2026-08-15': '광복절',
  '2026-09-24': '추석 연휴',
  '2026-09-25': '추석',
  '2026-09-26': '추석 연휴',
  '2026-10-03': '개천절',
  '2026-10-09': '한글날',
  '2026-12-25': '크리스마스',
};

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedYearMonth = ref.watch(selectedYearMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final monthlyEventsAsync = ref.watch(monthlyEventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeMonth(-1),
              tooltip: '이전 달',
            ),
            _buildYearMonthSelector(selectedYearMonth),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeMonth(1),
              tooltip: '다음 달',
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 달력 영역
          Expanded(
            child: monthlyEventsAsync.when(
              data: (events) => _buildCalendar(selectedYearMonth, events),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('오류: $e')),
            ),
          ),
          // 하단 이벤트 목록 (선택된 날짜가 있을 때)
          if (selectedDate != null)
            _buildBottomEventList(selectedDate),
        ],
      ),
    );
  }

  Widget _buildYearMonthSelector(DateTime selectedYearMonth) {
    return InkWell(
      onTap: () => _showYearMonthPicker(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('yyyy년 MM월').format(selectedYearMonth),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _showYearMonthPicker() async {
    final selectedYearMonth = ref.read(selectedYearMonthProvider);
    int selectedYear = selectedYearMonth.year;
    int selectedMonth = selectedYearMonth.month;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('년월 선택'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 년도 선택
                DropdownButtonFormField<int>(
                  value: selectedYear,
                  decoration: const InputDecoration(labelText: '년도'),
                  items: List.generate(10, (i) => DateTime.now().year - 5 + i)
                      .map((y) => DropdownMenuItem(value: y, child: Text('$y년')))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedYear = v!),
                ),
                const SizedBox(height: 16),
                // 월 선택
                DropdownButtonFormField<int>(
                  value: selectedMonth,
                  decoration: const InputDecoration(labelText: '월'),
                  items: List.generate(12, (i) => i + 1)
                      .map((m) => DropdownMenuItem(value: m, child: Text('$m월')))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedMonth = v!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () {
                ref.read(selectedYearMonthProvider.notifier).state =
                    DateTime(selectedYear, selectedMonth);
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  void _changeMonth(int delta) {
    final current = ref.read(selectedYearMonthProvider);
    ref.read(selectedYearMonthProvider.notifier).state = DateTime(
      current.year,
      current.month + delta,
    );
  }

  String _formatDateWithWeekday(DateTime date) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[date.weekday - 1];
    return '${date.year}년 ${date.month}월 ${date.day}일 ($weekday)';
  }

  Widget _buildCalendar(DateTime selectedYearMonth, List<CalendarEvent> events) {
    final eventsByDate = groupEventsByDate(events);
    final firstDayOfMonth = DateTime(selectedYearMonth.year, selectedYearMonth.month, 1);
    final lastDayOfMonth = DateTime(selectedYearMonth.year, selectedYearMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0=일, 1=월, ...
    final daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        // 요일 헤더
        _buildWeekdayHeader(),
        const Divider(height: 1),
        // 날짜 그리드
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.75,
            ),
            itemCount: 42, // 6주 * 7일
            itemBuilder: (context, index) {
              final dayOffset = index - firstWeekday;
              if (dayOffset < 0 || dayOffset >= daysInMonth) {
                return const SizedBox(); // 빈 셀
              }

              final day = dayOffset + 1;
              final date = DateTime(selectedYearMonth.year, selectedYearMonth.month, day);
              final dateStr = DateFormat('yyyy-MM-dd').format(date);
              final dayEvents = eventsByDate[dateStr] ?? [];
              final isHoliday = koreanHolidays.containsKey(dateStr);
              final isSunday = date.weekday == 7;
              final isSaturday = date.weekday == 6;
              final selectedDate = ref.watch(selectedDateProvider);
              final isSelected = selectedDate != null &&
                  selectedDate.year == date.year &&
                  selectedDate.month == date.month &&
                  selectedDate.day == date.day;

              return _buildDayCell(
                day: day,
                date: date,
                events: dayEvents,
                isHoliday: isHoliday,
                isSunday: isSunday,
                isSaturday: isSaturday,
                isSelected: isSelected,
                holidayName: koreanHolidays[dateStr],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: weekdays.asMap().entries.map((entry) {
          final index = entry.key;
          final weekday = entry.value;
          Color color = Colors.black;
          if (index == 0) color = Colors.red;
          if (index == 6) color = Colors.blue;
          return Expanded(
            child: Center(
              child: Text(
                weekday,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayCell({
    required int day,
    required DateTime date,
    required List<CalendarEvent> events,
    required bool isHoliday,
    required bool isSunday,
    required bool isSaturday,
    required bool isSelected,
    String? holidayName,
  }) {
    Color dayColor = Colors.black;
    if (isSunday || isHoliday) dayColor = Colors.red;
    else if (isSaturday) dayColor = Colors.blue;

    return GestureDetector(
      onTap: () {
        ref.read(selectedDateProvider.notifier).state = date;
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3) : null,
        ),
        child: Column(
          children: [
            // 날짜
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '$day',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: dayColor,
                  fontSize: 14,
                ),
              ),
            ),
            // 이벤트 목록
            Expanded(
              child: _buildEventList(events),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(List<CalendarEvent> events) {
    if (events.isEmpty) return const SizedBox();

    // 설명회를 먼저, 상담은 나중에
    final sortedEvents = [...events]..sort((a, b) {
      if (a.type == 'promotion' && b.type != 'promotion') return -1;
      if (a.type != 'promotion' && b.type == 'promotion') return 1;
      return 0;
    });

    // 6개까지 표시, 7개 이상이면 5개 + '...'
    final totalCount = sortedEvents.length;
    final int maxVisible = totalCount <= 6 ? totalCount : 5;
    final visibleEvents = sortedEvents.take(maxVisible).toList();
    final hasMore = totalCount > 6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...visibleEvents.map((event) => _buildEventChip(event)),
          if (hasMore)
            Text(
              '...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventChip(CalendarEvent event) {
    final isPromotion = event.type == 'promotion';
    final backgroundColor = isPromotion ? Colors.red : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        isPromotion ? '설명회' : event.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildBottomEventList(DateTime selectedDate) {
    final dailyEventsAsync = ref.watch(dailyEventsProvider);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Text(
                  _formatDateWithWeekday(selectedDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    ref.read(selectedDateProvider.notifier).state = null;
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // 이벤트 목록
          Expanded(
            child: dailyEventsAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return const Center(child: Text('일정이 없습니다'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _buildEventListTile(event);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('오류: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventListTile(CalendarEvent event) {
    final isPromotion = event.type == 'promotion';
    final isNextConsult = event.type == 'next_consult';
    final backgroundColor = isPromotion ? Colors.red : Colors.blue;
    final icon = isPromotion ? Icons.event : Icons.chat;

    String subtitle = '';
    if (isPromotion) {
      subtitle = event.promotionName ?? '';
    } else {
      subtitle = isNextConsult ? '(예정) ${event.tcName ?? ''}' : event.tcName ?? '';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: backgroundColor,
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        title: Text(
          isPromotion ? '설명회' : event.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (isPromotion) {
            context.push('/promotions/${event.promotionId}');
          } else {
            context.push('/consults/${event.id}');
          }
        },
      ),
    );
  }
}
