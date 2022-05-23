import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive/hive.dart';

import 'job.dart';
import 'serializers/serializers.dart';

part 'archive_model.g.dart';

@HiveType(typeId: 0)
abstract class ArchiveModel implements Built<ArchiveModel, ArchiveModelBuilder> {


  factory ArchiveModel([void Function(ArchiveModelBuilder) updates]) = _$ArchiveModel;

  ArchiveModel._();

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
  List<Job>? get jobList;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ArchiveModel.serializer, this) as Map<String, dynamic>;
  }

  static ArchiveModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ArchiveModel.serializer, json);
  }

  static Serializer<ArchiveModel> get serializer => _$archiveModelSerializer;
}