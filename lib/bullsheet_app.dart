import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';
import 'ui/dashboard.dart';

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
      home: _flavorBanner(
        child: Dashboard(),
        show: kDebugMode,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
