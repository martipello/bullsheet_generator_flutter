import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../api_response.dart';
import '../error_response.dart';
import '../job_search_request.dart';
import '../job_sources.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor([
  //models
  ApiResponse,
  ErrorResponse,
  JobSearchRequest,
  JobSources,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
