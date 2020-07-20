import 'package:flutter/material.dart';
import 'package:shik_i_blisk/app/locator.dart';
import 'package:shik_i_blisk/caches/preferences.dart';
import 'package:shik_i_blisk/enums/notifier_state.dart';
import 'package:shik_i_blisk/ui/setup/app_base_model.dart';

class LanguageProvider extends BaseModel {
  Preferences preferences;

  static String _language = 'en';

  Locale appLocale = Locale(_language);

  LanguageProvider() {
    init();
  }

  void init() {
    preferences = locator<Preferences>();
    language;
  }

  get language {
    setNotifier(NotifierState.Loading);
    _language = preferences.getLanguage();
    if (_language == null) {
      appLocale = null;
    } else {
      appLocale = Locale(_language);
    }
    setNotifier(NotifierState.Loaded);
  }

  void updateLanguage(String language) {
    setNotifier(NotifierState.Loading);
    preferences.setLanguage(language);

    switch (language) {
      case 'ru':
        appLocale = Locale(language);
        break;
      case 'uk':
        appLocale = Locale(language);
        break;
      case 'en':
        appLocale = Locale(language);
        break;
      default:
        appLocale = Locale('en');
        break;
    }
    setNotifier(NotifierState.Loaded);
  }
}
