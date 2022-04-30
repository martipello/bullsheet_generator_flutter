import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'bullsheet_app.dart';

// ignore: avoid_classes_with_only_static_members
class BullsheetAppWrapper {
  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final lightThemeString = await rootBundle.loadString('assets/themes/appainter_theme_light.json');
    final lightThemeJson = jsonDecode(lightThemeString);
    final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson)!;
    // final darkThemeString = await rootBundle.loadString('assets/themes/appainter_theme_dark.json');
    // final darkThemeJson = jsonDecode(darkThemeString);
    // final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;
    runApp(BullsheetApp(theme: lightTheme));
  }
}
