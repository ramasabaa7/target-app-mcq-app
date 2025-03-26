import 'dart:async';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_local_repo.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_repo.dart';
import 'package:dopamin/futures/mcq/presentation/controller/progress_controller.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class McqController extends GetxController {
  final McqRepo mcqRepo;
  final McqLocalRepo mcqLocalRepo;

  McqController(this.mcqRepo, this.mcqLocalRepo);

  @override
  void onInit() {
    focusNode.addListener(() {
      isSearchNow = focusNode.hasFocus;
      if (isSearchNow == false) {
        /* questionsList = oldList;
        update(); */
      }
      print(oldList);
    });

    super.onInit();
  }

  int timerSeconds = 0;
  RequestState getQuestionsState = RequestState.none;
  RequestState getNarrativeQuestionState = RequestState.none;
  String getQuestionMessage = '';
  String getNarrativeQuestionMessage = '';
  List<Question> questionsList = [];
  List<Question> narrativeQuestionList = [];
  late Question currentQuestion;
  List<Question> searchList = [];
  List<Question> oldList = [];
  FocusNode focusNode = FocusNode();
  String currentQuery = '';
  bool isSearchNow = false;
  bool isFirstSearch = false;
  TextEditingController searchController = TextEditingController();
  void deleteSearchQuery() {
    searchController.clear();
    focusNode.unfocus();
    if (isFirstSearch == true) {
      questionsList = List.from(oldList);
    }
    update();
  }

  void onSearch(String query) {
    if (isFirstSearch == false) {
      oldList = List<Question>.from(questionsList);
    }
    isFirstSearch = true;
    currentQuery = query;
    questionsList = List<Question>.from(oldList)
        .where((element) =>
            element.body.toLowerCase().contains(query.toLowerCase()))
        .toList();

    update();
  }

  Future<void> getQuestionsByExamCycleId({bool refresh = false}) async {
    print('object sssssssstart');

    questionsList.clear();

    getQuestionsState = RequestState.loading;
    update();
    if (!refresh) {
      questionsList = mcqLocalRepo.getQuestionsByExamCycleId(
          examCycleId: Get.find<SubjectController>().currentExamCycle.id);
      getQuestionsState = RequestState.success;
      print(questionsList);
      update();
      print('object eeeeeeeeeeend');

      return;
    }

    final dataState = await mcqRepo.getQuestionsByExamCycleId(
        examCycleId: Get.find<SubjectController>().currentExamCycle.id);
    if (dataState is DataSuccess) {
      questionsList = dataState.data!.question;
      getQuestionsState = RequestState.success;
      update();
      /*  mcqLocalRepo.addQuestion(
        questionList: questionsList,
      ); */
    }
    if (dataState is DataFailed) {
      getQuestionMessage = dataState.error.toString();
      getQuestionsState = RequestState.error;
      update();
    }
  }

  Future<void> getQuestionsByExamCycleId2(
      {required id, bool refresh = false}) async {
    print('object sssssssstart');

    questionsList.clear();

    getQuestionsState = RequestState.loading;
    update();
    if (!refresh) {
      questionsList = mcqLocalRepo.getQuestionsByExamCycleId(examCycleId: id);
      getQuestionsState = RequestState.success;
      print(questionsList);
      update();
      print('object eeeeeeeeeeend');

      return;
    }

    final dataState = await mcqRepo.getQuestionsByExamCycleId(
        examCycleId: Get.find<SubjectController>().currentExamCycle.id);
    if (dataState is DataSuccess) {
      questionsList = dataState.data!.question;
      getQuestionsState = RequestState.success;
      update();
      /*  mcqLocalRepo.addQuestion(
        questionList: questionsList,
      ); */
    }
    if (dataState is DataFailed) {
      getQuestionMessage = dataState.error.toString();
      getQuestionsState = RequestState.error;
      update();
    }
  }

  Future<void> getQuestionsByCategoryIdKindId({bool refresh = false}) async {
    questionsList.clear();

    getQuestionsState = RequestState.loading;
    update();
    if (!refresh) {
      questionsList = mcqLocalRepo.getQuestionsByCategoryId(
          categoryId: Get.find<SubjectController>().currentCategoryId,
          examCycleId: Get.find<SubjectController>().currentExamCycle.id);
      getQuestionsState = RequestState.success;
      update();
      return;
    }

    final dataState = await mcqRepo.getQuestionsByCategoryIdKindId(
        categoryId: Get.find<SubjectController>().currentCategoryId,
        kindId: Get.find<SubjectController>().currentExamCycle.id);
    if (dataState is DataSuccess) {
      questionsList = dataState.data!.question;
      getQuestionsState = RequestState.success;
      update();
      mcqLocalRepo.addQuestionInCategory(
          questionList: questionsList,
          categoryId: Get.find<SubjectController>().currentCategoryId);
    }
    if (dataState is DataFailed) {
      getQuestionMessage = dataState.error.toString();
      getQuestionsState = RequestState.error;
      update();
    }
  }

  Future<void> getFavoriteQuestions() async {
    getQuestionsState = RequestState.loading;
    update();

    questionsList = await mcqLocalRepo.getFavoriteQuestion(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (questionsList.isNotEmpty) {
      getQuestionsState = RequestState.success;
      update();
    }
    if (questionsList.isEmpty) {
      getQuestionMessage = "لايوجد اسئلة";
      getQuestionsState = RequestState.success;
      update();
    }

/* 
    final dataState = await mcqRepo.getFavoriteQuestions(
        subjectId: Get.find<HomeController>().currentSubject.id);
    if (dataState is DataSuccess) {
      questionsList = dataState.data!.question;
      getQuestionsState = RequestState.success;
      update();
      mcqLocalRepo.addFavoriteQuestion(questionList: questionsList);
    }
    if (dataState is DataFailed) {
      getQuestionMessage = dataState.error.toString();
      getQuestionsState = RequestState.error;
      update();
    } */
  }

  Future<void> toggleFavorite() async {
    currentQuestion.isFavorite = !currentQuestion.isFavorite;
    // update();
    // Question question = Question(
    //     categorizations: currentQuestion.categorizations,
    //     id: currentQuestion.id,
    //     image: currentQuestion.image,
    //     body: currentQuestion.body,
    //     points: currentQuestion.points,
    //     orderNumber: currentQuestion.orderNumber,
    //     hint: currentQuestion.hint,
    //     difficulty: currentQuestion.difficulty,
    //     createdAt: currentQuestion.createdAt,
    //     updatedAt: currentQuestion.updatedAt,
    //     correctAnswerId: currentQuestion.correctAnswerId,
    //     subjectId: currentQuestion.subjectId,
    //     timeNeeded: currentQuestion.timeNeeded,
    //     answers: currentQuestion.answers,
    //     doctors: currentQuestion.doctors,
    //     isFavorite: currentQuestion.isFavorite,
    //     examCycleId: currentQuestion.examCycleId,
    //     image2: currentQuestion.image2);

    await mcqLocalRepo.addFavoriteQuestion(question: currentQuestion);

    /*  final dataState =
        await mcqRepo.toggleFavorite(questionId: currentQuestion.id);

    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        Functions.showSnackbarFailed("No internet connection");
      }
      currentQuestion.isFavorite = !currentQuestion.isFavorite;
      update();
    } */
  }

  Future<void> toggleFavoriteNarrative() async {
    currentQuestion.isFavorite = !currentQuestion.isFavorite;
    // update();
    // Question question = Question(
    //     categorizations: currentQuestion.categorizations,
    //     id: currentQuestion.id,
    //     image: currentQuestion.image,
    //     body: currentQuestion.body,
    //     points: currentQuestion.points,
    //     orderNumber: currentQuestion.orderNumber,
    //     hint: currentQuestion.hint,
    //     difficulty: currentQuestion.difficulty,
    //     createdAt: currentQuestion.createdAt,
    //     updatedAt: currentQuestion.updatedAt,
    //     correctAnswerId: currentQuestion.correctAnswerId,
    //     subjectId: currentQuestion.subjectId,
    //     timeNeeded: currentQuestion.timeNeeded,
    //     answers: currentQuestion.answers,
    //     doctors: currentQuestion.doctors,
    //     isFavorite: currentQuestion.isFavorite,
    //     examCycleId: currentQuestion.examCycleId,
    //     image2: currentQuestion.image2);

    await mcqLocalRepo.addFavoriteNarrativeQuestion(question: currentQuestion);

    /*  final dataState =
        await mcqRepo.toggleFavoriteNarrative(questionId: currentQuestion.id);

    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        Functions.showSnackbarFailed("No internet connection");
      }
      currentQuestion.isFavorite = !currentQuestion.isFavorite;
      update();
    } */
  }

  Future<void> getNarrativeQuestion({bool refresh = false}) async {
    getNarrativeQuestionState = RequestState.loading;
    update();
    if (!refresh) {
      narrativeQuestionList = mcqLocalRepo.getNarrativeQuestionByLectureId(
          lectureId: Get.find<SubjectController>().currentLecture.id);
      getNarrativeQuestionState = RequestState.success;
      update();
      return;
    }
    final dataState = await mcqRepo.getNarrativeQuestionsByLectureId(
        lectureId: Get.find<SubjectController>().currentLecture.id);
    if (dataState is DataSuccess) {
      narrativeQuestionList = dataState.data!.question;
      getNarrativeQuestionState = RequestState.success;
      update();
      /* mcqLocalRepo.addNarrativeQuestion(
        questionList: narrativeQuestionList,
      ); */
    }
    if (dataState is DataFailed) {
      getNarrativeQuestionMessage = dataState.error.toString();
      getNarrativeQuestionState = RequestState.error;
      update();
    }
  }

  Future<void> addNote({required String note, required int questionId}) async {
    await mcqLocalRepo.addNoteToQuestion(note: note, questionId: questionId);
  }

  Map<int, int> selectedAnswer = {};
  Map<int, int> wrongAnswer = {};

  bool visibleResult = false;
  // double value = 0;

  double mcqTime = 0;

  void viewResult() {
    if (selectedAnswer.length != questionsList.length) {
      Functions.showSnackbarFailed("يرجى الاجابة على جميع الاسئلة اولاً");
      return;
    }
    selectedAnswer.forEach((key, value) {
      if (!isCorrectAnswer(questionIndex: key, answerIndex: value)) {
        wrongAnswer[key] = value;
      }
    });
    for (var element in questionsList) {
      element.color = AppColor.green;
    }

    correctAllAnswer();
    visibleResult = true;
    update();
    Get.find<CircularProgressController>().increaseProgress(
        selectedAnswer: selectedAnswer, wrongAnswer: wrongAnswer);
  }

  double getPercent(value) {
    if (value.toString().length < 4) {
      return value * 100;
    } else {
      value = value * 100;
      return value;
    }
  }

  double calculateMcqTime() {
    for (var element in questionsList) {
      mcqTime += element.timeNeeded;
    }
    return mcqTime;
  }

  // void increaseProgress() {
  //   const duration = Duration(milliseconds: 50);
  //   Timer.periodic(duration, (Timer timer) {
  //     if (value >=
  //         ((selectedAnswer.length - wrongAnswer.length) /
  //             selectedAnswer.length)) {
  //       timer.cancel();
  //     } else {
  //       value += 0.01;
  //     }
  //     update();
  //   });
  //   value = 0;
  // }

  bool isWrongAnswer({required questionIndex, required answerIndex}) {
    return wrongAnswer[questionIndex] == answerIndex ? true : false;
  }

  bool isHaveAnswer({required questionIndex, required answerIndex}) {
    return selectedAnswer[questionIndex] == answerIndex ? true : false;
  }

  void selectAnswer({required questionIndex, required answerIndex}) {
    if (visibleResult == false) {
      questionsList[questionIndex].color = AppColor.newGray;
      selectedAnswer[questionIndex] = answerIndex;
      // update();
    }
  }

  bool isCorrectAnswer({required questionIndex, required answerIndex}) {
    if (questionsList[questionIndex].correctAnswerId ==
        questionsList[questionIndex].answers[answerIndex].id) {
      return true;
    } else {
      return false;
    }
  }

  void correctOneQuestion({required questionIndex}) {
    if (visibleResult == false) {
      questionsList[questionIndex].color = AppColor.green;
      questionsList[questionIndex].isCorrect =
          !questionsList[questionIndex].isCorrect!;
      if (!questionsList[questionIndex].isCorrect!) {
        selectedAnswer.removeWhere((key, value) => key == questionIndex);
        if (wrongAnswer.containsKey(questionIndex)) {
          wrongAnswer.removeWhere((key, value) => key == questionIndex);
        }
      }
      if (questionsList[questionIndex].isCorrect!) {
        if (selectedAnswer.containsKey(questionIndex)) {
          if (!isCorrectAnswer(
              questionIndex: questionIndex,
              answerIndex: selectedAnswer[questionIndex])) {
            wrongAnswer[questionIndex] = selectedAnswer[questionIndex]!;
          }
        }
        for (int i = 0; i < questionsList[questionIndex].answers.length; i++) {
          if (questionsList[questionIndex].correctAnswerId ==
              questionsList[questionIndex].answers[i].id) {
            selectedAnswer[questionIndex] = i;
          }
        }
      }
      // update();
    }
  }

  void correctAllAnswer() {
    for (int i = 0; i < questionsList.length; i++) {
      for (int j = 0; j < questionsList[i].answers.length; j++) {
        if (questionsList[i].correctAnswerId ==
            questionsList[i].answers[j].id) {
          selectedAnswer[i] = j;
        }
      }
    }
    update();
  }

  void clearAnswers() {
    selectedAnswer.clear();
    wrongAnswer.clear();
    update();
  }

  void clearResult() {
    clearAnswers();
    visibleResult = false;
    for (var element in questionsList) {
      element.color = AppColor.green;
      element.isCorrect = false;
    }
  }
}
