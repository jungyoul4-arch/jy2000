import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/routes.dart';
import '../../models/promotion.dart';
import '../../models/schedule_category.dart';
import '../../models/schedule_event.dart';
import '../../models/schedule_event_type.dart';
import '../../providers/promotion_provider.dart';
import '../../providers/schedule_provider.dart';
import 'schedule_event_dialog.dart';
import 'schedule_event_list_dialog.dart';
import '../../widgets/logout_button.dart';

class ScheduleCalendarScreen extends ConsumerStatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  ConsumerState<ScheduleCalendarScreen> createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends ConsumerState<ScheduleCalendarScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  final Map<String, GlobalKey> _weekKeys = {};
  Timer? _scrollRetryTimer;

  // 셀 크기
  static const double cellWidth = 360.0;
  static const double categoryColumnWidth = 100.0;
  static const double dayHeaderHeight = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(scheduleEventsProvider.notifier);
      final previousDate = ref.read(scheduleEventsProvider).selectedDate;

      // 선택된 날짜가 없을 때(로그인 후 첫 진입)만 오늘로 이동한다.
      // 다른 메뉴에 갔다 돌아온 경우에는 이전에 선택한 날짜를 그대로 유지한다.
      final targetDate = previousDate ?? DateTime.now();

      if (previousDate == null) {
        notifier.selectDate(targetDate);
      }

      ref.read(promotionListProvider.notifier).fetchList(
        params: const PromotionListParams(perPage: 1000),
        refresh: true,
      );

      // 일정 로드가 끝나야 주간 그리드가 그려지므로, 로드 후 스크롤
      await notifier.loadEvents();
      _scrollToDateWhenReady(targetDate);
    });
  }

  /// 주간 그리드가 그려진 뒤 해당 날짜로 스크롤.
  /// 첫 진입 시에는 그리드 렌더링이 끝나지 않았을 수 있어 준비될 때까지 재시도한다.
  ///
  /// 재시도는 타이머로 돌린다. addPostFrameCallback은 다음 프레임이 예약되어 있을
  /// 때만 실행되는데, 로드가 끝나고 화면이 정지하면 프레임이 더 이상 생기지 않아
  /// 콜백이 영영 호출되지 않는다.
  void _scrollToDateWhenReady(DateTime date, {bool animate = false}) {
    _scrollRetryTimer?.cancel();
    var attempts = 0;

    void tryScroll() {
      if (!mounted) return;

      final isReady = _weekKeys[_weekKeyForDate(date)]?.currentContext != null &&
          _verticalScrollController.hasClients &&
          _horizontalScrollController.hasClients;

      if (isReady) {
        _scrollToDate(date, animate: animate);
        return;
      }

      if (++attempts >= 30) return; // 약 1.5초까지만 대기
      _scrollRetryTimer = Timer(const Duration(milliseconds: 50), tryScroll);
    }

    tryScroll();
  }

  /// 날짜가 속한 주의 GlobalKey 이름
  String _weekKeyForDate(DateTime date) {
    final month = ref.read(scheduleEventsProvider).selectedMonth;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final startWeekday = firstDayOfMonth.weekday % 7;
    final calendarStartDate = firstDayOfMonth.subtract(Duration(days: startWeekday));

    final daysFromStart = date.difference(calendarStartDate).inDays;
    final weekIndex = (daysFromStart / 7).floor();
    final weekStartDate = calendarStartDate.add(Duration(days: weekIndex * 7));

    return 'week_${weekStartDate.toString()}';
  }

  @override
  void dispose() {
    _scrollRetryTimer?.cancel();
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _weekKeys.clear();
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
          // 이전/다음 달 이동은 좌측 미니 캘린더의 년월 표시 좌우로 옮겼다
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              final today = DateTime.now();
              ref.read(scheduleEventsProvider.notifier).selectDate(today);
              ref.read(scheduleEventsProvider.notifier).changeMonth(today);
              _scrollToDateWhenReady(today);
            },
            tooltip: '오늘',
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(scheduleEventsProvider.notifier).refresh();
              ref.read(promotionListProvider.notifier).refresh();
            },
            tooltip: '새로고침',
          ),
          const SizedBox(width: 8),
          const LogoutButton(),
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
        // 년월 표시 + 이전/다음 달 이동
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () =>
                    ref.read(scheduleEventsProvider.notifier).previousMonth(),
                tooltip: '이전 달',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              Text(
                DateFormat('yyyy년 M월').format(month),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () =>
                    ref.read(scheduleEventsProvider.notifier).nextMonth(),
                tooltip: '다음 달',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
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
              final isSelected = eventsState.selectedDate != null &&
                  eventsState.selectedDate!.year == date.year &&
                  eventsState.selectedDate!.month == date.month &&
                  eventsState.selectedDate!.day == date.day;

              return InkWell(
                onTap: () {
                  ref.read(scheduleEventsProvider.notifier).selectDate(date);
                  _scrollToDate(date);
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade200
                        : isToday
                            ? Colors.orange.shade100
                            : null,
                    borderRadius: BorderRadius.circular(4),
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 2)
                        : isToday
                            ? Border.all(color: Colors.orange, width: 2)
                            : null,
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

    // 전체 컨텐츠 너비 계산: (카테고리 열 + 셀) * 7일
    final totalWidth = (categoryColumnWidth + cellWidth) * 7;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // 가로/세로 스크롤 영역
            // 세로 스크롤바는 가로 스크롤 뷰 "바깥"에 두어야 화면 오른쪽 끝에 고정된다.
            // (안쪽에 두면 트랙이 totalWidth 끝에 그려져 가로로 끝까지 스크롤해야만 보임)
            Expanded(
              child: Scrollbar(
                controller: _verticalScrollController,
                thumbVisibility: true,
                // 세로 스크롤 알림은 가로 뷰포트를 한 번 거쳐 올라오므로 depth == 1
                notificationPredicate: (notification) => notification.depth == 1,
                child: Scrollbar(
                  controller: _horizontalScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: totalWidth,
                      child: SingleChildScrollView(
                        controller: _verticalScrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: List.generate(totalWeeks, (weekIndex) {
                            final weekStartDate = calendarStartDate.add(Duration(days: weekIndex * 7));
                            final weekKey = 'week_${weekStartDate.toString()}';

                            // GlobalKey가 없으면 생성
                            _weekKeys.putIfAbsent(weekKey, () => GlobalKey());

                            return _WeekSection(
                              key: _weekKeys[weekKey],
                              weekStartDate: weekStartDate,
                              month: month,
                              eventsState: eventsState,
                              categories: categories,
                              eventTypes: eventTypes,
                              promotions: promotions,
                              onShowEventDialog: _showEventDialog,
                              onShowEventListDialog: _showEventListDialog,
                              totalWidth: totalWidth,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
        onSave: (eventTypeId, eventHour, eventMinute, content, isImportant,
            studentId, tcId, consultTypeCode) async {
          if (existingEvent != null) {
            final success = await ref.read(scheduleEventsProvider.notifier).updateEvent(
              eventId: existingEvent.eventId,
              eventTypeId: eventTypeId,
              eventHour: eventHour,
              eventMinute: eventMinute,
              content: content,
              isImportant: isImportant,
              studentId: studentId,
              tcId: tcId,
              consultTypeCode: consultTypeCode,
            );
            return success;
          } else {
            final success = await ref.read(scheduleEventsProvider.notifier).createEvent(
              categoryId: category.categoryId,
              eventTypeId: eventTypeId,
              eventDate: date,
              eventHour: eventHour,
              eventMinute: eventMinute,
              content: content,
              isImportant: isImportant,
              studentId: studentId,
              tcId: tcId,
              consultTypeCode: consultTypeCode,
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

  void _showEventListDialog(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    List<ScheduleEvent> events,
    List<ScheduleEventType> eventTypes,
  ) {
    showDialog(
      context: context,
      builder: (context) => ScheduleEventListDialog(
        category: category,
        date: date,
        events: events,
        eventTypes: eventTypes,
        onEditEvent: (event) {
          _showEventDialog(
            context,
            category,
            date,
            eventTypes,
            existingEvent: event,
          );
        },
        onAddEvent: () {
          _showEventDialog(
            context,
            category,
            date,
            eventTypes,
          );
        },
        onDeleteEvent: (eventId) async {
          final success = await ref
              .read(scheduleEventsProvider.notifier)
              .deleteEvent(eventId);
          return success;
        },
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// [animate]가 false면 애니메이션 없이 즉시 이동한다.
  /// 화면 진입 시에는 가로/세로가 동시에 움직이면 산만해 보이므로 즉시 이동한다.
  void _scrollToDate(DateTime date, {bool animate = true}) {
    // 클릭한 날짜가 어느 주에 속하는지 찾기
    final weekKey = _weekKeyForDate(date);

    // 세로 스크롤: 해당 주로 이동
    final key = _weekKeys[weekKey];
    if (key?.currentContext != null && _verticalScrollController.hasClients) {
      // RenderBox를 통해 실제 위치 계산
      final RenderBox? renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final scrollOffset = _verticalScrollController.offset;
        final targetOffset = scrollOffset + position.dy - 100; // AppBar 높이만큼 여유

        _moveTo(
          _verticalScrollController,
          targetOffset.clamp(0.0, _verticalScrollController.position.maxScrollExtent),
          animate: animate,
        );
      }
    }

    // 가로 스크롤: 해당 날짜 열로 이동
    if (!_horizontalScrollController.hasClients) return;

    final dayOfWeek = date.weekday % 7; // 0=일요일, 1=월요일, ..., 6=토요일
    final columnWidth = categoryColumnWidth + cellWidth; // 100 + 360 = 460
    final horizontalOffset = dayOfWeek * columnWidth;

    _moveTo(
      _horizontalScrollController,
      horizontalOffset.clamp(
        0.0,
        _horizontalScrollController.position.maxScrollExtent,
      ),
      animate: animate,
    );
  }

  void _moveTo(ScrollController controller, double offset, {required bool animate}) {
    if (!animate) {
      controller.jumpTo(offset);
      return;
    }

    controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

/// 한 주 섹션
class _WeekSection extends StatefulWidget {
  final DateTime weekStartDate;
  final DateTime month;
  final ScheduleEventsState eventsState;
  final List<ScheduleCategory> categories;
  final List<ScheduleEventType> eventTypes;
  final List<Promotion> promotions;
  final double totalWidth;
  final void Function(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    List<ScheduleEventType> eventTypes, {
    ScheduleEvent? existingEvent,
  }) onShowEventDialog;
  final void Function(
    BuildContext context,
    ScheduleCategory category,
    DateTime date,
    List<ScheduleEvent> events,
    List<ScheduleEventType> eventTypes,
  ) onShowEventListDialog;

  const _WeekSection({
    super.key,
    required this.weekStartDate,
    required this.month,
    required this.eventsState,
    required this.categories,
    required this.eventTypes,
    required this.promotions,
    required this.totalWidth,
    required this.onShowEventDialog,
    required this.onShowEventListDialog,
  });

  @override
  State<_WeekSection> createState() => _WeekSectionState();
}

class _WeekSectionState extends State<_WeekSection> {
  static const double cellWidth = 360.0;
  static const double categoryColumnWidth = 100.0;
  static const double dayHeaderHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final weekDates = List.generate(7, (i) => widget.weekStartDate.add(Duration(days: i)));

    return Container(
      width: widget.totalWidth,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          // 주차 헤더
          _buildWeekHeader(weekDates),
          // 카테고리별 행
          ...widget.categories.map((category) {
            return _buildCategoryRow(category, weekDates);
          }),
        ],
      ),
    );
  }

  Widget _buildWeekHeader(List<DateTime> weekDates) {
    return Container(
      height: dayHeaderHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: Row(
        children: weekDates.map((date) {
          final isCurrentMonth = date.month == widget.month.month;
          final isToday = _isToday(date);
          final isSelected = widget.eventsState.selectedDate != null &&
              widget.eventsState.selectedDate!.year == date.year &&
              widget.eventsState.selectedDate!.month == date.month &&
              widget.eventsState.selectedDate!.day == date.day;
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
                  color: isSelected
                      ? Colors.blue.shade200
                      : isToday
                          ? Colors.orange.shade100
                          : null,
                  border: Border(right: BorderSide(color: Colors.grey.shade400, width: 2)),
                ),
                child: Center(
                  child: Text(
                    '${date.month}/${date.day} (${weekdayNames[date.weekday]})',
                    style: TextStyle(
                      fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
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
    );
  }

  Widget _buildCategoryRow(
    ScheduleCategory category,
    List<DateTime> weekDates,
  ) {
    final minRowHeight = _getMinCategoryRowHeight(category);

    return Container(
      constraints: BoxConstraints(minHeight: minRowHeight),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
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
          ? () => widget.onShowEventListDialog(context, category, date, events, widget.eventTypes)
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
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: event.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      event.displayText,
                      style: TextStyle(
                        fontSize: 12,
                        color: event.displayTextColor,
                        fontWeight: event.displayFontWeight,
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

    // 디버깅: 중복 체크
    if (matchingPromotions.length > 1) {
      print('[설명회 중복] 날짜: $dateStr, 개수: ${matchingPromotions.length}');
      for (var p in matchingPromotions) {
        print('  - ID: ${p.promotionId}, 이름: ${p.promotionName}, 시작일: ${p.startDate}');
      }
    }

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
                  key: Key('promotion_${promotion.promotionId}'),
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
    if (category.isTimeSlot) return 40;
    if (category.isPromotion) return 50;
    return 50;
  }

  Color? _getCategoryColor(ScheduleCategory category) {
    switch (category.categoryType) {
      case 'INFO':
        return Colors.yellow.shade50;
      case 'TIME_SLOT':
        return Colors.white;
      case 'PROMOTION':
        return Colors.pink.shade100;
      case 'CONSULT':
        // 전화상담 - 하늘색
        return Colors.lightBlue.shade100;
      case 'ISSUE':
        return Colors.pink.shade50;
      default:
        return null;
    }
  }
}
