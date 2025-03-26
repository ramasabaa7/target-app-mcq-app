import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/futures/subjects/data/models/answer_model.dart';
import 'package:dopamin/futures/subjects/data/models/doctor_model.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:hive/hive.dart';
part 'question_model.g.dart';

class QuestionModel {
  List<Question> question;

  QuestionModel({
    required this.question,
  });

  factory QuestionModel.fromJson(List json) => QuestionModel(
        question:
            List<Question>.from(json.map((x) => Question.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 3)
class Question extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  String body;
  @HiveField(3)
  int points;
  @HiveField(4)
  int orderNumber;
  @HiveField(5)
  String hint;
  @HiveField(6)
  String difficulty;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String updatedAt;
  @HiveField(9)
  int correctAnswerId;
  @HiveField(10)
  int subjectId;
  @HiveField(11)
  int timeNeeded;
  @HiveField(12)
  List<Answer> answers;
  @HiveField(13)
  List<Doctors> doctors;
  @HiveField(14)
  bool isFavorite;
  @HiveField(15)
  int examCycleId;
  @HiveField(16)
  List<String> categorizations;
//frontend
  @HiveField(17)
  int? categoryId;
  @HiveField(18)
  Uint8List? image2;
  @HiveField(19)
  String? note;
  bool? isCorrect;
  Color? color;
  Question(
      {required this.id,
      required this.image,
      required this.body,
      required this.points,
      required this.orderNumber,
      required this.hint,
      required this.difficulty,
      required this.createdAt,
      required this.updatedAt,
      required this.correctAnswerId,
      required this.subjectId,
      required this.timeNeeded,
      required this.answers,
      required this.doctors,
      this.isFavorite = false,
      required this.examCycleId,
      this.categoryId,
      this.isCorrect = false,
      this.color = AppColor.golden,
      this.image2,
      required this.categorizations,
      this.note = ""});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        image: json["image"] == "" ? "0" : json["image"] ?? "0",
        body: json["body"],
        points: json["points"] ?? 0,
        orderNumber: json["orderNumber"] ?? 0,
        hint: json["hint"] ?? "hint",
        difficulty: json["difficulty"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        correctAnswerId: json["correct_answer_id"] ?? -2,
        subjectId: json["subject_id"],
        timeNeeded: json["timeNeeded"],
        examCycleId: json["exam_cycle_id"] ?? -1,
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        doctors: json.containsKey("doctors")
            ? List<Doctors>.from(
                json["doctors"].map((x) => Doctors.fromJson(x)))
            : [],
        categorizations: List<String>.from(json["categorizations"] ?? []),
      );
}

class PivotQuestion {
  int examCycleId;
  int questionId;

  PivotQuestion({
    required this.examCycleId,
    required this.questionId,
  });

  factory PivotQuestion.fromJson(Map<String, dynamic> json) => PivotQuestion(
        examCycleId: json["exam_cycle_id"],
        questionId: json["question_id"],
      );
}
