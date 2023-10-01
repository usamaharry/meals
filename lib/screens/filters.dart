import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filteresProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Gluten Free'),
              subtitle: const Text('Meals without gluten.'),
              value: filters[Filter.isGlutenFree]!,
              onChanged: (value) {
                ref
                    .read(filteresProvider.notifier)
                    .changeFilter(Filter.isGlutenFree, value);
              },
            ),
            SwitchListTile(
              title: const Text('Lactose Free'),
              subtitle: const Text('Meals without lactose.'),
              value: filters[Filter.isLactoseFree]!,
              onChanged: (value) {
                ref
                    .read(filteresProvider.notifier)
                    .changeFilter(Filter.isLactoseFree, value);
              },
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              subtitle: const Text('Vegetarian meals.'),
              value: filters[Filter.isVegetarian]!,
              onChanged: (value) {
                ref
                    .read(filteresProvider.notifier)
                    .changeFilter(Filter.isVegetarian, value);
              },
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              subtitle: const Text('Vegan meals.'),
              value: filters[Filter.isVegan]!,
              onChanged: (value) {
                ref
                    .read(filteresProvider.notifier)
                    .changeFilter(Filter.isVegan, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
