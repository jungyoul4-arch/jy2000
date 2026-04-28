import 'package:flutter/material.dart';

class PromotionListScreen extends StatelessWidget {
  const PromotionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로모션 관리'),
        actions: [
          FilledButton.icon(
            onPressed: () {
              // TODO: 프로모션 등록
            },
            icon: const Icon(Icons.add),
            label: const Text('프로모션 등록'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: const Center(
        child: Text('프로모션 목록 (준비 중)'),
      ),
    );
  }
}
