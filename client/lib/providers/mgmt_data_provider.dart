import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mgmt_data.dart';
import '../repositories/mgmt_data_repository.dart';

// Repository Provider
final mgmtDataRepositoryProvider = Provider((ref) => MgmtDataRepository());

// 경영 데이터 목록 상태
class MgmtDataListState {
  final List<MgmtData> data;
  final List<YearMonth> availableMonths;
  final int? selectedYear;
  final int? selectedMonth;
  final int total;
  final bool isLoading;
  final String? error;

  MgmtDataListState({
    this.data = const [],
    this.availableMonths = const [],
    this.selectedYear,
    this.selectedMonth,
    this.total = 0,
    this.isLoading = false,
    this.error,
  });

  MgmtDataListState copyWith({
    List<MgmtData>? data,
    List<YearMonth>? availableMonths,
    int? selectedYear,
    int? selectedMonth,
    int? total,
    bool? isLoading,
    String? error,
  }) {
    return MgmtDataListState(
      data: data ?? this.data,
      availableMonths: availableMonths ?? this.availableMonths,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 경영 데이터 목록 Notifier
class MgmtDataListNotifier extends StateNotifier<MgmtDataListState> {
  final MgmtDataRepository _repository;

  MgmtDataListNotifier(this._repository) : super(MgmtDataListState());

  // 경영 데이터 목록 로드
  Future<void> loadData({int? year, int? month, String? search}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getList(
        year: year ?? state.selectedYear,
        month: month ?? state.selectedMonth,
        search: search,
        perPage: 10000, // 전체 데이터
      );

      // 선택된 년월 결정
      int? selectedYear = year ?? state.selectedYear;
      int? selectedMonth = month ?? state.selectedMonth;

      if ((selectedYear == null || selectedMonth == null) && result.availableMonths.isNotEmpty) {
        selectedYear = result.availableMonths.first.year;
        selectedMonth = result.availableMonths.first.month;
      }

      state = state.copyWith(
        data: result.data,
        availableMonths: result.availableMonths,
        selectedYear: selectedYear,
        selectedMonth: selectedMonth,
        total: result.total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 년월 변경
  Future<void> changeYearMonth(int year, int month) async {
    state = state.copyWith(selectedYear: year, selectedMonth: month);
    await loadData(year: year, month: month);
  }

  // 특정 년월 데이터 삭제
  Future<bool> deleteByMonth(int year, int month) async {
    try {
      final deletedCount = await _repository.deleteByMonth(year, month);
      // 삭제 후 목록 새로고침
      await loadData();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  // 엑셀 파일 업로드
  Future<UploadResult?> uploadExcel(String filePath, int year, int month) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.uploadExcel(filePath, year, month);
      // 업로드 후 해당 년월 데이터 로드
      await loadData(year: year, month: month);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final mgmtDataListProvider =
    StateNotifierProvider<MgmtDataListNotifier, MgmtDataListState>((ref) {
  return MgmtDataListNotifier(ref.read(mgmtDataRepositoryProvider));
});
