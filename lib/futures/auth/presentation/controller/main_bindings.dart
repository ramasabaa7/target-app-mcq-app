import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(Get.find())).getLoginFlagValue();
  }
}
