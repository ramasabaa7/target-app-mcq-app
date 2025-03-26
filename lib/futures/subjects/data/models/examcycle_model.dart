import 'package:hive/hive.dart';
part 'examcycle_model.g.dart';

class ExamCycleModel {
  List<ExamCycle> examCycle;

  ExamCycleModel({
    required this.examCycle,
  });

  factory ExamCycleModel.fromJson(List json) => ExamCycleModel(
        examCycle: List<ExamCycle>.from(
            json.map((x) => ExamCycle.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 1)
class ExamCycle extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String createdAt;
  @HiveField(3)
  String updatedAt;
  @HiveField(4)
  int numberOfQuestions;
  @HiveField(5)
  int subjectId;
  @HiveField(6)
  bool isLocked;
  @HiveField(7)
  String note;
  ExamCycle(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      required this.numberOfQuestions,
      required this.subjectId,
      required this.isLocked,
      required this.note});

  factory ExamCycle.fromJson(Map<String, dynamic> json) => ExamCycle(
      id: json["id"],
      name: json["name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      numberOfQuestions: json["numberOfQuestions"],
      subjectId: json["subject_id"],
      isLocked: json["isLocked"] ?? false,
      note: json["note"] ?? "لايوجد ملاحظة");
}
