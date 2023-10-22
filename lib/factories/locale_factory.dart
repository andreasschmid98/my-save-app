import 'package:flutter/material.dart';

class LocaleFactory {
  static Locale create(String locale) {
    if (locale.contains('es')) {
      return const Locale('es');
    } else if (locale.contains('de')) {
      return const Locale('de');
    } else if (locale.contains('fr')) {
      return const Locale('fr');
    } else if (locale.contains('en')) {
      return const Locale('en');
    } else {
      return const Locale('en');
    }
  }
}
