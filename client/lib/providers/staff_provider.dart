import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_response.dart';
import '../models/staff.dart';
import '../repositories/staff_repository.dart';

// Repository Provider
final staffRepositoryProvider = Provider((ref) => StaffRepository());

// 정렬 상태 저장 키
const _staffSortKey = 'staff_sort';
const _staffOrderKey = 'staff_order';

// 직원 목록 상태
class StaffListState {
  final List<Staff> staffList;
  final PaginationMeta? meta;
  final bool isLoading;
  final String? error;
  final StaffListParams params;

  StaffListState({
    this.staffList = const [],
    this.meta,
    this.isLoading = false,
    this.error,
    this.params = const StaffListParams(),
  });

  StaffListState copyWith({
    List<Staff>? staffList,
    PaginationMeta? meta,
    bool? isLoading,
    String? error,
    StaffListParams? params,
  }) {
    return StaffListState(
      staffList: staffList ?? this.staffList,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      params: params ?? this.params,
    );
  }

  bool get hasMore => meta != null && meta!.page < meta!.totalPages;
}

// 직원 목록 Notifier
class StaffListNotifier extends StateNotifier<StaffListState> {
  final StaffRepository _repository;

  StaffListNotifier(this._repository) : super(StaffListState()) {
    _loadSavedSort();
  }

  // 저장된 정렬 상태 불러오고 데이터 fetch
  Future<void> _loadSavedSort() async {
    final prefs = await SharedPreferences.getInstance();
    final sort = prefs.getString(_staffSortKey) ?? 'name';
    final order = prefs.getString(_staffOrderKey) ?? 'asc';

    // 저장된 정렬 상태로 데이터 fetch
    await fetchList(
      params: state.params.copyWith(sort: sort, order: order),
      refresh: true,
    );
  }

  // 정렬 상태 저장
  Future<void> _saveSortPreference(String sort, String order) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_staffSortKey, sort);
    await prefs.setString(_staffOrderKey, order);
  }

  // 목록 조회
  Future<void> fetchList({StaffListParams? params, bool refresh = false}) async {
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
          staffList: result.data,
          meta: result.meta,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          staffList: [...state.staffList, ...result.data],
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

  // 검색
  void search(String? searchText) {
    fetchList(
      params: state.params.copyWith(page: 1, search: searchText),
      refresh: true,
    );
  }

  // 정렬 변경
  void updateSort(String sort, String order) {
    _saveSortPreference(sort, order);
    fetchList(
      params: state.params.copyWith(page: 1, sort: sort, order: order),
      refresh: true,
    );
  }

  // 새로고침
  Future<void> refresh() => fetchList(refresh: true);
}

// Provider
final staffListProvider =
    StateNotifierProvider<StaffListNotifier, StaffListState>((ref) {
  return StaffListNotifier(ref.read(staffRepositoryProvider));
});

// 직원 상세 Provider
final staffDetailProvider =
    FutureProvider.family<Staff, int>((ref, userId) async {
  final repository = ref.read(staffRepositoryProvider);
  return repository.getById(userId);
});

/// 상담자 후보 목록 (재직 중인 직원)
///
/// `/staff/list`는 kind IN (1,3,5,6,7)로 조회하므로 학생(2)/학부모(4)가 이미 제외된다.
final consultantListProvider = FutureProvider<List<Staff>>((ref) async {
  final repository = ref.read(staffRepositoryProvider);
  final result = await repository.getList(
    const StaffListParams(page: 1, perPage: 500, sort: 'name', order: 'asc'),
  );
  return result.data.where((s) => s.activeFlag == 1).toList();
});

// 직원 등록 Provider
final createStaffProvider =
    FutureProvider.family<Staff, StaffCreate>((ref, data) async {
  final repository = ref.read(staffRepositoryProvider);
  return repository.create(data);
});
