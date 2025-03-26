import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo.dart';
import 'package:get/get.dart';

class CountController extends GetxController {
  final SubjectRepo subjectRepo;
  CountController(this.subjectRepo);
  RequestState examCyclesAndCategorizationsCountState = RequestState.none;
  int examCyclesCount = 0;
  int categorizationsCount = 0;
  String getExamCyclesAndCategorizationsCountMessage = '';
  Future<void> getExamCyclesAndCategorizationsCount() async {
    examCyclesAndCategorizationsCountState = RequestState.loading;
    update();
    final dataState = await subjectRepo.getExamCyclesAndCategorizationsCount(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (dataState is DataSuccess) {
      examCyclesCount = dataState.data!.numberOfExamCycles;
      categorizationsCount = dataState.data!.numberOfCategorizations;
      examCyclesAndCategorizationsCountState = RequestState.success;
      print("getcounts");
      update();
    }
    if (dataState is DataFailed) {
      examCyclesCount = 0;
      categorizationsCount = 0;
      // getExamCyclesAndCategorizationsCountMessage = dataState.error.toString();
      // Functions.showSnackbarFailed(dataState.error.toString());
      // examCyclesAndCategorizationsCountState = RequestState.error;
      examCyclesAndCategorizationsCountState = RequestState.success;
      update();
    }
  }

  @override
  void onInit() {
    getExamCyclesAndCategorizationsCount();

    super.onInit();
  }
}
