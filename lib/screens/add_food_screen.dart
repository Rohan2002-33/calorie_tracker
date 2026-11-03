import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/food_item.dart';
import '../services/food_image_service.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class _QuickPick {
  const _QuickPick(this.name, this.calories);

  final String name;
  final int calories;
}

/// Form page to add a food item. Pops with a [FoodItem] when saved.
class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  static const List<_QuickPick> _quickPicks = [
    _QuickPick('Apple', 95),
    _QuickPick('Banana', 105),
    _QuickPick('Boiled Egg', 78),
    _QuickPick('Rice (1 cup)', 205),
    _QuickPick('Chicken Curry', 240),
    _QuickPick('Dal (1 bowl)', 180),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _calorieController = TextEditingController();
  final FocusNode _calorieFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _calorieController.dispose();
    _calorieFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a food name';
    }
    return null;
  }

  String? _validateCalories(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter the calorie amount';
    }
    final int? calories = int.tryParse(text);
    if (calories == null) {
      return 'Enter a valid number';
    }
    if (calories <= 0) {
      return 'Calories must be greater than 0';
    }
    if (calories > kMaxCaloriesPerItem) {
      return 'Maximum allowed is $kMaxCaloriesPerItem kcal';
    }
    return null;
  }

  void _applyQuickPick(_QuickPick pick) {
    setState(() {
      _nameController.text = pick.name;
      _calorieController.text = pick.calories.toString();
    });
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final String name = _nameController.text.trim();
    final FoodItem item = FoodItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      calories: int.parse(_calorieController.text.trim()),
      addedAt: DateTime.now(),
      imageUrl: FoodImageService.getFoodImageUrl(name),
    );
    Navigator.of(context).pop(item);
  }

  Widget _buildFoodPrefix() {
    final String name = _nameController.text.trim();
    if (name.isEmpty) {
      return Icon(Icons.restaurant_rounded, color: AppTheme.textMuted(context));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 30,
          height: 30,
          child: Image.network(
            FoodImageService.getFoodImageUrl(name),
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                const Icon(Icons.restaurant_rounded, color: AppTheme.primary),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration({
    required String label,
    required String hint,
    Widget? prefixIcon,
    IconData? fallbackIcon,
    String? suffix,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color borderC = AppTheme.borderColor(context);
    final Color fillC = isDark ? AppTheme.darkInputFill : Colors.white;

    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppTheme.textMuted(context)),
      hintText: hint,
      hintStyle: TextStyle(
        color: AppTheme.textMuted(context).withValues(alpha: 0.6),
      ),
      prefixIcon:
          prefixIcon ??
          (fallbackIcon != null
              ? Icon(fallbackIcon, color: AppTheme.textMuted(context))
              : null),
      suffixText: suffix,
      counterText: '',
      filled: true,
      fillColor: fillC,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      enabledBorder: border(borderC),
      focusedBorder: border(AppTheme.primary, 1.6),
      errorBorder: border(AppTheme.danger),
      focusedErrorBorder: border(AppTheme.danger, 1.6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Food')),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What did you eat?',
                    style: TextStyle(
                      color: AppTheme.textDark(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enter the food name and its calories to log it.',
                    style: TextStyle(
                      color: AppTheme.textMuted(context),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    validator: _validateName,
                    maxLength: 40,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: AppTheme.textDark(context)),
                    onFieldSubmitted: (_) => _calorieFocus.requestFocus(),
                    decoration: _decoration(
                      label: 'Food Name',
                      hint: 'e.g. Grilled chicken',
                      prefixIcon: _buildFoodPrefix(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _calorieController,
                    focusNode: _calorieFocus,
                    validator: _validateCalories,
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: AppTheme.textDark(context)),
                    onFieldSubmitted: (_) => _submit(),
                    decoration: _decoration(
                      label: 'Calorie Amount (kcal)',
                      hint: 'e.g. 350',
                      fallbackIcon: Icons.local_fire_department_rounded,
                      suffix: 'kcal',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Quick add',
                    style: TextStyle(
                      color: AppTheme.textDark(context),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final _QuickPick pick in _quickPicks)
                        ActionChip(
                          label: Text(
                            '${pick.name} · ${pick.calories}',
                            style: TextStyle(
                              color: AppTheme.textDark(context),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: isDark
                              ? AppTheme.darkCard
                              : Colors.white,
                          side: BorderSide(
                            color: AppTheme.borderColor(context),
                          ),
                          onPressed: () => _applyQuickPick(pick),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Add to List'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
