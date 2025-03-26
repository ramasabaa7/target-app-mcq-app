
import 'package:hive/hive.dart';
part 'point_sale_model.g.dart';

@HiveType(typeId: 11)
class PointSale extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  String name;
  @HiveField(3)
  String locationUrl;
  @HiveField(4)
  String address;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  int provinceId;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String updatedAt;

  PointSale({
    required this.id,
    required this.image,
    required this.name,
    required this.locationUrl,
    required this.address,
    required this.phoneNumber,
    required this.provinceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PointSale.fromJson(Map<String, dynamic> json) => PointSale(
        id: json["id"],
        image: json["image"] ?? "",
        name: json["name"],
        locationUrl: json["location_url"] ?? "",
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        provinceId: json["province_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
