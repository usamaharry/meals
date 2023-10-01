import 'package:flutter/material.dart';

//local
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onSelectFavourite;

  const MealDetailScreen({
    super.key,
    required this.meal,
    required this.onSelectFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              onSelectFavourite(meal);
            },
            icon: const Icon(
              Icons.star,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            ...meal.ingredients
                .map((i) => Text(
                      i,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ))
                .toList(),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            ...meal.steps
                .map((i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Text(
                        i,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
