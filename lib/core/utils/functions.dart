import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

class Functions {
  static Future getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      logPrint(androidDeviceInfo.id);
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  static Future<String> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? deviceToken = await messaging.getToken();
      return deviceToken!;
      //   await box.write("deviceToken", deviceToken);

      //  Functions.logPrint(box.read("deviceToken"));
    }
    return "";
  }

  static Future<void> disableScreenshots() async {
    try {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } on PlatformException catch (e) {
      logPrint('Failed to disable screenshots: ${e.message}');
    }
  }

  static viewNotification(RemoteMessage message) {
    Functions.logPrint('Message data: ${message.notification!.body}');
    Get.snackbar("", "",
        titleText: Text(
          "${message.notification!.title}",
          style: kTextStyle.copyWith(fontSize: 12.sp),
        ),
        messageText: Text(
          "${message.notification!.body}",
          style: kTextStyle.copyWith(fontSize: 12.sp),
        ));
  }

  static void showSnackbarFailed(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.red,
        content: Text(
          message,
          style: kTextStyle.copyWith(color: AppColor.white),
        ),
      ),
    );
  }

  static void showSnackbarSuccess(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.green,
        content: Text(
          message,
          style: kTextStyle.copyWith(color: AppColor.white),
        ),
      ),
    );
  }

  static logPrint(String message) {
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  static ThemeMode currenThem() {
    if (box.read(MOOD) == null) {
      box.write(MOOD, "1");
      return ThemeMode.light;
    } else if (int.parse(box.read(MOOD)) == 1) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }
}
