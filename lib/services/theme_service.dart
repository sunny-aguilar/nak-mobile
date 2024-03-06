import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

/// Toggle Theme Mode Service
class ThemeService{
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox (bool isDarkMode) => _box.write(_key, isDarkMode);

  // returns bool status of 'isDarkMode'
  bool _loadThemeFromBox ()=> _box.read(_key) ?? false;

  // returns dark or light mode depending on bool value of 'isDarkMode'
  // FYI - getX allows you to get variables from other files without importing them
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  // called in HomeScreen to toggle light or dark mode
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}