# Calorie Tracker

A Flutter app to log meals, track daily calorie intake and see how many calories are left for the day.

Built for the Module 19 assignment (Complete app development with Claude).

## Features
- Home screen with app name, today's date and a daily progress card
- Calorie summary cards: Total Calories, Daily Goal (2,000 kcal) and Remaining Calories
- Add Food screen with validation (name required, calories must be a positive number)
- Food list built with `ListView.builder`, with a delete button and undo
- Totals update automatically when items are added or deleted
- Data is kept in a local in-memory `List`. It resets when the app restarts.
- No database, no API, no Firebase

## Project structure
```
lib/
  main.dart
  models/    food_item.dart
  screens/   splash_screen.dart, home_screen.dart, add_food_screen.dart
  widgets/   calorie_progress_card.dart, summary_card.dart, food_tile.dart, empty_state.dart
  theme/     app_theme.dart
  utils/     constants.dart, date_formatter.dart
```

## Run
```bash
flutter pub get
flutter run
```

## Test
```bash
flutter test
```