import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../api_response.dart';
import '../error_response.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor([
  //models
  ApiResponse,
  ErrorResponse,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
