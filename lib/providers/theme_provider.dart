import 'package:flutter/material.dart';
import 'package:shik_i_blisk/app/locator.dart';
import 'package:shik_i_blisk/caches/preferences.dart';

class ThemeProvider extends ChangeNotifier {
  Preferences preferences = locator<Preferences>();

  bool get darkTheme => preferences.darkMode();

  set darkTheme(bool value) {
    preferences.setDarkMode(value);
    notifyListeners();
  }
}
