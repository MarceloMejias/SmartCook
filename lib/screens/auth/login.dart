import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              _buildTextField(
                context,
                hintText: 'Ingresa tu usuario',
                isPassword: false,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto de contraseña
              _buildTextField(
                context,
                hintText: 'Contraseña',
                isPassword: true,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 30.0),

              // Botón de login
              ElevatedButton(
                onPressed: () {
                  // Simulación de autenticación y redirección
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
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

  Widget _buildTextField(BuildContext context,
      {required String hintText,
      required bool isPassword,
      required Color? fillColor}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor, // Color dinámico del campo
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(0.6), // Color del hint basado en el tema
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
