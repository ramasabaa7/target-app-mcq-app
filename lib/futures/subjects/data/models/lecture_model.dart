import 'package:hive/hive.dart';
part 'lecture_model.g.dart';

class LectureModel {
  List<Lecture> lecture;

  LectureModel({
    required this.lecture,
  });

  factory LectureModel.fromJson(List json) => LectureModel(
        lecture:
            List<Lecture>.from(json.map((x) => Lecture.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 7)
class Lecture {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int subjectId;
  @HiveField(3)
  int numberOfQuestions;
  @HiveField(4)
  String createdAt;
  @HiveField(5)
  String updatedAt;
  @HiveField(6)
  bool isLocked;

  Lecture({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.numberOfQuestions,
    required this.createdAt,
    required this.updatedAt,
    required this.isLocked
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        id: json["id"],
        name: json["name"],
        subjectId: json["subject_id"],
        numberOfQuestions: json["numberOfQuestions"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "  ",
        isLocked: json["isLocked"]
      );


}
