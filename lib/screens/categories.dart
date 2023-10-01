import 'package:flutter/material.dart';

//local
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onSelectFavourite;
  final Map<Filter, dynamic> filters;

  const CategoriesScreen({
    super.key,
    required this.onSelectFavourite,
    required this.filters,
  });

  void _onSelectCategory(BuildContext context, Category category) {
    final categoryMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    final filteredMeals = categoryMeals.where((meal) {
      if (filters[Filter.isGlutenFree] && !meal.isGlutenFree) return false;
      if (filters[Filter.isLactoseFree] && !meal.isLactoseFree) return false;
      if (filters[Filter.isVegetarian] && !meal.isVegetarian) return false;
      if (filters[Filter.isVegan] && !meal.isVegan) return false;

      return true;
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onSelectFavourite: onSelectFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        padding: const EdgeInsets.all(24),
        children: [
          ...availableCategories
              .map(
                (category) => CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _onSelectCategory(context, category);
                  },
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
