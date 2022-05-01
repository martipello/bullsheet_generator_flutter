import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/date_time_extension.dart';
import '../view_models/job_search_view_model.dart';
import 'shared_widgets/bottom_button_holder.dart';
import 'shared_widgets/bullsheet_app_bar.dart';
import 'shared_widgets/bullsheet_chip.dart';
import 'shared_widgets/bullsheet_date_time_field.dart';
import 'shared_widgets/bullsheet_post_code_text_field.dart';
import 'shared_widgets/bullsheet_text_field.dart';
import 'shared_widgets/chip_group.dart';
import 'shared_widgets/rounded_button.dart';

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
                constraints: BoxConstraints(
                  maxWidth: context.screenWidth * 0.9,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeroImage(),
                      _buildMediumMargin(),
                      _buildTitleText(),
                      _buildLargeMargin(),
                      _buildSubtitleText(),
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
                      _buildFromDate(
                        _jobSearchRequest?.fromDate,
                      ),
                      _buildMediumMargin(),
                      _buildEndDate(
                        _jobSearchRequest?.fromDate,
                        _jobSearchRequest?.toDate,
                      ),
                      _buildLargeMargin(),
                      _selectJobSources(),
                      _buildMediumMargin(),
                      _buildSourcesChipGroup(
                        _jobSearchRequest?.jobSource ?? BuiltList.of([]),
                      ),
                      _buildLargeMargin(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomButtonHolder(
        hasShadow: true,
        child: _buildContinueButton(),
      ),
    );
  }

  Widget _buildDistanceInMilesText(double? distance) {
    return Text('Distance in miles: ${distance ?? 0}');
  }

  Widget _selectJobSources() {
    return const Text('Select websites to pull jobs from.');
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

  Widget _buildTitleText() {
    return Text(
      'BULL SH*T SHEET',
      textAlign: TextAlign.center,
      style: context.text.titleLarge,
    );
  }

  Widget _buildSubtitleText() {
    return Text(
      'Welcome to the bull sh*t sheet generator, '
      'input some details below to get started.',
      textAlign: TextAlign.center,
      style: context.text.bodyLarge,
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
    DateTime? fromDate,
  ) {
    return _buildDateField(
      context,
      'FROM : ',
      fromDate ?? DateTime.now(),
      (date) {
        if (fromDate.removeTime() != date.removeTime()) {
          _jobSearchViewModel.setFromDate(date);
        }
      },
    );
  }

  Widget _buildEndDate(
    DateTime? fromDate,
    DateTime? toDate,
  ) {
    return _buildDateField(
      context,
      'TO : ',
      toDate ?? DateTime.now(),
      (date) {
        if (toDate.removeTime() != date.removeTime()) {
          _jobSearchViewModel.setToDate(date);
        }
      },
      limitStart: fromDate,
    );
  }

  Widget _buildDateField(
    BuildContext context,
    String label,
    DateTime date,
    DateCallback dateCallback, {
    DateTime? limitStart,
  }) {
    final screenMeasure = (context.screenWidth / 5) * 3;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            label,
            style: context.text.bodyMedium,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenMeasure,
            ),
            child: Container(
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
                limitStart: limitStart,
                dateFormat: date.dateFormat(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(
    double? distance,
  ) {
    return Slider(
      value: distance ?? 0,
      min: 0,
      max: 10,
      divisions: 5,
      thumbColor: context.colors.secondary,
      onChanged: _jobSearchViewModel.setDistanceInMiles,
    );
  }

  Widget _buildSourcesChipGroup(
    BuiltList<JobSource> selectedSources,
  ) {
    return ChipGroup(
      chips: JobSource.values
          .map(
            (p0) => BullsheetChip(
              chipType: ChipType.filter,
              label: p0.name,
              isSelected: selectedSources.any(
                (selectedSource) => selectedSource == p0,
              ),
              onSelected: (isSelected) {
                if (!isSelected) {
                  _jobSearchViewModel.removeJobSource(p0);
                } else {
                  _jobSearchViewModel.addJobSource(p0);
                }
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildContinueButton() {
    return RoundedButton(
      label: 'SUBMIT',
      textStyle: context.text.bodyMedium,
      onPressed: () {},
    );
  }
}
