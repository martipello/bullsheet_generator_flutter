// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_search_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<JobSearchRequest> _$jobSearchRequestSerializer =
    new _$JobSearchRequestSerializer();

class _$JobSearchRequestSerializer
    implements StructuredSerializer<JobSearchRequest> {
  @override
  final Iterable<Type> types = const [JobSearchRequest, _$JobSearchRequest];
  @override
  final String wireName = 'JobSearchRequest';

  @override
  Iterable<Object?> serialize(Serializers serializers, JobSearchRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'jobSource',
      serializers.serialize(object.jobSource,
          specifiedType:
              const FullType(BuiltList, const [const FullType(JobSource)])),
    ];
    Object? value;
    value = object.jobTitle;
    if (value != null) {
      result
        ..add('jobTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postCode;
    if (value != null) {
      result
        ..add('postCode')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.distanceInMiles;
    if (value != null) {
      result
        ..add('distanceInMiles')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fromDate;
    if (value != null) {
      result
        ..add('fromDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.toDate;
    if (value != null) {
      result
        ..add('toDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  JobSearchRequest deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new JobSearchRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'jobTitle':
          result.jobTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'postCode':
          result.postCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'distanceInMiles':
          result.distanceInMiles = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fromDate':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'toDate':
          result.toDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'jobSource':
          result.jobSource.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(JobSource)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$JobSearchRequest extends JobSearchRequest {
  @override
  final String? jobTitle;
  @override
  final String? postCode;
  @override
  final double? distanceInMiles;
  @override
  final DateTime? fromDate;
  @override
  final DateTime? toDate;
  @override
  final BuiltList<JobSource> jobSource;

  factory _$JobSearchRequest(
          [void Function(JobSearchRequestBuilder)? updates]) =>
      (new JobSearchRequestBuilder()..update(updates)).build();

  _$JobSearchRequest._(
      {this.jobTitle,
      this.postCode,
      this.distanceInMiles,
      this.fromDate,
      this.toDate,
      required this.jobSource})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        jobSource, 'JobSearchRequest', 'jobSource');
  }

  @override
  JobSearchRequest rebuild(void Function(JobSearchRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobSearchRequestBuilder toBuilder() =>
      new JobSearchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobSearchRequest &&
        jobTitle == other.jobTitle &&
        postCode == other.postCode &&
        distanceInMiles == other.distanceInMiles &&
        fromDate == other.fromDate &&
        toDate == other.toDate &&
        jobSource == other.jobSource;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, jobTitle.hashCode), postCode.hashCode),
                    distanceInMiles.hashCode),
                fromDate.hashCode),
            toDate.hashCode),
        jobSource.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('JobSearchRequest')
          ..add('jobTitle', jobTitle)
          ..add('postCode', postCode)
          ..add('distanceInMiles', distanceInMiles)
          ..add('fromDate', fromDate)
          ..add('toDate', toDate)
          ..add('jobSource', jobSource))
        .toString();
  }
}

class JobSearchRequestBuilder
    implements Builder<JobSearchRequest, JobSearchRequestBuilder> {
  _$JobSearchRequest? _$v;

  String? _jobTitle;
  String? get jobTitle => _$this._jobTitle;
  set jobTitle(String? jobTitle) => _$this._jobTitle = jobTitle;

  String? _postCode;
  String? get postCode => _$this._postCode;
  set postCode(String? postCode) => _$this._postCode = postCode;

  double? _distanceInMiles;
  double? get distanceInMiles => _$this._distanceInMiles;
  set distanceInMiles(double? distanceInMiles) =>
      _$this._distanceInMiles = distanceInMiles;

  DateTime? _fromDate;
  DateTime? get fromDate => _$this._fromDate;
  set fromDate(DateTime? fromDate) => _$this._fromDate = fromDate;

  DateTime? _toDate;
  DateTime? get toDate => _$this._toDate;
  set toDate(DateTime? toDate) => _$this._toDate = toDate;

  ListBuilder<JobSource>? _jobSource;
  ListBuilder<JobSource> get jobSource =>
      _$this._jobSource ??= new ListBuilder<JobSource>();
  set jobSource(ListBuilder<JobSource>? jobSource) =>
      _$this._jobSource = jobSource;

  JobSearchRequestBuilder();

  JobSearchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _jobTitle = $v.jobTitle;
      _postCode = $v.postCode;
      _distanceInMiles = $v.distanceInMiles;
      _fromDate = $v.fromDate;
      _toDate = $v.toDate;
      _jobSource = $v.jobSource.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JobSearchRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$JobSearchRequest;
  }

  @override
  void update(void Function(JobSearchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$JobSearchRequest build() {
    _$JobSearchRequest _$result;
    try {
      _$result = _$v ??
          new _$JobSearchRequest._(
              jobTitle: jobTitle,
              postCode: postCode,
              distanceInMiles: distanceInMiles,
              fromDate: fromDate,
              toDate: toDate,
              jobSource: jobSource.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'jobSource';
        jobSource.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'JobSearchRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
