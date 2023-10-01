import 'package:flutter/material.dart';

//local
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

final kIntialFilters = {
  Filter.isGlutenFree: false,
  Filter.isLactoseFree: false,
  Filter.isVegetarian: false,
  Filter.isVegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var _currentPageIndex = 0;
  Widget? screen;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, dynamic> filters = kIntialFilters;

  @override
  void initState() {
    screen = CategoriesScreen(
      onSelectFavourite: _onAddFavourite,
      filters: filters,
    );
    super.initState();
  }

  void _onAddFavourite(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    String message = "Meal removed from favourites";

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        message = "Meal added to favourites";
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }

  void _onScreenSelectDrawer(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final selectedFilters =
          await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FiltersScreen(
          filters: filters,
        ),
      ));

      setState(() {
        filters = selectedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screen = CategoriesScreen(
      onSelectFavourite: _onAddFavourite,
      filters: filters,
    );
    if (_currentPageIndex == 1) {
      screen = MealsScreen(
        meals: _favouriteMeals,
        onSelectFavourite: _onAddFavourite,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPageIndex == 0 ? 'Pick Your Category' : 'Favourites',
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _onScreenSelectDrawer,
      ),
      body: screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (value) => setState(() {
          _currentPageIndex = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Favourites',
          )
        ],
      ),
    );
  }
}
