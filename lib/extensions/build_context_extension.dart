import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get scaleFactor => MediaQuery.of(this).textScaleFactor;

  NavigatorState get navigator => Navigator.of(this);

  MaterialLocalizations get materialLocale => MaterialLocalizations.of(this);

  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  dynamic get routeArguments => ModalRoute.of(this)?.settings.arguments;

  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}
