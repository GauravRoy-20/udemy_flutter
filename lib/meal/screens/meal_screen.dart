import 'package:flutter/material.dart';
import 'package:udemy_flutter/meal/data/dummy_data.dart';
import 'package:udemy_flutter/meal/modals/category.dart';
import 'package:udemy_flutter/meal/modals/meal.dart';
import 'package:udemy_flutter/meal/screens/meals_item_screen.dart';
import 'package:udemy_flutter/meal/widgets/category_item.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({required this.availableMeals, super.key});
  final List<Meal> availableMeals;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
      lowerBound: 0,
      upperBound: 1,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    final filteredMeal = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(
            category.id,
          ),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsItemScreen(
          title: category.title,
          meals: filteredMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItem(
              category: category,
              onSelectCategory: () {
                selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (ctx, child) {
        return FadeTransition(
          opacity: animationController.drive(
            Tween(
              begin: 0.0,
              end: 1.0,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
