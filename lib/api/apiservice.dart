import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl =
      'http://127.0.0.1:8000/api'; // Cambia por la URL de tu backend

  // Método para registrar un nuevo usuario
  Future<void> registerUser(
      String username, String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'), // Cambia según tu URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'name': name, // Agrega el nombre
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error en el registro: ${response.body}');
    }
  }

  // Método para iniciar sesión
  Future<void> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data[
          'access']; // Asegúrate de que el nombre coincida con la respuesta de tu API

      // Guardar el token en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
    } else {
      throw Exception(
          'Error en el inicio de sesión: ${response.statusCode} - ${response.body}');
    }
  }

  // Método para obtener el progreso del usuario
  Future<List<dynamic>> getUserProgress(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user-progress/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el progreso: ${response.body}');
    }
  }

  // Método para crear una nueva receta
  Future<void> createRecipe(String token, String title, String description,
      List<int> ingredientIds) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'ingredients': ingredientIds,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la receta: ${response.body}');
    }
  }

  // Método para obtener todas las recetas
  Future<List<dynamic>> getRecipes(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipes/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener las recetas: ${response.body}');
    }
  }

  // Método para dar like a una receta
  Future<void> likeRecipe(String token, int recipeId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/$recipeId/like/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al dar like a la receta: ${response.body}');
    }
  }

  // Método para obtener las recetas favoritas
  Future<List<dynamic>> getFavoriteRecipes(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorite-recipes/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Error al obtener las recetas favoritas: ${response.body}');
    }
  }

  // Método para subir una imagen
  Future<String> uploadImage(String token, String imagePath) async {
    final response = await http.post(
      Uri.parse('$baseUrl/upload-image/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
      body: jsonEncode({
        'image': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    } else {
      throw Exception('Error al subir la imagen: ${response.body}');
    }
  }

  // Método para obtener los ingredientes
  Future<List<dynamic>> getIngredients(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ingredients/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Añade el token de autorización
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los ingredientes: ${response.body}');
    }
  }
}
