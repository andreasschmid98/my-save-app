import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_tracker_app/providers/project_provider.dart';
import 'package:savings_tracker_app/screens/home/home.dart';

import 'screens/dashboard/dashboard.dart';

void main(){
  runApp(WeSaveApp());
}

class WeSaveApp extends StatelessWidget {

  const WeSaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectProvider>(
      create: (_) => ProjectProvider(),
      child: MaterialApp(
            theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.green,
                brightness: Brightness.light),
            home: Home(),
            routes: {
              '/home': (context) => Home(),
              '/dashboard': (context) => Dashboard(),
            }),
    );
  }
}
