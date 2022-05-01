import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'job_source.dart';
import 'serializers/serializers.dart';

part 'job_search_request.g.dart';

abstract class JobSearchRequest implements Built<JobSearchRequest, JobSearchRequestBuilder> {
  factory JobSearchRequest([void Function(JobSearchRequestBuilder) updates]) = _$JobSearchRequest;

  JobSearchRequest._();

  String? get jobTitle;

  String? get postCode;

  double? get distanceInMiles;

  DateTime? get fromDate;

  DateTime? get toDate;

  BuiltList<JobSource> get jobSource;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(JobSearchRequest.serializer, this) as Map<String, dynamic>;
  }

  static JobSearchRequest? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(JobSearchRequest.serializer, json);
  }

  static Serializer<JobSearchRequest> get serializer => _$jobSearchRequestSerializer;
}
