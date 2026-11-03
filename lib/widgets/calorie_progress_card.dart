import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Hero card showing overall progress toward the daily goal.
class CalorieProgressCard extends StatelessWidget {
  const CalorieProgressCard({
    super.key,
    required this.total,
    required this.goal,
    required this.remaining,
  });

  final int total;
  final int goal;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    final double progress = goal == 0
        ? 0.0
        : (total / goal).clamp(0.0, 1.0).toDouble();
    final bool exceeded = total > goal;

    final String status;
    if (exceeded) {
      status = 'Over goal by ${total - goal} kcal';
    } else if (remaining == 0) {
      status = 'Daily goal reached';
    } else {
      status = '$remaining kcal left';
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 9,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          exceeded ? const Color(0xFFFFC857) : Colors.white,
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Daily progress',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$total / $goal kcal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
