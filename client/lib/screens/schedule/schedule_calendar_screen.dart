import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../config/routes.dart';
import '../../models/promotion.dart';
import '../../models/schedule_category.dart';
import '../../models/schedule_event.dart';
import '../../models/schedule_event_type.dart';
import '../../providers/promotion_provider.dart';
import '../../providers/schedule_provider.dart';
import 'schedule_event_dialog.dart';

class ScheduleCalendarScreen extends ConsumerStatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  ConsumerState<ScheduleCalendarScreen> createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends ConsumerState<ScheduleCalendarScreen> {
  final ScrollController _verticalScrollController = ScrollController();

  // 셀 크기
  static const double cellWidth = 360.0;
  static const double categoryColumnWidth = 100.0;
  static const double dayHeaderHeight = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scheduleEventsProvider.notifier).loadEvents();
      ref.read(promotionListProvider.notifier).fetchList(
        params: const PromotionListParams(perPage: 1000),
        refresh: true,
      );
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(scheduleEventsProvider);
    final categoriesAsync = ref.watch(scheduleCategoriesProvider);
    final eventTypesAsync = ref.watch(scheduleEventTypesProvider);
    final promotionState = ref.watch(promotionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('일정 캘린더 - ${DateFormat('yyyy년 M월').format(eventsState.selectedMonth)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => ref.read(scheduleEventsProvider.notifier).previousMonth(),
            tooltip: '이전 달',
          ),
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => ref.read(scheduleEventsProvider.notifier).changeMonth(DateTime.now()),
            tooltip: '오늘',
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => ref.read(scheduleEventsProvider.notifier).nextMonth(),
            tooltip: '다음 달',
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(scheduleEventsProvider.notifier).refresh();
              ref.read(promotionListProvider.notifier).refresh();
            },
            tooltip: '새로고침',
          ),
        ],
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('카테고리 로드 실패: $err')),
        data: (categories) => eventTypesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('일정 유형 로드 실패: $err')),
          data: (eventTypes) => _buildBody(
            context,
            eventsState,
            categories,
            eventTypes,
            promotionState.promotions,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ScheduleEventsState eventsState,
    List<ScheduleCategory> categories,
    List<ScheduleEventType> eventTypes,
    List<Promotion> promotions,
  ) {
    return Row(
      children: [
        // 좌측 미니 캘린더 (고정)
        Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: _buildMiniCalendar(eventsState),
        ),
        // 우측 메인 그리드
        Expanded(
          child: _buildWeeklyGrid(
            context,
            eventsState,
            categories,
            eventTypes,
            promotions,
          ),
        ),
      ],
    );
  }

  /// 좌측 미니 캘린더
  Widget _buildMiniCalendar(ScheduleEventsState eventsState) {
    final month = eventsState.selectedMonth;
    final firstDay = eventsState.firstDayOfMonth;
    final daysInMonth = eventsState.daysInMonth;
    final startWeekday = firstDay.weekday % 7;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            DateFormat('yyyy년 M월').format(month),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: ['일', '월', '화', '수', '목', '금', '토']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: TextStyle(
                            fontSize: 12,
                            color: d == '일'
                                ? Colors.red
                                : d == '토'
                                    ? Colors.blue
                                    : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final day = index - startWeekday + 1;
              if (day < 1 || day > daysInMonth) {
                return const SizedBox();
              }

              final date = DateTime(month.year, month.month, day);
              final isToday = _isToday(date);
              final hasEvents = eventsState.eventsForDate(date).isNotEmpty;
              final weekday = date.weekday;

              return Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isToday ? Colors.orange.shade100 : null,
                  borderRadius: BorderRadius.circular(4),
                  border: isToday ? Border.all(color: Colors.orange, width: 2) : null,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: weekday == DateTime.sunday
                              ? Colors.red
                              : weekday == DateTime.saturday
                                  ? Colors.blue
                                  : Colors.black,
                        ),
                      ),
                    ),
                    if (hasEvents)
                      Positioned(
                        bottom: 2,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(height: 16),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              const Text('오늘', style: TextStyle(fontSize: 11)),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text('일정있음', style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  /// 주간 단위 그리드
  Widget _buildWeeklyGrid(
    BuildContext context,
    ScheduleEventsState eventsState,
    List<ScheduleCategory> categories,
    List<ScheduleEventType> eventTypes,
    List<Promotion> promotions,
  ) {
    final month = eventsState.selectedMonth;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    final startWeekday = firstDayOfMonth.weekday % 7;
    final calendarStartDate = firstDayOfMonth.subtract(Duration(days: startWeekday));

    final endWeekday = lastDayOfMonth.weekday % 7;
    final calendarEndDate = lastDayOfMonth.add(Duration(days: 6 - endWeekday));

    final totalDays = calendarEndDate.difference(calendarStartDate).inDays + 1;
    final totalWeeks = (totalDays / 7).ceil();

    if (eventsState.isLoading && eventsState.events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      controller: _verticalScrollController,
      child: Column(
        children: List.generate(totalWeeks, (weekIndex) {
          final weekStartDate = calendarStartDate.add(Duration(days: weekIndex * 7));
          return _WeekSection(
            key: ValueKey('week_${weekStartDate.toString()}'),
            weekStartDate: weekStartDate,
            month: month,
            eventsState: eventsState,
            categories: categories,
            eventTypes: eventTypes,
            promotions: promotions,
            onShowEventDialog: _showEventDialog,
          );
        }),
      ),
    );
  }

  void _showEventDialog(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    List<ScheduleEventType> eventTypes, {
    ScheduleEvent? existingEvent,
  }) {
    showDialog(
      context: context,
      builder: (context) => ScheduleEventDialog(
        category: category,
        date: date,
        eventTypes: eventTypes,
        existingEvent: existingEvent,
        onSave: (eventTypeId, content, studentId) async {
          if (existingEvent != null) {
            final success = await ref.read(scheduleEventsProvider.notifier).updateEvent(
              eventId: existingEvent.eventId,
              eventTypeId: eventTypeId,
              content: content,
              studentId: studentId,
            );
            return success;
          } else {
            final success = await ref.read(scheduleEventsProvider.notifier).createEvent(
              categoryId: category.categoryId,
              eventTypeId: eventTypeId,
              eventDate: date,
              content: content,
              studentId: studentId,
            );
            return success;
          }
        },
        onDelete: existingEvent != null
            ? () async {
                final success = await ref
                    .read(scheduleEventsProvider.notifier)
                    .deleteEvent(existingEvent.eventId);
                return success;
              }
            : null,
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

/// 한 주 섹션 (연결된 스크롤 컨트롤러 사용)
class _WeekSection extends StatefulWidget {
  final DateTime weekStartDate;
  final DateTime month;
  final ScheduleEventsState eventsState;
  final List<ScheduleCategory> categories;
  final List<ScheduleEventType> eventTypes;
  final List<Promotion> promotions;
  final void Function(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    List<ScheduleEventType> eventTypes, {
    ScheduleEvent? existingEvent,
  }) onShowEventDialog;

  const _WeekSection({
    super.key,
    required this.weekStartDate,
    required this.month,
    required this.eventsState,
    required this.categories,
    required this.eventTypes,
    required this.promotions,
    required this.onShowEventDialog,
  });

  @override
  State<_WeekSection> createState() => _WeekSectionState();
}

class _WeekSectionState extends State<_WeekSection> {
  late LinkedScrollControllerGroup _controllers;
  late List<ScrollController> _scrollControllers;

  static const double cellWidth = 360.0;
  static const double categoryColumnWidth = 100.0;
  static const double dayHeaderHeight = 40.0;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    // 헤더 + 각 카테고리 행에 대한 스크롤 컨트롤러
    _scrollControllers = List.generate(
      widget.categories.length + 1,
      (_) => _controllers.addAndGet(),
    );
  }

  @override
  void dispose() {
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = List.generate(7, (i) => widget.weekStartDate.add(Duration(days: i)));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          // 주차 헤더
          _buildWeekHeader(weekDates, _scrollControllers[0]),
          // 카테고리별 행
          ...widget.categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return _buildCategoryRow(
              category,
              weekDates,
              _scrollControllers[index + 1],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeekHeader(List<DateTime> weekDates, ScrollController scrollController) {
    return Container(
      height: dayHeaderHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: weekDates.map((date) {
            final isCurrentMonth = date.month == widget.month.month;
            final isToday = _isToday(date);
            final weekdayNames = ['', '월', '화', '수', '목', '금', '토', '일'];

            return Row(
              children: [
                // 카테고리 열 헤더
                Container(
                  width: categoryColumnWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border(right: BorderSide(color: Colors.grey.shade400)),
                  ),
                  child: const Center(
                    child: Text('카테고리', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ),
                // 날짜 헤더
                Container(
                  width: cellWidth,
                  decoration: BoxDecoration(
                    color: isToday ? Colors.orange.shade100 : null,
                    border: Border(right: BorderSide(color: Colors.grey.shade400, width: 2)),
                  ),
                  child: Center(
                    child: Text(
                      '${date.month}/${date.day} (${weekdayNames[date.weekday]})',
                      style: TextStyle(
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                        color: !isCurrentMonth
                            ? Colors.grey
                            : date.weekday == DateTime.sunday
                                ? Colors.red
                                : date.weekday == DateTime.saturday
                                    ? Colors.blue
                                    : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
    ScheduleCategory category,
    List<DateTime> weekDates,
    ScrollController scrollController,
  ) {
    final minRowHeight = _getMinCategoryRowHeight(category);

    return Container(
      constraints: BoxConstraints(minHeight: minRowHeight),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: weekDates.map((date) {
              final isCurrentMonth = date.month == widget.month.month;
              final events = widget.eventsState.eventsForCategoryAndDate(category.categoryId, date);

              return Row(
                children: [
                  // 카테고리명 (각 날짜 앞에 반복)
                  Container(
                    width: categoryColumnWidth,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      border: Border(right: BorderSide(color: Colors.grey.shade400)),
                    ),
                    child: Center(
                      child: Text(
                        category.categoryName,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // 셀
                  _buildCell(
                    context,
                    category,
                    date,
                    isCurrentMonth,
                    events,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCell(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    bool isCurrentMonth,
    List<ScheduleEvent> events,
  ) {
    if (category.isPromotion) {
      return _buildPromotionCell(context, date, isCurrentMonth);
    }

    final isToday = _isToday(date);

    return GestureDetector(
      onTap: isCurrentMonth
          ? () => widget.onShowEventDialog(context, category, date, widget.eventTypes)
          : null,
      child: Container(
        width: cellWidth,
        decoration: BoxDecoration(
          color: !isCurrentMonth
              ? Colors.grey.shade100
              : isToday
                  ? Colors.orange.shade50
                  : null,
          border: Border(right: BorderSide(color: Colors.grey.shade400, width: 2)),
        ),
        padding: const EdgeInsets.all(4),
        child: events.isEmpty
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: events.map((event) {
                  return GestureDetector(
                    onTap: () => widget.onShowEventDialog(
                      context,
                      category,
                      date,
                      widget.eventTypes,
                      existingEvent: event,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: event.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        event.content ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: event.textColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildPromotionCell(BuildContext context, DateTime date, bool isCurrentMonth) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final matchingPromotions = widget.promotions.where((p) => _normalizeDate(p.startDate) == dateStr).toList();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isPast = date.isBefore(today);
    final isToday = _isToday(date);

    return Container(
      width: cellWidth,
      decoration: BoxDecoration(
        color: !isCurrentMonth
            ? Colors.grey.shade100
            : matchingPromotions.isNotEmpty
                ? Colors.pink.shade50
                : isToday
                    ? Colors.orange.shade50
                    : null,
        border: Border(right: BorderSide(color: Colors.grey.shade400, width: 2)),
      ),
      padding: const EdgeInsets.all(4),
      child: matchingPromotions.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: matchingPromotions.map((promotion) {
                return GestureDetector(
                  onTap: () => context.push('${AppRoutes.promotionList}/${promotion.promotionId}'),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            promotion.promotionName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => context.push('${AppRoutes.promotionList}/${promotion.promotionId}'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            minimumSize: Size.zero,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          child: const Text('상세보기', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          : (isCurrentMonth && !isPast)
              ? Center(
                  child: TextButton.icon(
                    onPressed: () => context.push('${AppRoutes.promotionCreate}?date=$dateStr'),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('설명회 등록', style: TextStyle(fontSize: 12)),
                  ),
                )
              : null,
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String _normalizeDate(String dateStr) {
    if (dateStr.contains('T')) {
      return dateStr.split('T')[0];
    }
    return dateStr.length >= 10 ? dateStr.substring(0, 10) : dateStr;
  }

  double _getMinCategoryRowHeight(ScheduleCategory category) {
    if (category.isTimeSlot) return 60;
    if (category.isPromotion) return 80;
    return 80;
  }

  Color? _getCategoryColor(ScheduleCategory category) {
    switch (category.categoryType) {
      case 'INFO':
        return Colors.yellow.shade50;
      case 'TIME_SLOT':
        return Colors.white;
      case 'PROMOTION':
        return Colors.pink.shade100;
      case 'ISSUE':
        return Colors.pink.shade50;
      default:
        return null;
    }
  }
}
