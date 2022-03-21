import 'package:flutter/material.dart';
import 'package:task_master/others/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.dark;
  Color selectedPrimaryColor = AppColors.primaryColors[0];

  setSelectedThemeMode(ThemeMode _themeMode) {
    selectedThemeMode = _themeMode;
    notifyListeners();
  }

  setSelectedPrimaryColor(Color _color) {
    selectedPrimaryColor = _color;
    notifyListeners();
  }
}
