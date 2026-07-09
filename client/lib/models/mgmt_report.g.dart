// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mgmt_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MgmtReportImpl _$$MgmtReportImplFromJson(Map<String, dynamic> json) =>
    _$MgmtReportImpl(
      summary: MgmtReportSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      monthlyTrend: (json['monthlyTrend'] as List<dynamic>)
          .map((e) => MonthlyTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      bySubject: (json['bySubject'] as List<dynamic>)
          .map((e) => SubjectStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      byGrade: (json['byGrade'] as List<dynamic>)
          .map((e) => GradeStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      byTeacher: (json['byTeacher'] as List<dynamic>)
          .map((e) => TeacherStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      bySchool: (json['bySchool'] as List<dynamic>)
          .map((e) => SchoolStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      byClassType: (json['byClassType'] as List<dynamic>)
          .map((e) => ClassTypeStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MgmtReportImplToJson(_$MgmtReportImpl instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'monthlyTrend': instance.monthlyTrend,
      'bySubject': instance.bySubject,
      'byGrade': instance.byGrade,
      'byTeacher': instance.byTeacher,
      'bySchool': instance.bySchool,
      'byClassType': instance.byClassType,
    };

_$MgmtReportSummaryImpl _$$MgmtReportSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$MgmtReportSummaryImpl(
  totalRevenue: json['totalRevenue'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['totalRevenue']),
  totalEnrollments: json['totalEnrollments'] == null
      ? 0
      : const FlexibleDoubleConverter().fromJson(json['totalEnrollments']),
  studentCount: json['studentCount'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['studentCount']),
  avgUnitPrice: json['avgUnitPrice'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['avgUnitPrice']),
);

Map<String, dynamic> _$$MgmtReportSummaryImplToJson(
  _$MgmtReportSummaryImpl instance,
) => <String, dynamic>{
  'totalRevenue': const FlexibleIntConverter().toJson(instance.totalRevenue),
  'totalEnrollments': const FlexibleDoubleConverter().toJson(
    instance.totalEnrollments,
  ),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
  'avgUnitPrice': const FlexibleIntConverter().toJson(instance.avgUnitPrice),
};

_$MonthlyTrendImpl _$$MonthlyTrendImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyTrendImpl(
      year: const FlexibleIntConverter().fromJson(json['year']),
      month: const FlexibleIntConverter().fromJson(json['month']),
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      enrollments: json['enrollments'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['enrollments']),
      studentCount: json['studentCount'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['studentCount']),
    );

Map<String, dynamic> _$$MonthlyTrendImplToJson(
  _$MonthlyTrendImpl instance,
) => <String, dynamic>{
  'year': const FlexibleIntConverter().toJson(instance.year),
  'month': const FlexibleIntConverter().toJson(instance.month),
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'enrollments': const FlexibleDoubleConverter().toJson(instance.enrollments),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$SubjectStatImpl _$$SubjectStatImplFromJson(Map<String, dynamic> json) =>
    _$SubjectStatImpl(
      subject: json['subject'] as String,
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      enrollments: json['enrollments'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['enrollments']),
      percentage: json['percentage'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['percentage']),
    );

Map<String, dynamic> _$$SubjectStatImplToJson(
  _$SubjectStatImpl instance,
) => <String, dynamic>{
  'subject': instance.subject,
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'enrollments': const FlexibleDoubleConverter().toJson(instance.enrollments),
  'percentage': const FlexibleDoubleConverter().toJson(instance.percentage),
};

_$GradeStatImpl _$$GradeStatImplFromJson(Map<String, dynamic> json) =>
    _$GradeStatImpl(
      grade: const FlexibleIntConverter().fromJson(json['grade']),
      gradeName: json['gradeName'] as String,
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      studentCount: json['studentCount'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['studentCount']),
    );

Map<String, dynamic> _$$GradeStatImplToJson(
  _$GradeStatImpl instance,
) => <String, dynamic>{
  'grade': const FlexibleIntConverter().toJson(instance.grade),
  'gradeName': instance.gradeName,
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$TeacherStatImpl _$$TeacherStatImplFromJson(Map<String, dynamic> json) =>
    _$TeacherStatImpl(
      teacherId: (json['teacherId'] as num?)?.toInt(),
      teacherName: json['teacherName'] as String,
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      enrollments: json['enrollments'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['enrollments']),
      studentCount: json['studentCount'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['studentCount']),
    );

Map<String, dynamic> _$$TeacherStatImplToJson(
  _$TeacherStatImpl instance,
) => <String, dynamic>{
  'teacherId': instance.teacherId,
  'teacherName': instance.teacherName,
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'enrollments': const FlexibleDoubleConverter().toJson(instance.enrollments),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$SchoolStatImpl _$$SchoolStatImplFromJson(Map<String, dynamic> json) =>
    _$SchoolStatImpl(
      schoolId: (json['schoolId'] as num?)?.toInt(),
      schoolName: json['schoolName'] as String,
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      studentCount: json['studentCount'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['studentCount']),
    );

Map<String, dynamic> _$$SchoolStatImplToJson(
  _$SchoolStatImpl instance,
) => <String, dynamic>{
  'schoolId': instance.schoolId,
  'schoolName': instance.schoolName,
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$ClassTypeStatImpl _$$ClassTypeStatImplFromJson(Map<String, dynamic> json) =>
    _$ClassTypeStatImpl(
      classTypeId: (json['classTypeId'] as num?)?.toInt(),
      classTypeName: json['classTypeName'] as String,
      revenue: json['revenue'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['revenue']),
      enrollments: json['enrollments'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['enrollments']),
    );

Map<String, dynamic> _$$ClassTypeStatImplToJson(
  _$ClassTypeStatImpl instance,
) => <String, dynamic>{
  'classTypeId': instance.classTypeId,
  'classTypeName': instance.classTypeName,
  'revenue': const FlexibleIntConverter().toJson(instance.revenue),
  'enrollments': const FlexibleDoubleConverter().toJson(instance.enrollments),
};

_$RegionMonthlyStatImpl _$$RegionMonthlyStatImplFromJson(
  Map<String, dynamic> json,
) => _$RegionMonthlyStatImpl(
  regionName: json['regionName'] as String,
  year: const FlexibleIntConverter().fromJson(json['year']),
  month: const FlexibleIntConverter().fromJson(json['month']),
  studentCount: json['studentCount'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['studentCount']),
);

Map<String, dynamic> _$$RegionMonthlyStatImplToJson(
  _$RegionMonthlyStatImpl instance,
) => <String, dynamic>{
  'regionName': instance.regionName,
  'year': const FlexibleIntConverter().toJson(instance.year),
  'month': const FlexibleIntConverter().toJson(instance.month),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$RegionGradeMonthlyStatImpl _$$RegionGradeMonthlyStatImplFromJson(
  Map<String, dynamic> json,
) => _$RegionGradeMonthlyStatImpl(
  regionName: json['regionName'] as String,
  year: const FlexibleIntConverter().fromJson(json['year']),
  month: const FlexibleIntConverter().fromJson(json['month']),
  grade: json['grade'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['grade']),
  gradeName: json['gradeName'] as String,
  studentCount: json['studentCount'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['studentCount']),
);

Map<String, dynamic> _$$RegionGradeMonthlyStatImplToJson(
  _$RegionGradeMonthlyStatImpl instance,
) => <String, dynamic>{
  'regionName': instance.regionName,
  'year': const FlexibleIntConverter().toJson(instance.year),
  'month': const FlexibleIntConverter().toJson(instance.month),
  'grade': const FlexibleIntConverter().toJson(instance.grade),
  'gradeName': instance.gradeName,
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$SchoolRegionMonthlyStatImpl _$$SchoolRegionMonthlyStatImplFromJson(
  Map<String, dynamic> json,
) => _$SchoolRegionMonthlyStatImpl(
  schoolId: (json['schoolId'] as num?)?.toInt(),
  schoolName: json['schoolName'] as String,
  regionName: json['regionName'] as String,
  year: const FlexibleIntConverter().fromJson(json['year']),
  month: const FlexibleIntConverter().fromJson(json['month']),
  studentCount: json['studentCount'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['studentCount']),
);

Map<String, dynamic> _$$SchoolRegionMonthlyStatImplToJson(
  _$SchoolRegionMonthlyStatImpl instance,
) => <String, dynamic>{
  'schoolId': instance.schoolId,
  'schoolName': instance.schoolName,
  'regionName': instance.regionName,
  'year': const FlexibleIntConverter().toJson(instance.year),
  'month': const FlexibleIntConverter().toJson(instance.month),
  'studentCount': const FlexibleIntConverter().toJson(instance.studentCount),
};

_$RegionReportImpl _$$RegionReportImplFromJson(
  Map<String, dynamic> json,
) => _$RegionReportImpl(
  byRegionMonthly: (json['byRegionMonthly'] as List<dynamic>)
      .map((e) => RegionMonthlyStat.fromJson(e as Map<String, dynamic>))
      .toList(),
  byRegionGradeMonthly: (json['byRegionGradeMonthly'] as List<dynamic>)
      .map((e) => RegionGradeMonthlyStat.fromJson(e as Map<String, dynamic>))
      .toList(),
  bySchoolRegionMonthly: (json['bySchoolRegionMonthly'] as List<dynamic>)
      .map((e) => SchoolRegionMonthlyStat.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$RegionReportImplToJson(_$RegionReportImpl instance) =>
    <String, dynamic>{
      'byRegionMonthly': instance.byRegionMonthly,
      'byRegionGradeMonthly': instance.byRegionGradeMonthly,
      'bySchoolRegionMonthly': instance.bySchoolRegionMonthly,
    };
