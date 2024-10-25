import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartcook/screens/auth/register.dart';
import 'package:smartcook/api/apiservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService _apiService = ApiService(); // Instancia de ApiService

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      await _apiService.loginUser(
          username, password); // Llamada a la API para el login
      // Si el login es exitoso, navega al homescreen
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      // Si hay un error, muestra el diálogo de credenciales inválidas
      _showInvalidCredentialsDialog();
    }
  }

  Future<void> _loginWithGoogle() async {
    // Implementa la lógica de login con Google
  }

  Future<void> _loginWithApple() async {
    // Implementa la lógica de login con Apple
  }

  void _showInvalidCredentialsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Credenciales inválidas'),
          content: const Text(
              'El usuario o la contraseña que ingresaste no son correctos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : const Color(0xFF4DA72E);
    final textFieldFillColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: backgroundColor,
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

              // Campos de texto de usuario y contraseña
              _buildTextField(
                context,
                controller: _usernameController,
                hintText: 'Ingresa tu usuario',
                isPassword: false,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                context,
                controller: _passwordController,
                hintText: 'Contraseña',
                isPassword: true,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 30.0),

              // Botón de login
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Iniciar Sesión'),
              ),

              const SizedBox(height: 20.0),

              // Botón para registrarse
              TextButton(
                onPressed: _navigateToRegister,
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // Botones para iniciar sesión con Google y Apple (dentro de su propio círculo)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildSocialButton(
                    icon: FontAwesomeIcons.google,
                    onPressed: _loginWithGoogle,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 30.0),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.apple,
                    onPressed: _loginWithApple,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required TextEditingController controller,
      required String hintText,
      required bool isPassword,
      required Color? fillColor}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
  }) {
    final Color backgroundColor = colorScheme.surfaceVariant;
    final Color iconColor = colorScheme.onSurface;

    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor, // Color del círculo basado en el tema
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon),
        iconSize: 30.0,
        color: iconColor, // Color del icono basado en el tema
        onPressed: onPressed,
      ),
    );
  }
}
