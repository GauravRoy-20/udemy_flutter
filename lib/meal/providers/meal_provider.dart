import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/meal/data/dummy_data.dart';

final mealProvider = Provider((ref) {
  return dummyMeals;
});
