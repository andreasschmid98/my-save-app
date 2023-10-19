import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_save_app/factories/theme_factory.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {

    final isLightTheme = context.watch<ThemeProvider>().lightTheme();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLightTheme ? IconButton(
        icon: const Icon(Icons.dark_mode), onPressed: () async {
        ThemeData theme = ThemeFactory.create('dark');
        await context.read<ThemeProvider>().setTheme(theme);
      },
      ) : IconButton(
        icon: const Icon(Icons.sunny), onPressed: () async {
        ThemeData theme = ThemeFactory.create('light');
        await context.read<ThemeProvider>().setTheme(theme);
      },
      )
    );
  }
}