import 'package:flutter/material.dart';

/// App Theme Configuration
/// Provides light and dark theme configurations for the application
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light Theme - Premium design with purple accents
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF6750A4), // Deep purple
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFEADDFF),
        onPrimaryContainer: Color(0xFF21005D),
        secondary: Color(0xFF625B71),
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFE8DEF8),
        onSecondaryContainer: Color(0xFF1D192B),
        tertiary: Color(0xFF7D5260),
        onTertiary: Colors.white,
        error: Color(0xFFB3261E),
        onError: Colors.white,
        errorContainer: Color(0xFFF9DEDC),
        onErrorContainer: Color(0xFF410E0B),
        surface: Color(0xFFFEF7FF),
        onSurface: Color(0xFF1D1B20),
        surfaceContainerHighest: Color(0xFFE6E0E9),
        outline: Color(0xFF79747E),
        shadow: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFFFEF7FF),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xFFFEF7FF),
        foregroundColor: Color(0xFF1D1B20),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6750A4), width: 2),
        ),
      ),
    );
  }

  /// Dark Theme - Deep blacks with vibrant purple accents
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFD0BCFF), // Light purple for dark mode
        onPrimary: Color(0xFF381E72),
        primaryContainer: Color(0xFF4F378B),
        onPrimaryContainer: Color(0xFFEADDFF),
        secondary: Color(0xFFCCC2DC),
        onSecondary: Color(0xFF332D41),
        secondaryContainer: Color(0xFF4A4458),
        onSecondaryContainer: Color(0xFFE8DEF8),
        tertiary: Color(0xFFEFB8C8),
        onTertiary: Color(0xFF492532),
        error: Color(0xFFF2B8B5),
        onError: Color(0xFF601410),
        errorContainer: Color(0xFF8C1D18),
        onErrorContainer: Color(0xFFF9DEDC),
        surface: Color(0xFF141218), // Deep dark background
        onSurface: Color(0xFFE6E0E9),
        surfaceContainerHighest: Color(0xFF36343B),
        outline: Color(0xFF938F99),
        shadow: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFF141218),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xFF141218),
        foregroundColor: Color(0xFFE6E0E9),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1D1B20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: const Color(0xFFD0BCFF),
        foregroundColor: const Color(0xFF381E72),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD0BCFF), width: 2),
        ),
      ),
    );
  }
}
