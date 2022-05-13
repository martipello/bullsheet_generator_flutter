import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../api_response.dart';
import '../archive_model.dart';
import '../error_response.dart';
import '../job.dart';
import '../job_search_request.dart';
import '../job_source.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor([
  //models
  ApiResponse,
  ArchiveModel,
  ErrorResponse,
  Job,
  JobSearchRequest,
  JobSource,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
