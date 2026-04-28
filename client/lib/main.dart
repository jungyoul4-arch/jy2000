import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'providers/code_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: StudentCounselingApp(),
    ),
  );
}

class StudentCounselingApp extends ConsumerStatefulWidget {
  const StudentCounselingApp({super.key});

  @override
  ConsumerState<StudentCounselingApp> createState() =>
      _StudentCounselingAppState();
}

class _StudentCounselingAppState extends ConsumerState<StudentCounselingApp> {
  @override
  void initState() {
    super.initState();
    // 앱 시작 시 코드 마스터 로드
    Future.microtask(() {
      ref.read(codeCacheProvider.notifier).loadAllCodes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '학생 상담 관리',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
    );
  }
}
