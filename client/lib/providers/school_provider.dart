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

  // 삭제했을 때 그 항목을 목록에서 뺄지(기본) 회색으로 남길지('삭제됨 포함')
  // 판단하는 데 쓴다.
  bool _lastIncludeInactive = false;

  // 학교 목록 로드
  Future<void> loadSchools({
    String? search,
    int? schoolKind,
    bool includeInactive = false,
  }) async {
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
  // 삭제·복원 뒤에는 목록을 다시 받지 않고 그 항목만 손본다.
  //
  // loadSchools를 부르면 isLoading이 켜지면서 ListView가 스피너로 바뀌고,
  // 스크롤 위치가 맨 위로 돌아간다. 한 줄 바뀐 걸 보려고 보던 자리를
  // 잃을 이유가 없다.
  Future<bool> deleteSchool(int schoolId) async {
    try {
      await _repository.delete(schoolId);

      // 삭제는 is_active=0으로 내리는 것이다. '삭제됨 포함'을 켜 둔
      // 상태라면 목록에 남아 회색으로 보여야 하고, 아니면 사라져야 한다.
      final schools = _lastIncludeInactive
          ? [
              for (final s in state.schools)
                if (s.schoolId == schoolId) s.copyWith(isActive: false) else s,
            ]
          : state.schools.where((s) => s.schoolId != schoolId).toList();

      state = state.copyWith(schools: schools);
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

      state = state.copyWith(
        schools: [
          for (final s in state.schools)
            if (s.schoolId == schoolId) s.copyWith(isActive: true) else s,
        ],
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
