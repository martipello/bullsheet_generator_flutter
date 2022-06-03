import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../api/models/api_response.dart';
import '../../api/models/archive.dart';
import '../../api/models/job.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/archive_view_model.dart';
import '../job_search/job_card.dart';
import '../shared_widgets/bullsheet_app_bar.dart';
import '../shared_widgets/bullsheet_text_field.dart';

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
  final _titleTextController = TextEditingController();

  ArchivePageArguments get archivePageArguments =>
      context.routeArguments as ArchivePageArguments;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        _archiveViewModel
            .getArchiveForId(
              archivePageArguments.archiveModelId ?? '',
            )
            .then(
              (_archive) =>
                  _titleTextController.text = _archive?.name ?? 'New Job List',
            );
      },
    );
    addListener();
    super.initState();
  }

  void addListener() {
    _titleTextController.addListener(() {
      _archiveViewModel.archiveName = _titleTextController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: StreamBuilder<ApiResponse<Archive?>>(
        stream: _archiveViewModel.archiveStream,
        builder: (context, snapshot) {
          final _archive = snapshot.data?.data;
          final _jobList = _archive?.jobList ?? BuiltList.of([]);
          final _state = snapshot.data?.status;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: 32,
                  ),
                  child: BullsheetTextField(
                    textController: _titleTextController,
                    labelText: 'Title',
                    style: context.text.titleLarge,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                  bottom: 8,
                ),
                sliver: ReorderableSliverList(
                  delegate: ReorderableSliverChildBuilderDelegate(
                    (context, index) => _buildJobCard(_jobList[index]),
                    childCount: _jobList.length,
                  ),
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex--;
                    _archiveViewModel.moveJob(_jobList[oldIndex], newIndex);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _archiveViewModel.updateArchive();
        Navigator.of(context).pop(true);
      },
      child: const Icon(
        Icons.save,
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return JobCard(
      key: Key(job.hashCode.toString()),
      job: job,
      removeJob: _archiveViewModel.removeJob,
    );
  }
}
