import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/screens/home_screen.dart';
import 'package:calorie_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Theme System - Light & Dark Mode', () {
    test('AppTheme creates distinct light and dark ThemeData', () {
      final ThemeData light = AppTheme.light;
      final ThemeData dark = AppTheme.dark;

      expect(light.brightness, Brightness.light);
      expect(dark.brightness, Brightness.dark);
      expect(
        light.scaffoldBackgroundColor,
        isNot(equals(dark.scaffoldBackgroundColor)),
      );
      expect(light.cardColor, isNot(equals(dark.cardColor)));
    });

    testWidgets('Tapping theme toggle button in AppBar toggles theme mode', (
      tester,
    ) async {
      themeModeNotifier.value = ThemeMode.light;

      await tester.pumpWidget(
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeModeNotifier,
          builder: (context, mode, _) {
            return MaterialApp(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: mode,
              home: const HomeScreen(),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      final Finder toggleBtn = find.byIcon(Icons.dark_mode_rounded);
      expect(toggleBtn, findsOneWidget);

      await tester.tap(toggleBtn);
      await tester.pumpAndSettle();

      expect(themeModeNotifier.value, ThemeMode.dark);
      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.light_mode_rounded));
      await tester.pumpAndSettle();

      expect(themeModeNotifier.value, ThemeMode.light);
      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    });

    testWidgets('HomeScreen renders correctly in dark theme mode', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: const HomeScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Calorie Tracker'), findsOneWidget);
      expect(find.text('Total Calories'), findsOneWidget);
      expect(find.text('Daily Goal'), findsOneWidget);
      expect(find.text('Remaining Calories'), findsOneWidget);
      expect(find.text('No food added yet'), findsOneWidget);
    });
  });
}
