import 'package:hive/hive.dart';
part 'slider_model.g.dart';

class SliderModel {
  List<SliderM> slider;

  SliderModel({
    required this.slider, 
  });

  factory SliderModel.fromJson(List json) => SliderModel(
        slider:
            List<SliderM>.from(json.map((x) => SliderM.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 9)
class SliderM extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  dynamic image;
  @HiveField(4)
  String url;
  @HiveField(5)
  String createdAt;
  @HiveField(6)
  String updatedAt;
  @HiveField(7)
  int colorId;
  @HiveField(8)
  String color;

  SliderM({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.colorId,
    required this.color,
  });

  factory SliderM.fromJson(Map<String, dynamic> json) => SliderM(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        image: json["image"] ?? "",
        url: json["url"] ?? "",
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        colorId: json["color_id"] ?? 0,
        color: json["colorHexa"] ?? "",
      );
}
