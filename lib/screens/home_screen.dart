import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../utils/date_formatter.dart';
import '../widgets/calorie_progress_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/food_tile.dart';
import '../widgets/summary_card.dart';
import 'add_food_screen.dart';

/// Main screen: date, calorie summary and the list of foods.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Local in-memory list. Data resets when the app restarts.
  final List<FoodItem> _foods = <FoodItem>[];

  int get _totalCalories =>
      _foods.fold<int>(0, (int sum, FoodItem item) => sum + item.calories);

  int get _remainingCalories => _totalCalories >= kDailyCalorieGoal
      ? 0
      : kDailyCalorieGoal - _totalCalories;

  Future<void> _openAddFood() async {
    final FoodItem? newItem = await Navigator.of(context).push<FoodItem>(
      MaterialPageRoute<FoodItem>(builder: (_) => const AddFoodScreen()),
    );
    if (newItem == null || !mounted) {
      return;
    }
    setState(() => _foods.insert(0, newItem));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${newItem.name} added'),
          duration: const Duration(milliseconds: 2000),
        ),
      );
  }

  void _deleteFood(int index) {
    final FoodItem removed = _foods[index];
    setState(() => _foods.removeAt(index));
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${removed.name} removed'),
          duration: const Duration(milliseconds: 2500),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: const Color(0xFFFFC857),
            onPressed: () {
              messenger.hideCurrentSnackBar();
              setState(() {
                _foods.insert(math.min(index, _foods.length), removed);
              });
            },
          ),
        ),
      );
  }

  Widget _buildHeader() {
    final int count = _foods.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TODAY',
          style: TextStyle(
            color: AppTheme.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          DateFormatter.fullDate(DateTime.now()),
          style: const TextStyle(
            color: AppTheme.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        CalorieProgressCard(
          total: _totalCalories,
          goal: kDailyCalorieGoal,
          remaining: _remainingCalories,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                label: 'Total Calories',
                value: _totalCalories,
                icon: Icons.local_fire_department_rounded,
                color: AppTheme.warning,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SummaryCard(
                label: 'Daily Goal',
                value: kDailyCalorieGoal,
                icon: Icons.flag_rounded,
                color: AppTheme.info,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SummaryCard(
                label: 'Remaining Calories',
                value: _remainingCalories,
                icon: Icons.track_changes_rounded,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Text(
              'Food List',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              count == 1 ? '1 item' : '$count items',
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kAppName)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddFood,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Food'),
      ),
      body: SafeArea(
        top: false,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          // Index 0 = header. Then either the empty state or the food rows.
          itemCount: _foods.isEmpty ? 2 : _foods.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildHeader();
            }
            if (_foods.isEmpty) {
              return const EmptyState();
            }
            final int foodIndex = index - 1;
            final FoodItem item = _foods[foodIndex];
            return FoodTile(
              key: ValueKey<String>(item.id),
              item: item,
              onDelete: () => _deleteFood(foodIndex),
            );
          },
        ),
      ),
    );
  }
}
