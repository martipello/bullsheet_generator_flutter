import 'package:flutter/material.dart';

import '../../api/models/job.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
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
                        job.title ?? '',
                        style: context.text.titleSmall,
                      ),
                      if (job.company?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${job.company}',
                            style: context.text.bodyMedium,
                          ),
                        ),
                      if (job.location?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${job.location}',
                            style: context.text.bodyMedium,
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
                              '${job.url}',
                              style: context.text.bodyMedium?.copyWith(
                                color: Colors.blue,
                              ),
                            ),
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
