import 'package:flutter/material.dart';
import 'package:smartcook/cards/usercard.dart';
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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        setState(() {
          email = user.email ?? 'email@ejemplo.com';
          profileImageUrl = user.userMetadata?['profile_image'] ??
              'https://via.placeholder.com/150';
        });

        // Carga las recetas del usuario
        final response = await Supabase.instance.client
            .from('recipes')
            .select()
            .eq('user_id', user.id);

        // Verifica si la consulta fue exitosa y procesa los datos
        myRecipes = response as List<dynamic>;

        // Si no hay recetas, establece un mensaje de error
        if (myRecipes.isEmpty) {
          _errorMessage = 'No tienes recetas disponibles.';
        }
      } else {
        _logout();
      }
    } catch (e) {
      print('Error al cargar el perfil: $e');
      _errorMessage = 'Error al cargar las recetas.';
    } finally {
      setState(() {
        _isLoading = false;
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
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  Expanded(
                    child: myRecipes.isEmpty
                        ? const Center(
                            child: Text('No hay recetas disponibles.'))
                        : ListView.builder(
                            itemCount: myRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = myRecipes[index];
                              return Card(
                                elevation: 2,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(recipe['title']),
                                  subtitle: Text(recipe['description']),
                                  leading: recipe['imageUrl'] != null
                                      ? Image.network(recipe['imageUrl'])
                                      : Image.network(
                                          'https://via.placeholder.com/150'), // Placeholder image
                                  onTap: () {
                                    // Navegar a los detalles de la receta
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
