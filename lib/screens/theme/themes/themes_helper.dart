import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/theme/models/themes_enum.dart';

class ThemesHelper {
  static ThemeData getTheme(Themes theme) {
    switch (theme) {
      case Themes.amber:
        return ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.amber,
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.amber),
          cardTheme: CardThemeData(color: Colors.amber),
        );
      case Themes.pink:
        return ThemeData.dark().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.pinkAccent,
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.pinkAccent),
          cardTheme: CardThemeData(color: Colors.pinkAccent),
        );
      case Themes.red:
        return ThemeData.dark().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.red,
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.red),
          cardTheme: CardThemeData(color: Colors.red),
        );
      case Themes.defaultTheme:
        return ThemeData.light();
    }
  }
}
