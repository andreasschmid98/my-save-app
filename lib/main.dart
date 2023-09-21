import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/screens/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/dashboard/dashboard.dart';

void main() {
  runApp(const WeSaveApp());
}

class WeSaveApp extends StatelessWidget {
  const WeSaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectProvider>(
      create: (_) => ProjectProvider(),
      child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('de'),
            Locale('en'),
            Locale('es'),
            Locale('fr')
          ],
          theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.green,
              brightness: Brightness.light),
          home: const Home(),
          routes: {
            '/home': (context) => const Home(),
            '/dashboard': (context) => const Dashboard(),
          }),
    );
  }
}
