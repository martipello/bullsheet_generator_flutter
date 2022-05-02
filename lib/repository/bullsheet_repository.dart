import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';

class BullsheetRepository {

  void scrapeJobSources(JobSearchRequest jobSearchRequest){
    final jobSources = jobSearchRequest.jobSource;
    if(jobSources.any((p0) => p0 == JobSource.totalJobs)){

    }
    if(jobSources.any((p0) => p0 == JobSource.indeed)){

    }
    if(jobSources.any((p0) => p0 == JobSource.youGov)){

    }
  }
}