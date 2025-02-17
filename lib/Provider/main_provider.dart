import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomePage/color.dart';



class General with ChangeNotifier{
  bool fullMenu = true;
  bool notification = false;
  int activeTileMenuIndex = 0;

  void toggleMenu() {
    fullMenu =!fullMenu;
    notifyListeners();
  }

  void ChangeActiveTileMenuIndex(int index){
    activeTileMenuIndex = index;
    notifyListeners();
  }

  void toggleNotification() {
    notification =!notification;
    notifyListeners();
  }



}


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