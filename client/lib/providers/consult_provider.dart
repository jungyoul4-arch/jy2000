import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/api_response.dart';
import '../models/consult.dart';
import '../repositories/consult_repository.dart';

// Repository Provider
final consultRepositoryProvider = Provider((ref) => ConsultRepository());

// 상담 목록 상태
class ConsultListState {
  final List<Consult> consults;
  final PaginationMeta? meta;
  final bool isLoading;
  final String? error;
  final ConsultListParams params;

  ConsultListState({
    this.consults = const [],
    this.meta,
    this.isLoading = false,
    this.error,
    this.params = const ConsultListParams(),
  });

  ConsultListState copyWith({
    List<Consult>? consults,
    PaginationMeta? meta,
    bool? isLoading,
    String? error,
    ConsultListParams? params,
  }) {
    return ConsultListState(
      consults: consults ?? this.consults,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      params: params ?? this.params,
    );
  }

  bool get hasMore => meta != null && meta!.page < meta!.totalPages;
}

// 상담 목록 Notifier
class ConsultListNotifier extends StateNotifier<ConsultListState> {
  final ConsultRepository _repository;

  ConsultListNotifier(this._repository) : super(ConsultListState());

  // 목록 조회
  Future<void> fetchList({ConsultListParams? params, bool refresh = false}) async {
    final newParams = params ?? state.params;

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        error: null,
        params: newParams.copyWith(page: 1),
      );
    } else {
      state = state.copyWith(isLoading: true, error: null, params: newParams);
    }

    try {
      final result = await _repository.getList(state.params);

      if (refresh || state.params.page == 1) {
        state = state.copyWith(
          consults: result.data,
          meta: result.meta,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          consults: [...state.consults, ...result.data],
          meta: result.meta,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 다음 페이지 로드
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;

    await fetchList(
      params: state.params.copyWith(page: state.params.page + 1),
    );
  }

  // 새로고침
  Future<void> refresh() => fetchList(refresh: true);
}

// Provider
final consultListProvider =
    StateNotifierProvider<ConsultListNotifier, ConsultListState>((ref) {
  return ConsultListNotifier(ref.read(consultRepositoryProvider));
});

// 상담 등록 Provider
final createConsultProvider =
    FutureProvider.family<Consult, ConsultCreate>((ref, data) async {
  final repository = ref.read(consultRepositoryProvider);
  return repository.create(data);
});
