import 'dart:io';

import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/home/presentation/screens/code_screen.dart';
import 'package:dopamin/futures/home/presentation/screens/home_screen.dart';
import 'package:dopamin/futures/home/presentation/screens/notify_screen.dart';
import 'package:dopamin/futures/home/presentation/widgets/nav_bar.dart';
import 'package:dopamin/futures/setting/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  onItemTapped(int index) {
    Get.find<BottomNavBarController>().selectedIndexScreens = index;
    Get.find<BottomNavBarController>().update();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (_) {
      return Scaffold(
        body: _buildScreen(),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: Get.find<BottomNavBarController>().selectedIndexScreens,
          onTap: onItemTapped,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              svgurl: 'assets/svg/home.svg',
              title: Text("الرئيسية"),
              selectedColor: AppColor.lightGolden,
            ),
            SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("الاشعارات"),
                svgurl: 'assets/svg/notify.svg',
                selectedColor: AppColor.lightGolden),
            SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("باركود"),
                svgurl: 'assets/svg/barcode.svg',
                selectedColor: AppColor.lightGolden),
            SalomonBottomBarItem(
                icon: Icon(Icons.notifications),
                title: Text("الضبط"),
                svgurl: 'assets/svg/setting.svg',
                selectedColor: AppColor.lightGolden),
          ],
        ),
      );
    });
  }

  Widget _buildScreen() {
    switch (Get.find<BottomNavBarController>().selectedIndexScreens) {
      case 0:
        return const HomeScreen();
      case 1:
        return const NotifyScreen();
      //;
      case 2:
        return const CodeScreen();
      //;
      case 3:
        return SettingScreen();
      default:
        return Container();
    }
  }
}
