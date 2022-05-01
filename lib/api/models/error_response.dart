import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers/serializers.dart';

part 'error_response.g.dart';

abstract class ErrorResponse implements Built<ErrorResponse, ErrorResponseBuilder> {
  factory ErrorResponse([void Function(ErrorResponseBuilder) updates]) = _$ErrorResponse;

  ErrorResponse._();

  String? get message;

  String? get error;

  String? get url;

  int? get statusCode;

  // ignore: non_constant_identifier_names
  int? get attempts_remaining;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ErrorResponse.serializer, this) as Map<String, dynamic>;
  }

  static ErrorResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ErrorResponse.serializer, json);
  }

  static Serializer<ErrorResponse> get serializer => _$errorResponseSerializer;
}
