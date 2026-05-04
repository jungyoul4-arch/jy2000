import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/api_response.dart';
import '../models/student.dart';
import '../repositories/student_repository.dart';

// Repository Provider
final studentRepositoryProvider = Provider((ref) => StudentRepository());

// 학생 목록 상태
class StudentListState {
  final List<Student> students;
  final PaginationMeta? meta;
  final bool isLoading;
  final String? error;
  final StudentListParams params;

  StudentListState({
    this.students = const [],
    this.meta,
    this.isLoading = false,
    this.error,
    this.params = const StudentListParams(),
  });

  StudentListState copyWith({
    List<Student>? students,
    PaginationMeta? meta,
    bool? isLoading,
    String? error,
    StudentListParams? params,
  }) {
    return StudentListState(
      students: students ?? this.students,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      params: params ?? this.params,
    );
  }

  bool get hasMore => meta != null && meta!.page < meta!.totalPages;
}

// 학생 목록 Notifier
class StudentListNotifier extends StateNotifier<StudentListState> {
  final StudentRepository _repository;

  StudentListNotifier(this._repository) : super(StudentListState());

  // 목록 조회
  Future<void> fetchList({StudentListParams? params, bool refresh = false}) async {
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
          students: result.data,
          meta: result.meta,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          students: [...state.students, ...result.data],
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
    String? statusCode,
    int? grade,
    int? tcId,
    String? search,
    String? sort,
    String? order,
  }) {
    fetchList(
      params: state.params.copyWith(
        page: 1,
        statusCode: statusCode,
        grade: grade,
        tcId: tcId,
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
final studentListProvider =
    StateNotifierProvider<StudentListNotifier, StudentListState>((ref) {
  return StudentListNotifier(ref.read(studentRepositoryProvider));
});

// 학생 상세 Provider
final studentDetailProvider =
    FutureProvider.family<Student, int>((ref, studentId) async {
  final repository = ref.read(studentRepositoryProvider);
  return repository.getById(studentId);
});

// 상태 변경 Provider
final changeStudentStateProvider =
    FutureProvider.family<Student, StudentStateChange>((ref, data) async {
  final repository = ref.read(studentRepositoryProvider);
  return repository.changeState(data);
});

// 학생 신규 등록 Provider
final createStudentProvider =
    FutureProvider.family<Student, StudentCreate>((ref, data) async {
  final repository = ref.read(studentRepositoryProvider);
  return repository.create(data);
});
