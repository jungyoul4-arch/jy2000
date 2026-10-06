// 상담 화면의 학생 목록 항목
//
// 신규생 문의와 상담 관리가 같은 구조를 쓴다 — 학생을 고르면 그 학생의
// 상담 목록이 뜨고, 거기서 고르면 상세로 간다. 두 화면은 대상만 다르다.
// 읽기 전용이라 freezed를 쓰지 않는다.

/// 학생 목록의 대상 구분
enum ConsultStudentScope {
  /// 아직 학원생이 되지 않은 학생 (active_flag=0, 퇴원 아님)
  newStudent('new', '신규생'),

  /// 재원 또는 퇴원 학생
  existing('existing', '재원·퇴원');

  const ConsultStudentScope(this.value, this.label);

  final String value;
  final String label;
}

/// 목록 정렬
enum ConsultStudentSort {
  recent('recent', '최근 상담순'),
  name('name', '이름순');

  const ConsultStudentSort(this.value, this.label);

  final String value;
  final String label;
}

const _gradeNames = <int, String>{
  1: '초1', 2: '초2', 3: '초3', 4: '초4', 5: '초5', 6: '초6',
  7: '중1', 8: '중2', 9: '중3',
  10: '고1', 11: '고2', 12: '고3',
  13: 'N수', 14: '성인',
};

class ConsultStudent {
  final int studentId;
  final String studentName;
  final String? phone;
  final int? grade;
  final int activeFlag;
  final String? statusCode;
  final String? schoolName;
  final int consultCount;

  /// 상담이 한 건도 없으면 null. 화면에서 '상담 없음'으로 표시한다.
  final String? lastConsultDate;

  /// 마지막 상담의 내용과 유형. 목록에서 학생을 고를 때 '뭘 얘기했더라'가
  /// 바로 보이도록 서버가 200자까지 잘라서 내려 준다.
  final String? lastConsultContent;
  final String? lastConsultTypeName;

  /// 앞으로 잡힌 상담 중 가장 가까운 것. 등록 시점에 적어 둔 '상담할 내용'이
  /// 여기 들어온다. 계획이 없으면 null.
  final String? nextPlanDate;
  final String? nextPlanContent;
  final String? nextPlanTypeName;

  const ConsultStudent({
    required this.studentId,
    required this.studentName,
    this.phone,
    this.grade,
    required this.activeFlag,
    this.statusCode,
    this.schoolName,
    required this.consultCount,
    this.lastConsultDate,
    this.lastConsultContent,
    this.lastConsultTypeName,
    this.nextPlanDate,
    this.nextPlanContent,
    this.nextPlanTypeName,
  });

  bool get hasConsult => consultCount > 0;
  bool get hasPlan => nextPlanDate != null;
  bool get isEnrolled => activeFlag == 1;
  bool get isWithdrawn => statusCode == 'STATUS_WITHDRAW';

  /// 목록에 붙는 상태 배지. 신규생은 배지를 달지 않는다(전부 신규생이라 무의미).
  String? get statusLabel {
    if (isEnrolled) return '재원';
    if (isWithdrawn) return '퇴원';
    return null;
  }

  String get gradeName {
    final g = grade;
    if (g == null || g == 0) return '';
    return _gradeNames[g] ?? '$g학년';
  }

  /// '고1 · 상동고'처럼 이름 아래 한 줄로 붙인다.
  String get subtitle {
    final parts = <String>[
      if (gradeName.isNotEmpty) gradeName,
      if (schoolName != null && schoolName!.isNotEmpty) schoolName!,
    ];
    return parts.join(' · ');
  }

  factory ConsultStudent.fromJson(Map<String, dynamic> json) {
    int asInt(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    String? asString(dynamic v) {
      if (v == null) return null;
      final s = v.toString().trim();
      return s.isEmpty ? null : s;
    }

    return ConsultStudent(
      studentId: asInt(json['student_id']),
      studentName: json['student_name']?.toString() ?? '',
      phone: asString(json['phone']),
      grade: json['grade'] == null ? null : asInt(json['grade']),
      activeFlag: asInt(json['active_flag']),
      statusCode: asString(json['status_code']),
      schoolName: asString(json['school_name']),
      consultCount: asInt(json['consult_count']),
      lastConsultDate: asString(json['last_consult_date']),
      lastConsultContent: asString(json['last_consult_content']),
      lastConsultTypeName: asString(json['last_consult_type_name']),
      nextPlanDate: asString(json['next_plan_date']),
      nextPlanContent: asString(json['next_plan_content']),
      nextPlanTypeName: asString(json['next_plan_type_name']),
    );
  }
}
