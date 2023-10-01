import 'package:flutter/material.dart';

//local
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> meals;

  const CategoriesScreen({
    super.key,
    required this.meals,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void _onSelectCategory(BuildContext context, Category category) {
    final categoryMeals = widget.meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // final filteredMeals = categoryMeals.where((meal) {
    //   if (widget.filters[Filter.isGlutenFree] && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (widget.filters[Filter.isLactoseFree] && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (widget.filters[Filter.isVegetarian] && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (widget.filters[Filter.isVegan] && !meal.isVegan) return false;

    //   return true;
    // }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: categoryMeals,
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
