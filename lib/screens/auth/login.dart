import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartcook/screens/tabs/plan.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar si el tema es oscuro
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Colores dinámicos basados en el tema
    final backgroundColor = isDarkMode
        ? Colors.black
        : const Color(0xFF4DA72E); // Verde en modo claro, negro en modo oscuro
    final textFieldFillColor = isDarkMode
        ? Colors.grey[800]
        : Colors.white; // Campo de texto oscuro o claro
    final buttonBackgroundColor =
        isDarkMode ? Colors.grey[700] : Colors.white; // Botón de login
    final buttonTextColor =
        isDarkMode ? Colors.white : const Color(0xFF4DA72E); // Texto del botón

    return Scaffold(
      backgroundColor: backgroundColor, // Fondo dinámico
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo SVG
              SvgPicture.asset(
                'assets/logo.svg',
                height: 130.0,
                width: 130.0,
              ),
              const SizedBox(height: 50.0),

              // Campo de texto de usuario
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldFillColor, // Color dinámico del campo
                  hintText: 'Ingresa tu usuario',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Bordes redondeados
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Campo de texto de contraseña
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldFillColor, // Color dinámico del campo
                  hintText: 'Contraseña',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Bordes redondeados
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Botón de login
              ElevatedButton(
                onPressed: () {
                  // Navega hacia PlanScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlanScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor, // Texto dinámico
                  backgroundColor: buttonBackgroundColor, // Fondo dinámico
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
