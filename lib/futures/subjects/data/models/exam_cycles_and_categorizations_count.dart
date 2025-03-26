import 'package:hive/hive.dart';
//part 'exam_cycles_and_categorizations_count.g.dart';


class ExamCyclesAndCategorizationsCount {

  int numberOfExamCycles;
  
  int numberOfCategorizations;
  ExamCyclesAndCategorizationsCount(
      {required this.numberOfCategorizations,
      required this.numberOfExamCycles});

  factory ExamCyclesAndCategorizationsCount.fromJson(
          Map<String, dynamic> json) =>
      ExamCyclesAndCategorizationsCount(
        numberOfCategorizations: json['numberOfCategorizations'],
        numberOfExamCycles: json['numberOfExamCycles'],
      );
}
