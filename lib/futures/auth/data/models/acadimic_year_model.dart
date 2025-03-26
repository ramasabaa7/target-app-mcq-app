import 'package:hive/hive.dart';
part 'acadimic_year_model.g.dart';



class AcademicYearModel {
  List<AcademicYear> academicYear;

  AcademicYearModel({
    required this.academicYear,
  });

  factory AcademicYearModel.fromJson(List json) => AcademicYearModel(
        academicYear: List<AcademicYear>.from(
            json.map((x) => AcademicYear.fromJson(x)).toList()),
      );
}
@HiveType(typeId: 13)
class AcademicYear extends HiveObject{
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String createdAt;
  @HiveField(3)
  String updatedAt;
  @HiveField(4)
  PivotAcademic pivot;

  AcademicYear({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) => AcademicYear(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: PivotAcademic.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot.toJson(),
      };
}

@HiveType(typeId: 14)
class PivotAcademic extends HiveObject {
  @HiveField(0)
  int psId;

  @HiveField(1)
  int academicYearId;

  @HiveField(2)
  int id;

  PivotAcademic({
    required this.psId,
    required this.academicYearId,
    required this.id,
  });

  factory PivotAcademic.fromJson(Map<String, dynamic> json) => PivotAcademic(
        psId: json["PS_id"],
        academicYearId: json["academic_year_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "PS_id": psId,
        "academic_year_id": academicYearId,
        "id": id,
      };
}
