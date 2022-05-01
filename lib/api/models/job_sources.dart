import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers/serializers.dart';

part 'job_sources.g.dart';

class JobSources extends EnumClass {
  const JobSources._(String name) : super(name);

  static const JobSources totalJobs = _$totalJobs;
  static const JobSources indeed = _$indeed;
  static const JobSources youGov = _$youGov;

  static BuiltSet<JobSources> get values => _$jobSourcesValues;

  static JobSources valueOf(String name) => _$jobSourcesValueOf(name);

  String serialize() {
    return serializers.serializeWith(JobSources.serializer, this) as String;
  }

  static JobSources? deserialize(String string) {
    return serializers.deserializeWith(JobSources.serializer, string);
  }

  static Serializer<JobSources> get serializer => _$jobSourcesSerializer;
}
