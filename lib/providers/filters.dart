import 'package:flutter_riverpod/flutter_riverpod.dart';

//local
import 'package:meals/providers/meals.dart';

enum Filter { isGlutenFree, isLactoseFree, isVegetarian, isVegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.isGlutenFree: false,
          Filter.isLactoseFree: false,
          Filter.isVegetarian: false,
          Filter.isVegan: false,
        });

  void changeFilters(Map<Filter, bool> newFilters) {
    state = newFilters;
  }

  void changeFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filteresProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filteresProvider);

  return meals.where((meal) {
    if (filters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filter.isVegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[Filter.isVegan]! && !meal.isVegan) return false;

    return true;
  }).toList();
});
