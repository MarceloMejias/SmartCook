import 'package:flutter/material.dart';
import 'colors.dart'; // Importar la paleta de colores

class AppThemes {
  // Tema claro
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Activar Material 3
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentOrange,
      surface: AppColors.lightGray,
      background: AppColors.lightGray,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.darkGray,
      onBackground: AppColors.darkGray,
    ),
    scaffoldBackgroundColor: AppColors.lightGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkGray),
      bodyMedium: TextStyle(color: AppColors.darkGray),
      // Puedes agregar más estilos aquí
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // Personaliza otros componentes aquí según sea necesario
  );

  // Tema oscuro
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true, // Activar Material 3
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentOrange,
      surface: AppColors.darkGray,
      background: AppColors.darkGray,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.white,
      onBackground: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.darkGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      // Puedes agregar más estilos aquí
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // Personaliza otros componentes aquí según sea necesario
  );
}
