import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const RecipeDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Título de la barra de aplicaciones
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl, fit: BoxFit.cover), // Imagen de la receta
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // TODO: Añadir botones para dar "like" y ver comentarios
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
