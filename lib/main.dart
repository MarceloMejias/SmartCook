import 'package:flutter/material.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:smartcook/screens/tabs/home.dart'; // Importa la pantalla de inicio
import 'package:smartcook/colors.dart'; // Importa la paleta de colores
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Bindings necesarios para inicializar la app

  // Inicializa Supabase
  await Supabase.initialize(
    url: 'https://euhmwqyeoqxvdildhvfw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV1aG13cXllb3F4dmRpbGRodmZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk4ODg2MjcsImV4cCI6MjA0NTQ2NDYyN30.hLBmSmCh2uryeM4_G7DXrr_kBSOwlMANMlZEiyEEi8c',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
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
          // Configuraciones específicas del tema claro
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
        '/': (context) =>
            const _HomeWrapper(), // Envuelve la lógica de autenticación
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class _HomeWrapper extends StatelessWidget {
  const _HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Muestra un indicador de carga
        }

        if (snapshot.hasError || !snapshot.data!) {
          return const LoginPage(); // Si hay error o no está autenticado, muestra el login
        }

        return const HomeScreen(); // Si está autenticado, muestra la pantalla de inicio
      },
    );
  }

  Future<bool> _checkAuthentication() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? token =
        await storage.read(key: 'auth_token'); // Lee el token almacenado

    return token != null; // Retorna true si el token existe
  }
}
