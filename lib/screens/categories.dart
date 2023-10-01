import 'package:flutter/material.dart';

//local
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onSelectFavourite;

  const CategoriesScreen({
    super.key,
    required this.onSelectFavourite,
  });

  void _onSelectCategory(BuildContext context, Category category) {
    final fileteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: fileteredMeals,
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
