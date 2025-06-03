import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDarkMode = false;
  bool getThemeValue() => _isDarkMode;

  void updateTheme({required bool value}) {
    _isDarkMode = value;
    notifyListeners();
  }
}