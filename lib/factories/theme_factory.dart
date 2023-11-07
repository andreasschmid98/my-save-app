import 'package:flutter/material.dart';
import '../theme/custom_theme_extension.dart';

class ThemeFactory {
  static ThemeData create(String theme) {
    switch (theme) {
      case 'light':
        return ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
          brightness: Brightness.light,
          extensions: <ThemeExtension<dynamic>>[
            CustomThemeExtension(
                progressBarColor: Colors.grey[500],
                percentProgressColor: Colors.black),
          ],
        );

      case 'dark':
        return ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
          brightness: Brightness.dark,
          extensions: const <ThemeExtension<dynamic>>[
            CustomThemeExtension(
                progressBarColor: Colors.black,
                percentProgressColor: Color.fromRGBO(120, 221, 119, 1))
          ],
        );

      default:
        return ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
          brightness: Brightness.light,
          extensions: <ThemeExtension<dynamic>>[
            CustomThemeExtension(
                progressBarColor: Colors.grey[500],
                percentProgressColor: Colors.black)
          ],
        );
    }
  }
}
