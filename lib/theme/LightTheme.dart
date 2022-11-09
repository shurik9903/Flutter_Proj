import 'package:flutter/material.dart';

import 'AppThemeDefault.dart';

class LightTheme {
  ThemeData get theme => ThemeData.light().copyWith()
    ..addDefaultTheme(
      const AppThemeDefault(
        mColor1: Color.fromARGB(255, 255, 255, 255),
        mColor2: Color.fromARGB(255, 231, 231, 231),
        mColor3: Color.fromARGB(255, 173, 173, 173),
        mColor4: Color.fromARGB(255, 97, 97, 97),
      ),
    );
}
