import 'package:flutter/material.dart';
import 'package:smartcook/screens/widgets/recipe_card.dart';
import 'package:smartcook/screens/tabs/recipe_detail.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  Future<List<Map<String, String>>> _fetchRecipes() async {
    await Future.delayed(const Duration(seconds: 0)); // Simula una carga
    return [
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'title': 'Receta de Ejemplo 1',
        'description': 'Una breve descripción de la receta 1.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'title': 'Receta de Ejemplo 2',
        'description': 'Una breve descripción de la receta 2.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'title': 'Receta de Ejemplo 3',
        'description': 'Una breve descripción de la receta 3.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _fetchRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay recetas disponibles.'));
          }

          final recipes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Column(
                children: [
                  RecipeCard(
                    imageUrl: recipe['imageUrl']!,
                    title: recipe['title']!,
                    description: recipe['description']!,
                    onTap: () {
                      // Navegar a la pantalla de detalles de la receta
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            imageUrl: recipe['imageUrl']!,
                            title: recipe['title']!,
                            description: recipe['description']!,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
