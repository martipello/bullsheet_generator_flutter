import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers/serializers.dart';

part 'job_source.g.dart';

class JobSource extends EnumClass {
  const JobSource._(String name) : super(name);

  static const JobSource totalJobs = _$totalJobs;
  static const JobSource indeed = _$indeed;
  static const JobSource youGov = _$youGov;

  static BuiltSet<JobSource> get values => _$jobSourceValues;

  static JobSource valueOf(String name) => _$jobSourceValueOf(name);

  String serialize() {
    return serializers.serializeWith(JobSource.serializer, this) as String;
  }

  static JobSource? deserialize(String string) {
    return serializers.deserializeWith(JobSource.serializer, string);
  }

  static Serializer<JobSource> get serializer => _$jobSourceSerializer;
}
