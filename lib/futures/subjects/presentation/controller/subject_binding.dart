import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/count_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/hint_conrtoller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:get/get.dart';

class ExamCycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SubjectController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    Get.find<SubjectController>().getExamCycles();
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(Get.find(), Get.find()),
    );
   
  }
}



class CountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CountController(Get.find()),
    );
    Get.find<CountController>().getExamCyclesAndCategorizationsCount();
  }
}

class HintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HintConrtoller(Get.find(),Get.find()),
    );
    Get.find<HintConrtoller>().hint();
  }
}

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SubjectController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    Get.find<SubjectController>().getCategories();
  }
}

class LecturesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SubjectController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    Get.find<SubjectController>().getLectures();
  }
}
