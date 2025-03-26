class SemesterModel {
  List<Semester> semesters;

  SemesterModel({
    required this.semesters,
  });

  factory SemesterModel.fromJson(List json) => SemesterModel(
        semesters:
            List<Semester>.from(json.map((x) => Semester.fromJson(x)).toList()),
      );
}

class Semester {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  PivotSemester pivot;

  Semester({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: PivotSemester.fromJson(json["pivot"]),
      );


}

class PivotSemester {
  int id;
  int aypsId;
  int semesterId;

  PivotSemester({
    required this.id,
    required this.aypsId,
    required this.semesterId,
  });

  factory PivotSemester.fromJson(Map<String, dynamic> json) => PivotSemester(
        id: json["id"],
        aypsId: json["AYPS_id"],
        semesterId: json["semester_id"],
      );
}
