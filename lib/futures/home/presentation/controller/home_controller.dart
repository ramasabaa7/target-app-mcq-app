import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dopamin/core/services/data_state.dart';
import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/repo/main_repo.dart';
import 'package:dopamin/futures/home/data/models/buy_code_params.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/setting_model.dart';
import 'package:dopamin/futures/home/data/repo/home_local_repo.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;
  final HomeLocalData homeLocalData;

  HomeController(this.homeRepo, this.homeLocalData);

  RequestState getSubjectState = RequestState.none;
  RequestState getSliderState = RequestState.none;
  RequestState getPointSalesState = RequestState.none;
  RequestState buyCodeState = RequestState.none;
  RequestState getNotificationState = RequestState.none;
  RequestState getMySubscriptionState = RequestState.none;

  RequestState academicYearState = RequestState.none;
  RequestState subscriptionSubjectsState = RequestState.none;
  RequestState settingState = RequestState.none;

  String getMySubscriptionMessage = '';
  String getNotificationMessage = '';
  String getSubjectMessage = '';
  String getSliderMessage = '';
  String getPointSalesMessage = '';
  String getacademicYearMessage = '';
  String getSubscriptionMessage = '';
  String getSettingMessage = '';

  List<Subject> subjectList = [];
  List<SliderM> sliderList = [];
  List<City> pointSalesList = [];
  List<Notify> notificationList = [];
  List<MySubscription> mySubscriptionList = [];
  List<AcademicYear> academicYearList = [];
  List<Subject> subscriptionSubjectsList = [];
  List<Setting> settingList = [];

  int selectedAcademicYearIndex = -1;

  late Subject currentSubject;

  Future<void> getMySubscription({bool refresh = false}) async {
    getMySubscriptionState = RequestState.loading;
    update();
    if (!refresh) {
      mySubscriptionList = homeLocalData.getMySubscription();
      if (mySubscriptionList.isNotEmpty) {
        getMySubscriptionState = RequestState.success;
        update();
        return;
      }
    }
    final dataState = await homeRepo.getMySubscription();
    if (dataState is DataSuccess) {
      mySubscriptionList = dataState.data!.mySubscription;
      getMySubscriptionState = RequestState.success;
      update();
      homeLocalData.addMySubscription(mySubscriptionList: mySubscriptionList);
    }
    if (dataState is DataFailed) {
      getSliderMessage = dataState.error.toString();
      getMySubscriptionState = RequestState.error;
      update();
    }
  }

  Future<void> getSubjects({required int pivotId, bool refresh = false}) async {
    getSubjectState = RequestState.loading;
    update();
    if (!refresh) {
      subjectList = homeLocalData.getLocalSubject(pivotId: pivotId);
      if (subjectList.isNotEmpty) {
        getSubjectState = RequestState.success;
        update();
        return;
      }
    }

    final dataState = await homeRepo.getSubjects(pivotId: pivotId);
    if (dataState is DataSuccess) {
      subjectList = dataState.data!.subject;
      getSubjectState = RequestState.success;
      update();
      homeLocalData.addLocalSubject(
          subjectList: subjectList, semesterId: pivotId);
    }
    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        subjectList = homeLocalData.getLocalSubject(pivotId: pivotId);
        if (subjectList.isNotEmpty) {
          getSubjectState = RequestState.success;
          update();
          return;
        }
      }
      getSubjectMessage = dataState.error.toString();
      getSubjectState = RequestState.error;
      update();
    }
  }

  Future<void> getAcademicYear(
      {required int pivotId, bool refresh = false}) async {
    academicYearState = RequestState.loading;
    update();

    if (!refresh) {
      academicYearList =
          homeLocalData.getAcademicYear(specification: box.read(ACADENICYEARIDPIOVIT));
      if (academicYearList.isNotEmpty) {
        academicYearState = RequestState.success;
        print(academicYearList);
        update();
        return;
      }
    }
    final dataState = await homeRepo.getAcademicYear(specificationId: pivotId);
    if (dataState is DataSuccess) {
      academicYearList = dataState.data!.academicYear;
      academicYearState = RequestState.success;
      update();
      homeLocalData.addAcademicYear(
          academicYearList: academicYearList,
          specification: box.read(ACADENICYEARIDPIOVIT));
    }
    if (dataState is DataFailed) {
      Functions.showSnackbarFailed(dataState.error.toString());
      academicYearState = RequestState.error;
      update();
    }
  }



  Future<void> getSubscriptionSubjects({
    required int pivotId,
  }) async {
    subscriptionSubjectsState = RequestState.loading;
    update();
    final dataState = await homeRepo.getSubscriptionSubjects(pivotId: pivotId);
    if (dataState is DataSuccess) {
      subscriptionSubjectsList = dataState.data!.subject;
      subscriptionSubjectsState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      getSubscriptionMessage = dataState.error.toString();
      Functions.showSnackbarFailed(dataState.error.toString());
      subscriptionSubjectsState = RequestState.error;
      update();
    }
  }

  Future<void> getSlider() async {
    getSliderState = RequestState.loading;
    update();
    final dataState = await homeRepo.getSlider();
    if (dataState is DataSuccess) {
      sliderList = dataState.data!.slider;
      getSliderState = RequestState.success;

      update();
      await homeLocalData.addSlider(sliderList: sliderList);
    }
    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        sliderList = homeLocalData.getSlider();
        getSliderState = RequestState.success;
        update();
      } else {
        getSliderMessage = dataState.error.toString();
        getSliderState = RequestState.error;
        update();
      }
    }
  }

  Future<void> getPointSales() async {
    getPointSalesState = RequestState.loading;
    update();
    final dataState = await homeRepo.getPointSales();
    if (dataState is DataSuccess) {
      pointSalesList = dataState.data!.cities;
      getPointSalesState = RequestState.success;
      update();
      await homeLocalData.addCitesAndPos(cityList: pointSalesList);
    }
    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        pointSalesList = homeLocalData.getCitesAndPos();
        getPointSalesState = RequestState.success;
        update();
      } else {
        getPointSalesMessage = dataState.error.toString();
        getPointSalesState = RequestState.error;
        update();
      }
    }
  }

  Future<void> getSetting() async {
    settingState = RequestState.loading;
    update();
    final dataState = await homeRepo.getSetting();
    if (dataState is DataSuccess) {
      settingList = dataState.data!.setting;
      settingState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      getSettingMessage = dataState.error.toString();
      settingState = RequestState.error;
      // Functions.showSnackbarFailed(dataState.error.toString());

      update();
    }
  }

  Future<void> buyCode({required BuyCodeParams buyCodeParams}) async {
    buyCodeState = RequestState.loading;
    update();
    final dataState = await homeRepo.buyCode(buyCodeParams: buyCodeParams);
    if (dataState is DataSuccess) {
      Functions.showSnackbarSuccess(
          "تم الشراء بنجاح , يمكنك ايجاد المادة أو المواد ضمن  ثائمة اشتراكاتي بعد تحديثها ");
      buyCodeState = RequestState.success;
      update();
    }
    if (dataState is DataFailed) {
      getPointSalesMessage = dataState.error.toString();
      Functions.showSnackbarFailed(
          dataState.error.toString() + 'الكود غير صالح');
      buyCodeState = RequestState.error;
      update();
    }
  }

  Future<void> getNotification() async {
    notificationList.clear();
    getNotificationState = RequestState.loading;
    update();
    final dataState = await homeRepo.getNotification();
    if (dataState is DataSuccess) {
      notificationList = dataState.data!.notify;
      getNotificationState = RequestState.success;
      update();
      await homeLocalData.addNotification(notificationList: notificationList);
    }
    if (dataState is DataFailed) {
      if (dataState.statusCode == 0) {
        notificationList = homeLocalData.getNotification();
        getNotificationState = RequestState.success;
        update();
      } else {
        getNotificationMessage = dataState.error.toString();
        getNotificationState = RequestState.error;
        update();
      }
    }
  }

  @override
  void onInit() {
    getMySubscription();
    getSubjects(pivotId: box.read(SEMESTERID));
    //getSlider();
    getSetting();
    getAcademicYear(pivotId: box.read(ACADENICYEARIDPIOVIT));
    getNotification();
    getPointSales();
    super.onInit();
  }
}
