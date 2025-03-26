import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as d;
import 'package:dopamin/core/global/progress_controller.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_local_repo.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_repo.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/exam_cycles_and_categorizations_count.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_local_repo.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  final SubjectRepo subjectRepo;
  final McqRepo mcqRepo;
  final McqLocalRepo mcqLocalRepo;
  final SubjectLocalRepo subjectLocalRepo;

  SubjectController(
      this.subjectRepo, this.subjectLocalRepo, this.mcqRepo, this.mcqLocalRepo);

  RequestState getExamCyclesState = RequestState.none;
  RequestState getCategoriesState = RequestState.none;
  RequestState getLecturesState = RequestState.none;
  RequestState examCyclesAndCategorizationsCountState = RequestState.none;
  RequestState getExamCyclesNameState = RequestState.none;
  RequestState hintState = RequestState.none;

  String getExamCyclesMessage = '';
  String getCategoriesMessage = '';

  String hintMessage = '';
  String getLecturesMessage = '';
  String examCyclesnamesMessage = '';
  String getExamCyclesAndCategorizationsCountMessage = '';

  List<ExamCycle> examCyclesList = [];
  List<CategoryM> categoriesList = [];
  List<Lecture> lecturesList = [];
  List<ExamCycle> examCyclesnamesList = [];
  //List <HintsModel>hintList = [];

  HintsModel hintsModel = HintsModel(id: 0, hints: []);
  int examCyclesCount = 0;
  int categorizationsCount = 0;

  late ExamCycle currentExamCycle;
  late int currentCategoryId;

  late Lecture currentLecture;

  Future<void> getExamCycles({bool refresh = false}) async {
    getExamCyclesState = RequestState.loading;
    update();
    if (!refresh) {
      examCyclesList = subjectLocalRepo.getExamCycle(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (examCyclesList.isNotEmpty) {
        getExamCyclesState = RequestState.success;
        update();
        return;
      }
    }
    Get.find<ProgressController>().number.value = 0;
    final dataState = await subjectRepo.getExamCycles(
        subjectId: Get.find<HomeController>().currentSubject.id);

    List<Question> questions = [];

    if (dataState is DataSuccess) {
      Get.find<ProgressController>().number.value +=
          (1 / dataState.data!.examCycle.length) * 10;
      examCyclesList = dataState.data!.examCycle;
      await subjectLocalRepo.addExamCycle(
          examCyclesList: examCyclesList,
          subjectId: Get.find<HomeController>().currentSubject.id);

      for (int i = 0; i < examCyclesList.length; i++) {
        Get.find<ProgressController>().number.value +=
            (i / dataState.data!.examCycle.length) * 10;
        if (!examCyclesList[i].isLocked) {
          final dataState1 = await mcqRepo.getQuestionsByExamCycleId(
              examCycleId: examCyclesList[i].id);
          if (dataState1 is DataSuccess) {
            for (int k = 0; k < dataState1.data!.question.length; k++) {
              if (dataState1.data!.question[k].image != "0") {
                print("${dataState1.data!.question[k].image} hello mester");
                dataState1.data!.question[k].image2 =
                    await downloadImage(dataState1.data!.question[k].image);
              }
              //questions.add(dataState1.data!.question[k]);
            }
            await mcqLocalRepo.addQuestion(
                questionList: dataState1.data!.question,
                examId: examCyclesList[i].id);
          }
          if (dataState1 is DataFailed) {
            Functions.showSnackbarFailed("حدث خطأ");
            getExamCyclesMessage = "اعادة المحاولة";
            questions.clear();
            getExamCyclesState = RequestState.error;
            update();
            return;
          }
        }
      }
      getExamCyclesState = RequestState.success;
      update();
    }

    if (dataState is DataFailed) {
      Functions.showSnackbarFailed("فشل التحميل");
      examCyclesList = subjectLocalRepo.getExamCycle(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (examCyclesList.isNotEmpty) {
        getExamCyclesState = RequestState.success;
        update();
        return;
      }
      getExamCyclesMessage = dataState.error.toString();
      getExamCyclesState = RequestState.error;
      update();
    }
  }

  Future<void> getCategories({bool refresh = false}) async {
    getCategoriesState = RequestState.loading;
    update();
    if (!refresh) {
      categoriesList = subjectLocalRepo.getCategories(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (categoriesList.isNotEmpty) {
        getCategoriesState = RequestState.success;
        update();
        return;
      }
    }
    Get.find<ProgressController>().number.value = 0;
    final dataState = await subjectRepo.getCategories(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (dataState is DataSuccess) {
      Get.find<ProgressController>().number.value +=
          (1 / dataState.data!.category.length) * 10;
      Map<int, List<Question>> questionsMap = {};
      categoriesList = dataState.data!.category;
      for (int i = 0; i < categoriesList.length; i++) {
        for (int j = 0; j < categoriesList[i].kinds.length; j++) {
          Get.find<ProgressController>().number.value +=
              (j / categoriesList.length) * 10;
          if (!categoriesList[i].kinds[j].isLocked) {
            final dataState1 = await mcqRepo.getQuestionsByCategoryIdKindId(
                categoryId: categoriesList[i].id,
                kindId: categoriesList[i].kinds[j].id);
            if (dataState1 is DataSuccess) {
              for (int k = 0; k < dataState1.data!.question.length; k++) {
                if (dataState1.data!.question[k].image != "0") {
                  dataState1.data!.question[k].image2 =
                      await downloadImage(dataState1.data!.question[k].image);
                }
              }
              if (questionsMap.containsKey(categoriesList[i].id)) {
                questionsMap[categoriesList[i].id]!
                    .addAll(dataState1.data!.question);
              } else {
                questionsMap[categoriesList[i].id] = dataState1.data!.question;
              }
            }
            if (dataState1 is DataFailed) {
              Functions.showSnackbarFailed("حدث خطأ");
              getCategoriesMessage = "اعادة المحاولة";
              getCategoriesState = RequestState.error;
              update();
              return;
            }
          }
        }
      }
      getCategoriesState = RequestState.success;
      update();

      subjectLocalRepo.addCategories(
          categoriesList: categoriesList,
          subjectId: Get.find<HomeController>().currentSubject.id);
      questionsMap.forEach((key, value) async {
        await mcqLocalRepo.addQuestionInCategory(
            questionList: value, categoryId: key);
      });
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed("فشل التحميل");

      categoriesList = subjectLocalRepo.getCategories(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (categoriesList.isNotEmpty) {
        getCategoriesState = RequestState.success;
        update();
        return;
      }
      getCategoriesMessage = dataState.error.toString();
      getCategoriesState = RequestState.error;
      update();
    }
  }

  Future<void> getLectures({bool refresh = false}) async {
    getLecturesState = RequestState.loading;
    update();
    if (!refresh) {
      lecturesList = subjectLocalRepo.getLectures(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (lecturesList.isNotEmpty) {
        getLecturesState = RequestState.success;
        update();
        return;
      }
    }
    Get.find<ProgressController>().number.value = 0;

    final dataState = await subjectRepo.getLectures(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (dataState is DataSuccess) {
      Get.find<ProgressController>().number.value +=
          (1 / dataState.data!.lecture.length) * 10;
      lecturesList = dataState.data!.lecture;

      await subjectLocalRepo.addLecture(
          lectureList: lecturesList,
          subjectId: Get.find<HomeController>().currentSubject.id);

      for (int i = 0; i < lecturesList.length; i++) {
        Get.find<ProgressController>().number.value +=
            (i / lecturesList.length) * 10;
        if (!lecturesList[i].isLocked) {
          final dataState1 = await mcqRepo.getNarrativeQuestionsByLectureId(
              lectureId: lecturesList[i].id);
          if (dataState1 is DataSuccess) {
            for (int k = 0; k < dataState1.data!.question.length; k++) {
              if (dataState1.data!.question[k].image != "0") {
                dataState1.data!.question[k].image2 =
                    await downloadImage(dataState1.data!.question[k].image);
              }
            }

            await mcqLocalRepo.addNarrativeQuestion(
                questionList: dataState1.data!.question,
                lectureId: lecturesList[i].id);
            //  questions.addAll(dataState1.data!.question);
          }
          if (dataState1 is DataFailed) {
            Functions.showSnackbarFailed("حدث خطأ");
            getLecturesMessage = "اعادة المحاولة";
            getLecturesState = RequestState.error;
            update();
            return;
          }
        }
      }
      getLecturesState = RequestState.success;
      update();
    }

    if (dataState is DataFailed) {
      Functions.showSnackbarFailed("فشل التحميل");

      lecturesList = subjectLocalRepo.getLectures(
          subjectId: Get.find<HomeController>().currentSubject.id);
      if (lecturesList.isNotEmpty) {
        getLecturesState = RequestState.success;
        update();
        return;
      }
      getLecturesMessage = dataState.error.toString();
      getLecturesState = RequestState.error;
      update();
    }
  }

  static Future<Uint8List?> downloadImage(String imageUrl) async {
    try {
      final d.Dio dio = d.Dio();
      final Directory tempDir = await Directory.systemTemp.createTemp();
      final String tempPath = tempDir.path;
      final String fileName = imageUrl.split('/').last;
      final String filePath = '$tempPath/$fileName';
      await dio.download(baseUrlImage + imageUrl, filePath);
      final File imageFile = File(filePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      return imageBytes;
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }

  // Future<void> getExamCyclesAndCategorizationsCount() async {
  //   examCyclesAndCategorizationsCountState = RequestState.loading;
  //   update();
  //   final dataState = await subjectRepo.getExamCyclesAndCategorizationsCount(
  //       subjectId: Get.find<HomeController>().currentSubject.id);
  //   if (dataState is DataSuccess) {
  //     examCyclesCount = dataState.data!.numberOfExamCycles;
  //     categorizationsCount = dataState.data!.numberOfCategorizations;
  //     examCyclesAndCategorizationsCountState = RequestState.success;
  //     print("getcounts");
  //     update();
  //   }
  //   // if (dataState is DataFailed) {
  //   examCyclesCount = 0;
  //   categorizationsCount = 0;
  //   // getExamCyclesAndCategorizationsCountMessage = dataState.error.toString();
  //   // Functions.showSnackbarFailed(dataState.error.toString());
  //   examCyclesAndCategorizationsCountState = RequestState.success;
  //   update();
  //   // }
  // }

  // Future<void> hint() async {
  //   hintState = RequestState.loading;
  //   update();
  //   final dataState = await subjectRepo.getHint(
  //       subjectId: Get.find<HomeController>().currentSubject.id);
  //   if (dataState is DataSuccess) {
  //     hintsModel = dataState.data!;
  //     hintState = RequestState.success;

  //     update();
  //   }
  //   if (dataState is DataFailed) {
  //     hintMessage = dataState.error.toString();
  //     Functions.showSnackbarFailed(dataState.error.toString());
  //     hintState = RequestState.error;
  //     update();
  //   }
  // }

  @override
  void onInit() {
   // getExamCyclesAndCategorizationsCount();
    // getExamCycles();
    super.onInit();
  }
}
