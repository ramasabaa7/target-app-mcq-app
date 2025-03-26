import 'package:dopamin/core/services/data_repo.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/auth_model.dart';
import 'package:dopamin/futures/auth/data/models/change_login_flag.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/models/login_flag_model.dart';
import 'package:dopamin/futures/auth/data/models/semester_model.dart';
import 'package:dopamin/futures/auth/data/models/specification_model.dart';
import 'package:dopamin/futures/auth/data/repo/main_repo.dart';

class MainRepoImpl extends MainRepo {
  final DataService dataService;

  MainRepoImpl(this.dataService);
  @override
  Future<DataState<CityModel>> getCities() async {
    final response = await dataService.getData<CityModel>(
        endPoint: "provinces", fromJson: CityModel.fromJson);
    return response;
  }

  @override
  Future<DataState<SpecificationModel>> getSpecifications(
      {required int cityId}) async {
    final response = await dataService.getData<SpecificationModel>(
        endPoint: "specifications?province_id=$cityId",
        fromJson: SpecificationModel.fromJson);
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
  Future<DataState<SemesterModel>> getSemesters({required int yearId}) async {
    final response = await dataService.getData<SemesterModel>(
        endPoint: "semesters?pivot_id=$yearId",
        fromJson: SemesterModel.fromJson);
    return response;
  }

  @override
  Future<DataState<AuthModel>> login({required   authParams,required bool isGoogleAuth}) async {
    final response = await dataService.postData<AuthModel>(
        formData: authParams.toJsonLogin(),
        endPoint: isGoogleAuth ? 'loginWithGoogle' : "login",
        fromJson: AuthModel.fromJson);
    return response;
  }

  @override
  Future<DataState<AuthModel>> register(
      {required AuthParams authParams}) async {
    final response = await dataService.postData<AuthModel>(
        formData: authParams.toJsonRegister(),
        endPoint: "register",
        fromJson: AuthModel.fromJson);
    return response;
  }

  @override
  Future<DataState> getLoginFlagValue() async {
    final response = await dataService.getData(
        endPoint: "getLoginFlagValue", fromJson: LoginFlagModel.fromJson);
    return response;
  }

   @override
  Future<DataState> changeLoginFlagValue() async {
    final response = await dataService.getData(
        endPoint: "changeLoginFlag", fromJson: ChangeLoginFlagModel.fromJson);
    return response;
  }
}
