import 'package:get_it/get_it.dart';

import 'repository/archive_repository.dart';
import 'repository/bullsheet_repository.dart';
import 'services/launch_service.dart';
import 'ui/shared_widgets/bullsheet_date_time_field.dart';
import 'view_models/archive_view_model.dart';
import 'view_models/archives_view_model.dart';
import 'view_models/job_result_view_model.dart';
import 'view_models/job_search_view_model.dart';
import 'view_models/location_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(BullsheetRepository.new);
  getIt.registerLazySingleton(ArchiveRepository.new);
  getIt.registerFactory(LaunchService.new);
  getIt.registerFactory(BullsheetDateTimeFieldViewModel.new);
  getIt.registerFactory(LocationViewModel.new);
  getIt.registerFactory(() => ArchiveViewModel(getIt(), getIt()));
  getIt.registerFactory(() => ArchivesViewModel(getIt()));
  getIt.registerFactory(() => JobSearchViewModel(getIt()));
  getIt.registerFactory(() => JobResultViewModel(getIt(), getIt()));
}
