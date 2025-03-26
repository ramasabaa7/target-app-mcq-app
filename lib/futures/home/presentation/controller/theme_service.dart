import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  Rx<ThemeMode> theme = ThemeMode.system.obs;

  void changeTheme(ThemeMode newTheme) {
    theme.value = newTheme;
    Get.changeThemeMode(newTheme);
  }
}
