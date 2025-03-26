import 'package:hive/hive.dart';
part 'hint_model.g.dart';


// class HintsModel  {
  
//   final List items;
//   // @HiveField(1)
//   // final int subjectid;

//   HintsModel({required this.items});
//   factory HintsModel.fromList(List list) {
//     return HintsModel(items: list);
//   }

//   List toList() {
//     return items;
//   }
// }
@HiveType(typeId: 15)
class HintsModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final List hints;

  HintsModel({required this.id, required this.hints});
  factory HintsModel.fromJson(Map<String, dynamic> json) =>
   HintsModel(id: json["id"],hints: json["data"]);
}
