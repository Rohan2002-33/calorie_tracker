import 'package:flutter/material.dart';

/// Central place for colors and the Material 3 light and dark themes.
class AppTheme {
  AppTheme._();

  // Brand & Accent Colors
  static const Color primary = Color(0xFF1F8A5B);
  static const Color primaryLight = Color(0xFF28A76B);
  static const Color primaryDark = Color(0xFF14694A);
  static const Color danger = Color(0xFFD64545);
  static const Color warning = Color(0xFFE08A1E);
  static const Color info = Color(0xFF2F6FDE);

  // Light Palette
  static const Color lightBackground = Color(0xFFF4F7F5);
  static const Color lightCard = Colors.white;
  static const Color lightTextDark = Color(0xFF14231C);
  static const Color lightTextMuted = Color(0xFF6B7A72);
  static const Color lightBorder = Color(0xFFE2E8E4);

  // Dark Palette
  static const Color darkBackground = Color(0xFF111714);
  static const Color darkCard = Color(0xFF1B231F);
  static const Color darkTextPrimary = Color(0xFFEDF5F1);
  static const Color darkTextMuted = Color(0xFF90A199);
  static const Color darkBorder = Color(0xFF28362F);
  static const Color darkInputFill = Color(0xFF161E1A);

  // Static constants preserved for backward compatibility
  static const Color background = lightBackground;
  static const Color textDarkStatic = lightTextDark;
  static const Color textMutedStatic = lightTextMuted;
  static const Color border = lightBorder;

  // Adaptive Color Helpers
  static Color textDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextPrimary
      : lightTextDark;

  static Color textMuted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextMuted
      : lightTextMuted;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBorder
      : lightBorder;

  static Color cardBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;

  /// Adaptive rounded outline used by cards.
  static RoundedRectangleBorder cardShape([BuildContext? context]) {
    final Color borderC = context != null ? borderColor(context) : lightBorder;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: borderC),
    );
  }

  /// Light Theme
  // Dark Palette
  static const Color darkBackground = Color(0xFF111714);
  static const Color darkCard = Color(0xFF1B231F);
  static const Color darkTextPrimary = Color(0xFFEDF5F1);
  static const Color darkTextMuted = Color(0xFF90A199);
  static const Color darkBorder = Color(0xFF28362F);
  static const Color darkInputFill = Color(0xFF161E1A);

  // Static constants preserved for backward compatibility
  static const Color background = lightBackground;
  static const Color textDarkStatic = lightTextDark;
  static const Color textMutedStatic = lightTextMuted;
  static const Color border = lightBorder;

  // Adaptive Color Helpers
  static Color textDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextPrimary
          : lightTextDark;

  static Color textMuted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextMuted
          : lightTextMuted;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBorder
          : lightBorder;

  static Color cardBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkCard
          : lightCard;

  /// Adaptive rounded outline used by cards.
  static RoundedRectangleBorder cardShape([BuildContext? context]) {
    final Color borderC = context != null
        ? borderColor(context)
        : lightBorder;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: borderC),
    );
  }

  /// Light Theme
  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(primary: primary, surface: lightCard);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: lightTextDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: lightTextDark),
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

  /// Dark Theme
  static ThemeData get dark {
    final ColorScheme scheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: primaryLight,
          surface: darkCard,
          onSurface: darkTextPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF26332C),
        contentTextStyle: const TextStyle(color: darkTextPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Dark Theme
  static ThemeData get dark {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primaryLight,
      surface: darkCard,
      onSurface: darkTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF26332C),
        contentTextStyle: const TextStyle(color: darkTextPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
