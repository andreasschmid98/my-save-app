import 'package:flutter/material.dart';

class LocaleFactory {
  static Locale create(String locale) {
    switch (locale) {
      case 'es':
        return Locale(locale);
      case 'de':
        return Locale(locale);
      case 'fr':
        return Locale(locale);
      case 'en':
        return Locale(locale);
      default:
        return const Locale('en');
    }
  }
}
