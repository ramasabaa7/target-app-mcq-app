import 'package:hive_flutter/hive_flutter.dart';
part 'notification_model.g.dart';

class NotificationModel {
  List<Notify> notify;

  NotificationModel({
    required this.notify,
  });

  factory NotificationModel.fromJson(List json) => NotificationModel(
        notify: List<Notify>.from(json.map((x) => Notify.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 12)
class Notify extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  String url;
  @HiveField(4)
  String createdAt;
  @HiveField(5)
  String updatedAt;

  Notify({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json["id"],
        title: json["title"] ?? "title",
        subtitle: json["body"] ?? "sub title",
        url: json["url"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );
}
