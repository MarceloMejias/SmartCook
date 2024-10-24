import 'package:flutter/material.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/screens/tabs/home.dart'; // Importa el nuevo archivo
import 'package:smartcook/colors.dart'; // Asegúrate de que este import esté presente

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
          seedColor: AppColors.primaryGreen, // Cambia Colors por AppColors
          brightness: Brightness.light,
        ),
      ).copyWith(
          // Aquí puedes agregar más configuraciones específicas del tema
          ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen, // Cambia Colors por AppColors
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
        '/home': (context) =>
            const HomeScreen(), // HomeScreen ahora está en otro archivo
      },
    );
  }
}
