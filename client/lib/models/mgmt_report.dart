import 'package:freezed_annotation/freezed_annotation.dart';

part 'mgmt_report.freezed.dart';
part 'mgmt_report.g.dart';

// String 또는 num을 int로 변환하는 컨버터
class FlexibleIntConverter implements JsonConverter<int, dynamic> {
  const FlexibleIntConverter();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is int) return json;
    if (json is double) return json.toInt();
    if (json is String) return int.tryParse(json) ?? 0;
    return 0;
  }

  @override
  dynamic toJson(int object) => object;
}

// String 또는 num을 double로 변환하는 컨버터
class FlexibleDoubleConverter implements JsonConverter<double, dynamic> {
  const FlexibleDoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json == null) return 0.0;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) return double.tryParse(json) ?? 0.0;
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

// 경영 보고서 전체 데이터
@freezed
class MgmtReport with _$MgmtReport {
  const factory MgmtReport({
    required MgmtReportSummary summary,
    required List<MonthlyTrend> monthlyTrend,
    required List<SubjectStat> bySubject,
    required List<GradeStat> byGrade,
    required List<TeacherStat> byTeacher,
    required List<SchoolStat> bySchool,
    required List<ClassTypeStat> byClassType,
  }) = _MgmtReport;

  factory MgmtReport.fromJson(Map<String, dynamic> json) =>
      _$MgmtReportFromJson(json);
}

// 요약 KPI
@freezed
class MgmtReportSummary with _$MgmtReportSummary {
  const factory MgmtReportSummary({
    @FlexibleIntConverter() @Default(0) int totalRevenue,
    @FlexibleDoubleConverter() @Default(0) double totalEnrollments,
    @FlexibleIntConverter() @Default(0) int studentCount,
    @FlexibleIntConverter() @Default(0) int avgUnitPrice,
  }) = _MgmtReportSummary;

  factory MgmtReportSummary.fromJson(Map<String, dynamic> json) =>
      _$MgmtReportSummaryFromJson(json);
}

// 월별 추이
@freezed
class MonthlyTrend with _$MonthlyTrend {
  const factory MonthlyTrend({
    @FlexibleIntConverter() required int year,
    @FlexibleIntConverter() required int month,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleDoubleConverter() @Default(0) double enrollments,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _MonthlyTrend;

  factory MonthlyTrend.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTrendFromJson(json);
}

// 과목별 통계
@freezed
class SubjectStat with _$SubjectStat {
  const factory SubjectStat({
    required String subject,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleDoubleConverter() @Default(0) double enrollments,
    @FlexibleDoubleConverter() @Default(0) double percentage,
  }) = _SubjectStat;

  factory SubjectStat.fromJson(Map<String, dynamic> json) =>
      _$SubjectStatFromJson(json);
}

// 학년별 통계
@freezed
class GradeStat with _$GradeStat {
  const factory GradeStat({
    @FlexibleIntConverter() required int grade,
    required String gradeName,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _GradeStat;

  factory GradeStat.fromJson(Map<String, dynamic> json) =>
      _$GradeStatFromJson(json);
}

// 강사별 통계
@freezed
class TeacherStat with _$TeacherStat {
  const factory TeacherStat({
    int? teacherId,
    required String teacherName,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleDoubleConverter() @Default(0) double enrollments,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _TeacherStat;

  factory TeacherStat.fromJson(Map<String, dynamic> json) =>
      _$TeacherStatFromJson(json);
}

// 학교별 통계
@freezed
class SchoolStat with _$SchoolStat {
  const factory SchoolStat({
    int? schoolId,
    required String schoolName,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _SchoolStat;

  factory SchoolStat.fromJson(Map<String, dynamic> json) =>
      _$SchoolStatFromJson(json);
}

// 반형태별 통계
@freezed
class ClassTypeStat with _$ClassTypeStat {
  const factory ClassTypeStat({
    int? classTypeId,
    required String classTypeName,
    @FlexibleIntConverter() @Default(0) int revenue,
    @FlexibleDoubleConverter() @Default(0) double enrollments,
  }) = _ClassTypeStat;

  factory ClassTypeStat.fromJson(Map<String, dynamic> json) =>
      _$ClassTypeStatFromJson(json);
}

// ============================================================
// 지역별 보고서 모델
// ============================================================

// 지역별 월별 학생수
@freezed
class RegionMonthlyStat with _$RegionMonthlyStat {
  const factory RegionMonthlyStat({
    required String regionName,
    @FlexibleIntConverter() required int year,
    @FlexibleIntConverter() required int month,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _RegionMonthlyStat;

  factory RegionMonthlyStat.fromJson(Map<String, dynamic> json) =>
      _$RegionMonthlyStatFromJson(json);
}

// 지역별 월별 학년별 학생수
@freezed
class RegionGradeMonthlyStat with _$RegionGradeMonthlyStat {
  const factory RegionGradeMonthlyStat({
    required String regionName,
    @FlexibleIntConverter() required int year,
    @FlexibleIntConverter() required int month,
    @FlexibleIntConverter() @Default(0) int grade,
    required String gradeName,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _RegionGradeMonthlyStat;

  factory RegionGradeMonthlyStat.fromJson(Map<String, dynamic> json) =>
      _$RegionGradeMonthlyStatFromJson(json);
}

// 학교별 지역별 월별 학생수
@freezed
class SchoolRegionMonthlyStat with _$SchoolRegionMonthlyStat {
  const factory SchoolRegionMonthlyStat({
    int? schoolId,
    required String schoolName,
    required String regionName,
    @FlexibleIntConverter() required int year,
    @FlexibleIntConverter() required int month,
    @FlexibleIntConverter() @Default(0) int studentCount,
  }) = _SchoolRegionMonthlyStat;

  factory SchoolRegionMonthlyStat.fromJson(Map<String, dynamic> json) =>
      _$SchoolRegionMonthlyStatFromJson(json);
}

// 지역별 보고서 전체 데이터
@freezed
class RegionReport with _$RegionReport {
  const factory RegionReport({
    required List<RegionMonthlyStat> byRegionMonthly,
    required List<RegionGradeMonthlyStat> byRegionGradeMonthly,
    required List<SchoolRegionMonthlyStat> bySchoolRegionMonthly,
  }) = _RegionReport;

  factory RegionReport.fromJson(Map<String, dynamic> json) =>
      _$RegionReportFromJson(json);
}
