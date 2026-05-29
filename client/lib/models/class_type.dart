import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_type.freezed.dart';
part 'class_type.g.dart';

// int를 bool로 변환하는 컨버터
class IntToBoolConverter implements JsonConverter<bool, dynamic> {
  const IntToBoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is int) return json == 1;
    return false;
  }

  @override
  dynamic toJson(bool object) => object ? 1 : 0;
}

// 강사 정보
@freezed
class ClassTypeTeacher with _$ClassTypeTeacher {
  const factory ClassTypeTeacher({
    @JsonKey(name: 'teacher_id') required int teacherId,
    @JsonKey(name: 'teacher_name') @Default('') String teacherName,
  }) = _ClassTypeTeacher;

  factory ClassTypeTeacher.fromJson(Map<String, dynamic> json) =>
      _$ClassTypeTeacherFromJson(json);
}

// 학년 코드 변환 헬퍼
// grade: 1~6=초1~초6, 7~9=중1~중3, 10~12=고1~고3
String gradeToString(int grade) {
  if (grade >= 1 && grade <= 6) return '초$grade';
  if (grade >= 7 && grade <= 9) return '중${grade - 6}';
  if (grade >= 10 && grade <= 12) return '고${grade - 9}';
  return '$grade';
}

int stringToGrade(String str) {
  final match = RegExp(r'^(초|중|고)(\d)$').firstMatch(str);
  if (match == null) return 0;
  final prefix = match.group(1)!;
  final num = int.parse(match.group(2)!);
  switch (prefix) {
    case '초':
      return num;
    case '중':
      return num + 6;
    case '고':
      return num + 9;
    default:
      return 0;
  }
}

// 과목 코드 변환 헬퍼
// subject: 1=국어, 2=수학, 3=영어, 4=과학, 5=사회
const Map<int, String> subjectMap = {
  1: '국어',
  2: '수학',
  3: '영어',
  4: '과학',
  5: '사회',
};

String subjectToString(int subject) {
  return subjectMap[subject] ?? '$subject';
}

int stringToSubject(String str) {
  for (final entry in subjectMap.entries) {
    if (entry.value == str) return entry.key;
  }
  return 0;
}

@freezed
class ClassType with _$ClassType {
  const ClassType._();

  const factory ClassType({
    @JsonKey(name: 'class_type_id') required int classTypeId,
    @JsonKey(name: 'class_type_name') required String classTypeName,
    required int grade,
    required int subject,
    @JsonKey(name: 'unit_price') @Default(0) int unitPrice,
    @Default([]) List<ClassTypeTeacher> teachers,
    @JsonKey(name: 'is_active')
    @IntToBoolConverter()
    @Default(true)
    bool isActive,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ClassType;

  factory ClassType.fromJson(Map<String, dynamic> json) =>
      _$ClassTypeFromJson(json);

  // 학년 문자열 반환
  String get gradeString => gradeToString(grade);

  // 과목 문자열 반환
  String get subjectString => subjectToString(subject);

  // 강사 이름 목록 반환
  List<String> get teacherNames => teachers.map((t) => t.teacherName).toList();

  // 강사 이름 문자열 반환
  String get teachersString => teacherNames.join(', ');
}

@freezed
class ClassTypeCreate with _$ClassTypeCreate {
  const factory ClassTypeCreate({
    @JsonKey(name: 'class_type_name') required String classTypeName,
    required int grade,
    required int subject,
    @JsonKey(name: 'unit_price') @Default(0) int unitPrice,
    @JsonKey(name: 'teacher_ids') @Default([]) List<int> teacherIds,
    @JsonKey(name: 'teacher_names') @Default([]) List<String> teacherNames,
  }) = _ClassTypeCreate;

  factory ClassTypeCreate.fromJson(Map<String, dynamic> json) =>
      _$ClassTypeCreateFromJson(json);
}
