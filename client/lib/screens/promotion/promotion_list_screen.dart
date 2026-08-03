import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

import '../../providers/promotion_provider.dart';
import '../../models/promotion.dart';
import '../../widgets/logout_button.dart';

class PromotionListScreen extends ConsumerStatefulWidget {
  const PromotionListScreen({super.key});

  @override
  ConsumerState<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends ConsumerState<PromotionListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(promotionListProvider.notifier).fetchList(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final promotionState = ref.watch(promotionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설명회 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(promotionListProvider.notifier).refresh();
            },
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () => context.go('/promotions/create'),
            icon: const Icon(Icons.add),
            label: const Text('설명회 등록'),
          ),
          const SizedBox(width: 16),
          const LogoutButton(),
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
                if (promotionState.meta != null)
                  Text(
                    '총 ${promotionState.meta!.total}건',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 테이블
          Expanded(
            child: promotionState.isLoading && promotionState.promotions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : promotionState.error != null
                    ? Center(child: Text('오류: ${promotionState.error}'))
                    : promotionState.promotions.isEmpty
                        ? const Center(child: Text('등록된 설명회가 없습니다'))
                        : _buildDataTable(promotionState.promotions),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Promotion> promotions) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 1000,
      columns: const [
        DataColumn2(label: Text('No.'), fixedWidth: 60),
        DataColumn2(label: Text('설명회명'), size: ColumnSize.L),
        DataColumn2(label: Text('유형'), size: ColumnSize.S),
        DataColumn2(label: Text('일시'), size: ColumnSize.M),
        DataColumn2(label: Text('장소'), size: ColumnSize.S),
        DataColumn2(label: Text('대상 학년'), size: ColumnSize.S),
        DataColumn2(label: Text('정원'), fixedWidth: 80),
        DataColumn2(label: Text('상태'), fixedWidth: 80),
      ],
      rows: promotions.asMap().entries.map((entry) {
        final index = entry.key;
        final promotion = entry.value;
        return DataRow2(
          onTap: () => context.push('/promotions/${promotion.promotionId}'),
          cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text(promotion.promotionName)),
            DataCell(Text(_getPromotionTypeName(promotion.promotionTypeCode))),
            DataCell(Text(_formatDateTime(promotion.startDate))),
            DataCell(Text(promotion.targetSubject ?? '-')),
            DataCell(Text(promotion.targetGrade ?? '-')),
            DataCell(Text(
              promotion.discountValue != null
                  ? '${promotion.discountValue!.toInt()}명'
                  : '-',
            )),
            DataCell(_buildStatusChip(promotion)),
          ],
        );
      }).toList(),
    );
  }

  String _getPromotionTypeName(String? typeCode) {
    switch (typeCode) {
      case 'PROMO_ENTRANCE':
        return '입시 설명회';
      case 'PROMO_PARENT':
        return '학부모 설명회';
      case 'PROMO_ADMISSION':
        return '입학 설명회';
      case 'PROMO_CONSULT':
        return '진학 상담회';
      case 'PROMO_SPECIAL':
        return '특강 안내';
      case 'PROMO_OPEN':
        return '오픈 클래스';
      default:
        return typeCode ?? '-';
    }
  }

  String _formatDateTime(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildStatusChip(Promotion promotion) {
    // 설명회 일시 기준으로 상태 결정
    try {
      final eventDate = DateTime.parse(promotion.startDate);
      final now = DateTime.now();

      if (eventDate.isBefore(now)) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '종료',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '예정',
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
          ),
        );
      }
    } catch (e) {
      return const Text('-');
    }
  }
}
