import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartcook/screens/auth/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Verifica si hay un usuario autenticado
      if (response.user != null) {
        // Guarda el token de acceso
        await _secureStorage.write(
            key: 'auth_token', value: response.session?.accessToken);

        // Si el login es exitoso, navega al homescreen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Si no hay usuario, muestra el mensaje de error
        _showInvalidCredentialsDialog(
            'Credenciales inválidas. Por favor, inténtalo de nuevo.');
      }
    } catch (e) {
      // Manejo de excepciones
      _showInvalidCredentialsDialog('Error de conexión');
    }
  }

  Future<void> _loginWithGoogle() async {
    // Implementa la lógica de login con Google aquí
  }

  Future<void> _loginWithApple() async {
    // Implementa la lógica de login con Apple aquí
  }

  void _showInvalidCredentialsDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Credenciales inválidas'),
          content: Text(message),
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

              // Campos de texto de email y contraseña
              _buildTextField(
                context,
                controller: _emailController,
                hintText: 'Ingresa tu email',
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

              // Botones para iniciar sesión con Google y Apple
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
    final Color backgroundColor = colorScheme.surfaceContainerHighest;
    final Color iconColor = colorScheme.onSurface;

    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
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
        color: iconColor,
        onPressed: onPressed,
      ),
    );
  }
}
