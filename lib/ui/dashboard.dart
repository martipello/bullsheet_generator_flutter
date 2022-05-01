import 'package:flutter/material.dart';

import '../api/models/job_search_request.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/date_time_extension.dart';
import '../view_models/job_search_view_model.dart';
import 'shared_widgets/bullsheet_app_bar.dart';
import 'shared_widgets/bullsheet_date_time_field.dart';
import 'shared_widgets/bullsheet_post_code_text_field.dart';
import 'shared_widgets/bullsheet_text_field.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _jobSearchViewModel = getIt.get<JobSearchViewModel>();

  final _formKey = GlobalKey<FormState>();

  final jobTitleTextController = TextEditingController();

  final postCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobTitleTextController.addListener(() {
      _jobSearchViewModel.setJobTitle(jobTitleTextController.text);
    });
    postCodeTextController.addListener(() {
      _jobSearchViewModel.setPostcode(postCodeTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: StreamBuilder<JobSearchRequest>(
          stream: _jobSearchViewModel.jobSearchStream,
          builder: (context, snapshot) {
            final _jobSearchRequest = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: context.screenWidth * 0.9),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeroImage(),
                        _buildMediumMargin(),
                        _buildTitleText(context),
                        _buildLargeMargin(),
                        _buildSubtitleText(context),
                        _buildLargeMargin(),
                        _buildJobTitleTextField(),
                        _buildMediumMargin(),
                        _buildPostCodeTextField(),
                        _buildLargeMargin(),
                        _buildDistanceInMilesText(
                          _jobSearchRequest?.distanceInMiles,
                        ),
                        _buildProgressBar(
                          _jobSearchRequest?.distanceInMiles,
                        ),
                        _buildMediumMargin(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFromDate(context),
                            _buildMediumMargin(),
                            _buildEndDate(context),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Text _buildDistanceInMilesText(double? distance) {
    return Text('Distance in miles: ${distance ?? 0}');
  }

  Widget _buildPostCodeTextField() {
    return BullsheetPostCodeTextField(
      textController: postCodeTextController,
      validator: (value) {
        if (value.isAPostCode) {
          return 'Please enter a post code.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildJobTitleTextField() {
    return BullsheetTextField(
      textController: jobTitleTextController,
      labelText: 'Job Title',
      isDense: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a job title.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildSubtitleText(BuildContext context) {
    return Text(
      'Welcome to the bull sh*t sheet generator, '
      'input some details below to get started.',
      textAlign: TextAlign.center,
      style: context.text.bodyLarge,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      'BULL SH*T SHEET',
      textAlign: TextAlign.center,
      style: context.text.titleLarge,
    );
  }

  Widget _buildLargeMargin() {
    return const SizedBox(
      height: 32,
      width: 32,
    );
  }

  Widget _buildMediumMargin() {
    return const SizedBox(
      height: 16,
      width: 16,
    );
  }

  Widget _buildHeroImage() {
    return Image.asset(
      'assets/images/bullsheet_launcher.png',
      height: 150,
      fit: BoxFit.contain,
    );
  }

  Widget _buildFromDate(
    BuildContext context,
  ) {
    return _buildDateField(
      context,
      'FROM',
      DateTime.now(),
      _jobSearchViewModel.setFromDate,
    );
  }

  Widget _buildEndDate(
    BuildContext context,
  ) {
    return _buildDateField(
      context,
      'TO',
      DateTime.now(),
      _jobSearchViewModel.setToDate,
    );
  }

  Widget _buildDateField(
    BuildContext context,
    String label,
    DateTime date,
    DateCallback dateCallback,
  ) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.text.bodyMedium,
          ),
          _buildMediumMargin(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: context.colors.primary,
              ),
            ),
            child: BullsheetDateTimeField(
              dateCallback: dateCallback,
              initialDateTime: date,
              showTimePicker: false,
              dateFormat: date.dateFormat(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double? distance) {
    return Slider(
      value: distance ?? 0,
      min: 0,
      max: 10,
      divisions: 5,
      thumbColor: context.colors.secondary,
      onChanged: _jobSearchViewModel.setDistanceInMiles,
    );
  }
}
