import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:hive/hive.dart';

abstract class McqLocalRepo {
  List<Question> getQuestionsByExamCycleId({required int examCycleId});
  List<Question> getQuestionsByCategoryId(
      {required int categoryId, required int examCycleId});
  Future<void> addQuestionInCategory(
      {required List<Question> questionList, required int categoryId});
  Future<void> addQuestion(
      {required List<Question> questionList, required int examId});

  Future<void> addNarrativeQuestion(
      {required List<Question> questionList, required int lectureId});
  List<Question> getNarrativeQuestionByLectureId({required int lectureId});

  Future<void> addFavoriteQuestion({required Question question});
  Future<void> addFavoriteNarrativeQuestion({required Question question});

  Future<List<Question>> getFavoriteQuestion({required int subjectId});

  Future<void> addNoteToQuestion(
      {required String note, required int questionId});
}

class McqLocalRepoImpl extends McqLocalRepo {
  @override
  Future<void> addQuestion(
      {required List<Question> questionList, required int examId}) async {
    var questionBox = Hive.box<Question>('question');

    questionBox.toMap().forEach((key, value) async {
      if (value.examCycleId == examId) {
        int? questionIndex = questionList.indexWhere((element) {
          return element.id == value.id;
        });
        if (questionIndex != -1) {
          questionList[questionIndex].note = value.note;
          questionList[questionIndex].isFavorite = value.isFavorite;
        }
        await questionBox.delete(key);
      }
    });
    await questionBox.addAll(questionList);
  }

  @override
  List<Question> getQuestionsByExamCycleId({required int examCycleId}) {
    var questionBox = Hive.box<Question>('question');
    if (questionBox.isNotEmpty) {
      return questionBox.values.toList().where((element) {
        return element.examCycleId == examCycleId;
      }).toList();
    }
    return [];
  }

  @override
  List<Question> getQuestionsByCategoryId(
      {required int categoryId, required int examCycleId}) {
    var questionBox = Hive.box<Question>('questionInCategory');
    if (questionBox.isNotEmpty) {
      return questionBox.values.toList().where((element) {
        return (element.examCycleId == examCycleId) &&
            (element.categoryId == categoryId);
      }).toList();
    }
    return [];
  }

  @override
  Future<void> addQuestionInCategory(
      {required List<Question> questionList, required int categoryId}) async {
    var questionBox = Hive.box<Question>('questionInCategory');

    questionBox.toMap().forEach((key, value) async {
      if (value.categoryId == categoryId) {
        int? questionIndex = questionList.indexWhere((element) {
          return element.id == value.id;
        });
        if (questionIndex != -1) {
          questionList[questionIndex].note = value.note;
          questionList[questionIndex].isFavorite = value.isFavorite;
        }
        await questionBox.delete(key);
      }
    });

    for (Question question in questionList) {
      question.categoryId = categoryId;
      await questionBox.add(question);
    }
  }

  @override
  Future<void> addNarrativeQuestion(
      {required List<Question> questionList, required int lectureId}) async {
    var narrativeBox = Hive.box<Question>('narrativeQuestions');
    narrativeBox.toMap().forEach((key, value) async {
      if (value.examCycleId == lectureId) {
        int? questionIndex = questionList.indexWhere((element) {
          return element.id == value.id;
        });
        if (questionIndex != -1) {
          questionList[questionIndex].isFavorite = value.isFavorite;
        }
        await narrativeBox.delete(key);
      }
    });
    await narrativeBox.addAll(questionList);
  }

  @override
  List<Question> getNarrativeQuestionByLectureId({required int lectureId}) {
    var narrativeBox = Hive.box<Question>('narrativeQuestions');
    if (narrativeBox.isNotEmpty) {
      return narrativeBox.values.toList().where((element) {
        return element.examCycleId == lectureId;
      }).toList();
    }
    return [];
  }

  @override
  Future<void> addFavoriteQuestion({required Question question}) async {
    var questionBox = Hive.box<Question>('question');
    Question question1 = questionBox.values.toList().firstWhere((element) {
      return element.id == question.id;
    });
    var index = questionBox.values
        .toList()
        .indexWhere((element) => element.id == question1.id);
    question1.isFavorite = question.isFavorite;
    await questionBox.putAt(index, question1);
  }

  @override
  Future<List<Question>> getFavoriteQuestion({required int subjectId}) async {
    var favoriteBox = Hive.box<Question>('question');
    var favoriteNBox = Hive.box<Question>('narrativeQuestions');

    if (favoriteBox.isNotEmpty || favoriteNBox.isNotEmpty) {
      List<Question> questions = [];
      questions.addAll(favoriteBox.values.toList().where((element) {
        return element.subjectId == subjectId && element.isFavorite == true;
      }).toList());

      questions.addAll(favoriteNBox.values.toList().where((element) {
        return element.subjectId == subjectId && element.isFavorite == true;
      }).toList());
      return questions;
    }
    return [];
  }

  @override
  Future<void> addNoteToQuestion(
      {required String note, required int questionId}) async {
    var questionBox = Hive.box<Question>('question');
    Question question = questionBox.values.toList().firstWhere((element) {
      return element.id == questionId;
    });
    var index = questionBox.values
        .toList()
        .indexWhere((element) => element.id == questionId);
    question.note = note;
    await questionBox.putAt(index, question);
  }

  @override
  Future<void> addFavoriteNarrativeQuestion(
      {required Question question}) async {
    var questionBox = Hive.box<Question>('narrativeQuestions');
    Question question1 = questionBox.values.toList().firstWhere((element) {
      return element.id == question.id;
    });
    var index = questionBox.values
        .toList()
        .indexWhere((element) => element.id == question1.id);
    question1.isFavorite = question.isFavorite;
    await questionBox.putAt(index, question1);
  }
}
