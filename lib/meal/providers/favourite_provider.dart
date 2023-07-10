import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/meal/modals/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool updateFavMeal(Meal meal) {
    final isFavMeal = state.contains(meal);
    if (isFavMeal) {
      state = state.where((mealItem) => mealItem.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
