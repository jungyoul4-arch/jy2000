import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/schedule_category.dart';
import '../../models/schedule_event.dart';
import '../../models/schedule_event_type.dart';

class ScheduleEventListDialog extends StatelessWidget {
  final ScheduleCategory category;
  final DateTime date;
  final List<ScheduleEvent> events;
  final List<ScheduleEventType> eventTypes;
  final Function(ScheduleEvent event) onEditEvent;
  final VoidCallback onAddEvent;
  final Function(int eventId) onDeleteEvent;

  const ScheduleEventListDialog({
    super.key,
    required this.category,
    required this.date,
    required this.events,
    required this.eventTypes,
    required this.onEditEvent,
    required this.onAddEvent,
    required this.onDeleteEvent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('yyyy년 M월 d일 (E)').format(date),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  category.categoryName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (events.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  '등록된 일정이 없습니다',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    // 시간대 일정은 내용 앞에 분 표시 (예: 10' 학생면담)
                    final titleText = [event.minutePrefix, event.content ?? '']
                        .where((s) => s.isNotEmpty)
                        .join(' ');
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        tileColor: event.color,
                        title: Text(
                          titleText,
                          style: TextStyle(
                            color: event.displayTextColor,
                            fontWeight: event.isImportant
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                        subtitle: event.eventTypeName != null
                            ? Text(
                                event.eventTypeName!,
                                style: TextStyle(
                                  color: event.textColor?.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: event.textColor),
                              onPressed: () {
                                Navigator.pop(context);
                                onEditEvent(event);
                              },
                              tooltip: '수정',
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: event.textColor),
                              onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('일정 삭제'),
                                    content: const Text('이 일정을 삭제하시겠습니까?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('취소'),
                                      ),
                                      FilledButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('삭제'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmed == true) {
                                  await onDeleteEvent(event.eventId);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              tooltip: '삭제',
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          onEditEvent(event);
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        FilledButton.icon(
          onPressed: () {
            Navigator.pop(context);
            onAddEvent();
          },
          icon: const Icon(Icons.add),
          label: const Text('새 일정 추가'),
        ),
      ],
    );
  }
}
