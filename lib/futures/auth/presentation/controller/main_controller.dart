import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/auth_model.dart';
import 'package:dopamin/futures/auth/data/models/change_login_flag.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/models/login_flag_model.dart';
import 'package:dopamin/futures/auth/data/models/semester_model.dart';
import 'package:dopamin/futures/auth/data/models/specification_model.dart';
import 'package:dopamin/futures/auth/data/repo/main_repo.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainController extends GetxController {
  final MainRepo mainRepo;

  MainController(this.mainRepo);

  RequestState getCitiesState = RequestState.none;
  RequestState getSpecificationsState = RequestState.none;
  RequestState getAcademicYearState = RequestState.none;
  RequestState getSemestersState = RequestState.none;
  RequestState loginState = RequestState.none;
  RequestState registerState = RequestState.none;
  RequestState getLoginFlagState = RequestState.none;
  RequestState loginWithGoogleState = RequestState.none;
  RequestState changeLoginFlagState = RequestState.none;

  List<City> citiesList = [];
  List<Specification> specificationList = [];
  List<AcademicYear> academicYearList = [];
  List<Semester> semesterList = [];
  int selectedCityIndex = -1;
  int selectedSpecificationIndex = -1;
  int selectedAcademicYearIndex = -1;
  int selectedSemesterIndex = -1;

  late AuthModel authModel;

  ////

  ///

  LoginFlagModel? loginFlagModel;
  Future<void> getLoginFlagValue() async {
    getLoginFlagState = RequestState.loading;
    final dataState = await mainRepo.getLoginFlagValue();
    if (dataState is DataSuccess) {
      loginFlagModel = dataState.data;
      getLoginFlagState = RequestState.success;

      box.write(IS_GOOGLE_AUTH, loginFlagModel!.normalLogin == 0);
    }
    if (dataState is DataFailed) {
      getLoginFlagState = RequestState.error;
    }
  }

  ChangeLoginFlagModel? changeLoginFlagModel;
  Future<void> changLoginFlagValue() async {
    changeLoginFlagState = RequestState.loading;
    final dataState = await mainRepo.changeLoginFlagValue();
    if (dataState is DataSuccess) {
      changeLoginFlagModel = dataState.data;
      changeLoginFlagState = RequestState.success;
      print(dataState.data);
      print(" changed");
    }
    if (dataState is DataFailed) {
      print("not changed");
      changeLoginFlagState = RequestState.error;
    }
  }

  Future<void> login({required authParams, required bool isGoogleAuth}) async {
    loginState = RequestState.loading;
    update();
    final dataState = await mainRepo.login(
        authParams: authParams, isGoogleAuth: isGoogleAuth);
    if (dataState is DataSuccess) {
      Get.find<BottomNavBarController>().selectedIndexScreens = 0;

      authModel = dataState.data!;
      await box.write(TOKEN, dataState.data!.token);
      await box.write(USERNAME, dataState.data!.name);
      await box.write(NAME, dataState.data!.userName);
      await box.write(SUBJECTTRACK, dataState.data!.subjectTrack);
      //await box.write(MOOD, 1);

      Get.offAllNamed(AppRouter.kEditInfoScreen);
      // if (authModel.AYPSSID != -1) {
      //   await box.write(SEMESTERID, dataState.data!.AYPSSID);
      //   Get.offAllNamed(AppRouter.kMainScreen);
      // } else {
      //   Get.offAllNamed(AppRouter.kCitiesScreen);
      // }
      loginState = RequestState.success;
      Get.find<BottomNavBarController>().selectedIndexScreens = 0;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      loginState = RequestState.error;
      update();
    }
  }

  Future<String> logInWithGoogle() async {
    loginWithGoogleState = RequestState.loading;
    String? tokenId;
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleAccount?.authentication;

    loginWithGoogleState = RequestState.success;
    print(tokenId ?? googleAuth!.accessToken ?? '-1');
    return tokenId ?? googleAuth!.accessToken ?? '-1';
  }

  Future<void> register({required AuthParams authParams}) async {
    registerState = RequestState.loading;
    update();
    final dataState = await mainRepo.register(authParams: authParams);
    if (dataState is DataSuccess) {
      Get.find<BottomNavBarController>().selectedIndexScreens = 0;

      authModel = dataState.data!;
      await box.write(TOKEN, dataState.data!.token);
      await box.write(USERNAME, dataState.data!.userName);
      await box.write(NAME, dataState.data!.name);
      //await box.write(MOOD, 1);
      Get.offAllNamed(AppRouter.kCitiesScreen);
      registerState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      registerState = RequestState.error;
      update();
    }
  }

  Future<void> getCities() async {
    getCitiesState = RequestState.loading;
    update();
    final dataState = await mainRepo.getCities();

    if (dataState is DataSuccess) {
      citiesList = dataState.data!.cities;

      getCitiesState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      getCitiesState = RequestState.error;
      update();
    }
  }

  Future<void> getSpecifications() async {
    getSpecificationsState = RequestState.loading;
    update();
    final dataState = await mainRepo.getSpecifications(
        cityId: citiesList[selectedCityIndex].id);
    if (dataState is DataSuccess) {
      specificationList = dataState.data!.specification;
      getSpecificationsState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      getSpecificationsState = RequestState.error;
      update();
    }
  }

  Future<void> getAcademicYear() async {
    getAcademicYearState = RequestState.loading;
    update();
    final dataState = await mainRepo.getAcademicYear(
        specificationId:
            specificationList[selectedSpecificationIndex].pivot.id);
    if (dataState is DataSuccess) {
      academicYearList = dataState.data!.academicYear;
      getAcademicYearState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      getAcademicYearState = RequestState.error;
      update();
    }
  }

  Future<void> getSemesters() async {
    getSemestersState = RequestState.loading;
    update();
    final dataState = await mainRepo.getSemesters(
        yearId: academicYearList[selectedAcademicYearIndex].pivot.id);
    if (dataState is DataSuccess) {
      semesterList = dataState.data!.semesters;
      getSemestersState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      getSemestersState = RequestState.error;
      update();
    }
  }

//////////////////
  @override
  void onInit() {
    super.onInit();
  }
////////////////////////

  void setCity(index) {
    selectedCityIndex = index;
    update();
  }

  void setSpecification(index) {
    selectedSpecificationIndex = index;
    update();
  }

  void setYear(index) {
    selectedAcademicYearIndex = index;
    update();
  }

  void setSemester(index) {
    selectedSemesterIndex = index;
    update();
  }

  String selectCity = "قم باختيار الحافظة:";
  String selectSpecification = "قم باختيار الكلية:";
  String selectYear = "قم باختيار السنة:";
  String selectSemester = "قم باختيار الفصل:";
}
