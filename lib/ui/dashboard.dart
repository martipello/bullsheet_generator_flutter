import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';
import 'archives/archive_page.dart';
import 'job_search/job_search_detail_page.dart';
import 'shared_widgets/bullsheet_app_bar.dart';
import 'shared_widgets/rounded_button.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const route = 'Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeroImage(),
                _buildTitleText(),
                _buildLargeMargin(),
                _buildSubtitleText(),
                _buildLargeMargin(),
                _buildNavigateToSearchButton(),
                _buildLargeMargin(),
                _buildNavigateToArchiveButton(),
                _buildLargeMargin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLargeMargin() {
    return const SizedBox(
      height: 32,
      width: 32,
    );
  }

  Widget _buildHeroImage() {
    return Image.asset(
      'assets/images/bullsheet_launcher.png',
      height: 150,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTitleText() {
    return Text(
      'BULL SH*T SHEET',
      textAlign: TextAlign.center,
      style: context.text.titleLarge,
    );
  }

  Widget _buildSubtitleText() {
    return Text(
      'Welcome to the bull sh*t sheet generator.',
      textAlign: TextAlign.center,
      style: context.text.bodyLarge,
    );
  }

  Widget _buildNavigateToArchiveButton() {
    return RoundedButton(
      label: 'ARCHIVES',
      textStyle: context.text.bodyMedium,
      onPressed: () async {
        Navigator.of(context).pushNamed(ArchivePage.route);
      },
    );
  }

  Widget _buildNavigateToSearchButton() {
    return RoundedButton(
      label: 'GENERATE BULLSH*T SHEET',
      textStyle: context.text.bodyMedium,
      onPressed: () async {
        Navigator.of(context).pushNamed(JobSearchDetailPage.route);
      },
    );
  }
}
