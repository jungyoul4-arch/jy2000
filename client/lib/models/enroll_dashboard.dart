// 재원생 경영 대시보드 모델
//
// 서버가 한 달치 집계를 통째로 내려 주므로 읽기 전용이다.
// 다른 모델과 달리 freezed를 쓰지 않는다 — 수정도 비교도 하지 않는
// 표시 전용 데이터라 codegen 단계를 늘릴 이유가 없다.

int _asInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

double _asDouble(dynamic v) {
  if (v is double) return v;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? 0;
  return 0;
}

String? _asString(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  return s.isEmpty ? null : s;
}

/// 이름-값 한 쌍. 막대 차트와 목록이 전부 이 형태다.
class NamedValue {
  final String name;
  final int value;

  const NamedValue({required this.name, required this.value});

  factory NamedValue.fromJson(Map<String, dynamic> json) => NamedValue(
        name: json['name']?.toString() ?? '',
        value: _asInt(json['value']),
      );
}

/// 스냅샷 출처. 2~8월은 엑셀, 9월부터는 DB에서 자동 생성된다.
class SnapshotInfo {
  final int year;
  final int month;
  final String sourceKind;
  final String? sourceNote;
  final String? asOfDate;

  const SnapshotInfo({
    required this.year,
    required this.month,
    required this.sourceKind,
    this.sourceNote,
    this.asOfDate,
  });

  bool get isFromDb => sourceKind == 'db';
  String get label => '$year년 $month월';
  String get sourceLabel => isFromDb ? 'DB 자동' : '엑셀';

  factory SnapshotInfo.fromJson(Map<String, dynamic> json) => SnapshotInfo(
        year: _asInt(json['year']),
        month: _asInt(json['month']),
        sourceKind: json['sourceKind']?.toString() ?? 'excel',
        sourceNote: _asString(json['sourceNote']),
        asOfDate: _asString(json['asOfDate']),
      );
}

/// 월 선택기용 항목
class EnrollMonth {
  final int year;
  final int month;
  final String sourceKind;
  final String? sourceNote;
  final int studentCount;
  final int rowCount;

  const EnrollMonth({
    required this.year,
    required this.month,
    required this.sourceKind,
    this.sourceNote,
    required this.studentCount,
    required this.rowCount,
  });

  String get label => '$month월';
  bool get isFromDb => sourceKind == 'db';

  factory EnrollMonth.fromJson(Map<String, dynamic> json) => EnrollMonth(
        year: _asInt(json['year']),
        month: _asInt(json['month']),
        sourceKind: json['sourceKind']?.toString() ?? 'excel',
        sourceNote: _asString(json['sourceNote']),
        studentCount: _asInt(json['studentCount']),
        rowCount: _asInt(json['rowCount']),
      );
}

/// 월별 추이 한 점
class EnrollTrendPoint {
  final int year;
  final int month;
  final String sourceKind;
  final int students;
  final int enrollments;
  final int classes;
  final double subjectsPerStudent;

  /// 첫 달은 비교 대상이 없어 null이다.
  final int? newStudents;
  final int? leftStudents;

  const EnrollTrendPoint({
    required this.year,
    required this.month,
    required this.sourceKind,
    required this.students,
    required this.enrollments,
    required this.classes,
    required this.subjectsPerStudent,
    this.newStudents,
    this.leftStudents,
  });

  String get label => '$month월';
  bool get isFromDb => sourceKind == 'db';

  factory EnrollTrendPoint.fromJson(Map<String, dynamic> json) => EnrollTrendPoint(
        year: _asInt(json['year']),
        month: _asInt(json['month']),
        sourceKind: json['sourceKind']?.toString() ?? 'excel',
        students: _asInt(json['students']),
        enrollments: _asInt(json['enrollments']),
        classes: _asInt(json['classes']),
        subjectsPerStudent: _asDouble(json['subjectsPerStudent']),
        newStudents: json['newStudents'] == null ? null : _asInt(json['newStudents']),
        leftStudents: json['leftStudents'] == null ? null : _asInt(json['leftStudents']),
      );
}

class EnrollKpi {
  final int students;
  final int enrollments;
  final int classes;
  final int regularClasses;
  final double subjectsPerStudent;
  final double scienceRate;
  final int upsellTargets;

  const EnrollKpi({
    required this.students,
    required this.enrollments,
    required this.classes,
    required this.regularClasses,
    required this.subjectsPerStudent,
    required this.scienceRate,
    required this.upsellTargets,
  });

  factory EnrollKpi.fromJson(Map<String, dynamic> json) => EnrollKpi(
        students: _asInt(json['students']),
        enrollments: _asInt(json['enrollments']),
        classes: _asInt(json['classes']),
        regularClasses: _asInt(json['regularClasses']),
        subjectsPerStudent: _asDouble(json['subjectsPerStudent']),
        scienceRate: _asDouble(json['scienceRate']),
        upsellTargets: _asInt(json['upsellTargets']),
      );
}

/// 학년별 항목 — 학년 필터가 grade 값을 쓴다.
class GradeCount {
  final int grade;
  final String name;
  final int value;

  const GradeCount({required this.grade, required this.name, required this.value});

  factory GradeCount.fromJson(Map<String, dynamic> json) => GradeCount(
        grade: _asInt(json['grade']),
        name: json['name']?.toString() ?? '',
        value: _asInt(json['value']),
      );
}

/// 학년별 과학 침투율
class SciencePenetration {
  final String name;
  final int total;
  final int science;
  final double rate;

  const SciencePenetration({
    required this.name,
    required this.total,
    required this.science,
    required this.rate,
  });

  factory SciencePenetration.fromJson(Map<String, dynamic> json) => SciencePenetration(
        name: json['name']?.toString() ?? '',
        total: _asInt(json['total']),
        science: _asInt(json['science']),
        rate: _asDouble(json['rate']),
      );
}

class ScienceSection {
  final int students;
  final List<SciencePenetration> byGrade;
  final List<NamedValue> bySubject;

  const ScienceSection({
    required this.students,
    required this.byGrade,
    required this.bySubject,
  });

  factory ScienceSection.fromJson(Map<String, dynamic> json) => ScienceSection(
        students: _asInt(json['students']),
        byGrade: _list(json['byGrade'], SciencePenetration.fromJson),
        bySubject: _list(json['bySubject'], NamedValue.fromJson),
      );
}

class ClassInfoItem {
  final String name;
  final String kind;
  final int size;

  const ClassInfoItem({required this.name, required this.kind, required this.size});

  factory ClassInfoItem.fromJson(Map<String, dynamic> json) => ClassInfoItem(
        name: json['name']?.toString() ?? '',
        kind: json['kind']?.toString() ?? '정규',
        size: _asInt(json['size']),
      );
}

class TeacherLoad {
  final String name;
  final int students;
  final int classes;

  const TeacherLoad({required this.name, required this.students, required this.classes});

  factory TeacherLoad.fromJson(Map<String, dynamic> json) => TeacherLoad(
        name: json['name']?.toString() ?? '',
        students: _asInt(json['students']),
        classes: _asInt(json['classes']),
      );
}

/// 업셀 타겟 — 한 과목만 듣는 학생
class UpsellTarget {
  final String name;
  final String gradeName;
  final String? school;
  final String subject;

  const UpsellTarget({
    required this.name,
    required this.gradeName,
    this.school,
    required this.subject,
  });

  factory UpsellTarget.fromJson(Map<String, dynamic> json) => UpsellTarget(
        name: json['name']?.toString() ?? '',
        gradeName: json['gradeName']?.toString() ?? '',
        school: _asString(json['school']),
        subject: json['subject']?.toString() ?? '',
      );
}

List<T> _list<T>(dynamic raw, T Function(Map<String, dynamic>) fromJson) {
  if (raw is! List) return const [];
  return raw
      .whereType<Map>()
      .map((e) => fromJson(Map<String, dynamic>.from(e)))
      .toList();
}

class EnrollDashboard {
  final SnapshotInfo snapshot;
  final EnrollKpi kpi;
  final List<GradeCount> byGrade;
  final List<NamedValue> bySubject;
  final List<NamedValue> bySubjectGroup;
  final List<NamedValue> byNsubj;
  final List<NamedValue> bySchool;
  final List<NamedValue> byClassKind;
  final List<NamedValue> byClassSize;
  final List<ClassInfoItem> smallClasses;
  final List<TeacherLoad> byTeacher;
  final ScienceSection science;
  final List<UpsellTarget> upsell;

  const EnrollDashboard({
    required this.snapshot,
    required this.kpi,
    required this.byGrade,
    required this.bySubject,
    required this.bySubjectGroup,
    required this.byNsubj,
    required this.bySchool,
    required this.byClassKind,
    required this.byClassSize,
    required this.smallClasses,
    required this.byTeacher,
    required this.science,
    required this.upsell,
  });

  factory EnrollDashboard.fromJson(Map<String, dynamic> json) => EnrollDashboard(
        snapshot: SnapshotInfo.fromJson(
          Map<String, dynamic>.from(json['snapshot'] as Map? ?? {}),
        ),
        kpi: EnrollKpi.fromJson(Map<String, dynamic>.from(json['kpi'] as Map? ?? {})),
        byGrade: _list(json['byGrade'], GradeCount.fromJson),
        bySubject: _list(json['bySubject'], NamedValue.fromJson),
        bySubjectGroup: _list(json['bySubjectGroup'], NamedValue.fromJson),
        byNsubj: _list(json['byNsubj'], NamedValue.fromJson),
        bySchool: _list(json['bySchool'], NamedValue.fromJson),
        byClassKind: _list(json['byClassKind'], NamedValue.fromJson),
        byClassSize: _list(json['byClassSize'], NamedValue.fromJson),
        smallClasses: _list(json['smallClasses'], ClassInfoItem.fromJson),
        byTeacher: _list(json['byTeacher'], TeacherLoad.fromJson),
        science: ScienceSection.fromJson(
          Map<String, dynamic>.from(json['science'] as Map? ?? {}),
        ),
        upsell: _list(json['upsell'], UpsellTarget.fromJson),
      );
}
