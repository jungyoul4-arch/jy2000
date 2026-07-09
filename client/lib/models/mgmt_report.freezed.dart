// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mgmt_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MgmtReport _$MgmtReportFromJson(Map<String, dynamic> json) {
  return _MgmtReport.fromJson(json);
}

/// @nodoc
mixin _$MgmtReport {
  MgmtReportSummary get summary => throw _privateConstructorUsedError;
  List<MonthlyTrend> get monthlyTrend => throw _privateConstructorUsedError;
  List<SubjectStat> get bySubject => throw _privateConstructorUsedError;
  List<GradeStat> get byGrade => throw _privateConstructorUsedError;
  List<TeacherStat> get byTeacher => throw _privateConstructorUsedError;
  List<SchoolStat> get bySchool => throw _privateConstructorUsedError;
  List<ClassTypeStat> get byClassType => throw _privateConstructorUsedError;

  /// Serializes this MgmtReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MgmtReportCopyWith<MgmtReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MgmtReportCopyWith<$Res> {
  factory $MgmtReportCopyWith(
    MgmtReport value,
    $Res Function(MgmtReport) then,
  ) = _$MgmtReportCopyWithImpl<$Res, MgmtReport>;
  @useResult
  $Res call({
    MgmtReportSummary summary,
    List<MonthlyTrend> monthlyTrend,
    List<SubjectStat> bySubject,
    List<GradeStat> byGrade,
    List<TeacherStat> byTeacher,
    List<SchoolStat> bySchool,
    List<ClassTypeStat> byClassType,
  });

  $MgmtReportSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$MgmtReportCopyWithImpl<$Res, $Val extends MgmtReport>
    implements $MgmtReportCopyWith<$Res> {
  _$MgmtReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? monthlyTrend = null,
    Object? bySubject = null,
    Object? byGrade = null,
    Object? byTeacher = null,
    Object? bySchool = null,
    Object? byClassType = null,
  }) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as MgmtReportSummary,
            monthlyTrend: null == monthlyTrend
                ? _value.monthlyTrend
                : monthlyTrend // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyTrend>,
            bySubject: null == bySubject
                ? _value.bySubject
                : bySubject // ignore: cast_nullable_to_non_nullable
                      as List<SubjectStat>,
            byGrade: null == byGrade
                ? _value.byGrade
                : byGrade // ignore: cast_nullable_to_non_nullable
                      as List<GradeStat>,
            byTeacher: null == byTeacher
                ? _value.byTeacher
                : byTeacher // ignore: cast_nullable_to_non_nullable
                      as List<TeacherStat>,
            bySchool: null == bySchool
                ? _value.bySchool
                : bySchool // ignore: cast_nullable_to_non_nullable
                      as List<SchoolStat>,
            byClassType: null == byClassType
                ? _value.byClassType
                : byClassType // ignore: cast_nullable_to_non_nullable
                      as List<ClassTypeStat>,
          )
          as $Val,
    );
  }

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MgmtReportSummaryCopyWith<$Res> get summary {
    return $MgmtReportSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MgmtReportImplCopyWith<$Res>
    implements $MgmtReportCopyWith<$Res> {
  factory _$$MgmtReportImplCopyWith(
    _$MgmtReportImpl value,
    $Res Function(_$MgmtReportImpl) then,
  ) = __$$MgmtReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MgmtReportSummary summary,
    List<MonthlyTrend> monthlyTrend,
    List<SubjectStat> bySubject,
    List<GradeStat> byGrade,
    List<TeacherStat> byTeacher,
    List<SchoolStat> bySchool,
    List<ClassTypeStat> byClassType,
  });

  @override
  $MgmtReportSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$MgmtReportImplCopyWithImpl<$Res>
    extends _$MgmtReportCopyWithImpl<$Res, _$MgmtReportImpl>
    implements _$$MgmtReportImplCopyWith<$Res> {
  __$$MgmtReportImplCopyWithImpl(
    _$MgmtReportImpl _value,
    $Res Function(_$MgmtReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? monthlyTrend = null,
    Object? bySubject = null,
    Object? byGrade = null,
    Object? byTeacher = null,
    Object? bySchool = null,
    Object? byClassType = null,
  }) {
    return _then(
      _$MgmtReportImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as MgmtReportSummary,
        monthlyTrend: null == monthlyTrend
            ? _value._monthlyTrend
            : monthlyTrend // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyTrend>,
        bySubject: null == bySubject
            ? _value._bySubject
            : bySubject // ignore: cast_nullable_to_non_nullable
                  as List<SubjectStat>,
        byGrade: null == byGrade
            ? _value._byGrade
            : byGrade // ignore: cast_nullable_to_non_nullable
                  as List<GradeStat>,
        byTeacher: null == byTeacher
            ? _value._byTeacher
            : byTeacher // ignore: cast_nullable_to_non_nullable
                  as List<TeacherStat>,
        bySchool: null == bySchool
            ? _value._bySchool
            : bySchool // ignore: cast_nullable_to_non_nullable
                  as List<SchoolStat>,
        byClassType: null == byClassType
            ? _value._byClassType
            : byClassType // ignore: cast_nullable_to_non_nullable
                  as List<ClassTypeStat>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MgmtReportImpl implements _MgmtReport {
  const _$MgmtReportImpl({
    required this.summary,
    required final List<MonthlyTrend> monthlyTrend,
    required final List<SubjectStat> bySubject,
    required final List<GradeStat> byGrade,
    required final List<TeacherStat> byTeacher,
    required final List<SchoolStat> bySchool,
    required final List<ClassTypeStat> byClassType,
  }) : _monthlyTrend = monthlyTrend,
       _bySubject = bySubject,
       _byGrade = byGrade,
       _byTeacher = byTeacher,
       _bySchool = bySchool,
       _byClassType = byClassType;

  factory _$MgmtReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$MgmtReportImplFromJson(json);

  @override
  final MgmtReportSummary summary;
  final List<MonthlyTrend> _monthlyTrend;
  @override
  List<MonthlyTrend> get monthlyTrend {
    if (_monthlyTrend is EqualUnmodifiableListView) return _monthlyTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyTrend);
  }

  final List<SubjectStat> _bySubject;
  @override
  List<SubjectStat> get bySubject {
    if (_bySubject is EqualUnmodifiableListView) return _bySubject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bySubject);
  }

  final List<GradeStat> _byGrade;
  @override
  List<GradeStat> get byGrade {
    if (_byGrade is EqualUnmodifiableListView) return _byGrade;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byGrade);
  }

  final List<TeacherStat> _byTeacher;
  @override
  List<TeacherStat> get byTeacher {
    if (_byTeacher is EqualUnmodifiableListView) return _byTeacher;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byTeacher);
  }

  final List<SchoolStat> _bySchool;
  @override
  List<SchoolStat> get bySchool {
    if (_bySchool is EqualUnmodifiableListView) return _bySchool;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bySchool);
  }

  final List<ClassTypeStat> _byClassType;
  @override
  List<ClassTypeStat> get byClassType {
    if (_byClassType is EqualUnmodifiableListView) return _byClassType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byClassType);
  }

  @override
  String toString() {
    return 'MgmtReport(summary: $summary, monthlyTrend: $monthlyTrend, bySubject: $bySubject, byGrade: $byGrade, byTeacher: $byTeacher, bySchool: $bySchool, byClassType: $byClassType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MgmtReportImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._monthlyTrend,
              _monthlyTrend,
            ) &&
            const DeepCollectionEquality().equals(
              other._bySubject,
              _bySubject,
            ) &&
            const DeepCollectionEquality().equals(other._byGrade, _byGrade) &&
            const DeepCollectionEquality().equals(
              other._byTeacher,
              _byTeacher,
            ) &&
            const DeepCollectionEquality().equals(other._bySchool, _bySchool) &&
            const DeepCollectionEquality().equals(
              other._byClassType,
              _byClassType,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_monthlyTrend),
    const DeepCollectionEquality().hash(_bySubject),
    const DeepCollectionEquality().hash(_byGrade),
    const DeepCollectionEquality().hash(_byTeacher),
    const DeepCollectionEquality().hash(_bySchool),
    const DeepCollectionEquality().hash(_byClassType),
  );

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MgmtReportImplCopyWith<_$MgmtReportImpl> get copyWith =>
      __$$MgmtReportImplCopyWithImpl<_$MgmtReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MgmtReportImplToJson(this);
  }
}

abstract class _MgmtReport implements MgmtReport {
  const factory _MgmtReport({
    required final MgmtReportSummary summary,
    required final List<MonthlyTrend> monthlyTrend,
    required final List<SubjectStat> bySubject,
    required final List<GradeStat> byGrade,
    required final List<TeacherStat> byTeacher,
    required final List<SchoolStat> bySchool,
    required final List<ClassTypeStat> byClassType,
  }) = _$MgmtReportImpl;

  factory _MgmtReport.fromJson(Map<String, dynamic> json) =
      _$MgmtReportImpl.fromJson;

  @override
  MgmtReportSummary get summary;
  @override
  List<MonthlyTrend> get monthlyTrend;
  @override
  List<SubjectStat> get bySubject;
  @override
  List<GradeStat> get byGrade;
  @override
  List<TeacherStat> get byTeacher;
  @override
  List<SchoolStat> get bySchool;
  @override
  List<ClassTypeStat> get byClassType;

  /// Create a copy of MgmtReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MgmtReportImplCopyWith<_$MgmtReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MgmtReportSummary _$MgmtReportSummaryFromJson(Map<String, dynamic> json) {
  return _MgmtReportSummary.fromJson(json);
}

/// @nodoc
mixin _$MgmtReportSummary {
  @FlexibleIntConverter()
  int get totalRevenue => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get totalEnrollments => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get avgUnitPrice => throw _privateConstructorUsedError;

  /// Serializes this MgmtReportSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MgmtReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MgmtReportSummaryCopyWith<MgmtReportSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MgmtReportSummaryCopyWith<$Res> {
  factory $MgmtReportSummaryCopyWith(
    MgmtReportSummary value,
    $Res Function(MgmtReportSummary) then,
  ) = _$MgmtReportSummaryCopyWithImpl<$Res, MgmtReportSummary>;
  @useResult
  $Res call({
    @FlexibleIntConverter() int totalRevenue,
    @FlexibleDoubleConverter() double totalEnrollments,
    @FlexibleIntConverter() int studentCount,
    @FlexibleIntConverter() int avgUnitPrice,
  });
}

/// @nodoc
class _$MgmtReportSummaryCopyWithImpl<$Res, $Val extends MgmtReportSummary>
    implements $MgmtReportSummaryCopyWith<$Res> {
  _$MgmtReportSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MgmtReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalEnrollments = null,
    Object? studentCount = null,
    Object? avgUnitPrice = null,
  }) {
    return _then(
      _value.copyWith(
            totalRevenue: null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEnrollments: null == totalEnrollments
                ? _value.totalEnrollments
                : totalEnrollments // ignore: cast_nullable_to_non_nullable
                      as double,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            avgUnitPrice: null == avgUnitPrice
                ? _value.avgUnitPrice
                : avgUnitPrice // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MgmtReportSummaryImplCopyWith<$Res>
    implements $MgmtReportSummaryCopyWith<$Res> {
  factory _$$MgmtReportSummaryImplCopyWith(
    _$MgmtReportSummaryImpl value,
    $Res Function(_$MgmtReportSummaryImpl) then,
  ) = __$$MgmtReportSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @FlexibleIntConverter() int totalRevenue,
    @FlexibleDoubleConverter() double totalEnrollments,
    @FlexibleIntConverter() int studentCount,
    @FlexibleIntConverter() int avgUnitPrice,
  });
}

/// @nodoc
class __$$MgmtReportSummaryImplCopyWithImpl<$Res>
    extends _$MgmtReportSummaryCopyWithImpl<$Res, _$MgmtReportSummaryImpl>
    implements _$$MgmtReportSummaryImplCopyWith<$Res> {
  __$$MgmtReportSummaryImplCopyWithImpl(
    _$MgmtReportSummaryImpl _value,
    $Res Function(_$MgmtReportSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MgmtReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalEnrollments = null,
    Object? studentCount = null,
    Object? avgUnitPrice = null,
  }) {
    return _then(
      _$MgmtReportSummaryImpl(
        totalRevenue: null == totalRevenue
            ? _value.totalRevenue
            : totalRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEnrollments: null == totalEnrollments
            ? _value.totalEnrollments
            : totalEnrollments // ignore: cast_nullable_to_non_nullable
                  as double,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        avgUnitPrice: null == avgUnitPrice
            ? _value.avgUnitPrice
            : avgUnitPrice // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MgmtReportSummaryImpl implements _MgmtReportSummary {
  const _$MgmtReportSummaryImpl({
    @FlexibleIntConverter() this.totalRevenue = 0,
    @FlexibleDoubleConverter() this.totalEnrollments = 0,
    @FlexibleIntConverter() this.studentCount = 0,
    @FlexibleIntConverter() this.avgUnitPrice = 0,
  });

  factory _$MgmtReportSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MgmtReportSummaryImplFromJson(json);

  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int totalRevenue;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double totalEnrollments;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int avgUnitPrice;

  @override
  String toString() {
    return 'MgmtReportSummary(totalRevenue: $totalRevenue, totalEnrollments: $totalEnrollments, studentCount: $studentCount, avgUnitPrice: $avgUnitPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MgmtReportSummaryImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalEnrollments, totalEnrollments) ||
                other.totalEnrollments == totalEnrollments) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount) &&
            (identical(other.avgUnitPrice, avgUnitPrice) ||
                other.avgUnitPrice == avgUnitPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalRevenue,
    totalEnrollments,
    studentCount,
    avgUnitPrice,
  );

  /// Create a copy of MgmtReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MgmtReportSummaryImplCopyWith<_$MgmtReportSummaryImpl> get copyWith =>
      __$$MgmtReportSummaryImplCopyWithImpl<_$MgmtReportSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MgmtReportSummaryImplToJson(this);
  }
}

abstract class _MgmtReportSummary implements MgmtReportSummary {
  const factory _MgmtReportSummary({
    @FlexibleIntConverter() final int totalRevenue,
    @FlexibleDoubleConverter() final double totalEnrollments,
    @FlexibleIntConverter() final int studentCount,
    @FlexibleIntConverter() final int avgUnitPrice,
  }) = _$MgmtReportSummaryImpl;

  factory _MgmtReportSummary.fromJson(Map<String, dynamic> json) =
      _$MgmtReportSummaryImpl.fromJson;

  @override
  @FlexibleIntConverter()
  int get totalRevenue;
  @override
  @FlexibleDoubleConverter()
  double get totalEnrollments;
  @override
  @FlexibleIntConverter()
  int get studentCount;
  @override
  @FlexibleIntConverter()
  int get avgUnitPrice;

  /// Create a copy of MgmtReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MgmtReportSummaryImplCopyWith<_$MgmtReportSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyTrend _$MonthlyTrendFromJson(Map<String, dynamic> json) {
  return _MonthlyTrend.fromJson(json);
}

/// @nodoc
mixin _$MonthlyTrend {
  @FlexibleIntConverter()
  int get year => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get month => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get enrollments => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this MonthlyTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyTrendCopyWith<MonthlyTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyTrendCopyWith<$Res> {
  factory $MonthlyTrendCopyWith(
    MonthlyTrend value,
    $Res Function(MonthlyTrend) then,
  ) = _$MonthlyTrendCopyWithImpl<$Res, MonthlyTrend>;
  @useResult
  $Res call({
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$MonthlyTrendCopyWithImpl<$Res, $Val extends MonthlyTrend>
    implements $MonthlyTrendCopyWith<$Res> {
  _$MonthlyTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            enrollments: null == enrollments
                ? _value.enrollments
                : enrollments // ignore: cast_nullable_to_non_nullable
                      as double,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyTrendImplCopyWith<$Res>
    implements $MonthlyTrendCopyWith<$Res> {
  factory _$$MonthlyTrendImplCopyWith(
    _$MonthlyTrendImpl value,
    $Res Function(_$MonthlyTrendImpl) then,
  ) = __$$MonthlyTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$MonthlyTrendImplCopyWithImpl<$Res>
    extends _$MonthlyTrendCopyWithImpl<$Res, _$MonthlyTrendImpl>
    implements _$$MonthlyTrendImplCopyWith<$Res> {
  __$$MonthlyTrendImplCopyWithImpl(
    _$MonthlyTrendImpl _value,
    $Res Function(_$MonthlyTrendImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$MonthlyTrendImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        enrollments: null == enrollments
            ? _value.enrollments
            : enrollments // ignore: cast_nullable_to_non_nullable
                  as double,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyTrendImpl implements _MonthlyTrend {
  const _$MonthlyTrendImpl({
    @FlexibleIntConverter() required this.year,
    @FlexibleIntConverter() required this.month,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleDoubleConverter() this.enrollments = 0,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$MonthlyTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyTrendImplFromJson(json);

  @override
  @FlexibleIntConverter()
  final int year;
  @override
  @FlexibleIntConverter()
  final int month;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double enrollments;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'MonthlyTrend(year: $year, month: $month, revenue: $revenue, enrollments: $enrollments, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyTrendImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.enrollments, enrollments) ||
                other.enrollments == enrollments) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, revenue, enrollments, studentCount);

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyTrendImplCopyWith<_$MonthlyTrendImpl> get copyWith =>
      __$$MonthlyTrendImplCopyWithImpl<_$MonthlyTrendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyTrendImplToJson(this);
  }
}

abstract class _MonthlyTrend implements MonthlyTrend {
  const factory _MonthlyTrend({
    @FlexibleIntConverter() required final int year,
    @FlexibleIntConverter() required final int month,
    @FlexibleIntConverter() final int revenue,
    @FlexibleDoubleConverter() final double enrollments,
    @FlexibleIntConverter() final int studentCount,
  }) = _$MonthlyTrendImpl;

  factory _MonthlyTrend.fromJson(Map<String, dynamic> json) =
      _$MonthlyTrendImpl.fromJson;

  @override
  @FlexibleIntConverter()
  int get year;
  @override
  @FlexibleIntConverter()
  int get month;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleDoubleConverter()
  double get enrollments;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyTrendImplCopyWith<_$MonthlyTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubjectStat _$SubjectStatFromJson(Map<String, dynamic> json) {
  return _SubjectStat.fromJson(json);
}

/// @nodoc
mixin _$SubjectStat {
  String get subject => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get enrollments => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this SubjectStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubjectStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubjectStatCopyWith<SubjectStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectStatCopyWith<$Res> {
  factory $SubjectStatCopyWith(
    SubjectStat value,
    $Res Function(SubjectStat) then,
  ) = _$SubjectStatCopyWithImpl<$Res, SubjectStat>;
  @useResult
  $Res call({
    String subject,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleDoubleConverter() double percentage,
  });
}

/// @nodoc
class _$SubjectStatCopyWithImpl<$Res, $Val extends SubjectStat>
    implements $SubjectStatCopyWith<$Res> {
  _$SubjectStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubjectStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            enrollments: null == enrollments
                ? _value.enrollments
                : enrollments // ignore: cast_nullable_to_non_nullable
                      as double,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubjectStatImplCopyWith<$Res>
    implements $SubjectStatCopyWith<$Res> {
  factory _$$SubjectStatImplCopyWith(
    _$SubjectStatImpl value,
    $Res Function(_$SubjectStatImpl) then,
  ) = __$$SubjectStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subject,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleDoubleConverter() double percentage,
  });
}

/// @nodoc
class __$$SubjectStatImplCopyWithImpl<$Res>
    extends _$SubjectStatCopyWithImpl<$Res, _$SubjectStatImpl>
    implements _$$SubjectStatImplCopyWith<$Res> {
  __$$SubjectStatImplCopyWithImpl(
    _$SubjectStatImpl _value,
    $Res Function(_$SubjectStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubjectStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? percentage = null,
  }) {
    return _then(
      _$SubjectStatImpl(
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        enrollments: null == enrollments
            ? _value.enrollments
            : enrollments // ignore: cast_nullable_to_non_nullable
                  as double,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubjectStatImpl implements _SubjectStat {
  const _$SubjectStatImpl({
    required this.subject,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleDoubleConverter() this.enrollments = 0,
    @FlexibleDoubleConverter() this.percentage = 0,
  });

  factory _$SubjectStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubjectStatImplFromJson(json);

  @override
  final String subject;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double enrollments;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double percentage;

  @override
  String toString() {
    return 'SubjectStat(subject: $subject, revenue: $revenue, enrollments: $enrollments, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectStatImpl &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.enrollments, enrollments) ||
                other.enrollments == enrollments) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, subject, revenue, enrollments, percentage);

  /// Create a copy of SubjectStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectStatImplCopyWith<_$SubjectStatImpl> get copyWith =>
      __$$SubjectStatImplCopyWithImpl<_$SubjectStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubjectStatImplToJson(this);
  }
}

abstract class _SubjectStat implements SubjectStat {
  const factory _SubjectStat({
    required final String subject,
    @FlexibleIntConverter() final int revenue,
    @FlexibleDoubleConverter() final double enrollments,
    @FlexibleDoubleConverter() final double percentage,
  }) = _$SubjectStatImpl;

  factory _SubjectStat.fromJson(Map<String, dynamic> json) =
      _$SubjectStatImpl.fromJson;

  @override
  String get subject;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleDoubleConverter()
  double get enrollments;
  @override
  @FlexibleDoubleConverter()
  double get percentage;

  /// Create a copy of SubjectStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubjectStatImplCopyWith<_$SubjectStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GradeStat _$GradeStatFromJson(Map<String, dynamic> json) {
  return _GradeStat.fromJson(json);
}

/// @nodoc
mixin _$GradeStat {
  @FlexibleIntConverter()
  int get grade => throw _privateConstructorUsedError;
  String get gradeName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this GradeStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GradeStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GradeStatCopyWith<GradeStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradeStatCopyWith<$Res> {
  factory $GradeStatCopyWith(GradeStat value, $Res Function(GradeStat) then) =
      _$GradeStatCopyWithImpl<$Res, GradeStat>;
  @useResult
  $Res call({
    @FlexibleIntConverter() int grade,
    String gradeName,
    @FlexibleIntConverter() int revenue,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$GradeStatCopyWithImpl<$Res, $Val extends GradeStat>
    implements $GradeStatCopyWith<$Res> {
  _$GradeStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GradeStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grade = null,
    Object? gradeName = null,
    Object? revenue = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            gradeName: null == gradeName
                ? _value.gradeName
                : gradeName // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GradeStatImplCopyWith<$Res>
    implements $GradeStatCopyWith<$Res> {
  factory _$$GradeStatImplCopyWith(
    _$GradeStatImpl value,
    $Res Function(_$GradeStatImpl) then,
  ) = __$$GradeStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @FlexibleIntConverter() int grade,
    String gradeName,
    @FlexibleIntConverter() int revenue,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$GradeStatImplCopyWithImpl<$Res>
    extends _$GradeStatCopyWithImpl<$Res, _$GradeStatImpl>
    implements _$$GradeStatImplCopyWith<$Res> {
  __$$GradeStatImplCopyWithImpl(
    _$GradeStatImpl _value,
    $Res Function(_$GradeStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GradeStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grade = null,
    Object? gradeName = null,
    Object? revenue = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$GradeStatImpl(
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        gradeName: null == gradeName
            ? _value.gradeName
            : gradeName // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GradeStatImpl implements _GradeStat {
  const _$GradeStatImpl({
    @FlexibleIntConverter() required this.grade,
    required this.gradeName,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$GradeStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradeStatImplFromJson(json);

  @override
  @FlexibleIntConverter()
  final int grade;
  @override
  final String gradeName;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'GradeStat(grade: $grade, gradeName: $gradeName, revenue: $revenue, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeStatImpl &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.gradeName, gradeName) ||
                other.gradeName == gradeName) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, grade, gradeName, revenue, studentCount);

  /// Create a copy of GradeStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeStatImplCopyWith<_$GradeStatImpl> get copyWith =>
      __$$GradeStatImplCopyWithImpl<_$GradeStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradeStatImplToJson(this);
  }
}

abstract class _GradeStat implements GradeStat {
  const factory _GradeStat({
    @FlexibleIntConverter() required final int grade,
    required final String gradeName,
    @FlexibleIntConverter() final int revenue,
    @FlexibleIntConverter() final int studentCount,
  }) = _$GradeStatImpl;

  factory _GradeStat.fromJson(Map<String, dynamic> json) =
      _$GradeStatImpl.fromJson;

  @override
  @FlexibleIntConverter()
  int get grade;
  @override
  String get gradeName;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of GradeStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GradeStatImplCopyWith<_$GradeStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeacherStat _$TeacherStatFromJson(Map<String, dynamic> json) {
  return _TeacherStat.fromJson(json);
}

/// @nodoc
mixin _$TeacherStat {
  int? get teacherId => throw _privateConstructorUsedError;
  String get teacherName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get enrollments => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this TeacherStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeacherStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeacherStatCopyWith<TeacherStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherStatCopyWith<$Res> {
  factory $TeacherStatCopyWith(
    TeacherStat value,
    $Res Function(TeacherStat) then,
  ) = _$TeacherStatCopyWithImpl<$Res, TeacherStat>;
  @useResult
  $Res call({
    int? teacherId,
    String teacherName,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$TeacherStatCopyWithImpl<$Res, $Val extends TeacherStat>
    implements $TeacherStatCopyWith<$Res> {
  _$TeacherStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeacherStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teacherId = freezed,
    Object? teacherName = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            teacherId: freezed == teacherId
                ? _value.teacherId
                : teacherId // ignore: cast_nullable_to_non_nullable
                      as int?,
            teacherName: null == teacherName
                ? _value.teacherName
                : teacherName // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            enrollments: null == enrollments
                ? _value.enrollments
                : enrollments // ignore: cast_nullable_to_non_nullable
                      as double,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeacherStatImplCopyWith<$Res>
    implements $TeacherStatCopyWith<$Res> {
  factory _$$TeacherStatImplCopyWith(
    _$TeacherStatImpl value,
    $Res Function(_$TeacherStatImpl) then,
  ) = __$$TeacherStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? teacherId,
    String teacherName,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$TeacherStatImplCopyWithImpl<$Res>
    extends _$TeacherStatCopyWithImpl<$Res, _$TeacherStatImpl>
    implements _$$TeacherStatImplCopyWith<$Res> {
  __$$TeacherStatImplCopyWithImpl(
    _$TeacherStatImpl _value,
    $Res Function(_$TeacherStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeacherStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teacherId = freezed,
    Object? teacherName = null,
    Object? revenue = null,
    Object? enrollments = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$TeacherStatImpl(
        teacherId: freezed == teacherId
            ? _value.teacherId
            : teacherId // ignore: cast_nullable_to_non_nullable
                  as int?,
        teacherName: null == teacherName
            ? _value.teacherName
            : teacherName // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        enrollments: null == enrollments
            ? _value.enrollments
            : enrollments // ignore: cast_nullable_to_non_nullable
                  as double,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherStatImpl implements _TeacherStat {
  const _$TeacherStatImpl({
    this.teacherId,
    required this.teacherName,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleDoubleConverter() this.enrollments = 0,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$TeacherStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherStatImplFromJson(json);

  @override
  final int? teacherId;
  @override
  final String teacherName;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double enrollments;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'TeacherStat(teacherId: $teacherId, teacherName: $teacherName, revenue: $revenue, enrollments: $enrollments, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherStatImpl &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.enrollments, enrollments) ||
                other.enrollments == enrollments) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    teacherId,
    teacherName,
    revenue,
    enrollments,
    studentCount,
  );

  /// Create a copy of TeacherStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherStatImplCopyWith<_$TeacherStatImpl> get copyWith =>
      __$$TeacherStatImplCopyWithImpl<_$TeacherStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherStatImplToJson(this);
  }
}

abstract class _TeacherStat implements TeacherStat {
  const factory _TeacherStat({
    final int? teacherId,
    required final String teacherName,
    @FlexibleIntConverter() final int revenue,
    @FlexibleDoubleConverter() final double enrollments,
    @FlexibleIntConverter() final int studentCount,
  }) = _$TeacherStatImpl;

  factory _TeacherStat.fromJson(Map<String, dynamic> json) =
      _$TeacherStatImpl.fromJson;

  @override
  int? get teacherId;
  @override
  String get teacherName;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleDoubleConverter()
  double get enrollments;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of TeacherStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherStatImplCopyWith<_$TeacherStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchoolStat _$SchoolStatFromJson(Map<String, dynamic> json) {
  return _SchoolStat.fromJson(json);
}

/// @nodoc
mixin _$SchoolStat {
  int? get schoolId => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this SchoolStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SchoolStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchoolStatCopyWith<SchoolStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolStatCopyWith<$Res> {
  factory $SchoolStatCopyWith(
    SchoolStat value,
    $Res Function(SchoolStat) then,
  ) = _$SchoolStatCopyWithImpl<$Res, SchoolStat>;
  @useResult
  $Res call({
    int? schoolId,
    String schoolName,
    @FlexibleIntConverter() int revenue,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$SchoolStatCopyWithImpl<$Res, $Val extends SchoolStat>
    implements $SchoolStatCopyWith<$Res> {
  _$SchoolStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SchoolStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = freezed,
    Object? schoolName = null,
    Object? revenue = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SchoolStatImplCopyWith<$Res>
    implements $SchoolStatCopyWith<$Res> {
  factory _$$SchoolStatImplCopyWith(
    _$SchoolStatImpl value,
    $Res Function(_$SchoolStatImpl) then,
  ) = __$$SchoolStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? schoolId,
    String schoolName,
    @FlexibleIntConverter() int revenue,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$SchoolStatImplCopyWithImpl<$Res>
    extends _$SchoolStatCopyWithImpl<$Res, _$SchoolStatImpl>
    implements _$$SchoolStatImplCopyWith<$Res> {
  __$$SchoolStatImplCopyWithImpl(
    _$SchoolStatImpl _value,
    $Res Function(_$SchoolStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SchoolStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = freezed,
    Object? schoolName = null,
    Object? revenue = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$SchoolStatImpl(
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SchoolStatImpl implements _SchoolStat {
  const _$SchoolStatImpl({
    this.schoolId,
    required this.schoolName,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$SchoolStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchoolStatImplFromJson(json);

  @override
  final int? schoolId;
  @override
  final String schoolName;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'SchoolStat(schoolId: $schoolId, schoolName: $schoolName, revenue: $revenue, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchoolStatImpl &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, schoolId, schoolName, revenue, studentCount);

  /// Create a copy of SchoolStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchoolStatImplCopyWith<_$SchoolStatImpl> get copyWith =>
      __$$SchoolStatImplCopyWithImpl<_$SchoolStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchoolStatImplToJson(this);
  }
}

abstract class _SchoolStat implements SchoolStat {
  const factory _SchoolStat({
    final int? schoolId,
    required final String schoolName,
    @FlexibleIntConverter() final int revenue,
    @FlexibleIntConverter() final int studentCount,
  }) = _$SchoolStatImpl;

  factory _SchoolStat.fromJson(Map<String, dynamic> json) =
      _$SchoolStatImpl.fromJson;

  @override
  int? get schoolId;
  @override
  String get schoolName;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of SchoolStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchoolStatImplCopyWith<_$SchoolStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassTypeStat _$ClassTypeStatFromJson(Map<String, dynamic> json) {
  return _ClassTypeStat.fromJson(json);
}

/// @nodoc
mixin _$ClassTypeStat {
  int? get classTypeId => throw _privateConstructorUsedError;
  String get classTypeName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get revenue => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get enrollments => throw _privateConstructorUsedError;

  /// Serializes this ClassTypeStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassTypeStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassTypeStatCopyWith<ClassTypeStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassTypeStatCopyWith<$Res> {
  factory $ClassTypeStatCopyWith(
    ClassTypeStat value,
    $Res Function(ClassTypeStat) then,
  ) = _$ClassTypeStatCopyWithImpl<$Res, ClassTypeStat>;
  @useResult
  $Res call({
    int? classTypeId,
    String classTypeName,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
  });
}

/// @nodoc
class _$ClassTypeStatCopyWithImpl<$Res, $Val extends ClassTypeStat>
    implements $ClassTypeStatCopyWith<$Res> {
  _$ClassTypeStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassTypeStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeId = freezed,
    Object? classTypeName = null,
    Object? revenue = null,
    Object? enrollments = null,
  }) {
    return _then(
      _value.copyWith(
            classTypeId: freezed == classTypeId
                ? _value.classTypeId
                : classTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            classTypeName: null == classTypeName
                ? _value.classTypeName
                : classTypeName // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            enrollments: null == enrollments
                ? _value.enrollments
                : enrollments // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassTypeStatImplCopyWith<$Res>
    implements $ClassTypeStatCopyWith<$Res> {
  factory _$$ClassTypeStatImplCopyWith(
    _$ClassTypeStatImpl value,
    $Res Function(_$ClassTypeStatImpl) then,
  ) = __$$ClassTypeStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? classTypeId,
    String classTypeName,
    @FlexibleIntConverter() int revenue,
    @FlexibleDoubleConverter() double enrollments,
  });
}

/// @nodoc
class __$$ClassTypeStatImplCopyWithImpl<$Res>
    extends _$ClassTypeStatCopyWithImpl<$Res, _$ClassTypeStatImpl>
    implements _$$ClassTypeStatImplCopyWith<$Res> {
  __$$ClassTypeStatImplCopyWithImpl(
    _$ClassTypeStatImpl _value,
    $Res Function(_$ClassTypeStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassTypeStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classTypeId = freezed,
    Object? classTypeName = null,
    Object? revenue = null,
    Object? enrollments = null,
  }) {
    return _then(
      _$ClassTypeStatImpl(
        classTypeId: freezed == classTypeId
            ? _value.classTypeId
            : classTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        classTypeName: null == classTypeName
            ? _value.classTypeName
            : classTypeName // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        enrollments: null == enrollments
            ? _value.enrollments
            : enrollments // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassTypeStatImpl implements _ClassTypeStat {
  const _$ClassTypeStatImpl({
    this.classTypeId,
    required this.classTypeName,
    @FlexibleIntConverter() this.revenue = 0,
    @FlexibleDoubleConverter() this.enrollments = 0,
  });

  factory _$ClassTypeStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassTypeStatImplFromJson(json);

  @override
  final int? classTypeId;
  @override
  final String classTypeName;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int revenue;
  @override
  @JsonKey()
  @FlexibleDoubleConverter()
  final double enrollments;

  @override
  String toString() {
    return 'ClassTypeStat(classTypeId: $classTypeId, classTypeName: $classTypeName, revenue: $revenue, enrollments: $enrollments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassTypeStatImpl &&
            (identical(other.classTypeId, classTypeId) ||
                other.classTypeId == classTypeId) &&
            (identical(other.classTypeName, classTypeName) ||
                other.classTypeName == classTypeName) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.enrollments, enrollments) ||
                other.enrollments == enrollments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    classTypeId,
    classTypeName,
    revenue,
    enrollments,
  );

  /// Create a copy of ClassTypeStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassTypeStatImplCopyWith<_$ClassTypeStatImpl> get copyWith =>
      __$$ClassTypeStatImplCopyWithImpl<_$ClassTypeStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassTypeStatImplToJson(this);
  }
}

abstract class _ClassTypeStat implements ClassTypeStat {
  const factory _ClassTypeStat({
    final int? classTypeId,
    required final String classTypeName,
    @FlexibleIntConverter() final int revenue,
    @FlexibleDoubleConverter() final double enrollments,
  }) = _$ClassTypeStatImpl;

  factory _ClassTypeStat.fromJson(Map<String, dynamic> json) =
      _$ClassTypeStatImpl.fromJson;

  @override
  int? get classTypeId;
  @override
  String get classTypeName;
  @override
  @FlexibleIntConverter()
  int get revenue;
  @override
  @FlexibleDoubleConverter()
  double get enrollments;

  /// Create a copy of ClassTypeStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassTypeStatImplCopyWith<_$ClassTypeStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegionMonthlyStat _$RegionMonthlyStatFromJson(Map<String, dynamic> json) {
  return _RegionMonthlyStat.fromJson(json);
}

/// @nodoc
mixin _$RegionMonthlyStat {
  String get regionName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get year => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get month => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this RegionMonthlyStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegionMonthlyStatCopyWith<RegionMonthlyStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionMonthlyStatCopyWith<$Res> {
  factory $RegionMonthlyStatCopyWith(
    RegionMonthlyStat value,
    $Res Function(RegionMonthlyStat) then,
  ) = _$RegionMonthlyStatCopyWithImpl<$Res, RegionMonthlyStat>;
  @useResult
  $Res call({
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$RegionMonthlyStatCopyWithImpl<$Res, $Val extends RegionMonthlyStat>
    implements $RegionMonthlyStatCopyWith<$Res> {
  _$RegionMonthlyStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            regionName: null == regionName
                ? _value.regionName
                : regionName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegionMonthlyStatImplCopyWith<$Res>
    implements $RegionMonthlyStatCopyWith<$Res> {
  factory _$$RegionMonthlyStatImplCopyWith(
    _$RegionMonthlyStatImpl value,
    $Res Function(_$RegionMonthlyStatImpl) then,
  ) = __$$RegionMonthlyStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$RegionMonthlyStatImplCopyWithImpl<$Res>
    extends _$RegionMonthlyStatCopyWithImpl<$Res, _$RegionMonthlyStatImpl>
    implements _$$RegionMonthlyStatImplCopyWith<$Res> {
  __$$RegionMonthlyStatImplCopyWithImpl(
    _$RegionMonthlyStatImpl _value,
    $Res Function(_$RegionMonthlyStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$RegionMonthlyStatImpl(
        regionName: null == regionName
            ? _value.regionName
            : regionName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionMonthlyStatImpl implements _RegionMonthlyStat {
  const _$RegionMonthlyStatImpl({
    required this.regionName,
    @FlexibleIntConverter() required this.year,
    @FlexibleIntConverter() required this.month,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$RegionMonthlyStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionMonthlyStatImplFromJson(json);

  @override
  final String regionName;
  @override
  @FlexibleIntConverter()
  final int year;
  @override
  @FlexibleIntConverter()
  final int month;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'RegionMonthlyStat(regionName: $regionName, year: $year, month: $month, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionMonthlyStatImpl &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, regionName, year, month, studentCount);

  /// Create a copy of RegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionMonthlyStatImplCopyWith<_$RegionMonthlyStatImpl> get copyWith =>
      __$$RegionMonthlyStatImplCopyWithImpl<_$RegionMonthlyStatImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionMonthlyStatImplToJson(this);
  }
}

abstract class _RegionMonthlyStat implements RegionMonthlyStat {
  const factory _RegionMonthlyStat({
    required final String regionName,
    @FlexibleIntConverter() required final int year,
    @FlexibleIntConverter() required final int month,
    @FlexibleIntConverter() final int studentCount,
  }) = _$RegionMonthlyStatImpl;

  factory _RegionMonthlyStat.fromJson(Map<String, dynamic> json) =
      _$RegionMonthlyStatImpl.fromJson;

  @override
  String get regionName;
  @override
  @FlexibleIntConverter()
  int get year;
  @override
  @FlexibleIntConverter()
  int get month;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of RegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionMonthlyStatImplCopyWith<_$RegionMonthlyStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegionGradeMonthlyStat _$RegionGradeMonthlyStatFromJson(
  Map<String, dynamic> json,
) {
  return _RegionGradeMonthlyStat.fromJson(json);
}

/// @nodoc
mixin _$RegionGradeMonthlyStat {
  String get regionName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get year => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get month => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get grade => throw _privateConstructorUsedError;
  String get gradeName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this RegionGradeMonthlyStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegionGradeMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegionGradeMonthlyStatCopyWith<RegionGradeMonthlyStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionGradeMonthlyStatCopyWith<$Res> {
  factory $RegionGradeMonthlyStatCopyWith(
    RegionGradeMonthlyStat value,
    $Res Function(RegionGradeMonthlyStat) then,
  ) = _$RegionGradeMonthlyStatCopyWithImpl<$Res, RegionGradeMonthlyStat>;
  @useResult
  $Res call({
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int grade,
    String gradeName,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$RegionGradeMonthlyStatCopyWithImpl<
  $Res,
  $Val extends RegionGradeMonthlyStat
>
    implements $RegionGradeMonthlyStatCopyWith<$Res> {
  _$RegionGradeMonthlyStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionGradeMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? grade = null,
    Object? gradeName = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            regionName: null == regionName
                ? _value.regionName
                : regionName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            gradeName: null == gradeName
                ? _value.gradeName
                : gradeName // ignore: cast_nullable_to_non_nullable
                      as String,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegionGradeMonthlyStatImplCopyWith<$Res>
    implements $RegionGradeMonthlyStatCopyWith<$Res> {
  factory _$$RegionGradeMonthlyStatImplCopyWith(
    _$RegionGradeMonthlyStatImpl value,
    $Res Function(_$RegionGradeMonthlyStatImpl) then,
  ) = __$$RegionGradeMonthlyStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int grade,
    String gradeName,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$RegionGradeMonthlyStatImplCopyWithImpl<$Res>
    extends
        _$RegionGradeMonthlyStatCopyWithImpl<$Res, _$RegionGradeMonthlyStatImpl>
    implements _$$RegionGradeMonthlyStatImplCopyWith<$Res> {
  __$$RegionGradeMonthlyStatImplCopyWithImpl(
    _$RegionGradeMonthlyStatImpl _value,
    $Res Function(_$RegionGradeMonthlyStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegionGradeMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? grade = null,
    Object? gradeName = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$RegionGradeMonthlyStatImpl(
        regionName: null == regionName
            ? _value.regionName
            : regionName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        gradeName: null == gradeName
            ? _value.gradeName
            : gradeName // ignore: cast_nullable_to_non_nullable
                  as String,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionGradeMonthlyStatImpl implements _RegionGradeMonthlyStat {
  const _$RegionGradeMonthlyStatImpl({
    required this.regionName,
    @FlexibleIntConverter() required this.year,
    @FlexibleIntConverter() required this.month,
    @FlexibleIntConverter() this.grade = 0,
    required this.gradeName,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$RegionGradeMonthlyStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionGradeMonthlyStatImplFromJson(json);

  @override
  final String regionName;
  @override
  @FlexibleIntConverter()
  final int year;
  @override
  @FlexibleIntConverter()
  final int month;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int grade;
  @override
  final String gradeName;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'RegionGradeMonthlyStat(regionName: $regionName, year: $year, month: $month, grade: $grade, gradeName: $gradeName, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionGradeMonthlyStatImpl &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.gradeName, gradeName) ||
                other.gradeName == gradeName) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    regionName,
    year,
    month,
    grade,
    gradeName,
    studentCount,
  );

  /// Create a copy of RegionGradeMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionGradeMonthlyStatImplCopyWith<_$RegionGradeMonthlyStatImpl>
  get copyWith =>
      __$$RegionGradeMonthlyStatImplCopyWithImpl<_$RegionGradeMonthlyStatImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionGradeMonthlyStatImplToJson(this);
  }
}

abstract class _RegionGradeMonthlyStat implements RegionGradeMonthlyStat {
  const factory _RegionGradeMonthlyStat({
    required final String regionName,
    @FlexibleIntConverter() required final int year,
    @FlexibleIntConverter() required final int month,
    @FlexibleIntConverter() final int grade,
    required final String gradeName,
    @FlexibleIntConverter() final int studentCount,
  }) = _$RegionGradeMonthlyStatImpl;

  factory _RegionGradeMonthlyStat.fromJson(Map<String, dynamic> json) =
      _$RegionGradeMonthlyStatImpl.fromJson;

  @override
  String get regionName;
  @override
  @FlexibleIntConverter()
  int get year;
  @override
  @FlexibleIntConverter()
  int get month;
  @override
  @FlexibleIntConverter()
  int get grade;
  @override
  String get gradeName;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of RegionGradeMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionGradeMonthlyStatImplCopyWith<_$RegionGradeMonthlyStatImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SchoolRegionMonthlyStat _$SchoolRegionMonthlyStatFromJson(
  Map<String, dynamic> json,
) {
  return _SchoolRegionMonthlyStat.fromJson(json);
}

/// @nodoc
mixin _$SchoolRegionMonthlyStat {
  int? get schoolId => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String get regionName => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get year => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get month => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get studentCount => throw _privateConstructorUsedError;

  /// Serializes this SchoolRegionMonthlyStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SchoolRegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchoolRegionMonthlyStatCopyWith<SchoolRegionMonthlyStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolRegionMonthlyStatCopyWith<$Res> {
  factory $SchoolRegionMonthlyStatCopyWith(
    SchoolRegionMonthlyStat value,
    $Res Function(SchoolRegionMonthlyStat) then,
  ) = _$SchoolRegionMonthlyStatCopyWithImpl<$Res, SchoolRegionMonthlyStat>;
  @useResult
  $Res call({
    int? schoolId,
    String schoolName,
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class _$SchoolRegionMonthlyStatCopyWithImpl<
  $Res,
  $Val extends SchoolRegionMonthlyStat
>
    implements $SchoolRegionMonthlyStatCopyWith<$Res> {
  _$SchoolRegionMonthlyStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SchoolRegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = freezed,
    Object? schoolName = null,
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? studentCount = null,
  }) {
    return _then(
      _value.copyWith(
            schoolId: freezed == schoolId
                ? _value.schoolId
                : schoolId // ignore: cast_nullable_to_non_nullable
                      as int?,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            regionName: null == regionName
                ? _value.regionName
                : regionName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            studentCount: null == studentCount
                ? _value.studentCount
                : studentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SchoolRegionMonthlyStatImplCopyWith<$Res>
    implements $SchoolRegionMonthlyStatCopyWith<$Res> {
  factory _$$SchoolRegionMonthlyStatImplCopyWith(
    _$SchoolRegionMonthlyStatImpl value,
    $Res Function(_$SchoolRegionMonthlyStatImpl) then,
  ) = __$$SchoolRegionMonthlyStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? schoolId,
    String schoolName,
    String regionName,
    @FlexibleIntConverter() int year,
    @FlexibleIntConverter() int month,
    @FlexibleIntConverter() int studentCount,
  });
}

/// @nodoc
class __$$SchoolRegionMonthlyStatImplCopyWithImpl<$Res>
    extends
        _$SchoolRegionMonthlyStatCopyWithImpl<
          $Res,
          _$SchoolRegionMonthlyStatImpl
        >
    implements _$$SchoolRegionMonthlyStatImplCopyWith<$Res> {
  __$$SchoolRegionMonthlyStatImplCopyWithImpl(
    _$SchoolRegionMonthlyStatImpl _value,
    $Res Function(_$SchoolRegionMonthlyStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SchoolRegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schoolId = freezed,
    Object? schoolName = null,
    Object? regionName = null,
    Object? year = null,
    Object? month = null,
    Object? studentCount = null,
  }) {
    return _then(
      _$SchoolRegionMonthlyStatImpl(
        schoolId: freezed == schoolId
            ? _value.schoolId
            : schoolId // ignore: cast_nullable_to_non_nullable
                  as int?,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        regionName: null == regionName
            ? _value.regionName
            : regionName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        studentCount: null == studentCount
            ? _value.studentCount
            : studentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SchoolRegionMonthlyStatImpl implements _SchoolRegionMonthlyStat {
  const _$SchoolRegionMonthlyStatImpl({
    this.schoolId,
    required this.schoolName,
    required this.regionName,
    @FlexibleIntConverter() required this.year,
    @FlexibleIntConverter() required this.month,
    @FlexibleIntConverter() this.studentCount = 0,
  });

  factory _$SchoolRegionMonthlyStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchoolRegionMonthlyStatImplFromJson(json);

  @override
  final int? schoolId;
  @override
  final String schoolName;
  @override
  final String regionName;
  @override
  @FlexibleIntConverter()
  final int year;
  @override
  @FlexibleIntConverter()
  final int month;
  @override
  @JsonKey()
  @FlexibleIntConverter()
  final int studentCount;

  @override
  String toString() {
    return 'SchoolRegionMonthlyStat(schoolId: $schoolId, schoolName: $schoolName, regionName: $regionName, year: $year, month: $month, studentCount: $studentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchoolRegionMonthlyStatImpl &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    schoolId,
    schoolName,
    regionName,
    year,
    month,
    studentCount,
  );

  /// Create a copy of SchoolRegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchoolRegionMonthlyStatImplCopyWith<_$SchoolRegionMonthlyStatImpl>
  get copyWith =>
      __$$SchoolRegionMonthlyStatImplCopyWithImpl<
        _$SchoolRegionMonthlyStatImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchoolRegionMonthlyStatImplToJson(this);
  }
}

abstract class _SchoolRegionMonthlyStat implements SchoolRegionMonthlyStat {
  const factory _SchoolRegionMonthlyStat({
    final int? schoolId,
    required final String schoolName,
    required final String regionName,
    @FlexibleIntConverter() required final int year,
    @FlexibleIntConverter() required final int month,
    @FlexibleIntConverter() final int studentCount,
  }) = _$SchoolRegionMonthlyStatImpl;

  factory _SchoolRegionMonthlyStat.fromJson(Map<String, dynamic> json) =
      _$SchoolRegionMonthlyStatImpl.fromJson;

  @override
  int? get schoolId;
  @override
  String get schoolName;
  @override
  String get regionName;
  @override
  @FlexibleIntConverter()
  int get year;
  @override
  @FlexibleIntConverter()
  int get month;
  @override
  @FlexibleIntConverter()
  int get studentCount;

  /// Create a copy of SchoolRegionMonthlyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchoolRegionMonthlyStatImplCopyWith<_$SchoolRegionMonthlyStatImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RegionReport _$RegionReportFromJson(Map<String, dynamic> json) {
  return _RegionReport.fromJson(json);
}

/// @nodoc
mixin _$RegionReport {
  List<RegionMonthlyStat> get byRegionMonthly =>
      throw _privateConstructorUsedError;
  List<RegionGradeMonthlyStat> get byRegionGradeMonthly =>
      throw _privateConstructorUsedError;
  List<SchoolRegionMonthlyStat> get bySchoolRegionMonthly =>
      throw _privateConstructorUsedError;

  /// Serializes this RegionReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegionReportCopyWith<RegionReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionReportCopyWith<$Res> {
  factory $RegionReportCopyWith(
    RegionReport value,
    $Res Function(RegionReport) then,
  ) = _$RegionReportCopyWithImpl<$Res, RegionReport>;
  @useResult
  $Res call({
    List<RegionMonthlyStat> byRegionMonthly,
    List<RegionGradeMonthlyStat> byRegionGradeMonthly,
    List<SchoolRegionMonthlyStat> bySchoolRegionMonthly,
  });
}

/// @nodoc
class _$RegionReportCopyWithImpl<$Res, $Val extends RegionReport>
    implements $RegionReportCopyWith<$Res> {
  _$RegionReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byRegionMonthly = null,
    Object? byRegionGradeMonthly = null,
    Object? bySchoolRegionMonthly = null,
  }) {
    return _then(
      _value.copyWith(
            byRegionMonthly: null == byRegionMonthly
                ? _value.byRegionMonthly
                : byRegionMonthly // ignore: cast_nullable_to_non_nullable
                      as List<RegionMonthlyStat>,
            byRegionGradeMonthly: null == byRegionGradeMonthly
                ? _value.byRegionGradeMonthly
                : byRegionGradeMonthly // ignore: cast_nullable_to_non_nullable
                      as List<RegionGradeMonthlyStat>,
            bySchoolRegionMonthly: null == bySchoolRegionMonthly
                ? _value.bySchoolRegionMonthly
                : bySchoolRegionMonthly // ignore: cast_nullable_to_non_nullable
                      as List<SchoolRegionMonthlyStat>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegionReportImplCopyWith<$Res>
    implements $RegionReportCopyWith<$Res> {
  factory _$$RegionReportImplCopyWith(
    _$RegionReportImpl value,
    $Res Function(_$RegionReportImpl) then,
  ) = __$$RegionReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RegionMonthlyStat> byRegionMonthly,
    List<RegionGradeMonthlyStat> byRegionGradeMonthly,
    List<SchoolRegionMonthlyStat> bySchoolRegionMonthly,
  });
}

/// @nodoc
class __$$RegionReportImplCopyWithImpl<$Res>
    extends _$RegionReportCopyWithImpl<$Res, _$RegionReportImpl>
    implements _$$RegionReportImplCopyWith<$Res> {
  __$$RegionReportImplCopyWithImpl(
    _$RegionReportImpl _value,
    $Res Function(_$RegionReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byRegionMonthly = null,
    Object? byRegionGradeMonthly = null,
    Object? bySchoolRegionMonthly = null,
  }) {
    return _then(
      _$RegionReportImpl(
        byRegionMonthly: null == byRegionMonthly
            ? _value._byRegionMonthly
            : byRegionMonthly // ignore: cast_nullable_to_non_nullable
                  as List<RegionMonthlyStat>,
        byRegionGradeMonthly: null == byRegionGradeMonthly
            ? _value._byRegionGradeMonthly
            : byRegionGradeMonthly // ignore: cast_nullable_to_non_nullable
                  as List<RegionGradeMonthlyStat>,
        bySchoolRegionMonthly: null == bySchoolRegionMonthly
            ? _value._bySchoolRegionMonthly
            : bySchoolRegionMonthly // ignore: cast_nullable_to_non_nullable
                  as List<SchoolRegionMonthlyStat>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionReportImpl implements _RegionReport {
  const _$RegionReportImpl({
    required final List<RegionMonthlyStat> byRegionMonthly,
    required final List<RegionGradeMonthlyStat> byRegionGradeMonthly,
    required final List<SchoolRegionMonthlyStat> bySchoolRegionMonthly,
  }) : _byRegionMonthly = byRegionMonthly,
       _byRegionGradeMonthly = byRegionGradeMonthly,
       _bySchoolRegionMonthly = bySchoolRegionMonthly;

  factory _$RegionReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionReportImplFromJson(json);

  final List<RegionMonthlyStat> _byRegionMonthly;
  @override
  List<RegionMonthlyStat> get byRegionMonthly {
    if (_byRegionMonthly is EqualUnmodifiableListView) return _byRegionMonthly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byRegionMonthly);
  }

  final List<RegionGradeMonthlyStat> _byRegionGradeMonthly;
  @override
  List<RegionGradeMonthlyStat> get byRegionGradeMonthly {
    if (_byRegionGradeMonthly is EqualUnmodifiableListView)
      return _byRegionGradeMonthly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byRegionGradeMonthly);
  }

  final List<SchoolRegionMonthlyStat> _bySchoolRegionMonthly;
  @override
  List<SchoolRegionMonthlyStat> get bySchoolRegionMonthly {
    if (_bySchoolRegionMonthly is EqualUnmodifiableListView)
      return _bySchoolRegionMonthly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bySchoolRegionMonthly);
  }

  @override
  String toString() {
    return 'RegionReport(byRegionMonthly: $byRegionMonthly, byRegionGradeMonthly: $byRegionGradeMonthly, bySchoolRegionMonthly: $bySchoolRegionMonthly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionReportImpl &&
            const DeepCollectionEquality().equals(
              other._byRegionMonthly,
              _byRegionMonthly,
            ) &&
            const DeepCollectionEquality().equals(
              other._byRegionGradeMonthly,
              _byRegionGradeMonthly,
            ) &&
            const DeepCollectionEquality().equals(
              other._bySchoolRegionMonthly,
              _bySchoolRegionMonthly,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_byRegionMonthly),
    const DeepCollectionEquality().hash(_byRegionGradeMonthly),
    const DeepCollectionEquality().hash(_bySchoolRegionMonthly),
  );

  /// Create a copy of RegionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionReportImplCopyWith<_$RegionReportImpl> get copyWith =>
      __$$RegionReportImplCopyWithImpl<_$RegionReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionReportImplToJson(this);
  }
}

abstract class _RegionReport implements RegionReport {
  const factory _RegionReport({
    required final List<RegionMonthlyStat> byRegionMonthly,
    required final List<RegionGradeMonthlyStat> byRegionGradeMonthly,
    required final List<SchoolRegionMonthlyStat> bySchoolRegionMonthly,
  }) = _$RegionReportImpl;

  factory _RegionReport.fromJson(Map<String, dynamic> json) =
      _$RegionReportImpl.fromJson;

  @override
  List<RegionMonthlyStat> get byRegionMonthly;
  @override
  List<RegionGradeMonthlyStat> get byRegionGradeMonthly;
  @override
  List<SchoolRegionMonthlyStat> get bySchoolRegionMonthly;

  /// Create a copy of RegionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionReportImplCopyWith<_$RegionReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
