import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';
import '../api/models/archive.dart';
import '../api/models/job.dart';
import '../api/models/job_search_request.dart';
import '../extensions/date_time_extension.dart';
import '../extensions/iterable_extension.dart';
import '../repository/archive_repository.dart';
import '../repository/bullsheet_repository.dart';
import '../utils/constants.dart';

class JobResultViewModel {
  JobResultViewModel(
    this.bullsheetRepository,
    this.archiveRepository,
  );

  final BullsheetRepository bullsheetRepository;
  final ArchiveRepository archiveRepository;

  final jobListStream = BehaviorSubject<ApiResponse<BuiltList<Job>>>();
  String? archiveName;

  JobSearchRequest? jobSearchRequest;

  Future<void> getJobs() async {
    jobListStream.add(ApiResponse.loading(null));
    final _jobs = await bullsheetRepository.getJobs(jobSearchRequest);
    if (_jobs.all((element) => element.id == Constants.errorId)) {
      jobListStream.add(ApiResponse.error('All sites had errors.'));
    } else {
      jobListStream.add(ApiResponse.completed(_jobs.toBuiltList()));
    }
  }

  void removeJob(Job job) {
    var _jobList = jobListStream.value?.data;
    if (_jobList != null) {
      _jobList.toList().remove(job);
      jobListStream.add(ApiResponse.completed(_jobList));
    }
  }

  void insertJob(Job job, int index) {
    var _jobList = jobListStream.value?.data;
    if (_jobList != null) {
      _jobList.toList().insert(index, job);
      jobListStream.add(ApiResponse.completed(_jobList));
    }
  }

  void moveJob(
    Job job,
    int index,
  ) {
    var _jobList = jobListStream.value?.data;
    if (_jobList != null) {
      _jobList.toList().remove(job);
      _jobList.toList().insert(index, job);
      jobListStream.add(ApiResponse.completed(_jobList));
    }
  }

  Archive? archiveJobs() {
    var _jobList = jobListStream.value?.data;
    if (_jobList != null) {
      final now = DateTime.now();
      final _id = now.id();
      final _archiveModel = Archive(
        (b) => b
          ..id = _id
          ..name = archiveName ?? 'New Job List'
          ..createdDate = now
          ..updatedDate = now
          ..color = Colors.white.value
          ..jobList = _jobList.toBuilder(),
      );
      archiveRepository.saveArchive(_archiveModel);
      return _archiveModel;
    } else {
      return null;
    }
  }

  void dispose() {
    jobListStream.close();
  }
}
