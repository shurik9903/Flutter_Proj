import 'package:flutter/material.dart';

import 'AppThemeDefault.dart';

class DarkTheme {
  ThemeData get theme => ThemeData.dark().copyWith()
    ..addDefaultTheme(
      const AppThemeDefault(
        mColor1: Color.fromARGB(255, 156, 156, 156),
        mColor2: Color.fromARGB(255, 91, 91, 91),
        mColor3: Color.fromARGB(255, 54, 54, 54),
        mColor4: Color.fromARGB(255, 41, 41, 41),
      ),
    );
}
