import 'package:flutter/material.dart';

import 'flavors.dart';
import 'ui/archives/archive_page.dart';
import 'ui/dashboard.dart';
import 'ui/job_search/job_search_detail_page.dart';

class BullsheetApp extends StatefulWidget {
  const BullsheetApp({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<BullsheetApp> createState() => _BullsheetAppState();
}

class _BullsheetAppState extends State<BullsheetApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: widget.theme,
      routes: {
        Dashboard.route: (_) => const Dashboard(),
        JobSearchDetailPage.route: (_) => const JobSearchDetailPage(),
        ArchivePage.route: (_) => const ArchivePage(),
      },
      initialRoute: Dashboard.route,
    );
  }
}
