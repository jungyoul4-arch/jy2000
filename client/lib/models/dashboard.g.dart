// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

int _toInt(dynamic value) => value is num ? value.toInt() : int.parse(value.toString());
double _toDouble(dynamic value) => value is num ? value.toDouble() : double.parse(value.toString());

_$DashboardKPIImpl _$$DashboardKPIImplFromJson(Map<String, dynamic> json) =>
    _$DashboardKPIImpl(
      totalStudents: _toInt(json['total_students']),
      newStudentsThisMonth: _toInt(json['new_students_this_month']),
      consultsThisMonth: _toInt(json['consults_this_month']),
      registersThisMonth: _toInt(json['registers_this_month']),
      enrolledCount: _toInt(json['enrolled_count']),
      conversionRate: _toDouble(json['conversion_rate']),
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
      count: _toInt(json['count']),
      percentage: _toDouble(json['percentage']),
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
      tcId: _toInt(json['tc_id']),
      tcName: json['tc_name'] as String,
      totalStudents: _toInt(json['total_students']),
      prospectCount: _toInt(json['prospect_count']),
      consultCount: _toInt(json['consult_count']),
      registerCount: _toInt(json['register_count']),
      consultTotal: _toInt(json['consult_total']),
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
      registerCount: _toInt(json['register_count']),
    );

Map<String, dynamic> _$$MonthlyTrendImplToJson(_$MonthlyTrendImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'register_count': instance.registerCount,
    };
