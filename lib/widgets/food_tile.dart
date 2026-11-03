import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../utils/date_formatter.dart';

/// One food entry: real food photo, name, calories and a delete button.
class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.item, required this.onDelete});

  final FoodItem item;
  final VoidCallback onDelete;

  Widget _buildImageAvatar(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String initial = item.name.isNotEmpty
        ? item.name.substring(0, 1).toUpperCase()
        : '?';

    Widget fallback() {
      return Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: isDark ? 0.24 : 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          initial,
          style: TextStyle(
            color: isDark ? const Color(0xFF62D298) : AppTheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 46,
        height: 46,
        child: Image.network(
          item.effectiveImageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return fallback();
          },
          errorBuilder: (context, error, stackTrace) => fallback(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: AppTheme.cardBg(context),
      shape: AppTheme.cardShape(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
        child: Row(
          children: [
            _buildImageAvatar(context),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.textDark(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Added at ${DateFormatter.time(item.addedAt)}',
                    style: TextStyle(
                      color: AppTheme.textMuted(context),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${item.calories} kcal',
              style: TextStyle(
                color: isDark ? const Color(0xFF62D298) : AppTheme.primaryDark,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              tooltip: 'Delete ${item.name}',
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppTheme.danger,
            ),
          ],
        ),
      ),
    );
  }
}
