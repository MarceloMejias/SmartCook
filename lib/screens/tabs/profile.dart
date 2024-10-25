import 'package:flutter/material.dart';
import 'package:smartcook/cards/recipe_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de recetas del usuario (puede ser dinámico o venir de una base de datos)
    final List<Map<String, String>> misRecetas = [
      {
        'titulo': 'Ensalada César',
        'descripcion': 'Una deliciosa ensalada con pollo.',
        'imageUrl': 'https://via.placeholder.com/150'
      },
      {
        'titulo': 'Pizza Margarita',
        'descripcion': 'Pizza clásica con albahaca y queso.',
        'imageUrl': 'https://via.placeholder.com/150'
      },
      {
        'titulo': 'Pasta Carbonara',
        'descripcion': 'Pasta con salsa cremosa y panceta.',
        'imageUrl': 'https://via.placeholder.com/150'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Información del perfil
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nombre del Usuario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Correo Electrónico: usuario@ejemplo.com',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Teléfono: +1234567890',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción para editar perfil
                },
                child: const Text('Editar Perfil'),
              ),
              const SizedBox(height: 20),

              // Sección de Mis Recetas
              const Text(
                'Mis Recetas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Lista de RecipeCard para las recetas del usuario
              ListView.builder(
                shrinkWrap:
                    true, // Hace que la lista se ajuste dentro del scroll padre
                physics:
                    const NeverScrollableScrollPhysics(), // Desactiva el scroll independiente
                itemCount: misRecetas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0), // Espaciado entre tarjetas
                    child: RecipeCard(
                      imageUrl: misRecetas[index]['imageUrl']!,
                      title: misRecetas[index]['titulo']!,
                      description: misRecetas[index]['descripcion']!,
                      onTap: () {
                        // Acción al tocar la receta, por ejemplo, abrir detalles
                        print(
                            'Receta seleccionada: ${misRecetas[index]['titulo']}');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
