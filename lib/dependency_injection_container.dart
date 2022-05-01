import 'package:get_it/get_it.dart';

import 'ui/shared_widgets/bullsheet_date_time_field.dart';
import 'view_models/job_search_view_model.dart';
import 'view_models/location_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(BullsheetDateTimeFieldViewModel.new);
  getIt.registerFactory(LocationViewModel.new);
  getIt.registerFactory(JobSearchViewModel.new);
}
