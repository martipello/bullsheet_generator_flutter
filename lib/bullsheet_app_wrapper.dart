import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'package:json_theme/json_theme.dart';
import 'package:path_provider/path_provider.dart';

import 'api/models/archive.dart';
import 'api/models/job.dart';
import 'bullsheet_app.dart';
import 'dependency_injection_container.dart' as di;

// ignore: avoid_classes_with_only_static_members
class BullsheetAppWrapper {
  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive
      ..registerAdapter<Job>(
        JobAdapter(),
      )
      ..registerAdapter<Archive>(
        ArchiveAdapter(),
      );
    final lightThemeString = await rootBundle.loadString(
      'assets/themes/appainter_theme_light.json',
    );
    final lightThemeJson = jsonDecode(
      lightThemeString,
    );
    final lightTheme = ThemeDecoder.decodeThemeData(
      lightThemeJson,
    )!;
    // final darkThemeString = await rootBundle.loadString('assets/themes/appainter_theme_dark.json');
    // final darkThemeJson = jsonDecode(darkThemeString);
    // final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;
    runApp(
      BullsheetApp(
        theme: lightTheme,
      ),
    );
  }
}
