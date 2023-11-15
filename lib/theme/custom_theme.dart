import 'package:flutter/material.dart';

import 'custom_theme_extension.dart';

class CustomTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.green,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        progressBarColor: Colors.grey[500],
        percentProgressColor: Colors.black,
      ),
    ],
  );
}
