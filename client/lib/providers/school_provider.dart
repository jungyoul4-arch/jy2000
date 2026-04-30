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

  // 학교 목록 로드
  Future<void> loadSchools({String? search, int? schoolKind}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final schools = await _repository.getList(
        search: search,
        schoolKind: schoolKind,
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

  // 학교 삭제
  Future<bool> deleteSchool(int schoolId) async {
    try {
      await _repository.delete(schoolId);
      state = state.copyWith(
        schools: state.schools.where((s) => s.schoolId != schoolId).toList(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

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
