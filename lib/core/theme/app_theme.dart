import 'package:flutter/material.dart';

class AppTheme {
  static final Color kScaffoldBackgroundColor = const Color(0xFFF3F4F6);
  static final Color kWhiteColor = Colors.white;
  static final Color kBlackColor = Colors.black;
  static final Color kGreyColor = const Color(0xFF91A1Af);
  static final Color kLightBlue = const Color(0xFF1447E6);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kScaffoldBackgroundColor,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: kBlackColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: kGreyColor,
      textColor: kBlackColor,
      tileColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    ),
  );
}
