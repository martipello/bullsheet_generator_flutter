import 'package:basic_utils/basic_utils.dart';

import '../../../extensions/string_extension.dart';
import '../job_search_request.dart';
import '../job_source.dart';

extension JobSourceExtension on JobSource {
  String displayName() {
    switch (this) {
      case JobSource.indeed:
        return 'Indeed';
      case JobSource.totalJobs:
        return 'Total Jobs';
      case JobSource.youGov:
        return 'Gov UK';
    }
    return '';
  }

  String baseUrl() {
    switch (this) {
      case JobSource.indeed:
        return 'https://uk.indeed.com/';
      case JobSource.totalJobs:
        return 'https://www.totaljobs.com/';
      case JobSource.youGov:
        return 'https://findajob.dwp.gov.uk/';
    }
    return '';
  }

  String searchQuery(JobSearchRequest? jobSearchRequest) {
    switch (this) {
      case JobSource.indeed:
        return _indeedSearchQuery(jobSearchRequest);
      case JobSource.totalJobs:
        return _totalJobsSearchQuery(jobSearchRequest);
      case JobSource.youGov:
        return _govUkSearchQuery(jobSearchRequest);
    }
    return '';
  }

  String _govUkSearchQuery(JobSearchRequest? jobSearchRequest) {
    final buffer = StringBuffer();
    buffer.write('search?adv=1');
    if (jobSearchRequest?.jobTitle?.isNotEmpty == true) {
      final encodeJobTitle = jobSearchRequest?.jobTitle?.replaceAll(' ', '%20').trim();
      buffer.write('&qor=$encodeJobTitle');
    }
    if (jobSearchRequest?.postCode?.isNotEmpty == true) {
      final _postCode = jobSearchRequest?.postCode?.removeWhiteSpace() ?? '';
      final _formatPostCode = StringUtils.addCharAtPosition(_postCode, ' ', _postCode.length - 3);
      final encodePostCode = _formatPostCode.replaceAll(' ', '+').trim();
      buffer.write('&w=$encodePostCode');
    }
    buffer.write('&d=${jobSearchRequest?.distanceInMiles ?? 5}');
    buffer.write('&pp=50&sb=date&sd=down');
    return buffer.toString();
  }

  String _totalJobsSearchQuery(JobSearchRequest? jobSearchRequest) {
    final buffer = StringBuffer();
    buffer.write('jobs');
    if (jobSearchRequest?.jobTitle?.isNotEmpty == true) {
      final encodeJobTitle = jobSearchRequest?.jobTitle?.replaceAll(' ', '-').trim();
      buffer.write('/$encodeJobTitle');
    }
    if (jobSearchRequest?.postCode?.isNotEmpty == true) {
      final _postCode = jobSearchRequest?.postCode?.removeWhiteSpace() ?? '';
      final _formatPostCode = StringUtils.addCharAtPosition(_postCode, ' ', _postCode.length - 3);
      final encodePostCode = _formatPostCode.replaceAll(' ', '-').trim();
      buffer.write('/in-$encodePostCode');
    }
    if (jobSearchRequest?.distanceInMiles != null && jobSearchRequest?.distanceInMiles.toString().isNotEmpty == true) {
      final _distanceInMiles = jobSearchRequest?.distanceInMiles ?? 0;
      if (_distanceInMiles > 5) {
        buffer.write('?radius=10');
      } else {
        buffer.write('?radius=5');
      }
    }
    return buffer.toString();
  }

  String _indeedSearchQuery(JobSearchRequest? jobSearchRequest) {
    final buffer = StringBuffer();
    buffer.write('jobs?');
    if (jobSearchRequest?.jobTitle?.isNotEmpty == true) {
      final encodeJobTitle = jobSearchRequest?.jobTitle?.replaceAll(' ', '%20').trim();
      buffer.write('q=$encodeJobTitle');
    }
    if (jobSearchRequest?.postCode?.isNotEmpty == true) {
      final _postCode = jobSearchRequest?.postCode?.removeWhiteSpace() ?? '';
      final _formatPostCode = StringUtils.addCharAtPosition(_postCode, ' ', _postCode.length - 3);
      final encodePostCode = _formatPostCode.replaceAll(' ', '%20').trim();
      buffer.write('&l=$encodePostCode');
    }
    if (jobSearchRequest?.distanceInMiles != null && jobSearchRequest?.distanceInMiles.toString().isNotEmpty == true) {
      buffer.write('&radius=${jobSearchRequest?.distanceInMiles}');
    }
    return buffer.toString();
  }

  String encodeGovUkUrl(String id) {
    return '${baseUrl()}details/$id';
  }

  String encodeIndeedUrl(String id){
    return '${baseUrl()}viewjob?jk=$id';
  }

}
