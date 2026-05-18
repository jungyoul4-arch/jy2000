// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassModelImpl _$$ClassModelImplFromJson(Map<String, dynamic> json) =>
    _$ClassModelImpl(
      classId: (json['class_id'] as num).toInt(),
      className: json['class_name'] as String,
      isActive: (json['is_active'] as num).toInt(),
      genreId: (json['genre_id'] as num).toInt(),
      genreName: json['genre_name'] as String?,
      regDt: json['reg_dt'] as String,
      grade: const FlexibleIntConverter().fromJson(json['grade']),
      gradeName: json['grade_name'] as String?,
      curriculum: const FlexibleIntConverter().fromJson(json['curriculum']),
      level: const FlexibleIntConverter().fromJson(json['level']),
      levelName: json['level_name'] as String?,
      year: const FlexibleIntConverter().fromJson(json['year']),
      monthlyFee: const FlexibleIntConverter().fromJson(json['monthly_fee']),
      lectureDates: json['lecture_dates'] as String?,
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => ClassTeacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClassModelImplToJson(_$ClassModelImpl instance) =>
    <String, dynamic>{
      'class_id': instance.classId,
      'class_name': instance.className,
      'is_active': instance.isActive,
      'genre_id': instance.genreId,
      'genre_name': instance.genreName,
      'reg_dt': instance.regDt,
      'grade': const FlexibleIntConverter().toJson(instance.grade),
      'grade_name': instance.gradeName,
      'curriculum': const FlexibleIntConverter().toJson(instance.curriculum),
      'level': const FlexibleIntConverter().toJson(instance.level),
      'level_name': instance.levelName,
      'year': const FlexibleIntConverter().toJson(instance.year),
      'monthly_fee': const FlexibleIntConverter().toJson(instance.monthlyFee),
      'lecture_dates': instance.lectureDates,
      'teachers': instance.teachers,
    };

_$ClassDetailImpl _$$ClassDetailImplFromJson(Map<String, dynamic> json) =>
    _$ClassDetailImpl(
      classId: (json['class_id'] as num).toInt(),
      className: json['class_name'] as String,
      isActive: (json['is_active'] as num).toInt(),
      genreId: (json['genre_id'] as num).toInt(),
      genreName: json['genre_name'] as String?,
      regDt: json['reg_dt'] as String,
      info: ClassInfo.fromJson(json['info'] as Map<String, dynamic>),
      teachers: (json['teachers'] as List<dynamic>)
          .map((e) => ClassMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      students: (json['students'] as List<dynamic>)
          .map((e) => ClassMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClassDetailImplToJson(_$ClassDetailImpl instance) =>
    <String, dynamic>{
      'class_id': instance.classId,
      'class_name': instance.className,
      'is_active': instance.isActive,
      'genre_id': instance.genreId,
      'genre_name': instance.genreName,
      'reg_dt': instance.regDt,
      'info': instance.info,
      'teachers': instance.teachers,
      'students': instance.students,
    };

_$ClassInfoImpl _$$ClassInfoImplFromJson(Map<String, dynamic> json) =>
    _$ClassInfoImpl(
      classId: (json['class_id'] as num).toInt(),
      grade: (json['grade'] as num).toInt(),
      curriculum: (json['curriculum'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      termStart: json['term_start'] as String?,
      termEnd: json['term_end'] as String?,
      lectureDate1: json['lecture_date1'] as String?,
      lectureDate2: json['lecture_date2'] as String?,
      lectureDate3: json['lecture_date3'] as String?,
      lectureDate4: json['lecture_date4'] as String?,
      lectureDate5: json['lecture_date5'] as String?,
      monthlyFee: const FlexibleIntConverter().fromJson(json['monthly_fee']),
    );

Map<String, dynamic> _$$ClassInfoImplToJson(_$ClassInfoImpl instance) =>
    <String, dynamic>{
      'class_id': instance.classId,
      'grade': instance.grade,
      'curriculum': instance.curriculum,
      'level': instance.level,
      'year': instance.year,
      'term_start': instance.termStart,
      'term_end': instance.termEnd,
      'lecture_date1': instance.lectureDate1,
      'lecture_date2': instance.lectureDate2,
      'lecture_date3': instance.lectureDate3,
      'lecture_date4': instance.lectureDate4,
      'lecture_date5': instance.lectureDate5,
      'monthly_fee': const FlexibleIntConverter().toJson(instance.monthlyFee),
    };

_$ClassMemberImpl _$$ClassMemberImplFromJson(Map<String, dynamic> json) =>
    _$ClassMemberImpl(
      userId: (json['user_id'] as num).toInt(),
      classId: (json['class_id'] as num).toInt(),
      kind: (json['kind'] as num).toInt(),
      activeFlag: (json['active_flag'] as num).toInt(),
      userName: json['user_name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$ClassMemberImplToJson(_$ClassMemberImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'class_id': instance.classId,
      'kind': instance.kind,
      'active_flag': instance.activeFlag,
      'user_name': instance.userName,
      'phone': instance.phone,
    };

_$ClassTeacherImpl _$$ClassTeacherImplFromJson(Map<String, dynamic> json) =>
    _$ClassTeacherImpl(
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$ClassTeacherImplToJson(_$ClassTeacherImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'phone': instance.phone,
    };

_$LectureDateImpl _$$LectureDateImplFromJson(Map<String, dynamic> json) =>
    _$LectureDateImpl(
      day: json['day'] as String,
      startTime: (json['start_time'] as num).toInt(),
      endTime: (json['end_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LectureDateImplToJson(_$LectureDateImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

_$ClassCreateImpl _$$ClassCreateImplFromJson(Map<String, dynamic> json) =>
    _$ClassCreateImpl(
      genreId: (json['genre_id'] as num).toInt(),
      grade: (json['grade'] as num).toInt(),
      curriculum: (json['curriculum'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      termStart: json['term_start'] as String?,
      termEnd: json['term_end'] as String?,
      lectureDates: (json['lecture_dates'] as List<dynamic>)
          .map((e) => LectureDate.fromJson(e as Map<String, dynamic>))
          .toList(),
      teacherIds: (json['teacher_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      monthlyFee: (json['monthly_fee'] as num?)?.toInt(),
      className: json['class_name'] as String?,
    );

Map<String, dynamic> _$$ClassCreateImplToJson(_$ClassCreateImpl instance) =>
    <String, dynamic>{
      'genre_id': instance.genreId,
      'grade': instance.grade,
      'curriculum': instance.curriculum,
      'level': instance.level,
      'year': instance.year,
      'term_start': instance.termStart,
      'term_end': instance.termEnd,
      'lecture_dates': instance.lectureDates,
      'teacher_ids': instance.teacherIds,
      'monthly_fee': instance.monthlyFee,
      'class_name': instance.className,
    };

_$ClassUpdateImpl _$$ClassUpdateImplFromJson(Map<String, dynamic> json) =>
    _$ClassUpdateImpl(
      genreId: (json['genre_id'] as num?)?.toInt(),
      grade: (json['grade'] as num?)?.toInt(),
      curriculum: (json['curriculum'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      termStart: json['term_start'] as String?,
      termEnd: json['term_end'] as String?,
      lectureDates: (json['lecture_dates'] as List<dynamic>?)
          ?.map((e) => LectureDate.fromJson(e as Map<String, dynamic>))
          .toList(),
      teacherIds: (json['teacher_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      studentIds: (json['student_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      monthlyFee: (json['monthly_fee'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      className: json['class_name'] as String?,
    );

Map<String, dynamic> _$$ClassUpdateImplToJson(_$ClassUpdateImpl instance) =>
    <String, dynamic>{
      'genre_id': instance.genreId,
      'grade': instance.grade,
      'curriculum': instance.curriculum,
      'level': instance.level,
      'year': instance.year,
      'term_start': instance.termStart,
      'term_end': instance.termEnd,
      'lecture_dates': instance.lectureDates,
      'teacher_ids': instance.teacherIds,
      'student_ids': instance.studentIds,
      'monthly_fee': instance.monthlyFee,
      'is_active': instance.isActive,
      'class_name': instance.className,
    };

_$ClassListParamsImpl _$$ClassListParamsImplFromJson(
  Map<String, dynamic> json,
) => _$ClassListParamsImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['perPage'] as num?)?.toInt() ?? 1000,
  sort: json['sort'] as String? ?? 'class_name',
  order: json['order'] as String? ?? 'asc',
  search: json['search'] as String?,
  genreId: (json['genre_id'] as num?)?.toInt(),
  grade: (json['grade'] as num?)?.toInt(),
  level: (json['level'] as num?)?.toInt(),
  year: (json['year'] as num?)?.toInt(),
  isActive: (json['is_active'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ClassListParamsImplToJson(
  _$ClassListParamsImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'sort': instance.sort,
  'order': instance.order,
  'search': instance.search,
  'genre_id': instance.genreId,
  'grade': instance.grade,
  'level': instance.level,
  'year': instance.year,
  'is_active': instance.isActive,
};

_$UserSearchResultImpl _$$UserSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$UserSearchResultImpl(
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String?,
  kind: (json['kind'] as num).toInt(),
);

Map<String, dynamic> _$$UserSearchResultImplToJson(
  _$UserSearchResultImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'name': instance.name,
  'phone': instance.phone,
  'kind': instance.kind,
};
