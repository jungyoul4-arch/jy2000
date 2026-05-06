// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardKPIImpl _$$DashboardKPIImplFromJson(Map<String, dynamic> json) =>
    _$DashboardKPIImpl(
      totalStudents: const _IntConverter().fromJson(json['total_students']),
      newStudentsThisMonth: const _IntConverter().fromJson(
        json['new_students_this_month'],
      ),
      consultsThisMonth: const _IntConverter().fromJson(
        json['consults_this_month'],
      ),
      registersThisMonth: const _IntConverter().fromJson(
        json['registers_this_month'],
      ),
      enrolledCount: const _IntConverter().fromJson(json['enrolled_count']),
      conversionRate: const _DoubleConverter().fromJson(
        json['conversion_rate'],
      ),
    );

Map<String, dynamic> _$$DashboardKPIImplToJson(
  _$DashboardKPIImpl instance,
) => <String, dynamic>{
  'total_students': const _IntConverter().toJson(instance.totalStudents),
  'new_students_this_month': const _IntConverter().toJson(
    instance.newStudentsThisMonth,
  ),
  'consults_this_month': const _IntConverter().toJson(
    instance.consultsThisMonth,
  ),
  'registers_this_month': const _IntConverter().toJson(
    instance.registersThisMonth,
  ),
  'enrolled_count': const _IntConverter().toJson(instance.enrolledCount),
  'conversion_rate': const _DoubleConverter().toJson(instance.conversionRate),
};

_$FunnelDataImpl _$$FunnelDataImplFromJson(Map<String, dynamic> json) =>
    _$FunnelDataImpl(
      statusCode: json['status_code'] as String,
      statusName: json['status_name'] as String,
      count: const _IntConverter().fromJson(json['count']),
      percentage: const _DoubleConverter().fromJson(json['percentage']),
    );

Map<String, dynamic> _$$FunnelDataImplToJson(_$FunnelDataImpl instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'status_name': instance.statusName,
      'count': const _IntConverter().toJson(instance.count),
      'percentage': const _DoubleConverter().toJson(instance.percentage),
    };

_$TCPerformanceImpl _$$TCPerformanceImplFromJson(Map<String, dynamic> json) =>
    _$TCPerformanceImpl(
      tcId: const _IntConverter().fromJson(json['tc_id']),
      tcName: json['tc_name'] as String,
      totalStudents: const _IntConverter().fromJson(json['total_students']),
      prospectCount: const _IntConverter().fromJson(json['prospect_count']),
      consultCount: const _IntConverter().fromJson(json['consult_count']),
      registerCount: const _IntConverter().fromJson(json['register_count']),
      consultTotal: const _IntConverter().fromJson(json['consult_total']),
    );

Map<String, dynamic> _$$TCPerformanceImplToJson(_$TCPerformanceImpl instance) =>
    <String, dynamic>{
      'tc_id': const _IntConverter().toJson(instance.tcId),
      'tc_name': instance.tcName,
      'total_students': const _IntConverter().toJson(instance.totalStudents),
      'prospect_count': const _IntConverter().toJson(instance.prospectCount),
      'consult_count': const _IntConverter().toJson(instance.consultCount),
      'register_count': const _IntConverter().toJson(instance.registerCount),
      'consult_total': const _IntConverter().toJson(instance.consultTotal),
    };

_$MonthlyTrendImpl _$$MonthlyTrendImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyTrendImpl(
      month: json['month'] as String,
      registerCount: const _IntConverter().fromJson(json['register_count']),
    );

Map<String, dynamic> _$$MonthlyTrendImplToJson(_$MonthlyTrendImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'register_count': const _IntConverter().toJson(instance.registerCount),
    };
