import 'package:rxdart/subjects.dart';

import '../api/models/api_response.dart';
import '../api/models/archive_model.dart';
import '../repository/archive_repository.dart';

class ArchiveViewModel {
  ArchiveViewModel(this.archiveRepository);

  final ArchiveRepository archiveRepository;

  final archiveStream = BehaviorSubject<ApiResponse<ArchiveModel?>>();

  void getArchiveModelForId(String id) async {
    archiveStream.add(ApiResponse.loading(null));
    final archiveModel = await archiveRepository.getArchive(id);
    if(archiveModel != null){
      archiveStream.add(ApiResponse.completed(archiveModel));
    } else {
      archiveStream.add(ApiResponse.error('Couldn\'t find archive. Please try again.'));
    }
  }

  void dispose () {
    archiveStream.close();
  }
}