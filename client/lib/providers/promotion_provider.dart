import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/api_response.dart';
import '../models/promotion.dart';
import '../repositories/promotion_repository.dart';

// Repository Provider
final promotionRepositoryProvider = Provider((ref) => PromotionRepository());

// 프로모션 목록 상태
class PromotionListState {
  final List<Promotion> promotions;
  final PaginationMeta? meta;
  final bool isLoading;
  final String? error;
  final PromotionListParams params;

  PromotionListState({
    this.promotions = const [],
    this.meta,
    this.isLoading = false,
    this.error,
    this.params = const PromotionListParams(),
  });

  PromotionListState copyWith({
    List<Promotion>? promotions,
    PaginationMeta? meta,
    bool? isLoading,
    String? error,
    PromotionListParams? params,
  }) {
    return PromotionListState(
      promotions: promotions ?? this.promotions,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      params: params ?? this.params,
    );
  }

  bool get hasMore => meta != null && meta!.page < meta!.totalPages;
}

// 프로모션 목록 Notifier
class PromotionListNotifier extends StateNotifier<PromotionListState> {
  final PromotionRepository _repository;

  PromotionListNotifier(this._repository) : super(PromotionListState());

  // 목록 조회
  Future<void> fetchList({PromotionListParams? params, bool refresh = false}) async {
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
          promotions: result.data,
          meta: result.meta,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          promotions: [...state.promotions, ...result.data],
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
final promotionListProvider =
    StateNotifierProvider<PromotionListNotifier, PromotionListState>((ref) {
  return PromotionListNotifier(ref.read(promotionRepositoryProvider));
});

// 프로모션 등록 Provider
final createPromotionProvider =
    FutureProvider.family<Promotion, PromotionCreate>((ref, data) async {
  final repository = ref.read(promotionRepositoryProvider);
  return repository.create(data);
});
