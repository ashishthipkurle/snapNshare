import 'package:flutter/material.dart';

/// Lightweight style holder used during UI iteration. Named `AppStyles` to
/// avoid colliding with the small `AppTheme` helper defined in `lib/theme.dart`.
class AppStyles {
  AppStyles._();

  static const Color primary = Color(0xFF6C5CE7);

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        primaryColor: primary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primary,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
        ),
      );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primary,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}

