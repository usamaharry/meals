import 'package:flutter/material.dart';

//local
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var _currentPageIndex = 0;
  Widget? screen;
  final List<Meal> _favouriteMeals = [];

  @override
  void initState() {
    screen = CategoriesScreen(
      onSelectFavourite: _onAddFavourite,
    );
    super.initState();
  }

  void _onAddFavourite(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screen = CategoriesScreen(
      onSelectFavourite: _onAddFavourite,
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
