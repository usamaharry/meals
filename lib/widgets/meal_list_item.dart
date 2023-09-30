import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

//local
import 'package:meals/models/meal.dart';

class MealListItem extends StatelessWidget {
  final Meal meal;

  const MealListItem({
    super.key,
    required this.meal,
  });

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(
              meal.imageUrl,
            ),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              color: Colors.black54,
              child: Column(
                children: [
                  Text(
                    meal.title,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListItemTrait(
                        label: '${meal.duration} min',
                        icon: Icons.schedule,
                      ),
                      const SizedBox(width: 10),
                      ListItemTrait(
                        label: complexityText,
                        icon: Icons.work,
                      ),
                      const SizedBox(width: 10),
                      ListItemTrait(
                        label: affordabilityText,
                        icon: Icons.attach_money,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListItemTrait extends StatelessWidget {
  final String label;
  final IconData icon;

  const ListItemTrait({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        )
      ],
    );
  }
}
