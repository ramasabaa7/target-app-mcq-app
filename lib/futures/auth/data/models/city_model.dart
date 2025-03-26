import 'package:dopamin/futures/auth/data/models/point_sale_model.dart';
import 'package:hive/hive.dart';
part 'city_model.g.dart';

class CityModel {
  List<City> cities;

  CityModel({
    required this.cities,
  });

  factory CityModel.fromJson(List json) => CityModel(
        cities: List<City>.from(json.map((x) => City.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 10)
class City extends HiveObject {
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
  List<PointSale> cityLibrary;

  City({
    required this.id,
    required this.name,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.cityLibrary,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        orderNumber: json["orderNumber"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        cityLibrary: List<PointSale>.from(
            json["library"].map((x) => PointSale.fromJson(x))),
      );
}
