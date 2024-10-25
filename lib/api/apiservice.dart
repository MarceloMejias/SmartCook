import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl =
      'http://127.0.0.1:8000/api'; // Cambia por la URL de tu backend

  // Método para registrar un nuevo usuario
  Future<void> registerUser(
      String username, String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'name': name,
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
      String token = data['access'];

      // Guardar el token en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
    } else {
      throw Exception(
          'Error en el inicio de sesión: ${response.statusCode} - ${response.body}');
    }
  }

  // Método para crear una nueva receta
  Future<void> createRecipe(String token, String title, String description,
      List<String> ingredients) async {
    // Nota: `ingredients` ahora contiene los nombres o categorías en lugar de IDs.
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'ingredients':
            ingredients, // Aquí se envían los ingredientes por nombre
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la receta: ${response.body}');
    }
  }

  // Método para obtener todas las recetas
  Future<List<dynamic>> getRecipes(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('Token de autenticación no disponible');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/recipes/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
        'Authorization': 'Bearer $token',
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
        'Authorization': 'Bearer $token',
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
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload-image/'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      return data['url']; // Ajusta esto según la respuesta de tu API
    } else {
      throw Exception('Error al subir la imagen: ${response.statusCode}');
    }
  }

  // Método para obtener los ingredientes (ahora devuelve los ingredientes por nombre o categoría)
  Future<List<dynamic>> getIngredients() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('Token de autenticación no disponible');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/ingredients/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los ingredientes: ${response.body}');
    }
  }

  // Método para subir una receta
  Future<void> uploadRecipe(String token, String title, String description,
      File imageFile, List<String> ingredients, String category) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/recipes/'),
    );

    // Agregar los encabezados
    request.headers['Authorization'] = 'Bearer $token';

    // Agregar los campos directamente al request.fields
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['ingredients'] = jsonEncode(ingredients); // Convertir a JSON
    request.fields['category'] = category; // Agregar la categoría aquí

    // Agregar la imagen
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode != 201) {
      final responseData = await response.stream.bytesToString();
      throw Exception(
          'Error al guardar la receta: ${response.statusCode} - $responseData');
    }
  }
}
