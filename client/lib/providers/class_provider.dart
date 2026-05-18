import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/api_response.dart';
import '../models/class_model.dart';
import '../repositories/class_repository.dart';

// Repository Provider
final classRepositoryProvider = Provider((ref) => ClassRepository());

// 반 목록 상태
class ClassListState {
  final List<ClassModel> classes;
  final PaginationMeta? meta;
  final bool isLoading;
  final String? error;
  final ClassListParams params;

  ClassListState({
    this.classes = const [],
    this.meta,
    this.isLoading = false,
    this.error,
    this.params = const ClassListParams(),
  });

  ClassListState copyWith({
    List<ClassModel>? classes,
    PaginationMeta? meta,
    bool? isLoading,
    String? error,
    ClassListParams? params,
  }) {
    return ClassListState(
      classes: classes ?? this.classes,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      params: params ?? this.params,
    );
  }

  bool get hasMore => meta != null && meta!.page < meta!.totalPages;
}

// 반 목록 Notifier
class ClassListNotifier extends StateNotifier<ClassListState> {
  final ClassRepository _repository;

  ClassListNotifier(this._repository) : super(ClassListState());

  // 목록 조회
  Future<void> fetchList({ClassListParams? params, bool refresh = false}) async {
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
          classes: result.data,
          meta: result.meta,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          classes: [...state.classes, ...result.data],
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

  // 필터 변경
  void updateFilter({
    int? genreId,
    int? grade,
    int? level,
    int? year,
    String? search,
    String? sort,
    String? order,
  }) {
    fetchList(
      params: state.params.copyWith(
        page: 1,
        genreId: genreId,
        grade: grade,
        level: level,
        year: year,
        search: search,
        sort: sort,
        order: order,
      ),
      refresh: true,
    );
  }

  // 새로고침
  Future<void> refresh() => fetchList(refresh: true);
}

// Provider
final classListProvider =
    StateNotifierProvider<ClassListNotifier, ClassListState>((ref) {
  return ClassListNotifier(ref.read(classRepositoryProvider));
});

// 반 상세 Provider
final classDetailProvider =
    FutureProvider.family<ClassDetail, int>((ref, classId) async {
  final repository = ref.read(classRepositoryProvider);
  return repository.getById(classId);
});

// 반 생성 Provider
final createClassProvider =
    FutureProvider.family<ClassDetail, ClassCreate>((ref, data) async {
  final repository = ref.read(classRepositoryProvider);
  return repository.create(data);
});

// 반 수정 Provider
final updateClassProvider =
    FutureProvider.family<ClassDetail, ({int classId, ClassUpdate data})>((ref, params) async {
  final repository = ref.read(classRepositoryProvider);
  return repository.update(params.classId, params.data);
});

// 선생님 목록 Provider
final teachersProvider = FutureProvider<List<ClassTeacher>>((ref) async {
  final repository = ref.read(classRepositoryProvider);
  return repository.getTeachers();
});

// 사용자 검색 Provider
final searchUsersProvider =
    FutureProvider.family<List<UserSearchResult>, ({String search, int? kind})>((ref, params) async {
  final repository = ref.read(classRepositoryProvider);
  return repository.searchUsers(params.search, kind: params.kind);
});
