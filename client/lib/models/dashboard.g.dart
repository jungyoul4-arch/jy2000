// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardKPIImpl _$$DashboardKPIImplFromJson(Map<String, dynamic> json) =>
    _$DashboardKPIImpl(
      totalStudents: (json['total_students'] as num).toInt(),
      newStudentsThisMonth: (json['new_students_this_month'] as num).toInt(),
      consultsThisMonth: (json['consults_this_month'] as num).toInt(),
      registersThisMonth: (json['registers_this_month'] as num).toInt(),
      enrolledCount: (json['enrolled_count'] as num).toInt(),
      conversionRate: (json['conversion_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$DashboardKPIImplToJson(_$DashboardKPIImpl instance) =>
    <String, dynamic>{
      'total_students': instance.totalStudents,
      'new_students_this_month': instance.newStudentsThisMonth,
      'consults_this_month': instance.consultsThisMonth,
      'registers_this_month': instance.registersThisMonth,
      'enrolled_count': instance.enrolledCount,
      'conversion_rate': instance.conversionRate,
    };

_$FunnelDataImpl _$$FunnelDataImplFromJson(Map<String, dynamic> json) =>
    _$FunnelDataImpl(
      statusCode: json['status_code'] as String,
      statusName: json['status_name'] as String,
      count: (json['count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$FunnelDataImplToJson(_$FunnelDataImpl instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'status_name': instance.statusName,
      'count': instance.count,
      'percentage': instance.percentage,
    };

_$TCPerformanceImpl _$$TCPerformanceImplFromJson(Map<String, dynamic> json) =>
    _$TCPerformanceImpl(
      tcId: (json['tc_id'] as num).toInt(),
      tcName: json['tc_name'] as String,
      totalStudents: (json['total_students'] as num).toInt(),
      prospectCount: (json['prospect_count'] as num).toInt(),
      consultCount: (json['consult_count'] as num).toInt(),
      registerCount: (json['register_count'] as num).toInt(),
      consultTotal: (json['consult_total'] as num).toInt(),
    );

Map<String, dynamic> _$$TCPerformanceImplToJson(_$TCPerformanceImpl instance) =>
    <String, dynamic>{
      'tc_id': instance.tcId,
      'tc_name': instance.tcName,
      'total_students': instance.totalStudents,
      'prospect_count': instance.prospectCount,
      'consult_count': instance.consultCount,
      'register_count': instance.registerCount,
      'consult_total': instance.consultTotal,
    };

_$MonthlyTrendImpl _$$MonthlyTrendImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyTrendImpl(
      month: json['month'] as String,
      registerCount: (json['register_count'] as num).toInt(),
    );

Map<String, dynamic> _$$MonthlyTrendImplToJson(_$MonthlyTrendImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'register_count': instance.registerCount,
    };
