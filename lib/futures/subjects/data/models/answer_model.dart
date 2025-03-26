import 'package:hive/hive.dart';
part 'answer_model.g.dart';

@HiveType(typeId: 5)
class Answer extends HiveObject{
  @HiveField(0)
  int id;
  @HiveField(1)
  String body;
  @HiveField(2)
  int questionId;

  Answer({
    required this.id,
    required this.body,
    required this.questionId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        body: json["body"],
        questionId: json["question_id"],
      );
}
