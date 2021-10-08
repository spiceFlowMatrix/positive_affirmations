import 'package:flutter/material.dart';

class PositiveAffirmationsTheme {
  static Color highlightColor = Color.fromRGBO(25, 118, 210, 1);

  static ThemeData get theme {
    final themeData = ThemeData.light();

    final newTextTheme = themeData.textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
      decorationColor: Colors.black,
    );

    return themeData.copyWith(
      highlightColor: highlightColor,
      primaryColor: highlightColor,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontWeight: FontWeight.bold),
          primary: highlightColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      )),
      /* primaryTextTheme affects the appbar title text.
         Reference for working solution for fixing appbar title theme https://stackoverflow.com/a/52804265
       */
      primaryTextTheme: newTextTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.black,
          side: BorderSide(
            width: 1,
          ),
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      textTheme: newTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
