import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/meal/providers/favourite_provider.dart';
import 'package:udemy_flutter/meal/screens/filter_screen.dart';
import 'package:udemy_flutter/meal/screens/meal_screen.dart';
import 'package:udemy_flutter/meal/screens/meals_item_screen.dart';
import 'package:udemy_flutter/meal/widgets/main_drawer.dart';
import 'package:udemy_flutter/meal/providers/filter_provider.dart';

const initialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     final availableMeals = ref.watch(filterMealsProvider);
    Widget activePage = MealScreen(
      availableMeals: availableMeals,
    );
    var activeTitle = "Categories";
    if (selectedPageIndex == 1) {
      final favMeals = ref.watch(favouriteMealsProvider);
      activeTitle = "Your Favourite";
      activePage = MealsItemScreen(
        meals: favMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activeTitle,
        ),
      ),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
        ],
        onTap: selectPage,
        currentIndex: selectedPageIndex,
      ),
    );
  }
}
