import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

/// 숫자 또는 문자열을 int?로 변환하는 컨버터
class FlexibleIntConverter implements JsonConverter<int?, dynamic> {
  const FlexibleIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is num) return json.toInt();
    if (json is String) {
      final parsed = int.tryParse(json);
      return parsed;
    }
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}

@freezed
class ClassModel with _$ClassModel {
  const factory ClassModel({
    @JsonKey(name: 'class_id') required int classId,
    @JsonKey(name: 'class_name') required String className,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'genre_id') required int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') required String regDt,
    @FlexibleIntConverter() int? grade,
    @JsonKey(name: 'grade_name') String? gradeName,
    @FlexibleIntConverter() int? curriculum,
    @FlexibleIntConverter() int? level,
    @JsonKey(name: 'level_name') String? levelName,
    @FlexibleIntConverter() int? year,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
    @JsonKey(name: 'lecture_dates') String? lectureDates,
    List<ClassTeacher>? teachers,
  }) = _ClassModel;

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
}

@freezed
class ClassDetail with _$ClassDetail {
  const factory ClassDetail({
    @JsonKey(name: 'class_id') required int classId,
    @JsonKey(name: 'class_name') required String className,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'genre_id') required int genreId,
    @JsonKey(name: 'genre_name') String? genreName,
    @JsonKey(name: 'reg_dt') required String regDt,
    required ClassInfo info,
    required List<ClassMember> teachers,
    required List<ClassMember> students,
  }) = _ClassDetail;

  factory ClassDetail.fromJson(Map<String, dynamic> json) =>
      _$ClassDetailFromJson(json);
}

@freezed
class ClassInfo with _$ClassInfo {
  const factory ClassInfo({
    @JsonKey(name: 'class_id') required int classId,
    required int grade,
    required int curriculum,
    required int level,
    required int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_date1') String? lectureDate1,
    @JsonKey(name: 'lecture_date2') String? lectureDate2,
    @JsonKey(name: 'lecture_date3') String? lectureDate3,
    @JsonKey(name: 'lecture_date4') String? lectureDate4,
    @JsonKey(name: 'lecture_date5') String? lectureDate5,
    @JsonKey(name: 'monthly_fee') @FlexibleIntConverter() int? monthlyFee,
  }) = _ClassInfo;

  factory ClassInfo.fromJson(Map<String, dynamic> json) =>
      _$ClassInfoFromJson(json);
}

@freezed
class ClassMember with _$ClassMember {
  const factory ClassMember({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'class_id') required int classId,
    required int kind, // 2=학생, 3=선생님
    @JsonKey(name: 'active_flag') required int activeFlag,
    @JsonKey(name: 'user_name') String? userName,
    String? phone,
  }) = _ClassMember;

  factory ClassMember.fromJson(Map<String, dynamic> json) =>
      _$ClassMemberFromJson(json);
}

@freezed
class ClassTeacher with _$ClassTeacher {
  const factory ClassTeacher({
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    String? phone,
  }) = _ClassTeacher;

  factory ClassTeacher.fromJson(Map<String, dynamic> json) =>
      _$ClassTeacherFromJson(json);
}

@freezed
class LectureDate with _$LectureDate {
  const factory LectureDate({
    required String day,
    @JsonKey(name: 'start_time') required int startTime,
    @JsonKey(name: 'end_time') int? endTime,
  }) = _LectureDate;

  factory LectureDate.fromJson(Map<String, dynamic> json) =>
      _$LectureDateFromJson(json);
}

@freezed
class ClassCreate with _$ClassCreate {
  const factory ClassCreate({
    @JsonKey(name: 'genre_id') required int genreId,
    required int grade,
    required int curriculum,
    required int level,
    required int year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') required List<LectureDate> lectureDates,
    @JsonKey(name: 'teacher_ids') required List<int> teacherIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'class_name') String? className,
  }) = _ClassCreate;

  factory ClassCreate.fromJson(Map<String, dynamic> json) =>
      _$ClassCreateFromJson(json);
}

@freezed
class ClassUpdate with _$ClassUpdate {
  const factory ClassUpdate({
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? curriculum,
    int? level,
    int? year,
    @JsonKey(name: 'term_start') String? termStart,
    @JsonKey(name: 'term_end') String? termEnd,
    @JsonKey(name: 'lecture_dates') List<LectureDate>? lectureDates,
    @JsonKey(name: 'teacher_ids') List<int>? teacherIds,
    @JsonKey(name: 'student_ids') List<int>? studentIds,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    @JsonKey(name: 'is_active') int? isActive,
    @JsonKey(name: 'class_name') String? className,
  }) = _ClassUpdate;

  factory ClassUpdate.fromJson(Map<String, dynamic> json) =>
      _$ClassUpdateFromJson(json);
}

@freezed
class ClassListParams with _$ClassListParams {
  const factory ClassListParams({
    @Default(1) int page,
    @Default(1000) int perPage,
    @Default('class_name') String? sort,
    @Default('asc') String? order,
    String? search,
    @JsonKey(name: 'genre_id') int? genreId,
    int? grade,
    int? level,
    int? year,
    @JsonKey(name: 'is_active') int? isActive,
  }) = _ClassListParams;

  factory ClassListParams.fromJson(Map<String, dynamic> json) =>
      _$ClassListParamsFromJson(json);
}

@freezed
class UserSearchResult with _$UserSearchResult {
  const factory UserSearchResult({
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    String? phone,
    required int kind,
  }) = _UserSearchResult;

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);
}
