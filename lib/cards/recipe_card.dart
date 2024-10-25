import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int likes; // Número de likes
  final VoidCallback onTap; // Callback para manejar el toque
  final VoidCallback onLike; // Callback para manejar el like
  final VoidCallback onComment; // Callback para manejar los comentarios

  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.onTap, // Añadir el parámetro onTap
    required this.onLike, // Callback para manejar el like
    required this.onComment, // Callback para manejar los comentarios
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLiked = false; // Estado para manejar si el usuario ha dado "like"

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Ejecutar el callback al tocar la tarjeta
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer, // Color de fondo
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                widget.imageUrl,
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
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Contador de likes
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked
                                  ? Colors.red
                                  : Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                              widget
                                  .onLike(); // Llamar al callback para manejar el like
                            },
                          ),
                          Text('${widget.likes + (isLiked ? 1 : 0)} likes'),
                        ],
                      ),
                      // Botón de comentar
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: widget
                            .onComment, // Ejecutar el callback de comentario
                      ),
                    ],
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
