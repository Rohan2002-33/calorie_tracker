/// A single food entry logged by the user.
class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.addedAt,
  });

  final String id;
  final String name;
  final int calories;
  final DateTime addedAt;
}