import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class for saving theme preference on local device
class DarkThemePreference {
    static const THEME_STATUS = "THEMESTATUS";

    // enables/disables darkmode
    setDarkTheme(bool value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(THEME_STATUS, value);
    }

    // retrieves the saved bool whether darkmode is enabled or not
    Future<bool> getDarkTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(THEME_STATUS) ?? false;
    }
}

// model class for actually setting darkmode
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value){
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}