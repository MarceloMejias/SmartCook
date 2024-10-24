import 'package:flutter/material.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/screens/tabs/home.dart'; // Importa el nuevo archivo
import 'package:smartcook/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Habilitar Material 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true, // Habilitar Material 3 en modo oscuro
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
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
