import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/school.dart';
import '../repositories/school_repository.dart';

// Repository Provider
final schoolRepositoryProvider = Provider((ref) => SchoolRepository());

// 학교 목록 상태
class SchoolListState {
  final List<School> schools;
  final bool isLoading;
  final String? error;

  SchoolListState({
    this.schools = const [],
    this.isLoading = false,
    this.error,
  });

  SchoolListState copyWith({
    List<School>? schools,
    bool? isLoading,
    String? error,
  }) {
    return SchoolListState(
      schools: schools ?? this.schools,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 학교 목록 Notifier
class SchoolListNotifier extends StateNotifier<SchoolListState> {
  final SchoolRepository _repository;

  SchoolListNotifier(this._repository) : super(SchoolListState());

  // 마지막 조회 조건. 삭제·복원 뒤 새로고침할 때 그대로 쓴다.
  String? _lastSearch;
  int? _lastSchoolKind;
  bool _lastIncludeInactive = false;

  // 학교 목록 로드
  Future<void> loadSchools({
    String? search,
    int? schoolKind,
    bool includeInactive = false,
  }) async {
    _lastSearch = search;
    _lastSchoolKind = schoolKind;
    _lastIncludeInactive = includeInactive;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final schools = await _repository.getList(
        search: search,
        schoolKind: schoolKind,
        includeInactive: includeInactive,
      );
      state = state.copyWith(schools: schools, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 학교 추가
  Future<bool> addSchool({
    required String schoolName,
    required int schoolKind,
    required int regionKind,
  }) async {
    try {
      final newSchool = await _repository.create(
        schoolName: schoolName,
        schoolKind: schoolKind,
        regionKind: regionKind,
      );
      state = state.copyWith(
        schools: [...state.schools, newSchool]..sort((a, b) => a.schoolName.compareTo(b.schoolName)),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 학교 수정
  Future<bool> updateSchool({
    required int schoolId,
    String? schoolName,
    int? schoolKind,
    int? regionKind,
  }) async {
    try {
      final updatedSchool = await _repository.update(
        schoolId,
        schoolName: schoolName,
        schoolKind: schoolKind,
        regionKind: regionKind,
      );
      state = state.copyWith(
        schools: state.schools.map((s) =>
          s.schoolId == schoolId ? updatedSchool : s
        ).toList()..sort((a, b) => a.schoolName.compareTo(b.schoolName)),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 학교 삭제 (soft delete 후 목록 새로고침)
  Future<bool> deleteSchool(int schoolId) async {
    try {
      await _repository.delete(schoolId);
      await _reload();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 지운 학교 되살리기
  Future<bool> restoreSchool(int schoolId) async {
    try {
      await _repository.restore(schoolId);
      await _reload();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<void> _reload() => loadSchools(
        search: _lastSearch,
        schoolKind: _lastSchoolKind,
        includeInactive: _lastIncludeInactive,
      );

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final schoolListProvider =
    StateNotifierProvider<SchoolListNotifier, SchoolListState>((ref) {
  return SchoolListNotifier(ref.read(schoolRepositoryProvider));
});

// 학교 검색용 FutureProvider
final schoolSearchProvider = FutureProvider.family<List<School>, String>((ref, search) async {
  final repository = ref.read(schoolRepositoryProvider);
  return repository.getList(search: search);
});
