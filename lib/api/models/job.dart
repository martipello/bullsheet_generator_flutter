import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers/serializers.dart';

part 'job.g.dart';

abstract class Job implements Built<Job, JobBuilder> {
  factory Job([void Function(JobBuilder) updates]) = _$Job;
  Job._();

  String? get id;

  String? get company;

  String? get description;

  String? get location;

  String? get applicationType;

  String? get url;

  DateTime? get date;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Job.serializer, this) as Map<String, dynamic>;
  }

  static Job? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Job.serializer, json);
  }

  static Serializer<Job> get serializer => _$jobSerializer;
}
