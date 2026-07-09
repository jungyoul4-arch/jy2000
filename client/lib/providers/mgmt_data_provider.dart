import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mgmt_data.dart';
import '../models/mgmt_report.dart';
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

  // 경영 데이터 수정
  Future<MgmtData?> update(int mgmtDataId, {int? studentId, int? teacherId, int? schoolId, int? classTypeId}) async {
    try {
      final result = await _repository.update(
        mgmtDataId,
        studentId: studentId,
        teacherId: teacherId,
        schoolId: schoolId,
        classTypeId: classTypeId,
      );

      // 목록에서 해당 항목 업데이트
      final updatedData = state.data.map((d) {
        if (d.mgmtDataId == mgmtDataId) {
          return result;
        }
        return d;
      }).toList();

      state = state.copyWith(data: updatedData);
      return result;
    } catch (e) {
      state = state.copyWith(error: e.toString());
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

// ============================================================
// 경영 보고서 Provider
// ============================================================

// 경영 보고서 상태
class MgmtReportState {
  final MgmtReport? report;
  final int startYear;
  final int startMonth;
  final int endYear;
  final int endMonth;
  final bool isLoading;
  final String? error;

  MgmtReportState({
    this.report,
    required this.startYear,
    required this.startMonth,
    required this.endYear,
    required this.endMonth,
    this.isLoading = false,
    this.error,
  });

  MgmtReportState copyWith({
    MgmtReport? report,
    int? startYear,
    int? startMonth,
    int? endYear,
    int? endMonth,
    bool? isLoading,
    String? error,
  }) {
    return MgmtReportState(
      report: report ?? this.report,
      startYear: startYear ?? this.startYear,
      startMonth: startMonth ?? this.startMonth,
      endYear: endYear ?? this.endYear,
      endMonth: endMonth ?? this.endMonth,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 경영 보고서 Notifier
class MgmtReportNotifier extends StateNotifier<MgmtReportState> {
  final MgmtDataRepository _repository;

  MgmtReportNotifier(this._repository)
      : super(MgmtReportState(
          startYear: DateTime.now().year,
          startMonth: 1,
          endYear: DateTime.now().year,
          endMonth: DateTime.now().month,
        ));

  // 경영 보고서 데이터 로드
  Future<void> loadReport() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getReport(
        startYear: state.startYear,
        startMonth: state.startMonth,
        endYear: state.endYear,
        endMonth: state.endMonth,
      );

      state = state.copyWith(
        report: result,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 기간 변경
  void changePeriod({
    required int startYear,
    required int startMonth,
    required int endYear,
    required int endMonth,
  }) {
    state = state.copyWith(
      startYear: startYear,
      startMonth: startMonth,
      endYear: endYear,
      endMonth: endMonth,
    );
    loadReport();
  }

  // 빠른 선택: 이번 달
  void selectThisMonth() {
    final now = DateTime.now();
    changePeriod(
      startYear: now.year,
      startMonth: now.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 최근 3개월
  void selectLast3Months() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 2, 1);
    changePeriod(
      startYear: start.year,
      startMonth: start.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 최근 6개월
  void selectLast6Months() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 5, 1);
    changePeriod(
      startYear: start.year,
      startMonth: start.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 올해 전체
  void selectThisYear() {
    final now = DateTime.now();
    changePeriod(
      startYear: now.year,
      startMonth: 1,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final mgmtReportProvider =
    StateNotifierProvider<MgmtReportNotifier, MgmtReportState>((ref) {
  return MgmtReportNotifier(ref.read(mgmtDataRepositoryProvider));
});

// ============================================================
// 지역별 보고서 Provider
// ============================================================

// 지역별 보고서 상태
class RegionReportState {
  final RegionReport? report;
  final int startYear;
  final int startMonth;
  final int endYear;
  final int endMonth;
  final bool isLoading;
  final String? error;

  RegionReportState({
    this.report,
    required this.startYear,
    required this.startMonth,
    required this.endYear,
    required this.endMonth,
    this.isLoading = false,
    this.error,
  });

  RegionReportState copyWith({
    RegionReport? report,
    int? startYear,
    int? startMonth,
    int? endYear,
    int? endMonth,
    bool? isLoading,
    String? error,
  }) {
    return RegionReportState(
      report: report ?? this.report,
      startYear: startYear ?? this.startYear,
      startMonth: startMonth ?? this.startMonth,
      endYear: endYear ?? this.endYear,
      endMonth: endMonth ?? this.endMonth,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 지역별 보고서 Notifier
class RegionReportNotifier extends StateNotifier<RegionReportState> {
  final MgmtDataRepository _repository;

  RegionReportNotifier(this._repository)
      : super(RegionReportState(
          startYear: DateTime.now().year,
          startMonth: 1,
          endYear: DateTime.now().year,
          endMonth: DateTime.now().month,
        ));

  // 지역별 보고서 데이터 로드
  Future<void> loadReport() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getRegionReport(
        startYear: state.startYear,
        startMonth: state.startMonth,
        endYear: state.endYear,
        endMonth: state.endMonth,
      );

      state = state.copyWith(
        report: result,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 기간 변경
  void changePeriod({
    required int startYear,
    required int startMonth,
    required int endYear,
    required int endMonth,
  }) {
    state = state.copyWith(
      startYear: startYear,
      startMonth: startMonth,
      endYear: endYear,
      endMonth: endMonth,
    );
    loadReport();
  }

  // 빠른 선택: 이번 달
  void selectThisMonth() {
    final now = DateTime.now();
    changePeriod(
      startYear: now.year,
      startMonth: now.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 최근 3개월
  void selectLast3Months() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 2, 1);
    changePeriod(
      startYear: start.year,
      startMonth: start.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 최근 6개월
  void selectLast6Months() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 5, 1);
    changePeriod(
      startYear: start.year,
      startMonth: start.month,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 빠른 선택: 올해 전체
  void selectThisYear() {
    final now = DateTime.now();
    changePeriod(
      startYear: now.year,
      startMonth: 1,
      endYear: now.year,
      endMonth: now.month,
    );
  }

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final regionReportProvider =
    StateNotifierProvider<RegionReportNotifier, RegionReportState>((ref) {
  return RegionReportNotifier(ref.read(mgmtDataRepositoryProvider));
});
