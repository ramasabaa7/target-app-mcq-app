import 'dart:developer';

import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_local_repo.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo.dart';
import 'package:get/get.dart';

class HintConrtoller extends GetxController {
  final SubjectRepo subjectRepo;
  final SubjectLocalRepo subjectLocalRepo;
  HintConrtoller(this.subjectRepo, this.subjectLocalRepo);
  RequestState hintState = RequestState.none;

  String hintMessage = '';
  //List hintList = [];
  HintsModel hintsModel = HintsModel(id: -1, hints: []);
  Future<void> hint({bool refresh = false}) async {
    hintState = RequestState.loading;
    update();
    if (!refresh) {
      hintsModel = subjectLocalRepo.getHints(
          subjectId: Get.find<HomeController>().currentSubject.id);

      if (hintsModel.id != -1 && hintsModel.hints != []) {
        hintState = RequestState.success;
        update();
        return;
      }
    }

    final dataState = await subjectRepo.getHint(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (dataState is DataSuccess) {
      hintsModel = dataState.data!;
      await subjectLocalRepo.addHints(
          hintsModel: hintsModel,
          subjectId: Get.find<HomeController>().currentSubject.id);
      hintState = RequestState.success;
      log("gethints");
      update();
    }
    if (dataState is DataFailed) {
      hintMessage = dataState.error.toString();
      Functions.showSnackbarFailed(dataState.error.toString());
      hintState = RequestState.error;
      update();
    }
  }
}
