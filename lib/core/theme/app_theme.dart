import 'package:flutter/material.dart';

class AppTheme {
  static const cream = Color(0xFFF5EDD8);
  static const _ink = Color(0xFF1C1C1E);
  static const _darkBg = Color(0xFF1C1A16);
  static const _darkSurface = Color(0xFF2C2A22);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    colorScheme: const ColorScheme.light(
      primary: _ink,
      onPrimary: Colors.white,
      secondary: _ink,
      onSecondary: Colors.white,
      surface: Color.fromARGB(255, 206, 206, 206),
      onSurface: _ink,
      outline: Color(0xFFAAAAAA),
      error: Color(0xFFD32F2F),
      primaryContainer: Color(0xFFEDE0C8),
      onPrimaryContainer: _ink,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: cream,
      foregroundColor: _ink,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _ink, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD32F2F)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
      prefixIconColor: Color(0xFFAAAAAA),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 56),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _ink,
        side: const BorderSide(color: _ink),
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFEDE0C8),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFE0D5C0)),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: _ink),
      headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: _ink),
      headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: _ink),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, color: _ink),
      titleMedium: TextStyle(fontWeight: FontWeight.w600, color: _ink),
      bodyMedium: TextStyle(color: _ink),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkBg,
    colorScheme: const ColorScheme.dark(
      primary: cream,
      onPrimary: _ink,
      secondary: cream,
      onSecondary: _ink,
      surface: Color.fromARGB(255, 88, 84, 69),
      onSurface: Colors.white,
      outline: Color(0xFF666666),
      error: Color(0xFFEF9A9A),
      primaryContainer: Color(0xFF3C3830),
      onPrimaryContainer: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: _darkBg,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: cream, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFF888888)),
      prefixIconColor: Color(0xFF888888),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: cream,
        foregroundColor: _ink,
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 56),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cream,
        side: const BorderSide(color: cream),
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _darkSurface,
      indicatorColor: const Color(0xFF3C3830),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
