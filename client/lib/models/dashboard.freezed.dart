// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardKPI _$DashboardKPIFromJson(Map<String, dynamic> json) {
  return _DashboardKPI.fromJson(json);
}

/// @nodoc
mixin _$DashboardKPI {
  @JsonKey(name: 'total_students')
  int get totalStudents => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_students_this_month')
  int get newStudentsThisMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'consults_this_month')
  int get consultsThisMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'registers_this_month')
  int get registersThisMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'enrolled_count')
  int get enrolledCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversion_rate')
  double get conversionRate => throw _privateConstructorUsedError;

  /// Serializes this DashboardKPI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardKPI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardKPICopyWith<DashboardKPI> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardKPICopyWith<$Res> {
  factory $DashboardKPICopyWith(
    DashboardKPI value,
    $Res Function(DashboardKPI) then,
  ) = _$DashboardKPICopyWithImpl<$Res, DashboardKPI>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_students') int totalStudents,
    @JsonKey(name: 'new_students_this_month') int newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') int consultsThisMonth,
    @JsonKey(name: 'registers_this_month') int registersThisMonth,
    @JsonKey(name: 'enrolled_count') int enrolledCount,
    @JsonKey(name: 'conversion_rate') double conversionRate,
  });
}

/// @nodoc
class _$DashboardKPICopyWithImpl<$Res, $Val extends DashboardKPI>
    implements $DashboardKPICopyWith<$Res> {
  _$DashboardKPICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardKPI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? newStudentsThisMonth = null,
    Object? consultsThisMonth = null,
    Object? registersThisMonth = null,
    Object? enrolledCount = null,
    Object? conversionRate = null,
  }) {
    return _then(
      _value.copyWith(
            totalStudents: null == totalStudents
                ? _value.totalStudents
                : totalStudents // ignore: cast_nullable_to_non_nullable
                      as int,
            newStudentsThisMonth: null == newStudentsThisMonth
                ? _value.newStudentsThisMonth
                : newStudentsThisMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            consultsThisMonth: null == consultsThisMonth
                ? _value.consultsThisMonth
                : consultsThisMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            registersThisMonth: null == registersThisMonth
                ? _value.registersThisMonth
                : registersThisMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            enrolledCount: null == enrolledCount
                ? _value.enrolledCount
                : enrolledCount // ignore: cast_nullable_to_non_nullable
                      as int,
            conversionRate: null == conversionRate
                ? _value.conversionRate
                : conversionRate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardKPIImplCopyWith<$Res>
    implements $DashboardKPICopyWith<$Res> {
  factory _$$DashboardKPIImplCopyWith(
    _$DashboardKPIImpl value,
    $Res Function(_$DashboardKPIImpl) then,
  ) = __$$DashboardKPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_students') int totalStudents,
    @JsonKey(name: 'new_students_this_month') int newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') int consultsThisMonth,
    @JsonKey(name: 'registers_this_month') int registersThisMonth,
    @JsonKey(name: 'enrolled_count') int enrolledCount,
    @JsonKey(name: 'conversion_rate') double conversionRate,
  });
}

/// @nodoc
class __$$DashboardKPIImplCopyWithImpl<$Res>
    extends _$DashboardKPICopyWithImpl<$Res, _$DashboardKPIImpl>
    implements _$$DashboardKPIImplCopyWith<$Res> {
  __$$DashboardKPIImplCopyWithImpl(
    _$DashboardKPIImpl _value,
    $Res Function(_$DashboardKPIImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardKPI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? newStudentsThisMonth = null,
    Object? consultsThisMonth = null,
    Object? registersThisMonth = null,
    Object? enrolledCount = null,
    Object? conversionRate = null,
  }) {
    return _then(
      _$DashboardKPIImpl(
        totalStudents: null == totalStudents
            ? _value.totalStudents
            : totalStudents // ignore: cast_nullable_to_non_nullable
                  as int,
        newStudentsThisMonth: null == newStudentsThisMonth
            ? _value.newStudentsThisMonth
            : newStudentsThisMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        consultsThisMonth: null == consultsThisMonth
            ? _value.consultsThisMonth
            : consultsThisMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        registersThisMonth: null == registersThisMonth
            ? _value.registersThisMonth
            : registersThisMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        enrolledCount: null == enrolledCount
            ? _value.enrolledCount
            : enrolledCount // ignore: cast_nullable_to_non_nullable
                  as int,
        conversionRate: null == conversionRate
            ? _value.conversionRate
            : conversionRate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardKPIImpl implements _DashboardKPI {
  const _$DashboardKPIImpl({
    @JsonKey(name: 'total_students') required this.totalStudents,
    @JsonKey(name: 'new_students_this_month')
    required this.newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') required this.consultsThisMonth,
    @JsonKey(name: 'registers_this_month') required this.registersThisMonth,
    @JsonKey(name: 'enrolled_count') required this.enrolledCount,
    @JsonKey(name: 'conversion_rate') required this.conversionRate,
  });

  factory _$DashboardKPIImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardKPIImplFromJson(json);

  @override
  @JsonKey(name: 'total_students')
  final int totalStudents;
  @override
  @JsonKey(name: 'new_students_this_month')
  final int newStudentsThisMonth;
  @override
  @JsonKey(name: 'consults_this_month')
  final int consultsThisMonth;
  @override
  @JsonKey(name: 'registers_this_month')
  final int registersThisMonth;
  @override
  @JsonKey(name: 'enrolled_count')
  final int enrolledCount;
  @override
  @JsonKey(name: 'conversion_rate')
  final double conversionRate;

  @override
  String toString() {
    return 'DashboardKPI(totalStudents: $totalStudents, newStudentsThisMonth: $newStudentsThisMonth, consultsThisMonth: $consultsThisMonth, registersThisMonth: $registersThisMonth, enrolledCount: $enrolledCount, conversionRate: $conversionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardKPIImpl &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.newStudentsThisMonth, newStudentsThisMonth) ||
                other.newStudentsThisMonth == newStudentsThisMonth) &&
            (identical(other.consultsThisMonth, consultsThisMonth) ||
                other.consultsThisMonth == consultsThisMonth) &&
            (identical(other.registersThisMonth, registersThisMonth) ||
                other.registersThisMonth == registersThisMonth) &&
            (identical(other.enrolledCount, enrolledCount) ||
                other.enrolledCount == enrolledCount) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalStudents,
    newStudentsThisMonth,
    consultsThisMonth,
    registersThisMonth,
    enrolledCount,
    conversionRate,
  );

  /// Create a copy of DashboardKPI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardKPIImplCopyWith<_$DashboardKPIImpl> get copyWith =>
      __$$DashboardKPIImplCopyWithImpl<_$DashboardKPIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardKPIImplToJson(this);
  }
}

abstract class _DashboardKPI implements DashboardKPI {
  const factory _DashboardKPI({
    @JsonKey(name: 'total_students') required final int totalStudents,
    @JsonKey(name: 'new_students_this_month')
    required final int newStudentsThisMonth,
    @JsonKey(name: 'consults_this_month') required final int consultsThisMonth,
    @JsonKey(name: 'registers_this_month')
    required final int registersThisMonth,
    @JsonKey(name: 'enrolled_count') required final int enrolledCount,
    @JsonKey(name: 'conversion_rate') required final double conversionRate,
  }) = _$DashboardKPIImpl;

  factory _DashboardKPI.fromJson(Map<String, dynamic> json) =
      _$DashboardKPIImpl.fromJson;

  @override
  @JsonKey(name: 'total_students')
  int get totalStudents;
  @override
  @JsonKey(name: 'new_students_this_month')
  int get newStudentsThisMonth;
  @override
  @JsonKey(name: 'consults_this_month')
  int get consultsThisMonth;
  @override
  @JsonKey(name: 'registers_this_month')
  int get registersThisMonth;
  @override
  @JsonKey(name: 'enrolled_count')
  int get enrolledCount;
  @override
  @JsonKey(name: 'conversion_rate')
  double get conversionRate;

  /// Create a copy of DashboardKPI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardKPIImplCopyWith<_$DashboardKPIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FunnelData _$FunnelDataFromJson(Map<String, dynamic> json) {
  return _FunnelData.fromJson(json);
}

/// @nodoc
mixin _$FunnelData {
  @JsonKey(name: 'status_code')
  String get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String get statusName => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this FunnelData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FunnelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FunnelDataCopyWith<FunnelData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunnelDataCopyWith<$Res> {
  factory $FunnelDataCopyWith(
    FunnelData value,
    $Res Function(FunnelData) then,
  ) = _$FunnelDataCopyWithImpl<$Res, FunnelData>;
  @useResult
  $Res call({
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String statusName,
    int count,
    double percentage,
  });
}

/// @nodoc
class _$FunnelDataCopyWithImpl<$Res, $Val extends FunnelData>
    implements $FunnelDataCopyWith<$Res> {
  _$FunnelDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FunnelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? statusName = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            statusCode: null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as String,
            statusName: null == statusName
                ? _value.statusName
                : statusName // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$FunnelDataImplCopyWith<$Res>
    implements $FunnelDataCopyWith<$Res> {
  factory _$$FunnelDataImplCopyWith(
    _$FunnelDataImpl value,
    $Res Function(_$FunnelDataImpl) then,
  ) = __$$FunnelDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status_code') String statusCode,
    @JsonKey(name: 'status_name') String statusName,
    int count,
    double percentage,
  });
}

/// @nodoc
class __$$FunnelDataImplCopyWithImpl<$Res>
    extends _$FunnelDataCopyWithImpl<$Res, _$FunnelDataImpl>
    implements _$$FunnelDataImplCopyWith<$Res> {
  __$$FunnelDataImplCopyWithImpl(
    _$FunnelDataImpl _value,
    $Res Function(_$FunnelDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FunnelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? statusName = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _$FunnelDataImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as String,
        statusName: null == statusName
            ? _value.statusName
            : statusName // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$FunnelDataImpl implements _FunnelData {
  const _$FunnelDataImpl({
    @JsonKey(name: 'status_code') required this.statusCode,
    @JsonKey(name: 'status_name') required this.statusName,
    required this.count,
    required this.percentage,
  });

  factory _$FunnelDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FunnelDataImplFromJson(json);

  @override
  @JsonKey(name: 'status_code')
  final String statusCode;
  @override
  @JsonKey(name: 'status_name')
  final String statusName;
  @override
  final int count;
  @override
  final double percentage;

  @override
  String toString() {
    return 'FunnelData(statusCode: $statusCode, statusName: $statusName, count: $count, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FunnelDataImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, statusCode, statusName, count, percentage);

  /// Create a copy of FunnelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FunnelDataImplCopyWith<_$FunnelDataImpl> get copyWith =>
      __$$FunnelDataImplCopyWithImpl<_$FunnelDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FunnelDataImplToJson(this);
  }
}

abstract class _FunnelData implements FunnelData {
  const factory _FunnelData({
    @JsonKey(name: 'status_code') required final String statusCode,
    @JsonKey(name: 'status_name') required final String statusName,
    required final int count,
    required final double percentage,
  }) = _$FunnelDataImpl;

  factory _FunnelData.fromJson(Map<String, dynamic> json) =
      _$FunnelDataImpl.fromJson;

  @override
  @JsonKey(name: 'status_code')
  String get statusCode;
  @override
  @JsonKey(name: 'status_name')
  String get statusName;
  @override
  int get count;
  @override
  double get percentage;

  /// Create a copy of FunnelData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FunnelDataImplCopyWith<_$FunnelDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TCPerformance _$TCPerformanceFromJson(Map<String, dynamic> json) {
  return _TCPerformance.fromJson(json);
}

/// @nodoc
mixin _$TCPerformance {
  @JsonKey(name: 'tc_id')
  int get tcId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tc_name')
  String get tcName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_students')
  int get totalStudents => throw _privateConstructorUsedError;
  @JsonKey(name: 'prospect_count')
  int get prospectCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_count')
  int get consultCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'register_count')
  int get registerCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_total')
  int get consultTotal => throw _privateConstructorUsedError;

  /// Serializes this TCPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TCPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TCPerformanceCopyWith<TCPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TCPerformanceCopyWith<$Res> {
  factory $TCPerformanceCopyWith(
    TCPerformance value,
    $Res Function(TCPerformance) then,
  ) = _$TCPerformanceCopyWithImpl<$Res, TCPerformance>;
  @useResult
  $Res call({
    @JsonKey(name: 'tc_id') int tcId,
    @JsonKey(name: 'tc_name') String tcName,
    @JsonKey(name: 'total_students') int totalStudents,
    @JsonKey(name: 'prospect_count') int prospectCount,
    @JsonKey(name: 'consult_count') int consultCount,
    @JsonKey(name: 'register_count') int registerCount,
    @JsonKey(name: 'consult_total') int consultTotal,
  });
}

/// @nodoc
class _$TCPerformanceCopyWithImpl<$Res, $Val extends TCPerformance>
    implements $TCPerformanceCopyWith<$Res> {
  _$TCPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TCPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tcId = null,
    Object? tcName = null,
    Object? totalStudents = null,
    Object? prospectCount = null,
    Object? consultCount = null,
    Object? registerCount = null,
    Object? consultTotal = null,
  }) {
    return _then(
      _value.copyWith(
            tcId: null == tcId
                ? _value.tcId
                : tcId // ignore: cast_nullable_to_non_nullable
                      as int,
            tcName: null == tcName
                ? _value.tcName
                : tcName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalStudents: null == totalStudents
                ? _value.totalStudents
                : totalStudents // ignore: cast_nullable_to_non_nullable
                      as int,
            prospectCount: null == prospectCount
                ? _value.prospectCount
                : prospectCount // ignore: cast_nullable_to_non_nullable
                      as int,
            consultCount: null == consultCount
                ? _value.consultCount
                : consultCount // ignore: cast_nullable_to_non_nullable
                      as int,
            registerCount: null == registerCount
                ? _value.registerCount
                : registerCount // ignore: cast_nullable_to_non_nullable
                      as int,
            consultTotal: null == consultTotal
                ? _value.consultTotal
                : consultTotal // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TCPerformanceImplCopyWith<$Res>
    implements $TCPerformanceCopyWith<$Res> {
  factory _$$TCPerformanceImplCopyWith(
    _$TCPerformanceImpl value,
    $Res Function(_$TCPerformanceImpl) then,
  ) = __$$TCPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tc_id') int tcId,
    @JsonKey(name: 'tc_name') String tcName,
    @JsonKey(name: 'total_students') int totalStudents,
    @JsonKey(name: 'prospect_count') int prospectCount,
    @JsonKey(name: 'consult_count') int consultCount,
    @JsonKey(name: 'register_count') int registerCount,
    @JsonKey(name: 'consult_total') int consultTotal,
  });
}

/// @nodoc
class __$$TCPerformanceImplCopyWithImpl<$Res>
    extends _$TCPerformanceCopyWithImpl<$Res, _$TCPerformanceImpl>
    implements _$$TCPerformanceImplCopyWith<$Res> {
  __$$TCPerformanceImplCopyWithImpl(
    _$TCPerformanceImpl _value,
    $Res Function(_$TCPerformanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TCPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tcId = null,
    Object? tcName = null,
    Object? totalStudents = null,
    Object? prospectCount = null,
    Object? consultCount = null,
    Object? registerCount = null,
    Object? consultTotal = null,
  }) {
    return _then(
      _$TCPerformanceImpl(
        tcId: null == tcId
            ? _value.tcId
            : tcId // ignore: cast_nullable_to_non_nullable
                  as int,
        tcName: null == tcName
            ? _value.tcName
            : tcName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalStudents: null == totalStudents
            ? _value.totalStudents
            : totalStudents // ignore: cast_nullable_to_non_nullable
                  as int,
        prospectCount: null == prospectCount
            ? _value.prospectCount
            : prospectCount // ignore: cast_nullable_to_non_nullable
                  as int,
        consultCount: null == consultCount
            ? _value.consultCount
            : consultCount // ignore: cast_nullable_to_non_nullable
                  as int,
        registerCount: null == registerCount
            ? _value.registerCount
            : registerCount // ignore: cast_nullable_to_non_nullable
                  as int,
        consultTotal: null == consultTotal
            ? _value.consultTotal
            : consultTotal // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TCPerformanceImpl implements _TCPerformance {
  const _$TCPerformanceImpl({
    @JsonKey(name: 'tc_id') required this.tcId,
    @JsonKey(name: 'tc_name') required this.tcName,
    @JsonKey(name: 'total_students') required this.totalStudents,
    @JsonKey(name: 'prospect_count') required this.prospectCount,
    @JsonKey(name: 'consult_count') required this.consultCount,
    @JsonKey(name: 'register_count') required this.registerCount,
    @JsonKey(name: 'consult_total') required this.consultTotal,
  });

  factory _$TCPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TCPerformanceImplFromJson(json);

  @override
  @JsonKey(name: 'tc_id')
  final int tcId;
  @override
  @JsonKey(name: 'tc_name')
  final String tcName;
  @override
  @JsonKey(name: 'total_students')
  final int totalStudents;
  @override
  @JsonKey(name: 'prospect_count')
  final int prospectCount;
  @override
  @JsonKey(name: 'consult_count')
  final int consultCount;
  @override
  @JsonKey(name: 'register_count')
  final int registerCount;
  @override
  @JsonKey(name: 'consult_total')
  final int consultTotal;

  @override
  String toString() {
    return 'TCPerformance(tcId: $tcId, tcName: $tcName, totalStudents: $totalStudents, prospectCount: $prospectCount, consultCount: $consultCount, registerCount: $registerCount, consultTotal: $consultTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TCPerformanceImpl &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.tcName, tcName) || other.tcName == tcName) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.prospectCount, prospectCount) ||
                other.prospectCount == prospectCount) &&
            (identical(other.consultCount, consultCount) ||
                other.consultCount == consultCount) &&
            (identical(other.registerCount, registerCount) ||
                other.registerCount == registerCount) &&
            (identical(other.consultTotal, consultTotal) ||
                other.consultTotal == consultTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tcId,
    tcName,
    totalStudents,
    prospectCount,
    consultCount,
    registerCount,
    consultTotal,
  );

  /// Create a copy of TCPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TCPerformanceImplCopyWith<_$TCPerformanceImpl> get copyWith =>
      __$$TCPerformanceImplCopyWithImpl<_$TCPerformanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TCPerformanceImplToJson(this);
  }
}

abstract class _TCPerformance implements TCPerformance {
  const factory _TCPerformance({
    @JsonKey(name: 'tc_id') required final int tcId,
    @JsonKey(name: 'tc_name') required final String tcName,
    @JsonKey(name: 'total_students') required final int totalStudents,
    @JsonKey(name: 'prospect_count') required final int prospectCount,
    @JsonKey(name: 'consult_count') required final int consultCount,
    @JsonKey(name: 'register_count') required final int registerCount,
    @JsonKey(name: 'consult_total') required final int consultTotal,
  }) = _$TCPerformanceImpl;

  factory _TCPerformance.fromJson(Map<String, dynamic> json) =
      _$TCPerformanceImpl.fromJson;

  @override
  @JsonKey(name: 'tc_id')
  int get tcId;
  @override
  @JsonKey(name: 'tc_name')
  String get tcName;
  @override
  @JsonKey(name: 'total_students')
  int get totalStudents;
  @override
  @JsonKey(name: 'prospect_count')
  int get prospectCount;
  @override
  @JsonKey(name: 'consult_count')
  int get consultCount;
  @override
  @JsonKey(name: 'register_count')
  int get registerCount;
  @override
  @JsonKey(name: 'consult_total')
  int get consultTotal;

  /// Create a copy of TCPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TCPerformanceImplCopyWith<_$TCPerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyTrend _$MonthlyTrendFromJson(Map<String, dynamic> json) {
  return _MonthlyTrend.fromJson(json);
}

/// @nodoc
mixin _$MonthlyTrend {
  String get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'register_count')
  int get registerCount => throw _privateConstructorUsedError;

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
  $Res call({String month, @JsonKey(name: 'register_count') int registerCount});
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
  $Res call({Object? month = null, Object? registerCount = null}) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            registerCount: null == registerCount
                ? _value.registerCount
                : registerCount // ignore: cast_nullable_to_non_nullable
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
  $Res call({String month, @JsonKey(name: 'register_count') int registerCount});
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
  $Res call({Object? month = null, Object? registerCount = null}) {
    return _then(
      _$MonthlyTrendImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        registerCount: null == registerCount
            ? _value.registerCount
            : registerCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyTrendImpl implements _MonthlyTrend {
  const _$MonthlyTrendImpl({
    required this.month,
    @JsonKey(name: 'register_count') required this.registerCount,
  });

  factory _$MonthlyTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyTrendImplFromJson(json);

  @override
  final String month;
  @override
  @JsonKey(name: 'register_count')
  final int registerCount;

  @override
  String toString() {
    return 'MonthlyTrend(month: $month, registerCount: $registerCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyTrendImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.registerCount, registerCount) ||
                other.registerCount == registerCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, registerCount);

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
    required final String month,
    @JsonKey(name: 'register_count') required final int registerCount,
  }) = _$MonthlyTrendImpl;

  factory _MonthlyTrend.fromJson(Map<String, dynamic> json) =
      _$MonthlyTrendImpl.fromJson;

  @override
  String get month;
  @override
  @JsonKey(name: 'register_count')
  int get registerCount;

  /// Create a copy of MonthlyTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyTrendImplCopyWith<_$MonthlyTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
