import 'package:flutter/material.dart';

import 'colors.dart';

abstract class TVSThemes {
  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: TVSColors.primaryColorDark,
  );
  static ThemeData light = ThemeData(
    primaryColor: TVSColors.primaryColorLight,
    primarySwatch: Colors.blue,
  );
}

enum AppTheme {
  dark,
  light,
}
