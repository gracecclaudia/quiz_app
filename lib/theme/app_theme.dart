import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPink = Color(0xFFD88098);
  static const Color lightPink = Color(0xFFF2B8C1);
  static const Color darkGreen = Color(0xFF39511C);
  static const Color lightGreen = Color(0xFF65893C);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    primaryColor: primaryPink,
    cardColor: Colors.white,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPink,
      foregroundColor: darkGreen,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkGreen),
      bodyMedium: TextStyle(color: darkGreen),
      displayLarge: TextStyle(color: darkGreen),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryPink,
      secondary: darkGreen,
      surface: Colors.white,
      tertiary: lightPink,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: primaryPink,
    cardColor: const Color(0xFF1E1E1E),
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      displayLarge: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryPink,
      secondary: lightGreen,
      surface: Color(0xFF1E1E1E),
      tertiary: darkGreen,
    ),
  );
}