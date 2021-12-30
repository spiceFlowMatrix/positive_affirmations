import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color.fromRGBO(250, 250, 250, 1);
  static const primaryColorLight = Color.fromRGBO(255, 255, 255, 1);
  static const primaryColorDark = Color.fromRGBO(199, 199, 199, 1);
  static const secondaryColor = Color.fromRGBO(25, 118, 210, 1);
  static const secondaryColorLight = Color.fromRGBO(99, 164, 255, 1);
  static const secondaryColorDark = Color.fromRGBO(0, 75, 160, 1);
  static const errorColor = Colors.red;

  static ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      primaryVariant: primaryColorDark,
      secondaryVariant: secondaryColorDark,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      background: primaryColorDark,
      onBackground: Colors.black,
      surface: primaryColor,
      onSurface: Colors.black,
      onError: Colors.black,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(circularTrackColor: secondaryColor),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 9,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 9,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: secondaryColor,
        onPrimary: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: secondaryColor,
          width: 2,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: secondaryColor,
        ),
      ),
    ),
  );
}
