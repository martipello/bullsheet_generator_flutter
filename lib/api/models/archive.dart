import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import 'job.dart';
import 'serializers/serializers.dart';

part 'archive.g.dart';

@HiveType(typeId: 0)
abstract class Archive implements Built<Archive, ArchiveBuilder> {
  factory Archive([void Function(ArchiveBuilder) updates]) = _$Archive;

  Archive._();

  @HiveField(0)
  String? get id;

  @HiveField(1)
  DateTime? get createdDate;

  @HiveField(2)
  DateTime? get updatedDate;

  @HiveField(3)
  String? get name;

  @HiveField(4)
  int? get color;

  @HiveField(5)
  BuiltList<Job>? get jobList;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Archive.serializer, this) as Map<String, dynamic>;
  }

  static Archive? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Archive.serializer, json);
  }

  static Serializer<Archive> get serializer => _$archiveSerializer;
}
