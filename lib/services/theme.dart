import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Toggles the theme mode between light and dark
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify listeners when the theme changes
  }

  // Light theme configuration
  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 255, 255, 255),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
      ),
    );
  }

  // Dark theme configuration
  ThemeData _darkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ThemeData.dark().colorScheme.copyWith(
            secondary: Colors.black,
            surface: Colors.black,
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
    );
  }

  // Returns the current theme based on the mode
  ThemeData get currentTheme {
    return _isDarkMode ? _darkTheme() : _lightTheme();
  }
}
