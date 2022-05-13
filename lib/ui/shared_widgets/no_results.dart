import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    Key? key,
    this.emptyMessage,
    this.emptyImage,
  }) : super(key: key);

  final String? emptyMessage;
  final Widget? emptyImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            emptyImage ??
                Icon(
                  Icons.search_off_rounded,
                  size: 120,
                  color: context.colors.secondaryContainer,
                ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
              ),
              child: Text(
                emptyMessage ?? 'No Results',
                style: context.text.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
