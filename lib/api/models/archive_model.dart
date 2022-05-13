import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'job.dart';
import 'serializers/serializers.dart';

part 'archive_model.g.dart';

abstract class ArchiveModel implements Built<ArchiveModel, ArchiveModelBuilder> {
  factory ArchiveModel([void Function(ArchiveModelBuilder) updates]) = _$ArchiveModel;

  ArchiveModel._();

  String? get id;

  DateTime? get createdDate;

  DateTime? get updatedDate;

  String? get name;

  Color? get color;

  BuiltList<Job> get jobList;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ArchiveModel.serializer, this) as Map<String, dynamic>;
  }

  static ArchiveModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ArchiveModel.serializer, json);
  }

  static Serializer<ArchiveModel> get serializer => _$archiveModelSerializer;
}
