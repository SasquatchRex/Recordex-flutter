import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomePage/color.dart';



class General with ChangeNotifier{
  bool fullMenu = true;
  bool notification = false;

  void toggleMenu() {
    fullMenu =!fullMenu;
    notifyListeners();
  }

  void toggleNotification() {
    notification =!notification;
    notifyListeners();
  }

  // bool _isDark = true; // Default to dark mode
  //
  // bool get isDark => _isDark;
  //
  //
  //
  // void toggleDarkMode() {
  //   _isDark = !_isDark;
  //   notifyListeners(); // Notify listeners when the theme changes
  // }

  // dynamic get colors => _isDark ? AppColorsDark() : AppColorsLight();


}
//
// class ThemeColorsProvider extends ChangeNotifier {
//   AppColorsDark _dark = AppColorsDark();
//   AppColorsLight _light = AppColorsLight();
//   bool _isDark = false;
//
//   AppColorsDark get dark => _dark;
//   AppColorsLight get light => _light;
//
//   AppColorsDark get currentColors => _isDark ? _dark : _light;
//
//   void toggleTheme() {
//     _isDark = !_isDark;
//     notifyListeners();
//   }
// }

// Singleton Theme Manager
class AppColors extends ChangeNotifier {
  static final AppColors _instance = AppColors._internal();
  factory AppColors() => _instance;
  AppColors._internal();

  bool _isDark = true;

  bool get isDark => _isDark;
  dynamic get appColors => _isDark ? AppColorsDark() : AppColorsLight();

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}