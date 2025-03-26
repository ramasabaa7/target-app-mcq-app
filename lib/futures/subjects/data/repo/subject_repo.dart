import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:dopamin/futures/subjects/data/models/exam_cycles_and_categorizations_count.dart';

abstract class SubjectRepo {
  Future<DataState<ExamCycleModel>> getExamCycles({required int subjectId});

  Future<DataState<CategoryModel>> getCategories({required int subjectId});

  Future<DataState<LectureModel>> getLectures({required int subjectId});
  Future<DataState<ExamCyclesAndCategorizationsCount>>
      getExamCyclesAndCategorizationsCount({required int subjectId});

  Future<DataState<HintsModel>> getHint({required int subjectId});
}
