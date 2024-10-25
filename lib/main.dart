import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importar shared_preferences
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/screens/tabs/home.dart'; // Importa la pantalla de inicio
import 'package:smartcook/colors.dart'; // Importa la paleta de colores

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegúrate de inicializar los bindings

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token'); // Recupera el token JWT

  runApp(
      MainApp(isLoggedIn: token != null)); // Pasa el estado de inicio de sesión
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp(
      {super.key, required this.isLoggedIn}); // Constructor modificado

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.light,
        ),
      ).copyWith(
          // Aquí puedes agregar más configuraciones específicas del tema
          ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.dark,
        ),
      ).copyWith(
          // Configuraciones específicas del tema oscuro
          ),
      themeMode:
          ThemeMode.system, // Cambia automáticamente entre claro y oscuro
      initialRoute: '/',
      routes: {
        '/': (context) => isLoggedIn
            ? const HomeScreen()
            : const LoginPage(), // Usa el estado de inicio de sesión
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
