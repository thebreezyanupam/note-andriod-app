import 'package:anecnote/themes/theme.dart';
import 'package:flutter/material.dart';



class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData ==darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      // Switch to dark mode and set dark mode icon
      themeData = darkMode;
    } else {
      // Switch to light mode and set light mode icon
      themeData = lightMode;
    }
  }

}
