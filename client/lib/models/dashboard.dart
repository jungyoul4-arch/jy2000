import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
class DashboardKPI with _$DashboardKPI {
  const factory DashboardKPI({
    @JsonKey(name: 'total_students') required int totalStudents,
    @JsonKey(name: 'new_students_this_month') required int newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') required int consultsThisMonth,
    @JsonKey(name: 'registers_this_month') required int registersThisMonth,
    @JsonKey(name: 'enrolled_count') required int enrolledCount,
    @JsonKey(name: 'conversion_rate') required double conversionRate,
  }) = _DashboardKPI;

  factory DashboardKPI.fromJson(Map<String, dynamic> json) =>
      _$DashboardKPIFromJson(json);
}

@freezed
class FunnelData with _$FunnelData {
  const factory FunnelData({
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_name') required String statusName,
    required int count,
    required double percentage,
  }) = _FunnelData;

  factory FunnelData.fromJson(Map<String, dynamic> json) =>
      _$FunnelDataFromJson(json);
}

@freezed
class TCPerformance with _$TCPerformance {
  const factory TCPerformance({
    @JsonKey(name: 'tc_id') required int tcId,
    @JsonKey(name: 'tc_name') required String tcName,
    @JsonKey(name: 'total_students') required int totalStudents,
    @JsonKey(name: 'prospect_count') required int prospectCount,
    @JsonKey(name: 'consult_count') required int consultCount,
    @JsonKey(name: 'register_count') required int registerCount,
    @JsonKey(name: 'consult_total') required int consultTotal,
  }) = _TCPerformance;

  factory TCPerformance.fromJson(Map<String, dynamic> json) =>
      _$TCPerformanceFromJson(json);
}

@freezed
class MonthlyTrend with _$MonthlyTrend {
  const factory MonthlyTrend({
    required String month,
    @JsonKey(name: 'register_count') required int registerCount,
  }) = _MonthlyTrend;

  factory MonthlyTrend.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTrendFromJson(json);
}
