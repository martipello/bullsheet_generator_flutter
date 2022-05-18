import 'package:flutter/material.dart';

import '../../api/models/job.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/date_time_extension.dart';
import '../../services/launch_service.dart';
import '../shared_widgets/bullsheet_tile.dart';

typedef JobCallback = void Function(Job job);

class JobCard extends StatelessWidget {
  JobCard({required this.job, this.removeJob, Key? key}) : super(key: key);

  final _launchService = getIt.get<LaunchService>();

  final Job job;
  final JobCallback? removeJob;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dismissible(
          key: Key(job.hashCode.toString()),
          background: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Icon(
                  Icons.delete,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onDismissed: (direction) {
            removeJob?.call(job);
          },
          child: BullsheetTile(
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
                      Text(
                        job.title?.trim() ?? '',
                        style: context.text.titleSmall,
                        textAlign: TextAlign.start,
                      ),
                      if (job.company?.trim().isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${job.company?.trim()}',
                            style: context.text.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      if (job.location?.trim().isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${job.location?.trim()}',
                            style: context.text.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      if (job.url?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _launchService.launchEvent(job.url ?? '', context);
                            },
                            child: Text(
                              '${job.url?.trim()}',
                              style: context.text.bodyMedium?.copyWith(
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      if (job.datePosted?.trim().isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Posted: ${job.datePosted?.trim()}',
                            style: context.text.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      if (job.dateApplied != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Applied: ${job.dateApplied?.dateFormat().format(job.dateApplied ?? DateTime.now())}',
                            style: context.text.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
