import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/code_master.dart';
import '../repositories/code_repository.dart';

// Repository Provider
final codeRepositoryProvider = Provider((ref) => CodeRepository());

// 전체 코드 Provider
final allCodesProvider =
    FutureProvider<Map<String, List<CodeMaster>>>((ref) async {
  final repository = ref.read(codeRepositoryProvider);
  return repository.getAllCodes();
});

// 특정 그룹 코드 Provider
final codesByGroupProvider =
    FutureProvider.family<List<CodeMaster>, String>((ref, group) async {
  final repository = ref.read(codeRepositoryProvider);
  return repository.getCodesByGroup(group);
});

// 코드 캐시 상태
class CodeCacheState {
  final Map<String, List<CodeMaster>> codes;
  final bool isLoading;
  final String? error;

  CodeCacheState({
    this.codes = const {},
    this.isLoading = false,
    this.error,
  });

  CodeCacheState copyWith({
    Map<String, List<CodeMaster>>? codes,
    bool? isLoading,
    String? error,
  }) {
    return CodeCacheState(
      codes: codes ?? this.codes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // 특정 그룹 코드 가져오기
  List<CodeMaster> getGroup(String group) => codes[group] ?? [];

  // 코드 ID로 이름 가져오기
  String? getCodeName(String codeId) {
    for (final group in codes.values) {
      for (final code in group) {
        if (code.codeId == codeId) {
          return code.codeName;
        }
      }
    }
    return null;
  }
}

// 코드 캐시 Notifier
class CodeCacheNotifier extends StateNotifier<CodeCacheState> {
  final CodeRepository _repository;

  CodeCacheNotifier(this._repository) : super(CodeCacheState());

  // 전체 코드 로드
  Future<void> loadAllCodes() async {
    if (state.codes.isNotEmpty && !state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final codes = await _repository.getAllCodes();
      state = state.copyWith(codes: codes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 특정 그룹 코드 가져오기
  List<CodeMaster> getGroup(String group) => state.getGroup(group);

  // 코드명 가져오기
  String? getCodeName(String codeId) => state.getCodeName(codeId);
}

// Provider
final codeCacheProvider =
    StateNotifierProvider<CodeCacheNotifier, CodeCacheState>((ref) {
  return CodeCacheNotifier(ref.read(codeRepositoryProvider));
});

// 편의 Provider - 상태 코드
final statusCodesProvider = Provider<List<CodeMaster>>((ref) {
  return ref.watch(codeCacheProvider).getGroup(CodeGroup.status);
});

// 편의 Provider - 학년 코드
final gradeCodesProvider = Provider<List<CodeMaster>>((ref) {
  return ref.watch(codeCacheProvider).getGroup(CodeGroup.grade);
});

// 편의 Provider - 상담 유형 코드
final consultTypeCodesProvider = Provider<List<CodeMaster>>((ref) {
  return ref.watch(codeCacheProvider).getGroup(CodeGroup.consultType);
});

// 편의 Provider - 채널 코드
final channelCodesProvider = Provider<List<CodeMaster>>((ref) {
  return ref.watch(codeCacheProvider).getGroup(CodeGroup.channel);
});

// 편의 Provider - 상담 결과 코드
final consultResultCodesProvider = Provider<List<CodeMaster>>((ref) {
  return ref.watch(codeCacheProvider).getGroup(CodeGroup.consultResult);
});
