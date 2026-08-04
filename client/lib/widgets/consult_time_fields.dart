import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// 상담 가능 시각 (일정 캘린더의 시간대 슬롯 10-11 ~ 9-10 = 10시~22시에 대응)
const List<int> consultHourOptions = [
  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
];

/// 상담 분은 10분 단위
const List<int> consultMinuteOptions = [0, 10, 20, 30, 40, 50];

/// 기본 상담 시각 (현재 시각이 상담 가능 범위를 벗어날 때 사용)
const int defaultConsultHour = 10;

/// 상담 시각으로 사용할 수 있는 시(hour)인지 여부
bool isValidConsultHour(int hour) => consultHourOptions.contains(hour);

/// 주어진 시각을 상담 가능 범위(10~21시, 10분 단위)로 보정한다.
/// 범위를 벗어나면 10시 0분으로, 분은 10분 단위로 내림 처리한다.
DateTime snapToConsultSlot(DateTime value) {
  final hour = isValidConsultHour(value.hour) ? value.hour : defaultConsultHour;
  final minute = isValidConsultHour(value.hour) ? (value.minute ~/ 10) * 10 : 0;

  return DateTime(value.year, value.month, value.day, hour, minute);
}

/// 상담 시/분 선택 드롭다운 한 쌍.
///
/// 시간 입력을 드롭다운으로 제한해 10시~21시 50분(10분 단위)만 선택할 수 있게 한다.
/// 폼 필드명은 `consult_hour`, `consult_minute`.
class ConsultTimeFields extends StatelessWidget {
  /// 초기 시각 (범위를 벗어나면 자동 보정)
  final DateTime initialValue;

  const ConsultTimeFields({super.key, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    final snapped = snapToConsultSlot(initialValue);

    return Row(
      children: [
        Expanded(
          child: FormBuilderDropdown<int>(
            name: 'consult_hour',
            initialValue: snapped.hour,
            decoration: const InputDecoration(
              labelText: '상담 시 *',
              prefixIcon: Icon(Icons.access_time),
            ),
            items: consultHourOptions
                .map((h) => DropdownMenuItem(value: h, child: Text('$h시')))
                .toList(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FormBuilderDropdown<int>(
            name: 'consult_minute',
            initialValue: snapped.minute,
            decoration: const InputDecoration(labelText: '분 *'),
            items: consultMinuteOptions
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text('${m.toString().padLeft(2, '0')}분'),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
