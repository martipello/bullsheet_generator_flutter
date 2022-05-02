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

  String searchQuery(JobSearchRequest jobSearchRequest){
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

  String _govUkSearchQuery(JobSearchRequest jobSearchRequest){
    final buffer = StringBuffer();
    buffer.write('/search?adv=1');
    if(jobSearchRequest.jobTitle?.isNotEmpty == true){
      final encodeJobTitle = jobSearchRequest.jobTitle?.replaceAll(' ', '%20').trim();
      buffer.write('&qor=$encodeJobTitle');
    }
    if (jobSearchRequest.postCode?.isNotEmpty == true) {
      final encodePostCode = jobSearchRequest.postCode?.replaceAll(' ', '%20').trim();
      buffer.write('&w=$encodePostCode');
    }
    if (jobSearchRequest.distanceInMiles.toString().isNotEmpty == true) {
      buffer.write('&d=${jobSearchRequest.distanceInMiles}');
    }
    buffer.write('&pp=50&sb=date&sd=down');
    return buffer.toString();
  }

  String _totalJobsSearchQuery(JobSearchRequest jobSearchRequest){
    final buffer = StringBuffer();
    buffer.write('/jobs');
    if(jobSearchRequest.jobTitle?.isNotEmpty == true){
      final encodeJobTitle = jobSearchRequest.jobTitle?.replaceAll(' ', '-').trim();
      buffer.write('/$encodeJobTitle');
    }
    if (jobSearchRequest.postCode?.isNotEmpty == true) {
      final encodePostCode = jobSearchRequest.postCode?.replaceAll(' ', '-').trim();
      buffer.write('/in-$encodePostCode');
    }
    if (jobSearchRequest.distanceInMiles.toString().isNotEmpty == true) {
      buffer.write('?radius=${jobSearchRequest.distanceInMiles}');
    }
    return buffer.toString();
  }

  String _indeedSearchQuery(JobSearchRequest jobSearchRequest){
    final buffer = StringBuffer();
    buffer.write('/jobs?');
    if(jobSearchRequest.jobTitle?.isNotEmpty == true){
      final encodeJobTitle = jobSearchRequest.jobTitle?.replaceAll(' ', '%20').trim();
      buffer.write('q=$encodeJobTitle');
    }
    if (jobSearchRequest.postCode?.isNotEmpty == true) {
      final encodePostCode = jobSearchRequest.postCode?.replaceAll(' ', '%20').trim();
      buffer.write('&l=$encodePostCode');
    }
    if (jobSearchRequest.distanceInMiles.toString().isNotEmpty == true) {
      buffer.write('&radius=${jobSearchRequest.distanceInMiles}');
    }
    return buffer.toString();
  }
}