import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_save_app/factories/theme_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String? appBarIconPath;
  ThemeData? theme;
  bool initialized = false;

  void initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var systemMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    String? themeDataAsString = sharedPreferences.getString('theme');

    themeDataAsString ??= systemMode == Brightness.light ? 'light' : 'dark';

    theme = ThemeFactory.create(themeDataAsString);
    appBarIconPath = theme!.brightness == Brightness.dark
        ? 'assets/app/app_bar_icon_dark.png'
        : 'assets/app/app_bar_icon.png';
    notifyListeners();
    initialized = true;
  }

  Future<void> setTheme(ThemeData newTheme) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String themeMode =
        newTheme.brightness == Brightness.dark ? 'dark' : 'light';
    await sharedPreferences.setString('theme', themeMode);
    theme = newTheme;
    notifyListeners();
  }

  bool lightTheme() {
    return theme!.brightness == Brightness.light;
  }
}
