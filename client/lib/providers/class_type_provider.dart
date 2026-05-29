import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/class_type.dart';
import '../repositories/class_type_repository.dart';

// Repository Provider
final classTypeRepositoryProvider = Provider((ref) => ClassTypeRepository());

// 반 형태 목록 상태
class ClassTypeListState {
  final List<ClassType> classTypes;
  final bool isLoading;
  final String? error;

  ClassTypeListState({
    this.classTypes = const [],
    this.isLoading = false,
    this.error,
  });

  ClassTypeListState copyWith({
    List<ClassType>? classTypes,
    bool? isLoading,
    String? error,
  }) {
    return ClassTypeListState(
      classTypes: classTypes ?? this.classTypes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 반 형태 목록 Notifier
class ClassTypeListNotifier extends StateNotifier<ClassTypeListState> {
  final ClassTypeRepository _repository;

  ClassTypeListNotifier(this._repository) : super(ClassTypeListState());

  // 반 형태 목록 로드
  Future<void> loadClassTypes({String? search, int? grade, int? subject}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final classTypes = await _repository.getList(
        search: search,
        grade: grade,
        subject: subject,
      );
      state = state.copyWith(classTypes: classTypes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 반 형태 추가
  Future<bool> addClassType({
    required String classTypeName,
    required int grade,
    required int subject,
    int unitPrice = 0,
    List<int>? teacherIds,
    List<String>? teacherNames,
  }) async {
    try {
      final newClassType = await _repository.create(
        classTypeName: classTypeName,
        grade: grade,
        subject: subject,
        unitPrice: unitPrice,
        teacherIds: teacherIds,
        teacherNames: teacherNames,
      );
      state = state.copyWith(
        classTypes: [newClassType, ...state.classTypes],
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 반 형태 수정
  Future<bool> updateClassType({
    required int classTypeId,
    String? classTypeName,
    int? grade,
    int? subject,
    int? unitPrice,
    List<int>? teacherIds,
    List<String>? teacherNames,
  }) async {
    try {
      final updatedClassType = await _repository.update(
        classTypeId,
        classTypeName: classTypeName,
        grade: grade,
        subject: subject,
        unitPrice: unitPrice,
        teacherIds: teacherIds,
        teacherNames: teacherNames,
      );
      state = state.copyWith(
        classTypes: state.classTypes.map((ct) =>
          ct.classTypeId == classTypeId ? updatedClassType : ct
        ).toList(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 반 형태 삭제
  Future<bool> deleteClassType(int classTypeId) async {
    try {
      await _repository.delete(classTypeId);
      state = state.copyWith(
        classTypes: state.classTypes.where((ct) => ct.classTypeId != classTypeId).toList(),
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
final classTypeListProvider =
    StateNotifierProvider<ClassTypeListNotifier, ClassTypeListState>((ref) {
  return ClassTypeListNotifier(ref.read(classTypeRepositoryProvider));
});
