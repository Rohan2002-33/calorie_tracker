import 'package:calorie_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp() => const MaterialApp(home: HomeScreen());

  testWidgets('Home shows title, goal and empty state', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Calorie Tracker'), findsOneWidget);
    expect(find.text('Total Calories'), findsOneWidget);
    expect(find.text('Daily Goal'), findsOneWidget);
    expect(find.text('Remaining Calories'), findsOneWidget);
    expect(find.text('2000'), findsNWidgets(2));
    expect(find.text('No food added yet'), findsOneWidget);
  });

  testWidgets('Empty form shows validation errors', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.text('Add Food'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add to List'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a food name'), findsOneWidget);
    expect(find.text('Please enter the calorie amount'), findsOneWidget);
  });

  testWidgets('Add then delete a food updates totals', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.tap(find.text('Add Food'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Rice');
    await tester.enterText(find.byType(TextFormField).last, '250');
    await tester.tap(find.text('Add to List'));
    await tester.pumpAndSettle();

    expect(find.text('Rice'), findsOneWidget);
    expect(find.text('250 kcal'), findsOneWidget);
    expect(find.text('1750'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Rice'), findsNothing);
    expect(find.text('2000'), findsNWidgets(2));
  });
}
