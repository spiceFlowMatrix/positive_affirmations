import 'package:flutter/material.dart';

class PositiveAffirmationsTheme {
  static ThemeData get theme {
    return ThemeData.light().copyWith(
      highlightColor: Color.fromRGBO(25, 118, 210, 1),
      accentColor: Colors.red,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.red,
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
