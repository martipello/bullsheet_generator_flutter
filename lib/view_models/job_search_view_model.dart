import 'package:rxdart/rxdart.dart';

import '../api/models/job_search_request.dart';

class JobSearchViewModel {
  final jobSearchStream = BehaviorSubject<JobSearchRequest>();

  void setJobTitle(String? jobTitle) {
    final jobSearchRequest = jobSearchStream.value;
    if (jobSearchRequest != null) {
      jobSearchStream.add(
        jobSearchRequest.rebuild(
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
    final jobSearchRequest = jobSearchStream.value;
    if (jobSearchRequest != null) {
      jobSearchStream.add(
        jobSearchRequest.rebuild(
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
    final jobSearchRequest = jobSearchStream.value;
    if (jobSearchRequest != null) {
      jobSearchStream.add(
        jobSearchRequest.rebuild(
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
    final jobSearchRequest = jobSearchStream.value;
    if (jobSearchRequest != null) {
      jobSearchStream.add(
        jobSearchRequest.rebuild(
          (p0) => p0..fromDate = fromDate,
        ),
      );
    } else {
      jobSearchStream.add(
        JobSearchRequest(
          (b) => b..fromDate = fromDate,
        ),
      );
    }
  }

  void setToDate(DateTime? toDate) {
    final jobSearchRequest = jobSearchStream.value;
    if (jobSearchRequest != null) {
      jobSearchStream.add(
        jobSearchRequest.rebuild(
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
}
