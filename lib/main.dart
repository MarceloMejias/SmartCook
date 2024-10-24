import 'package:flutter/material.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/theme.dart';

void main() {
  runApp(const MainApp());
}

// Prepara las tabs

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Paleta de colores de la app
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const LoginPage(),
    );
  }
}
