import 'package:flutter/material.dart';
import 'package:smartcook/cards/usercard.dart';
import 'package:smartcook/cards/recipe_card.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Cargando...';
  String email = 'Cargando...';
  String profileImageUrl = 'https://via.placeholder.com/150';
  List<dynamic> myRecipes = [];
  bool _isLoading = true;
  bool _hasRecipes = false; // Nueva variable para manejar el estado de recetas

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      setState(() {
        email = user.email ?? 'email@ejemplo.com';
        profileImageUrl = user.userMetadata?['profile_image'] ??
            'https://via.placeholder.com/150';
      });

      // Cargar el nombre de usuario desde la tabla de perfiles
      final profileResponse = await Supabase.instance.client
          .from('profiles') // Reemplaza con el nombre de tu tabla de perfiles
          .select('username') // Selecciona el campo 'username'
          .eq('id', user.id) // Filtra por el ID del usuario
          .limit(1) // Limita a 1 resultado
          .single(); // Usa .single() para obtener el primer registro

      // Verifica si la consulta fue exitosa
      if (profileResponse != null) {
        setState(() {
          username = profileResponse['username'] ??
              'NombreUsuario'; // Accede directamente a los datos
        });
      } else {
        // Si no se encuentra el perfil, puedes manejarlo como prefieras
        setState(() {
          username = 'Usuario desconocido'; // Asigna un valor por defecto
        });
      }

      // Cargar recetas del usuario
      await _fetchUserRecipes(user.id);
    } else {
      _logout();
    }
  }

Future<void> _fetchUserRecipes() async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    // Si no hay usuario autenticado, maneja el logout
    _logout();
    return;
  }

  try {
    final response = await Supabase.instance.client
        .from('recipes') // Reemplaza con el nombre de tu tabla
        .select()
        .eq('user_id', user.id) // Filtra las recetas por el ID del usuario
        .execute(); // Aquí no deberías necesitar el .execute() en versiones futuras.

    // Verifica si hay datos y maneja el error
    if (response.error != null) {
      print('Error al cargar recetas: ${response.error!.message}');
      setState(() {
        myRecipes = [];
        _hasRecipes = false; // No hay recetas
      });
      return;
    }

    // Procesa los datos obtenidos
    if (response.data is List) {
      setState(() {
        myRecipes = (response.data as List).map((recipe) {
          return {
            'imageUrl': recipe['image'], // Campo 'image' de tu modelo
            'title': recipe['title'],
            'description': recipe['description'],
            'likes': recipe['likes'],
          };
        }).toList();
        _hasRecipes = myRecipes.isNotEmpty; // Verifica si hay recetas
      });
    } else {
      // Si no hay recetas
      setState(() {
        myRecipes = [];
        _hasRecipes = false; // No hay recetas
      });
    }
  } catch (e) {
    print('Error al cargar recetas: $e');
    setState(() {
      myRecipes = [];
      _hasRecipes = false; // No hay recetas
    });
  }


      // Procesa los datos obtenidos
      if (response.data != null && response.data is List) {
        setState(() {
          myRecipes = (response.data as List).map((recipe) {
            return {
              'imageUrl': recipe['image'], // Campo 'image' de tu modelo
              'title': recipe['title'],
              'description': recipe['description'],
              'likes': recipe['likes'],
            };
          }).toList();
          _hasRecipes = myRecipes.isNotEmpty; // Verifica si hay recetas
        });
      } else {
        // Si no hay recetas
        setState(() {
          myRecipes = [];
          _hasRecipes = false; // No hay recetas
        });
      }
    } catch (e) {
      print('Error al cargar recetas: $e');
      setState(() {
        myRecipes = [];
        _hasRecipes = false; // No hay recetas
      });
    }
  }

  void _logout() async {
    await Supabase.instance.client.auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  UserCard(
                    username: username,
                    email: email,
                    profileImageUrl: profileImageUrl,
                    onLogout: _logout,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Mis Recetas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: _hasRecipes
                        ? ListView.builder(
                            itemCount: myRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = myRecipes[index];
                              return RecipeCard(
                                imageUrl: recipe['imageUrl'],
                                title: recipe['title'],
                                description: recipe['description'],
                                likes: recipe['likes'],
                                onTap: () {
                                  // Navegar a los detalles de la receta
                                },
                                onLike: () {
                                  // Aquí puedes implementar la lógica para dar "like" a la receta
                                },
                                onComment: () {
                                  // Aquí puedes implementar la lógica para añadir un comentario
                                },
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                                'No hay recetas disponibles.')), // Mensaje cuando no hay recetas
                  ),
                ],
              ),
            ),
    );
  }
}
