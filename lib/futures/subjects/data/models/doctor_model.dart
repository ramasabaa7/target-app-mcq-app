import 'package:hive/hive.dart';

part 'doctor_model.g.dart';

@HiveType(typeId: 4)
class Doctors  extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  Doctors({
    required this.id,
    required this.name,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        id: json["id"],
        name: json["name"],
      );
}
