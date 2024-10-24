import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap; // Callback para manejar el toque

  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap, // Añadir el parámetro onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Ejecutar el callback al tocar la tarjeta
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer, // Color de fondo
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
