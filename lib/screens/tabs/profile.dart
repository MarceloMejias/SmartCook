import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcook/api/apiservice.dart';
import 'package:smartcook/cards/usercard.dart';
import 'package:smartcook/screens/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Inicializamos las variables con valores predeterminados
  String username = 'Cargando...';
  String email = 'Cargando...';
  String profileImageUrl = 'https://via.placeholder.com/150';
  List<dynamic> myRecipes = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token != null) {
      try {
        // Llama a la API para obtener los datos del perfil
        final apiService = ApiService();
        final recipes = await apiService.getRecipes(token);
        // Aquí deberías obtener el nombre, email y otros datos del usuario de la API

        setState(() {
          username = 'NombreUsuario'; // Esto debe obtenerse de la API
          email = 'email@ejemplo.com'; // Esto debe obtenerse de la API
          profileImageUrl =
              'https://via.placeholder.com/150'; // Debe obtenerse de la API
          myRecipes = recipes;
          _isLoading = false;
        });
      } catch (e) {
        print('Error al cargar el perfil: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    // Redirigir al usuario a la pantalla de login
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
                    child: ListView.builder(
                      itemCount: myRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = myRecipes[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(recipe['title']),
                            subtitle: Text(recipe['description']),
                            leading: Image.network(recipe['imageUrl']),
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
