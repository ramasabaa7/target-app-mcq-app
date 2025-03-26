import 'package:hive/hive.dart';
part 'subject_model.g.dart';

class SubjectModel {
  List<Subject> subject;

  SubjectModel({
    required this.subject,
  });

  factory SubjectModel.fromJson(List json) => SubjectModel(
        subject:
            List<Subject>.from(json.map((x) => Subject.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int orderNumber;
  @HiveField(3)
  int numberOfQuestions;
  @HiveField(4)
  String createdAt;
  @HiveField(5)
  String updatedAt;
  @HiveField(6)
  int AYPSSID;
  @HiveField(7)
  String about;
  @HiveField(8)
  String subjectContactNumber;
  @HiveField(9)
  String academicYearPivotId;

  Subject({
    required this.id,
    required this.name,
    required this.orderNumber,
    required this.numberOfQuestions,
    required this.createdAt,
    required this.updatedAt,
    required this.AYPSSID,
    required this.about,
    required this.subjectContactNumber,
   required this.academicYearPivotId

  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        orderNumber: json["orderNumber"] ?? "",
        numberOfQuestions: json["numberOfQuestions"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        AYPSSID: json["AYPSS_id"],
        about: json["about"] ?? "لايوجد معلومات حالياٌ",
          subjectContactNumber:   json["subjectContactNumber"] ?? "لايوجد رقم حالياٌ",
          academicYearPivotId: json["academicYearPivotId"]??""

      );
}
