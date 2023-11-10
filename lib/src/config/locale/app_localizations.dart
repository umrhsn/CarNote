import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' show json;
import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();
  late Map<String, String> _localizedStrings;
  late Map<String, List<String>> _localizedLists;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map<String, String>((key, value) => MapEntry(key, value.toString()));
    _localizedLists = jsonMap.map<String, List<String>>((key, value) {
      List<String> list = [];
      for (int index = 0; index < value.length; index++) {
        list.add(value[index].toString());
      }
      return MapEntry(key, list);
    });
  }

  String? translate(String key) => _localizedStrings[key];

  List<String>? translateList(String key) => _localizedLists[key];

  bool get isEnLocale => locale.languageCode == 'en';
}
