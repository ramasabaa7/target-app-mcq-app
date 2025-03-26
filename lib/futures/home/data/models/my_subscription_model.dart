import 'package:hive/hive.dart';
part 'my_subscription_model.g.dart';

class MySubscriptionModel {
  List<MySubscription> mySubscription;

  MySubscriptionModel({
    required this.mySubscription,
  });

  factory MySubscriptionModel.fromJson(List json) => MySubscriptionModel(
        mySubscription: List<MySubscription>.from(
            json.map((x) => MySubscription.fromJson(x)).toList()),
      );
}

@HiveType(typeId: 8)
class MySubscription extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int semesterCodeId;
  @HiveField(3)
  int subjectId;
  @HiveField(4)
  String puchasedSemesterTrack;
  @HiveField(5)
  String colorHexa;
  @HiveField(6)
  String about;
  @HiveField(7)
  String subjectContactNumber;
  @HiveField(8)
  int AYPSSID;
  @HiveField(9)
  int orderNumber;
  @HiveField(10)
  int numberOfQuestions;
  @HiveField(11)
  String updatedAt;
   @HiveField(12)
  String createdAt;


  // @HiveField(0)
  // int id;
  // @HiveField(1)
  // int aypssId;
  // @HiveField(2)
  // int userId;
  // @HiveField(3)
  // String platformId;
  // @HiveField(4)
  // String createdAt;
  // @HiveField(5)
  // String updatedAt;
  // @HiveField(6)
  // String puchasedSemesterTrack;

  MySubscription(
      {required this.id,
      required this.name,
      required this.semesterCodeId,
      required this.subjectId,
      required this.puchasedSemesterTrack,
      required this.colorHexa,
      required this.about,
      required this.subjectContactNumber,
      required this.AYPSSID,
      required this.numberOfQuestions,
      required this.orderNumber,
      required this.createdAt,
      required this.updatedAt
      });

  factory MySubscription.fromJson(Map<String, dynamic> json) => MySubscription(
        id: json["id"],
        name: json["name"],
        semesterCodeId: json["pivot"]["semester_code_id"],
        subjectId: json["pivot"]["subject_id"],
        puchasedSemesterTrack: json["puchasedSemesterTrack"]??"",
        colorHexa: json["colorHexa"]??"",
        about: json["about"]??"لا يوجد معلومات عن هذه المادة ",
        subjectContactNumber: json["subjectContactNumber"]??"لايوجد رقم حالياٌ",
        AYPSSID: json["AYPSS_id"]??0,
        numberOfQuestions: json["numberOfQuestions"]??0,
        orderNumber: json["orderNumber"]??0,
        createdAt: json["created_at"]??"",
        updatedAt: json["updated_at"]??""
      );
}
