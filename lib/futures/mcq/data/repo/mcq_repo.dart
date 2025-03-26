import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';

abstract class McqRepo {
    Future<DataState<QuestionModel>> getQuestionsByExamCycleId(
      {required int examCycleId});
  Future<DataState<QuestionModel>> getNarrativeQuestionsByLectureId(
      {required int lectureId});
  Future<DataState<MessageModel>> toggleFavorite({required int questionId});
  Future<DataState<MessageModel>> toggleFavoriteNarrative({required int questionId});

  Future<DataState<QuestionModel>> getFavoriteQuestions({required int subjectId});



  Future<DataState<QuestionModel>> getQuestionsByCategoryIdKindId(
      {required int categoryId, required int kindId});
}