import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';
import 'shared_widgets/bullsheet_app_bar.dart';
import 'shared_widgets/bullsheet_date_time_field.dart';
import 'shared_widgets/bullsheet_post_code_text_field.dart';
import 'shared_widgets/bullsheet_text_field.dart';

class Dashboard extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final jobTitleTextController = TextEditingController();
  final postCodeTextController = TextEditingController();

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
      ),
    );
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
      (date) {},
    );
  }

  Widget _buildEndDate(
    BuildContext context,
  ) {
    return _buildDateField(
      context,
      'TO',
      DateTime.now(),
      (date) {},
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
            ),
          ),
        ],
      ),
    );
  }
}
