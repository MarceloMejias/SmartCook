import 'package:flutter/material.dart';
import 'colors.dart'; // Importar la paleta de colores

class AppThemes {
  // Tema claro
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryGreen,
    hintColor: AppColors.lightGreen,
    scaffoldBackgroundColor: AppColors.lightGray,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentOrange,
      surface: AppColors.lightGray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkGray),
      bodyMedium: TextStyle(color: AppColors.darkGray),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryGreen,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Tema oscuro
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryGreen,
    hintColor: AppColors.lightGreen,
    scaffoldBackgroundColor: AppColors.darkGray,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentOrange,
      surface: AppColors.darkGray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryGreen,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
