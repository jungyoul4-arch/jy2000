import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

import '../../providers/consult_provider.dart';
import '../../models/consult.dart';

class ConsultListScreen extends ConsumerStatefulWidget {
  const ConsultListScreen({super.key});

  @override
  ConsumerState<ConsultListScreen> createState() => _ConsultListScreenState();
}

class _ConsultListScreenState extends ConsumerState<ConsultListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(consultListProvider.notifier).fetchList(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final consultState = ref.watch(consultListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('상담 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(consultListProvider.notifier).refresh();
            },
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () => context.go('/consults/create'),
            icon: const Icon(Icons.add),
            label: const Text('상담 등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 필터 영역
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                // 결과 수
                if (consultState.meta != null)
                  Text(
                    '총 ${consultState.meta!.total}건',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 테이블
          Expanded(
            child: consultState.isLoading && consultState.consults.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : consultState.error != null
                    ? Center(child: Text('오류: ${consultState.error}'))
                    : consultState.consults.isEmpty
                        ? const Center(child: Text('데이터가 없습니다'))
                        : _buildDataTable(consultState.consults),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Consult> consults) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1200,
      columns: const [
        DataColumn2(label: Text('학생'), size: ColumnSize.S),
        DataColumn2(label: Text('상담유형'), size: ColumnSize.S),
        DataColumn2(label: Text('상담일시'), size: ColumnSize.M),
        DataColumn2(label: Text('채널'), size: ColumnSize.S),
        DataColumn2(label: Text('담당TC'), size: ColumnSize.S),
        DataColumn2(label: Text('결과'), size: ColumnSize.S),
        DataColumn2(label: Text('다음상담'), size: ColumnSize.M),
        DataColumn2(label: Text('내용'), size: ColumnSize.L),
      ],
      rows: consults.map((consult) {
        return DataRow2(
          cells: [
            DataCell(Text(consult.studentName ?? '-')),
            DataCell(Text(consult.consultTypeName ?? '-')),
            DataCell(Text(_formatDate(consult.consultDate))),
            DataCell(Text(consult.channelName ?? '-')),
            DataCell(Text(consult.tcName ?? '-')),
            DataCell(Text(consult.consultResultName ?? '-')),
            DataCell(Text(
              consult.nextConsultDate != null
                  ? _formatDate(consult.nextConsultDate!)
                  : '-',
            )),
            DataCell(
              Text(
                consult.content ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MM/dd HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
