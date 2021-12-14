import 'package:flutter/material.dart';
import '../../constants/image/image_constants.dart';
import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';

class LanguageManager {
  static LanguageManager? _instance;

  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  final tmLocale = const Locale('en', 'TM');
  final ruLocale = const Locale('ru', 'RU');
  final enLocale = const Locale('en', 'US');

  Locale? _appLocale;
  int get defaultLocaleIndex => 0;
  Locale get appLocale => _appLocale ?? supportedLocales[defaultLocaleIndex];
  set appLocale(Locale locale) => _appLocale = locale;

  LanguageManager._init() {
    var language = LocaleManager.instance.getStringValue(PreferencesKeys.localeLanguage);
    var country = LocaleManager.instance.getStringValue(PreferencesKeys.localeCountry);

    if (language.isNotEmpty) {
      _appLocale = Locale(language, country);
    }
  }

  List<Locale> get supportedLocales => [enLocale, ruLocale, tmLocale];

  Map toDropdown() {
    var languageList = {};

    languageList[0] = 'English';
    languageList[1] = 'Русский';
    languageList[2] = 'Türkmençe';

    return languageList;
  }

  String getImagePath(String? code) {
    //I use country code instead of language code, so I need to lower it
    if(code != null) {
      code = code.toLowerCase();
    }

    var path = ImageConstants.instance.flagRu;
    switch(code) {
      case 'tm': path = ImageConstants.instance.flagTm; break;
      case 'us': path = ImageConstants.instance.flagEn; break;
    }

    return path;
  }
}
