import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

class PointSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<HomeController>().getPointSales();
  }
}

class SetttingBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<HomeController>().getSetting();
  }
}
