import 'package:dopamin/core/services/data_repo.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/message_model.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/home/data/models/buy_code_params.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/setting_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';

import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final DataService dataService;

  HomeRepoImpl(
    this.dataService,
  );
  @override
  Future<DataState<SubjectModel>> getSubjects({required int pivotId}) async {
    final response = await dataService.getData<SubjectModel>(
        endPoint:
            //  box.read(SUBJECTTRACK).toString().isNotEmpty
            // ?
            //  "subjectsFromAcademicYear?platform_id=${await Functions.getDeviceId()}&pivot_id=$pivotId&subjectTrack=${box.read(SUBJECTTRACK)}"
            // :
            "subjectsFromAcademicYear?pivot_id=$pivotId &platform_id=${await Functions.getDeviceId()}",
        fromJson: SubjectModel.fromJson);
    return response;
  }

  @override
  Future<DataState<AcademicYearModel>> getAcademicYear(
      {required int specificationId}) async {
    final response = await dataService.getData<AcademicYearModel>(
        endPoint: "academicyears?pivot_id=$specificationId",
        fromJson: AcademicYearModel.fromJson);
    return response;
  }

  @override
  Future<DataState<SliderModel>> getSlider() async {
    final response = await dataService.getData<SliderModel>(
        endPoint: "sliders", fromJson: SliderModel.fromJson);
    return response;
  }

  @override
  Future<DataState<ExamCycleModel>> getExamCycles(
      {required int subjectId}) async {
    final response = await dataService.getData<ExamCycleModel>(
        endPoint: "examcycles?subject_id=$subjectId",
        fromJson: ExamCycleModel.fromJson);
    return response;
  }

  @override
  Future<DataState<CityModel>> getPointSales() async {
    final response = await dataService.getData<CityModel>(
        endPoint: "provinces", fromJson: CityModel.fromJson);

    return response;
  }

  @override
  Future<DataState<MessageModel>> buyCode(
      {required BuyCodeParams buyCodeParams}) async {
    final response = await dataService.postData<MessageModel>(
        formData: buyCodeParams.toJson(),
        endPoint: "getSemesterFromQR",
        fromJson: MessageModel.fromJson);
    return response;
  }

  @override
  Future<DataState<NotificationModel>> getNotification() async {
    final response = await dataService.getData<NotificationModel>(
        endPoint: "getNotifications", fromJson: NotificationModel.fromJson);
    return response;
  }

  @override
  Future<DataState<MySubscriptionModel>> getMySubscription() async {
    final response = await dataService.getData<MySubscriptionModel>(
        endPoint:
            "getPurchasedSemesters?platform_id=${await Functions.getDeviceId()}",
        fromJson: MySubscriptionModel.fromJson);
    return response;
  }

  @override
  Future<DataState<SubjectModel>> getSubscriptionSubjects(
      {required int pivotId}) async {
    final response = await dataService.getData<SubjectModel>(
        endPoint:
            //  box.read(SUBJECTTRACK).toString().isNotEmpty
            // ?
            //  "subjectsFromAcademicYear?platform_id=${await Functions.getDeviceId()}&pivot_id=$pivotId&subjectTrack=${box.read(SUBJECTTRACK)}"
            // :
            "subjects?pivot_id=$pivotId &platform_id=${await Functions.getDeviceId()}",
        fromJson: SubjectModel.fromJson);

    print("${response}  ");
    return response;
  }

  @override
  Future<DataState<SettingModel>> getSetting() async {
    final response = await dataService.getData<SettingModel>(
        endPoint: "infos", fromJson: SettingModel.fromJson);

    print("${response}  ");
    return response;
  }
}
