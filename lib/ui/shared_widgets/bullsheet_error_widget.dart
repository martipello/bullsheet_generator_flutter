import 'package:flutter/material.dart';

import '../../api/models/api_response.dart';
import '../../extensions/build_context_extension.dart';
import 'rounded_button.dart';

class BullsheetErrorWidget extends StatelessWidget {
  BullsheetErrorWidget({
    Key? key,
    this.onTryAgain,
    this.showImage = false,
    this.error,
    this.errorMessage,
    this.retryLabel,
    this.textAlign,
  }) : super(key: key);

  final VoidCallback? onTryAgain;
  final ApiResponse? error;
  final TextAlign? textAlign;
  final String? errorMessage;
  final String? retryLabel;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showImage)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                child: Image.asset(
                  'assets/images/bullsheet_launcher.png',
                  width: 200,
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    errorMessage ?? 'Oops that\'s an error...',
                    style: context.text.bodyMedium,
                    textAlign: textAlign ?? TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            if (onTryAgain != null)
              RoundedButton(
                label: retryLabel ?? 'Try Again',
                isFilled: false,
                disableShadow: true,
                onPressed: onTryAgain,
              ),
          ],
        ),
      ),
    );
  }
}
