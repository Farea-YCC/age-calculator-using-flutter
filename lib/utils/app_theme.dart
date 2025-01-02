
import 'package:flutter/material.dart';

import 'const.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kContentColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kContentColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: AppColors.kTextAndIconColor, fontSize: 20),
      iconTheme: IconThemeData(color: AppColors.kTextAndIconColor),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.kContentColor,
      scrimColor: Colors.black.withOpacity(0.5), // Optional, darkening behind drawer
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.kContentColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.kTextAndIconColor),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.kTextAndIconColor, fontSize: 14),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kTextAndIconColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kTextAndIconColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: AppColors.kContentColor, fontSize: 20),
      iconTheme: IconThemeData(color: AppColors.kContentColor),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.kTextAndIconColor,
      scrimColor: Colors.black.withOpacity(0.5), // Optional, darkening behind drawer
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.kTextAndIconColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.kContentColor),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.kContentColor, fontSize: 14),
    ),
  );
}
