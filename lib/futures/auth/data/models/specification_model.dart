
class SpecificationModel {
  List<Specification> specification;

  SpecificationModel({
    required this.specification,
  });

  factory SpecificationModel.fromJson(List json) => SpecificationModel(
        specification: List<Specification>.from(
            json.map((x) => Specification.fromJson(x)).toList()),
      );
}

class Specification {
  int id;
  String name;
  int orderNumber;
  String createdAt;
  String updatedAt;
  PivotSpecification pivot;

  Specification({
    required this.id,
    required this.name,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        id: json["id"],
        name: json["name"],
        orderNumber: json["orderNumber"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: PivotSpecification.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "orderNumber": orderNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot.toJson(),
      };
}

class PivotSpecification {
  int provinceId;
  int specificationId;
  int id;

  PivotSpecification({
    required this.provinceId,
    required this.specificationId,
    required this.id,
  });

  factory PivotSpecification.fromJson(Map<String, dynamic> json) =>
      PivotSpecification(
        provinceId: json["province_id"],
        specificationId: json["specification_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "specification_id": specificationId,
        "id": id,
      };
}
