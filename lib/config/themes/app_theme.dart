import 'package:flutter/material.dart';

enum AppTheme {
  lightAppTheme,
  darkAppTheme,
}

final appThemeData = {
  AppTheme.darkAppTheme: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyMedium: const TextStyle().copyWith(color: Colors.white),
      bodyLarge: const TextStyle().copyWith(color: Colors.yellowAccent),
    ),

  ),
  AppTheme.lightAppTheme: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyMedium: const TextStyle().copyWith(color: Colors.white),
      bodyLarge: const TextStyle().copyWith(color: Colors.black),
    ),
  ),
};
