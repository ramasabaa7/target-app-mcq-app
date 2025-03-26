import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => McqController(Get.find(), Get.find()),
    );
    Get.find<McqController>().getFavoriteQuestions();
  }
}

class NarrativeQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => McqController(Get.find(), Get.find()),
    );
    Get.find<McqController>().getNarrativeQuestion();
  }
}

class McqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => McqController(Get.find(), Get.find()),
    );
    // Get.previousRoute == "/categoriesScreen"
    //     ? Get.find<McqController>().getQuestionsByCategoryIdKindId()
    //     : Get.find<McqController>().getQuestionsByExamCycleId();
  }
}

class McqcycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => McqController(Get.find(), Get.find()),
    );

    Get.lazyPut(
      () => SubjectController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    //Get.find<SubjectController>().getExamCycles();
    // Get.previousRoute == "/categoriesScreen"
    //     ? Get.find<McqController>().getQuestionsByCategoryIdKindId()
    //     : Get.find<McqController>().getQuestionsByExamCycleId();
  }
}
