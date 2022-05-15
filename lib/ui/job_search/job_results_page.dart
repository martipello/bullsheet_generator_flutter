import 'package:flutter/material.dart';

import '../../api/models/api_response.dart';
import '../../api/models/job.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/job_result_view_model.dart';
import '../shared_widgets/bullsheet_app_bar.dart';
import '../shared_widgets/bullsheet_error_widget.dart';
import '../shared_widgets/bullsheet_loading_widget.dart';
import '../shared_widgets/bullsheet_tile.dart';
import '../shared_widgets/no_results.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.save,
            ),
          ),
        );
      },
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
        return RefreshIndicator(
          onRefresh: () async {
            jobSearchResultPageArguments.jobResultViewModel?.getJobs();
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Center(
                  child: BullsheetErrorWidget(
                    errorMessage: snapshot?.message ?? 'All sites had errors.',
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return const Center(child: BullsheetLoadingWidget());
    }
  }

  Widget _buildJobListView(List<Job> _jobList) {
    //TODO this crashes too tired to see why sure its obvious, good night
    return RefreshIndicator(
      onRefresh: () async {
        jobSearchResultPageArguments.jobResultViewModel?.getJobs();
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverAnimatedList(
              itemBuilder: (context, index, animation) {
                return _buildJobCard(_jobList[index]);
              },
              initialItemCount: _jobList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return Dismissible(
      key: Key(job.hashCode.toString()),
      onDismissed: (direction) {
        jobSearchResultPageArguments.jobResultViewModel?.removeJob(job);
      },
      child: Column(
        children: [
          BullsheetTile(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(job.title ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }

}
