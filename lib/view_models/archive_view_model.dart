import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';
import '../api/models/archive.dart';
import '../api/models/job.dart';
import '../repository/archive_repository.dart';
import '../repository/bullsheet_repository.dart';

class ArchiveViewModel {
  ArchiveViewModel(this.archiveRepository, this.bullsheetRepository);

  final BullsheetRepository bullsheetRepository;
  final ArchiveRepository archiveRepository;

  final archiveStream = BehaviorSubject<ApiResponse<Archive>>();
  String? archiveName;

  Future<Archive?> getArchiveForId(String id) async {
    archiveStream.add(ApiResponse.loading(null));
    final _archiveModel = await archiveRepository.getArchive(id);
    if (_archiveModel != null) {
      archiveStream.add(
        ApiResponse.completed(_archiveModel),
      );
    } else {
      archiveStream.add(
        ApiResponse.error('Couldn\'t find archive. Please try again.'),
      );
    }
    return _archiveModel;
  }

  void setColor(Color color) {
    var _archive = archiveStream.value?.data;
    archiveStream.add(
      ApiResponse.completed(
        _archive?.rebuild(
              (p0) => p0.color = color.value,
        ),
      ),
    );
  }

  void removeJob(Job job) {
    var _archive = archiveStream.value?.data;
    var _jobList = _archive?.jobList?.toList();
    if (_jobList != null) {
      _jobList.remove(job);
      archiveStream.add(
        ApiResponse.completed(
          _archive?.rebuild(
            (p0) => p0.jobList = _jobList.toBuiltList().toBuilder(),
          ),
        ),
      );
    }
  }

  void insertJob(Job job, int index) {
    var _archive = archiveStream.value?.data;
    var _jobList = _archive?.jobList;
    if (_jobList != null) {
      _jobList.toList().insert(index, job);
      archiveStream.add(
        ApiResponse.completed(
          _archive?.rebuild(
            (p0) => p0.jobList = _jobList.toBuilder(),
          ),
        ),
      );
    }
  }

  void moveJob(
    Job job,
    int index,
  ) {
    var _archive = archiveStream.value?.data;
    var _jobList = _archive?.jobList;
    if (_jobList != null) {
      _jobList.toList().remove(job);
      _jobList.toList().insert(index, job);
      archiveStream.add(
        ApiResponse.completed(
          _archive?.rebuild(
            (p0) => p0.jobList = _jobList.toBuilder(),
          ),
        ),
      );
    }
  }

  Archive? updateArchive() {
    var _archive = archiveStream.value?.data;
    var _jobList = _archive?.jobList;
    if (_jobList != null) {
      final now = DateTime.now();
      final _editedArchive = _archive?.rebuild(
        (p0) => p0
          ..jobList = _jobList.toBuilder()
          ..name = archiveName
          ..updatedDate = now,
      );
      archiveRepository.saveArchive(_editedArchive);
      return _editedArchive;
    } else {
      return null;
    }
  }

  void dispose() {
    archiveStream.close();
  }
}
