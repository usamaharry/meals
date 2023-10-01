import 'package:flutter/material.dart';

enum Filter { isGlutenFree, isLactoseFree, isVegetarian, isVegan }

class FiltersScreen extends StatefulWidget {
  final Map<Filter, dynamic> filters;
  const FiltersScreen({
    super.key,
    required this.filters,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _isGlutenFree;
  bool? _isLactoseFree;
  bool? _isVegetarian;
  bool? _isVegan;

  @override
  void initState() {
    _isGlutenFree = widget.filters[Filter.isGlutenFree];
    _isLactoseFree = widget.filters[Filter.isLactoseFree];
    _isVegetarian = widget.filters[Filter.isVegetarian];
    _isVegan = widget.filters[Filter.isVegan];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.isGlutenFree: _isGlutenFree,
            Filter.isLactoseFree: _isLactoseFree,
            Filter.isVegetarian: _isVegetarian,
            Filter.isVegan: _isVegan,
          });

          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Gluten Free'),
              subtitle: const Text('Meals without gluten.'),
              value: _isGlutenFree!,
              onChanged: (value) => setState(() {
                _isGlutenFree = value;
              }),
            ),
            SwitchListTile(
              title: const Text('Lactose Free'),
              subtitle: const Text('Meals without lactose.'),
              value: _isLactoseFree!,
              onChanged: (value) => setState(() {
                _isLactoseFree = value;
              }),
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              subtitle: const Text('Vegetarian meals.'),
              value: _isVegetarian!,
              onChanged: (value) => setState(() {
                _isVegetarian = value;
              }),
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              subtitle: const Text('Vegan meals.'),
              value: _isVegan!,
              onChanged: (value) => setState(() {
                _isVegan = value;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
