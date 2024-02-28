import 'package:flutter/material.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Cart',
      'hello': 'Hello, World!',
    },
    'ar': {
      'title': 'السلة',
      'hello': 'مرحبًا، العالم!',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get hello {
    return _localizedValues[locale.languageCode]!['hello']!;
  }
}
