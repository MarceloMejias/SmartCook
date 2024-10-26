import 'package:flutter/material.dart';
import 'package:smartcook/cards/recipe_card.dart';
import 'package:smartcook/screens/tabs/recipe_detail.dart';
import 'package:smartcook/screens/add_recipe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  // Método para hacer la solicitud a la API de Supabase y obtener las recetas
  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    try {
      final response = await Supabase.instance.client
          .from('recipes') // Reemplaza con el nombre de tu tabla
          .select(); // Selecciona todos los campos

      // Procesa los datos obtenidos
      final List<dynamic> recipes = response;

      return recipes.map((recipe) {
        return {
          'imageUrl': recipe[
              'image'], // TODO: Revisar si el campo de la imagen es correcto
          'title': recipe['title'],
          'description': recipe['description'],
          'likes': recipe['likes'], // Añade el número de likes
        };
      }).toList();
    } catch (e) {
      // Manejo de errores
      print('Error al obtener recetas: $e');
      rethrow; // Lanza la excepción original
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
                    imageUrl: recipe['imageUrl'], // Imagen de la receta
                    title: recipe['title'], // Título de la receta
                    description: recipe['description'], // Descripción
                    likes: recipe['likes'], // Número de likes
                    onTap: () {
                      // Navegar a la pantalla de detalles de la receta
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            imageUrl: recipe['imageUrl'],
                            title: recipe['title'],
                            description: recipe['description'],
                          ),
                        ),
                      );
                    },
                    onLike: () {
                      // Lógica para dar "like" a la receta
                    },
                    onComment: () {
                      // Lógica para ver los comentarios de la receta
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
          );
        },
        label: const Text('Añadir Receta'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
