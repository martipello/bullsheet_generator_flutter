import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import 'serializers/serializers.dart';

part 'job.g.dart';

@HiveType(typeId: 1)
abstract class Job implements Built<Job, JobBuilder> {
  factory Job([void Function(JobBuilder) updates]) = _$Job;

  Job._();

  @HiveField(0)
  String? get id;

  @HiveField(1)
  String? get title;

  @HiveField(2)
  String? get company;

  @HiveField(3)
  String? get description;

  @HiveField(4)
  String? get location;

  @HiveField(5)
  String? get applicationType;

  @HiveField(6)
  String? get url;

  @HiveField(7)
  DateTime? get dateApplied;

  @HiveField(8)
  String? get datePosted;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Job.serializer, this) as Map<String, dynamic>;
  }

  static Job? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Job.serializer, json);
  }

  static Serializer<Job> get serializer => _$jobSerializer;
}
