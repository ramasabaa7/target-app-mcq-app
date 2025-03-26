import 'package:dopamin/core/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchController extends GetxController {
  var isSwitched = false.obs;
  var title = 'تشغيل الوضع الليلي'.obs;
  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    if (!isSwitched.value) {
      title.value = 'تشغيل الوضع الليلي';
      Get.changeThemeMode(ThemeMode.light);
      box.write(MOOD, "1");
    } else {
      title.value = 'تشغيل الوضع النهاري';
      Get.changeThemeMode(ThemeMode.dark);
      box.write(MOOD, "2");
    }
  }
}
