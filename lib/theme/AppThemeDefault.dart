import 'package:flutter/material.dart';

class AppThemeDefault {
  final Color mColor1;
  final Color mColor2;
  final Color mColor3;
  final Color mColor4;

  const AppThemeDefault(
      {Color? mColor1, Color? mColor2, Color? mColor3, Color? mColor4})
      : mColor1 = mColor1 ?? Colors.black,
        mColor2 = mColor2 ?? Colors.black,
        mColor3 = mColor3 ?? Colors.black,
        mColor4 = mColor4 ?? Colors.black;
}

extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationTheme, AppThemeDefault> _appTheme = {};

  void addDefaultTheme(AppThemeDefault appTheme) {
    _appTheme[inputDecorationTheme] = appTheme;
  }

  static AppThemeDefault? empty;

  AppThemeDefault appDefault() {
    var appDefault = _appTheme[inputDecorationTheme];
    if (appDefault == null) {
      empty ??= const AppThemeDefault();
      appDefault = empty;
    }
    return appDefault!;
  }
}

AppThemeDefault appTheme(BuildContext context) =>
    Theme.of(context).appDefault();
