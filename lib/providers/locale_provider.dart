import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_save_app/factories/locale_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? locale;
  bool initialized = false;

  void initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String localeAsString =
        sharedPreferences.getString('locale') ?? Platform.localeName;
    locale = LocaleFactory.create(localeAsString);
    initialized = true;
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', newLocale.languageCode);
    locale = newLocale;
    notifyListeners();
  }
}
