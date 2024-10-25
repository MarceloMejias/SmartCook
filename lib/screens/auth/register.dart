import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartcook/screens/auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      // Registra al usuario en Supabase
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // Verifica si el registro fue exitoso
      if (response.user != null) {
        // Guarda el token de acceso
        await _secureStorage.write(
            key: 'auth_token', value: response.session?.accessToken);

        // Si el registro es exitoso, navega al homescreen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Si no hay usuario, muestra el mensaje de error
        _showAlertDialog('Error al registrarse', 'Inténtalo de nuevo.');
      }
    } catch (e) {
      // Manejo de excepciones
      _showAlertDialog('Error', 'Error de conexión');
    }
  }

  Future<void> _registerWithGoogle() async {
    // Implementa la lógica de registro con Google aquí
  }

  Future<void> _registerWithApple() async {
    // Implementa la lógica de registro con Apple aquí
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : const Color(0xFF4DA72E);
    final textFieldFillColor = isDarkMode ? Colors.grey[800] : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla anterior
          },
        ),
      ),
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

              // Campo de texto para el nombre
              _buildTextField(
                context,
                controller: _nameController,
                hintText: 'Ingresa tu nombre',
                isPassword: false,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto de usuario
              _buildTextField(
                context,
                controller: _usernameController,
                hintText: 'Ingresa tu usuario',
                isPassword: false,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto de correo electrónico
              _buildTextField(
                context,
                controller: _emailController,
                hintText: 'Ingresa tu correo electrónico',
                isPassword: false,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto de contraseña
              _buildTextField(
                context,
                controller: _passwordController,
                hintText: 'Contraseña',
                isPassword: true,
                fillColor: textFieldFillColor,
              ),
              const SizedBox(height: 30.0),

              // Botón de registro
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Registrarse'),
              ),

              const SizedBox(height: 20.0),

              // Botón para iniciar sesión
              TextButton(
                onPressed: _navigateToLogin,
                child: const Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // Botones para registrarse con Google y Apple
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Botón Google
                  _buildSocialButton(
                    icon: FontAwesomeIcons.google,
                    onPressed: _registerWithGoogle,
                  ),
                  const SizedBox(width: 30.0),

                  // Botón Apple
                  _buildSocialButton(
                    icon: FontAwesomeIcons.apple,
                    onPressed: _registerWithApple,
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

  Widget _buildSocialButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Color de fondo del círculo
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
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}
