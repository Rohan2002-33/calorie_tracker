import 'package:flutter/material.dart';

/// Central place for colors and the Material 3 theme.
class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF1F8A5B);
  static const Color primaryDark = Color(0xFF14694A);
  static const Color background = Color(0xFFF4F7F5);
  static const Color textDark = Color(0xFF14231C);
  static const Color textMuted = Color(0xFF6B7A72);
  static const Color border = Color(0xFFE2E8E4);
  static const Color danger = Color(0xFFD64545);
  static const Color warning = Color(0xFFE08A1E);
  static const Color info = Color(0xFF2F6FDE);

  /// Shared rounded outline used by white cards.
  static final RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: const BorderSide(color: border),
  );

  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: primary)
        .copyWith(primary: primary, surface: Colors.white);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: textDark),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
