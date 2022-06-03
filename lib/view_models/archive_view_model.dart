import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';
import '../api/models/archive.dart';
import '../api/models/job.dart';
import '../repository/archive_repository.dart';

class ArchiveViewModel {
  ArchiveViewModel(this.archiveRepository);

  final ArchiveRepository archiveRepository;

  final archiveStream = BehaviorSubject<ApiResponse<Archive?>>();

  Future<Archive?> getArchiveModelForId(String id) async {
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

  void removeJob(Job job) {
    var _archive = archiveStream.value?.data;
    var _jobList = archiveStream.value?.data?.jobList;
    if (_archive != null && _jobList != null) {
      _jobList.toList().remove(job);
      archiveStream.add(
        ApiResponse.completed(
          _archive.rebuild(
            (p0) => p0.jobList = _jobList.toBuiltList().toBuilder(),
          ),
        ),
      );
    }
  }

  void insertJob(Job job, int index) {
    var _archive = archiveStream.value?.data;
    var _jobList = archiveStream.value?.data?.jobList;
    if (_archive != null && _jobList != null) {
      _jobList.toList().insert(index, job);
      archiveStream.add(
        ApiResponse.completed(
          _archive.rebuild(
            (p0) => p0.jobList = _jobList.toBuiltList().toBuilder(),
          ),
        ),
      );
    }
  }

  void dispose() {
    archiveStream.close();
  }
}
