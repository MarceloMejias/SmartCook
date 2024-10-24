import 'package:flutter/material.dart';
import 'package:smartcook/screens/tabs/plan.dart';
import 'package:smartcook/screens/tabs/profile.dart'; // Asegúrate de crear esta pantalla

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas asociadas a las tabs
  static final List<Widget> _screens = <Widget>[
    const PlanScreen(), // Pantalla de Plan de comidas
    ProfileScreen(), // Pantalla de Perfil
    // Agrega más pantallas según sea necesario
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex], // Muestra la pantalla seleccionada
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Plan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          // Añade más items según sea necesario
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
