import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  int selectedIndexScreens = 0;
   onItemTapped(int index) {
    selectedIndexScreens = index;
    update();
  }
}
