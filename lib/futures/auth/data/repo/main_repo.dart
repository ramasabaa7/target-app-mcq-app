import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/auth_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/models/semester_model.dart';
import 'package:dopamin/futures/auth/data/models/specification_model.dart';

abstract class MainRepo {
  Future<DataState<CityModel>> getCities();
  Future<DataState<SpecificationModel>> getSpecifications(
      {required int cityId});
  Future<DataState<AcademicYearModel>> getAcademicYear(
      {required int specificationId});
  Future<DataState<SemesterModel>> getSemesters({required int yearId});
  Future<DataState<AuthModel>> login({required   authParams,required bool isGoogleAuth});
  Future<DataState<AuthModel>> register({required AuthParams authParams});
  Future<DataState> getLoginFlagValue();
   Future<DataState> changeLoginFlagValue();
}
