import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

/// 숫자 또는 문자열을 int로 변환하는 컨버터
class _IntConverter implements JsonConverter<int, dynamic> {
  const _IntConverter();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is int) return json;
    if (json is num) return json.toInt();
    if (json is String) return int.tryParse(json) ?? 0;
    return 0;
  }

  @override
  dynamic toJson(int object) => object;
}

/// 숫자 또는 문자열을 double로 변환하는 컨버터
class _DoubleConverter implements JsonConverter<double, dynamic> {
  const _DoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json == null) return 0.0;
    if (json is double) return json;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json) ?? 0.0;
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

@freezed
class DashboardKPI with _$DashboardKPI {
  const factory DashboardKPI({
    @JsonKey(name: 'total_students') @_IntConverter() required int totalStudents,
    @JsonKey(name: 'new_students_this_month') @_IntConverter() required int newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') @_IntConverter() required int consultsThisMonth,
    @JsonKey(name: 'registers_this_month') @_IntConverter() required int registersThisMonth,
    @JsonKey(name: 'enrolled_count') @_IntConverter() required int enrolledCount,
    @JsonKey(name: 'conversion_rate') @_DoubleConverter() required double conversionRate,
  }) = _DashboardKPI;

  factory DashboardKPI.fromJson(Map<String, dynamic> json) =>
      _$DashboardKPIFromJson(json);
}

@freezed
class FunnelData with _$FunnelData {
  const factory FunnelData({
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_name') required String statusName,
    @_IntConverter() required int count,
    @_DoubleConverter() required double percentage,
  }) = _FunnelData;

  factory FunnelData.fromJson(Map<String, dynamic> json) =>
      _$FunnelDataFromJson(json);
}

@freezed
class TCPerformance with _$TCPerformance {
  const factory TCPerformance({
    @JsonKey(name: 'tc_id') @_IntConverter() required int tcId,
    @JsonKey(name: 'tc_name') required String tcName,
    @JsonKey(name: 'total_students') @_IntConverter() required int totalStudents,
    @JsonKey(name: 'prospect_count') @_IntConverter() required int prospectCount,
    @JsonKey(name: 'consult_count') @_IntConverter() required int consultCount,
    @JsonKey(name: 'register_count') @_IntConverter() required int registerCount,
    @JsonKey(name: 'consult_total') @_IntConverter() required int consultTotal,
  }) = _TCPerformance;

  factory TCPerformance.fromJson(Map<String, dynamic> json) =>
      _$TCPerformanceFromJson(json);
}

@freezed
class MonthlyTrend with _$MonthlyTrend {
  const factory MonthlyTrend({
    required String month,
    @JsonKey(name: 'register_count') @_IntConverter() required int registerCount,
  }) = _MonthlyTrend;

  factory MonthlyTrend.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTrendFromJson(json);
}
