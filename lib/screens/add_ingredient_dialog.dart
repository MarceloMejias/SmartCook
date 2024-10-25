import 'package:flutter/material.dart';
import 'package:smartcook/ingredient_manager.dart';

class AddIngredientDialog extends StatelessWidget {
  final IngredientManager ingredientManager;

  const AddIngredientDialog({Key? key, required this.ingredientManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController ingredientController = TextEditingController();

    return AlertDialog(
      title: const Text('Añadir Ingrediente'),
      content: TextField(
        controller: ingredientController,
        decoration: const InputDecoration(labelText: 'Nombre del ingrediente'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final ingredientName = ingredientController.text;
            if (ingredientName.isNotEmpty) {
              ingredientManager
                  .addIngredient(ingredientName); // Añadir por nombre
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ingrediente añadido.')),
              );
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'El nombre del ingrediente no puede estar vacío.')),
              );
            }
          },
          child: const Text('Añadir'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
