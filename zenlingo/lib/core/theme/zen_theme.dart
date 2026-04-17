import 'package:flutter/material.dart';

class ZenTheme {
  static const Color accentRed = Color(0xFFBC002D);
  static const Color bgBlack = Color(0xFF0D0D0D);
  static const Color bgSurface = Color(0xFF1A1A1A);
  static const Color textPrimary = Color(0xFFF5F5F0);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color strokeCorrect = Color(0xFF4CAF50);
  static const Color strokeIncorrect = Color(0xFFE53935);
  static const Color heatmapMin = Color(0xFF2A1A1A);
  static const Color heatmapMax = accentRed;

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgBlack,
    colorScheme: const ColorScheme.dark(
      primary: accentRed,
      surface: bgSurface,
      onPrimary: Color(0xFFF5F5F0),
    ),
    fontFamily: 'NotoSansJP',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 16, height: 1.6),
      labelSmall: TextStyle(fontSize: 11, letterSpacing: 1.2, color: Color(0xFF8A8A8A)),
    ),
    cardTheme: const CardTheme(
      color: bgSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bgBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
        color: Color(0xFFF5F5F0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentRed,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        minimumSize: const Size(double.infinity, 52),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: bgSurface,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2A2A2A)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentRed),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
