import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../api/models/api_response.dart';
import '../../api/models/job.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/job_result_view_model.dart';
import '../archives/archive_page.dart';
import '../archives/archives_page.dart';
import '../dashboard.dart';
import '../shared_widgets/bullsheet_app_bar.dart';
import '../shared_widgets/bullsheet_error_widget.dart';
import '../shared_widgets/bullsheet_loading_widget.dart';
import '../shared_widgets/bullsheet_text_field.dart';
import '../shared_widgets/no_results.dart';
import 'job_card.dart';

class JobResultsPageArguments {
  JobResultsPageArguments(this.jobResultViewModel);

  final JobResultViewModel? jobResultViewModel;
}

class JobResultsPage extends StatefulWidget {
  static const route = 'JobResultPage';

  @override
  State<JobResultsPage> createState() => _JobResultsPageState();
}

class _JobResultsPageState extends State<JobResultsPage> {
  JobResultsPageArguments get jobSearchResultPageArguments => context.routeArguments as JobResultsPageArguments;
  final _titleTextController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      jobSearchResultPageArguments.jobResultViewModel?.getJobs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<Job>>>(
      stream: jobSearchResultPageArguments.jobResultViewModel?.jobListStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: BullsheetAppBar(
            label: 'RESULTS',
          ),
          body: _buildState(snapshot.data),
          floatingActionButton:
              snapshot.data?.status == Status.COMPLETED ? _buildFloatingActionButton() : const SizedBox(),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        final _archive = jobSearchResultPageArguments.jobResultViewModel?.archiveJobs();
        Navigator.of(context).popUntil(
              (route) => route.settings.name == Dashboard.route,
        );
        Navigator.of(context).pushNamed(
          ArchivesPage.route,
        );
        Navigator.of(context).pushNamed(
          ArchivePage.route,
          arguments: ArchivePageArguments(_archive?.id),
        );
      },
      child: const Icon(
        Icons.save,
      ),
    );
  }

  Widget _buildState(ApiResponse<List<Job>>? snapshot) {
    final _jobList = snapshot?.data ?? [];
    final status = snapshot?.status;
    switch (status) {
      case Status.COMPLETED:
        if (_jobList.isNotEmpty) {
          return _buildJobListView(_jobList);
        } else {
          return const NoResults(
            emptyMessage: 'No Jobs Found.',
          );
        }
      case Status.ERROR:
        return _buildErrorWidget(snapshot);
      default:
        return const Center(child: BullsheetLoadingWidget());
    }
  }

  Widget _buildErrorWidget(ApiResponse<List<Job>>? snapshot) {
    return RefreshIndicator(
      onRefresh: () async {
        jobSearchResultPageArguments.jobResultViewModel?.getJobs();
      },
      child: CustomScrollView(
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
          SliverFillRemaining(
            child: Center(
              child: BullsheetErrorWidget(
                errorMessage: snapshot?.message ?? 'All selected sites had errors.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobListView(List<Job> _jobList) {
    return RefreshIndicator(
      onRefresh: () async {
        jobSearchResultPageArguments.jobResultViewModel?.getJobs();
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: ReorderableSliverList(
              delegate: ReorderableSliverChildBuilderDelegate(
                (context, index) => _buildJobCard(_jobList[index]),
                childCount: _jobList.length,
              ),
              onReorder: (oldIndex, newIndex) {
                //TODO this is broken
                if (newIndex > oldIndex) newIndex--;
                jobSearchResultPageArguments.jobResultViewModel?.removeJob(
                  _jobList[oldIndex],
                );
                jobSearchResultPageArguments.jobResultViewModel?.insertJob(
                  _jobList[oldIndex],
                  newIndex,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return JobCard(
      key: Key(job.hashCode.toString()),
      job: job,
      removeJob: jobSearchResultPageArguments.jobResultViewModel?.removeJob,
    );
  }
}
