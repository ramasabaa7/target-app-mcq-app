import 'dart:convert';

import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:hive/hive.dart';

part 'category_model.g.dart';

class CategoryModel {
  List<CategoryM> category;

  CategoryModel({
    required this.category,
  });

  factory CategoryModel.fromJson(List json) => CategoryModel(
        category: List<CategoryM>.from(
            json.map((x) => CategoryM.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 2)
class CategoryM extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int orderNumber;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;
  @HiveField(5)
  List<ExamCycle> kinds;
  @HiveField(6)
  int subjectId;

  CategoryM(
      {required this.id,
      required this.name,
      required this.orderNumber,
      required this.createdAt,
      required this.updatedAt,
      required this.kinds,
      required this.subjectId});

  factory CategoryM.fromJson(Map<String, dynamic> json) => CategoryM(
        id: json["id"],
        name: json["name"],
        orderNumber: json["orderNumber"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        subjectId: int.parse(json["subject_id"]),
        kinds: List<ExamCycle>.from(
            json["kinds"].map((x) => ExamCycle.fromJson(x))),
      );
}
