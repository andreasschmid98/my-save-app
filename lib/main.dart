import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_save_app/providers/locale_provider.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/providers/theme_provider.dart';
import 'package:my_save_app/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProjectProvider>(
      create: (_) => ProjectProvider(),
    ),
    ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
    ),
  ], child: const WeSaveApp()));
}

class WeSaveApp extends StatelessWidget {
  const WeSaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeProvider>().initialize();
    context.watch<ProjectProvider>().initialize();
    context.watch<LocaleProvider>().initialize();

    final theme = context.watch<ThemeProvider>().theme;
    final locale = context.watch<LocaleProvider>().locale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
        Locale('es'),
        Locale('fr')
      ],
      theme: theme,
      home: const Home(),
      routes: {
        '/home': (context) => const Home(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
