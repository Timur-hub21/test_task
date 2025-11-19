import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;
  final Recipe recipe;

  const RecipeDetailScreen({
    required this.recipeId,
    required this.recipe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: recipe.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.text),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Ингредиенты (основа)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...recipe.ingredientsOne.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${ingredient.title}: ${ingredient.text}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Ингредиенты (дополнительно)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...recipe.ingredientsTwo.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${ingredient.title}: ${ingredient.text}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Энергетическая ценность',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 16,
              children: recipe.energy.map((e) => Chip(label: Text('${e.title}: ${e.text}'))).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Шаги приготовления',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...recipe.steps.asMap().entries.map((e) {
              final step = e.value;
              final index = e.key;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Шаг ${index + 1}: ${step.text}'),
                  if (step.image1?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: step.image1!,
                        placeholder: (context, url) =>
                            const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) =>
                            const SizedBox(height: 150, child: Center(child: Icon(Icons.error))),
                      ),
                    ),
                  if (step.image2?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: step.image2!,
                        placeholder: (context, url) =>
                            const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) =>
                            const SizedBox(height: 150, child: Center(child: Icon(Icons.error))),
                      ),
                    ),
                  const Divider(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
