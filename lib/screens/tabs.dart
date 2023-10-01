import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//local
import 'package:meals/providers/favourites.dart';
import 'package:meals/providers/filters.dart';
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

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  var _currentPageIndex = 0;
  Widget? screen;
  Map<Filter, dynamic> filters = kIntialFilters;

  @override
  void initState() {
    screen = CategoriesScreen(
      meals: ref.read(filteredMealsProvider),
    );
    super.initState();
  }

  void _onScreenSelectDrawer(String identifier) {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final meals = ref.watch(filteredMealsProvider);

    screen = CategoriesScreen(
      meals: meals,
    );
    if (_currentPageIndex == 1) {
      screen = MealsScreen(
        meals: favouriteMeals,
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
