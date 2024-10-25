import 'package:flutter/material.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/screens/tabs/home.dart'; // Importa la pantalla de inicio
import 'package:smartcook/colors.dart'; // Importa la paleta de colores

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
