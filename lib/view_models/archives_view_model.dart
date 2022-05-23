import 'package:rxdart/subjects.dart';

import '../api/models/api_response.dart';
import '../api/models/archive_model.dart';
import '../repository/archive_repository.dart';

class ArchivesViewModel {
  ArchivesViewModel(this.archiveRepository);

  final ArchiveRepository archiveRepository;

  final archivesStream = BehaviorSubject<ApiResponse<List<ArchiveModel>>>();

  void getArchives() async {
    archivesStream.add(ApiResponse.loading(null));
    final archiveModelList = await archiveRepository.getArchiveModels();
    if(archiveModelList != null){
      archivesStream.add(ApiResponse.completed(archiveModelList));
    } else {
      archivesStream.add(ApiResponse.error('Couldn\'t find archives. Please try again.'));
    }
  }

  void dispose () {
    archivesStream.close();
  }
}