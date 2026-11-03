import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small Card used for Total Calories, Daily Goal and Remaining Calories.
class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppTheme.cardBg(context),
      shape: AppTheme.cardShape(context),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.22 : 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppTheme.textMuted(context),
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$value',
                style: TextStyle(
                  color: AppTheme.textDark(context),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'kcal',
              style: TextStyle(
                color: AppTheme.textMuted(context),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
