import 'package:flutter/material.dart';

import '../../api/models/api_response.dart';
import '../../api/models/archive_model.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/archive_view_model.dart';
import '../shared_widgets/bullsheet_app_bar.dart';

class ArchivePageArguments {
  ArchivePageArguments(this.archiveModelId);

  final String? archiveModelId;
}

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  static const route = 'ArchivePage';

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final _archiveViewModel = getIt.get<ArchiveViewModel>();
  ArchivePageArguments get archivePageArguments => context.routeArguments as ArchivePageArguments;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _archiveViewModel.getArchiveModelForId(archivePageArguments.archiveModelId ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: StreamBuilder<ApiResponse<ArchiveModel?>>(
        stream: _archiveViewModel.archiveStream,
        builder: (context, snapshot) {
          final _archive = snapshot.data?.data;
          final _state = snapshot.data?.status;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.screenWidth * 0.9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('ARCHIVE'),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
