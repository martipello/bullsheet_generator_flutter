import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../repository/bullsheet_repository.dart';

class JobSearchViewModel {
  JobSearchViewModel(this.bullsheetRepository);

  final BullsheetRepository bullsheetRepository;

  final jobSearchStream = BehaviorSubject<JobSearchRequest>.seeded(
    JobSearchRequest(
      (b) => b..jobSource = JobSource.values.toBuiltList().toBuilder(),
    ),
  );

  void setJobTitle(String? jobTitle) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..jobTitle = jobTitle,
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..jobTitle = jobTitle,
        ),
      );
    }
  }

  void setPostcode(String? postCode) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..postCode = postCode,
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..postCode = postCode,
        ),
      );
    }
  }

  void setDistanceInMiles(double? distanceInMiles) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..distanceInMiles = distanceInMiles,
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..distanceInMiles = distanceInMiles,
        ),
      );
    }
  }

  void setFromDate(DateTime? fromDate) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      final toDate = _jobSearchRequest.toDate ?? DateTime.now();
      if (fromDate?.isAfter(toDate) == true) {
        jobSearchStream.add(
          _jobSearchRequest.rebuild(
            (p0) => p0
              ..fromDate = fromDate
              ..toDate = fromDate,
          ),
        );
      } else {
        jobSearchStream.add(
          _jobSearchRequest.rebuild(
            (p0) => p0..fromDate = fromDate,
          ),
        );
      }
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..fromDate = fromDate,
        ),
      );
    }
  }

  void setToDate(DateTime? toDate) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..toDate = toDate,
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..toDate = toDate,
        ),
      );
    }
  }

  void addJobSource(JobSource jobSource) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      final _jobSources = _jobSearchRequest.jobSource.toList();
      _jobSources.add(jobSource);
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..jobSource = _jobSources.toBuiltList().toBuilder(),
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (p0) => p0..jobSource = BuiltList.of([jobSource]).toBuilder(),
        ),
      );
    }
  }

  void removeJobSource(JobSource jobSource) {
    final _jobSearchRequest = jobSearchStream.value;
    if (_jobSearchRequest != null) {
      final _jobSources = _jobSearchRequest.jobSource.toList();
      _jobSources.remove(jobSource);
      jobSearchStream.add(
        _jobSearchRequest.rebuild(
          (p0) => p0..jobSource = _jobSources.toBuiltList().toBuilder(),
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (p0) => p0..jobSource = BuiltList.of(<JobSource>[]).toBuilder(),
        ),
      );
    }
  }

  void dispose() {
    jobSearchStream.close();
  }
}
