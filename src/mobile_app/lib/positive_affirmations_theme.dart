import 'package:flutter/material.dart';

class PositiveAffirmationsTheme {
  static ThemeData get theme {
    final themeData = ThemeData.light();

    final newTextTheme = themeData.textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
      decorationColor: Colors.black,
    );

    return themeData.copyWith(
      highlightColor: Color.fromRGBO(25, 118, 210, 1),
      accentColor: Colors.red,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.red,
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textTheme: newTextTheme,
    );
  }
}
