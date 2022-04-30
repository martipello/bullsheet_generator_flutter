import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class BullsheetLoadingWidget extends StatelessWidget {
  const BullsheetLoadingWidget({
    Key? key,
    this.valueColor,
    this.width,
  }) : super(key: key);

  final Color? valueColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: width ?? 4.0,
      valueColor: valueColor != null
          ? AlwaysStoppedAnimation(
              valueColor,
            )
          : AlwaysStoppedAnimation(
              context.colors.secondary,
            ),
    );
  }
}
