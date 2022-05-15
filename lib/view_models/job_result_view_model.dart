import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';
import '../api/models/job.dart';
import '../api/models/job_search_request.dart';
import '../extensions/iterable_extension.dart';
import '../repository/bullsheet_repository.dart';
import '../utils/constants.dart';

class JobResultViewModel {
  JobResultViewModel(this.bullsheetRepository);

  final BullsheetRepository bullsheetRepository;

  final jobListStream = BehaviorSubject<ApiResponse<List<Job>>>();

  JobSearchRequest? jobSearchRequest;

  Future<void> getJobs() async {
    jobListStream.add(ApiResponse.loading(null));
    final _jobs = await bullsheetRepository.getJobs(jobSearchRequest);
    if(_jobs.all((element) => element.id == Constants.errorId)) {
      jobListStream.add(ApiResponse.error('All sites had errors.'));
    } else {
      jobListStream.add(ApiResponse.completed(_jobs));
    }
  }

  Future<void> removeJob(Job job) async {
    var _jobList = jobListStream.value?.data;
    if(_jobList != null){
      _jobList.remove(job);
      jobListStream.add(ApiResponse.completed(_jobList));
    }
  }

  void dispose() {
    jobListStream.close();
  }
}