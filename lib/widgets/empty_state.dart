import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Shown when no food has been added yet.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: isDark ? 0.20 : 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.restaurant_menu_rounded,
              size: 40,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No food added yet',
            style: TextStyle(
              color: AppTheme.textDark(context),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap "Add Food" to log your first meal of the day.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted(context), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
