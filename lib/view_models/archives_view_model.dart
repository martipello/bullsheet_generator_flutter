import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';
import '../api/models/archive.dart';
import '../repository/archive_repository.dart';

class ArchivesViewModel {
  ArchivesViewModel(this.archiveRepository);

  final ArchiveRepository archiveRepository;

  final archivesStream = BehaviorSubject<ApiResponse<List<Archive>>>();

  void getArchives() async {
    archivesStream.add(ApiResponse.loading(null));
    final archiveModelList = await archiveRepository.getArchiveModels();
    if (archiveModelList != null) {
      archivesStream.add(
        ApiResponse.completed(archiveModelList),
      );
    } else {
      archivesStream.add(
        ApiResponse.error('Couldn\'t find archives. Please try again.'),
      );
    }
  }

  void removeArchive(Archive archiveModel) {
    var _archiveModelList = archivesStream.value?.data;
    if (_archiveModelList != null) {
      _archiveModelList.remove(archiveModel);
      archivesStream.add(ApiResponse.completed(_archiveModelList));
    }
  }

  void insertArchive(Archive archiveModel, int index) {
    var _archiveModelList = archivesStream.value?.data;
    if (_archiveModelList != null) {
      _archiveModelList.insert(index, archiveModel);
      archivesStream.add(ApiResponse.completed(_archiveModelList));
    }
  }

  void moveArchive(Archive archiveModel, int index) {
    var _archiveModelList = archivesStream.value?.data;
    if (_archiveModelList != null) {
      _archiveModelList.remove(archiveModel);
      _archiveModelList.insert(index, archiveModel);
      archivesStream.add(ApiResponse.completed(_archiveModelList));
    }
  }

  void dispose() {
    archivesStream.close();
  }
}
