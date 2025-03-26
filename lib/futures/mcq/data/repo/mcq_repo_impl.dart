import 'package:dopamin/core/services/data_repo.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_repo.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';

class McqRepoImpl extends McqRepo {
  final DataService dataService;

  McqRepoImpl(this.dataService);
  @override
  Future<DataState<QuestionModel>> getQuestionsByExamCycleId(
      {required int examCycleId}) async {
    final response = await dataService.getData<QuestionModel>(
        endPoint: "geQuestionsByExamCycleId?exam_cycle_id=$examCycleId",
        fromJson: QuestionModel.fromJson);

    return response;
  }

  @override
  Future<DataState<MessageModel>> toggleFavorite(
      {required int questionId}) async {
    final response = await dataService.getData<MessageModel>(
        endPoint: "addQuestionToFavorites/$questionId",
        fromJson: MessageModel.fromJson);
    return response;
  }

  @override
  Future<DataState<QuestionModel>> getFavoriteQuestions(
      {required subjectId}) async {
    final response = await dataService.getData<QuestionModel>(
        endPoint: "getFavoriteQuestions?subject_id=$subjectId",
        fromJson: QuestionModel.fromJson);
    return response;
  }

  @override
  Future<DataState<QuestionModel>> getQuestionsByCategoryIdKindId(
      {required int categoryId, required int kindId}) async {
    final response = await dataService.getData<QuestionModel>(
        endPoint:
            "geQuestionsByKindId?kind_id=$kindId &categorization_id=$categoryId",
        fromJson: QuestionModel.fromJson);
    return response;
  }

  @override
  Future<DataState<QuestionModel>> getNarrativeQuestionsByLectureId(
      {required int lectureId}) async {
    final response = await dataService.getData<QuestionModel>(
        endPoint: "getNarrativeQuestionsByLectureId?lecture_id=$lectureId",
        fromJson: QuestionModel.fromJson);
    return response;
  }

  @override
  Future<DataState<MessageModel>> toggleFavoriteNarrative(
      {required int questionId}) async {
    final response = await dataService.getData<MessageModel>(
        endPoint: "toggleLoveForNarrativeQuestion/$questionId",
        fromJson: MessageModel.fromJson);
    return response;
  }
}
