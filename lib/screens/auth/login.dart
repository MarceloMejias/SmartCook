import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4DA72E), // Fondo de color verde
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
                  fillColor: Colors.white,
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
                  fillColor: Colors.white,
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
                  // Lógica de login
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF4DA72E),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ), // Texto verde
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
