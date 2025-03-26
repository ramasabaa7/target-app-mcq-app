import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

abstract class SubjectLocalRepo {
  List<ExamCycle> getExamCycle({required int subjectId});
  List<CategoryM> getCategories({required int subjectId});
  List<Lecture> getLectures({required int subjectId});

  Future<void> addExamCycle(
      {required List<ExamCycle> examCyclesList, required int subjectId});
  Future<void> addCategories(
      {required List<CategoryM> categoriesList, required int subjectId});
  Future<void> addLecture(
      {required List<Lecture> lectureList, required int subjectId});
  Future<void> addHints(
      {required HintsModel hintsModel, required int subjectId});
  HintsModel getHints({required int subjectId});
  // Future<void> addExamCyclesAndCategorizationsCount(
  //     {required int examCyclesCount,
  //     int categorizationsCount,
  //     required int subjectId});
}

class SubjectLocalRepoImpl extends SubjectLocalRepo {
  @override
  List<ExamCycle> getExamCycle({required int subjectId}) {
    var examBox = Hive.box<ExamCycle>("examCycle");
    if (examBox.isNotEmpty) {
      return examBox.values.toList().where((element) {
        return element.subjectId == subjectId;
      }).toList();
    }
    return [];
  }

  @override
  List<CategoryM> getCategories({required int subjectId}) {
    var catBox = Hive.box<CategoryM>("categoryM");
    if (catBox.isNotEmpty) {
      return catBox.values.toList().where((element) {
        return element.subjectId == subjectId;
      }).toList();
    }
    return [];
  }

  @override
  Future<void> addCategories(
      {required List<CategoryM> categoriesList, required int subjectId}) async {
    var catBox = Hive.box<CategoryM>("categoryM");
    catBox.toMap().forEach((key, value) async {
      if (value.subjectId == subjectId) {
        await catBox.delete(key);
      }
    });
    await catBox.addAll(categoriesList);

    /*   for (var newData in categoriesList) {
      var exists = catBox.values.any((element) => element.id == newData.id);
      var index = catBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        await catBox.deleteAt(index);
        await catBox.add(newData);
      } else {
        await catBox.add(newData);
      }
    } */
  }

  @override
  Future<void> addExamCycle(
      {required List<ExamCycle> examCyclesList, required int subjectId}) async {
    var examBox = Hive.box<ExamCycle>("examCycle");
    examBox.toMap().forEach((key, value) async {
      if (value.subjectId == subjectId) {
        await examBox.delete(key);
      }
    });
    await examBox.addAll(examCyclesList);
  }

  @override
  Future<void> addLecture(
      {required List<Lecture> lectureList, required int subjectId}) async {
    var lectureBox = Hive.box<Lecture>("lecture");

    lectureBox.toMap().forEach((key, value) async {
      if (value.subjectId == subjectId) {
        await lectureBox.delete(key);
      }
    });
    await lectureBox.addAll(lectureList);
  }

  @override
  List<Lecture> getLectures({required int subjectId}) {
    var lectureBox = Hive.box<Lecture>("lecture");
    if (lectureBox.isNotEmpty) {
      return lectureBox.values.toList().where((element) {
        return element.subjectId == subjectId;
      }).toList();
    }
    return [];
  }

  @override
  Future<void> addHints(
      {required HintsModel hintsModel, required int subjectId}) async {
    var hintBox = Hive.box<HintsModel>("hints");

    hintBox.toMap().forEach((key, value) async {
      if (value.id == subjectId) {
        await hintBox.delete(key);
      }
    });
    print("added hints");
    await hintBox.add(hintsModel);
  }

@override
HintsModel getHints({required int subjectId}) {
  var hintBox = Hive.box<HintsModel>("hints");
  if (hintBox.isNotEmpty) {
    return hintBox.values
        .toList()
        .firstWhere(
          (element) => element.id == subjectId,
          orElse: () => HintsModel(id: -1, hints: []), // Provide a default value here
        );
  }
  return HintsModel(id: -1, hints: []);
}

}
