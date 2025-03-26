class SettingModel {
  List<Setting> setting;

  SettingModel({
    required this.setting,
  });

  factory SettingModel.fromJson(List json) => SettingModel(
        setting:
            List<Setting>.from(json.map((x) => Setting.fromJson(x)).toList()),
      );
}

class Setting {
  final int id;
  final String key;
  final String value;
  final int order;
  final String category;
  final String createdAt;
  final String updatedAt;

  Setting(
      {required this.id,
      required this.key,
      required this.value,
      required this.order,
      required this.category,
      required this.createdAt,
      required this.updatedAt});

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        key: json["key"] ?? "key",
        value: json["value"] ?? "value",
        order: json["order"] ?? 0,
        category: json['category'] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );
}
