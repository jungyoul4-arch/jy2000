import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/api_response.dart';
import '../models/consult.dart';
import '../models/consult_student.dart';
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

// 선정자 이름 목록 Provider (직원 공용)
//
// consult에 쌓인 값을 서버에서 꺼내 오므로 어느 PC에서 열어도 같은 목록이다.
// 문의를 저장한 뒤 invalidate하면 방금 적은 이름이 목록에 들어온다.
final selectorNamesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(consultRepositoryProvider);
  return repository.getSelectorNames();
});

// ============================================================
// 상담 학생 목록 (신규생 문의 / 상담 관리 공용)
//
// 두 화면이 같은 구조를 쓴다 — 학생을 고르면 그 학생의 상담 목록이 뜨고
// 거기서 고르면 상세로 간다. 대상(scope)만 다르다.
// ============================================================

/// 목록 조회 조건. family 키로 쓰므로 값 동등성이 필요하다.
class ConsultStudentQuery {
  final ConsultStudentScope scope;
  final ConsultStudentSort sort;
  final String search;

  /// 검색어가 없을 때만 의미가 있다. 기존생은 1,100명이 넘어
  /// 기본은 상담이 있는 학생만 보여 준다.
  final bool hasConsultOnly;

  const ConsultStudentQuery({
    required this.scope,
    this.sort = ConsultStudentSort.recent,
    this.search = '',
    this.hasConsultOnly = true,
  });

  ConsultStudentQuery copyWith({
    ConsultStudentSort? sort,
    String? search,
    bool? hasConsultOnly,
  }) =>
      ConsultStudentQuery(
        scope: scope,
        sort: sort ?? this.sort,
        search: search ?? this.search,
        hasConsultOnly: hasConsultOnly ?? this.hasConsultOnly,
      );

  @override
  bool operator ==(Object other) =>
      other is ConsultStudentQuery &&
      other.scope == scope &&
      other.sort == sort &&
      other.search == search &&
      other.hasConsultOnly == hasConsultOnly;

  @override
  int get hashCode => Object.hash(scope, sort, search, hasConsultOnly);
}

final consultStudentsProvider =
    FutureProvider.family<List<ConsultStudent>, ConsultStudentQuery>((ref, query) async {
  final repository = ref.read(consultRepositoryProvider);

  // 검색 중에는 상담 없는 학생도 찾을 수 있어야 한다. 첫 상담을 붙이려면
  // 목록에 떠야 하고, 검색으로 좁혀지니 길이도 문제되지 않는다.
  final searching = query.search.trim().isNotEmpty;

  return repository.getConsultStudents(
    scope: query.scope,
    sort: query.sort,
    search: query.search,
    hasConsultOnly: searching ? false : query.hasConsultOnly,
  );
});

// 학생별 상담 내역 Provider
final studentConsultListProvider =
    FutureProvider.family<List<Consult>, int>((ref, studentId) async {
  final repository = ref.read(consultRepositoryProvider);
  final result = await repository.getList(
    ConsultListParams(studentId: studentId, perPage: 100),
  );
  return result.data;
});
