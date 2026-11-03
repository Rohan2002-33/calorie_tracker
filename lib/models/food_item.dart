import '../services/food_image_service.dart';

/// A single food entry logged by the user.
class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.addedAt,
    this.imageUrl,
  });

  final String id;
  final String name;
  final int calories;
  final DateTime addedAt;
  final String? imageUrl;

  /// Returns the stored image URL or resolves it automatically from [name].
  String get effectiveImageUrl =>
      (imageUrl != null && imageUrl!.trim().isNotEmpty)
      ? imageUrl!
      : FoodImageService.getFoodImageUrl(name);
}
