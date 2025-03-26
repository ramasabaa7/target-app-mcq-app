import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/home/data/models/buy_code_params.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/setting_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';

abstract class HomeRepo {
  Future<DataState<SubjectModel>> getSubjects({required int pivotId});

  Future<DataState<SliderModel>> getSlider();

  Future<DataState<ExamCycleModel>> getExamCycles({required int subjectId});
  Future<DataState<CityModel>> getPointSales();
  Future<DataState<MessageModel>> buyCode(
      {required BuyCodeParams buyCodeParams});

  Future<DataState<NotificationModel>> getNotification();
  Future<DataState<MySubscriptionModel>> getMySubscription();
  Future<DataState<AcademicYearModel>> getAcademicYear(
      {required int specificationId});

  Future<DataState<SubjectModel>> getSubscriptionSubjects(
      {required int pivotId});

  Future<DataState<SettingModel>> getSetting();
}
