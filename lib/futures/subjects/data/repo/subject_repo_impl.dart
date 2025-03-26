import 'package:dopamin/core/services/data_repo.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/exam_cycles_and_categorizations_count.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo.dart';

class SubjectRepoImpl extends SubjectRepo {
  final DataService dataService;

  SubjectRepoImpl(this.dataService);

  @override
  Future<DataState<ExamCycleModel>> getExamCycles(
      {required int subjectId}) async {
    final response = await dataService.getData<ExamCycleModel>(
        endPoint:
            "examcycles?subject_id=$subjectId&platform_id=${await Functions.getDeviceId()}",
        fromJson: ExamCycleModel.fromJson);
    return response;
  }

  @override
  Future<DataState<CategoryModel>> getCategories(
      {required int subjectId}) async {
    final response = await dataService.getData<CategoryModel>(
        endPoint:
            "categorizations?subject_id=$subjectId&platform_id=${await Functions.getDeviceId()}",
        fromJson: CategoryModel.fromJson);
    return response;
  }

  @override
  Future<DataState<LectureModel>> getLectures({required int subjectId}) async {
    final response = await dataService.getData<LectureModel>(
        endPoint:
            "lectures?subject_id=$subjectId&platform_id=${await Functions.getDeviceId()}",
        fromJson: LectureModel.fromJson);
    return response;
  }

  @override
  Future<DataState<ExamCyclesAndCategorizationsCount>>
      getExamCyclesAndCategorizationsCount({required int subjectId}) async {
    final response =
        await dataService.getData<ExamCyclesAndCategorizationsCount>(
            endPoint: "getExamCyclesAndCategorizationsCount/$subjectId",
            fromJson: ExamCyclesAndCategorizationsCount.fromJson);
    return response;
  }

  @override
  Future<DataState<HintsModel>> getHint({required int subjectId}) async {
    final response = await dataService.getData<HintsModel>(
      endPoint: "pluckHintsFromSubjectQuestions/$subjectId",
      fromJson: HintsModel.fromJson,
    );
    return response;
  }
}
