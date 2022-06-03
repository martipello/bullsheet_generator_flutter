// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const JobSource _$totalJobs = const JobSource._('totalJobs');
const JobSource _$indeed = const JobSource._('indeed');
const JobSource _$youGov = const JobSource._('youGov');

JobSource _$jobSourceValueOf(String name) {
  switch (name) {
    case 'totalJobs':
      return _$totalJobs;
    case 'indeed':
      return _$indeed;
    case 'youGov':
      return _$youGov;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<JobSource> _$jobSourceValues =
    new BuiltSet<JobSource>(const <JobSource>[
  _$totalJobs,
  _$indeed,
  _$youGov,
]);

Serializer<JobSource> _$jobSourceSerializer = new _$JobSourceSerializer();

class _$JobSourceSerializer implements PrimitiveSerializer<JobSource> {
  @override
  final Iterable<Type> types = const <Type>[JobSource];
  @override
  final String wireName = 'JobSource';

  @override
  Object serialize(Serializers serializers, JobSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  JobSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      JobSource.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
