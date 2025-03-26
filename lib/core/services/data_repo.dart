import 'dart:developer';
import 'dart:io';
import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/services/internet_checker.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'data_state.dart';

class DataService {
  final Dio _dio;
  final NetworkInfo _networkInfo;

  DataService(this._dio, this._networkInfo);

  Future<DataState<T>> getData<T>({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required Function fromJson,
  }) async {
    print(endPoint);
    try {
      Functions.logPrint("TRY GET DATA");
      if (await checkInternet()) {
        return DataFailed(
          error: "لايوجد اتصال بالانترنت",
          statusCode: 0,
        );
      }
      final response = await _dio.get(
        baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${box.read(TOKEN)}",
          },
        ),
      );
      Functions.logPrint(response.toString());
      // log(response.toString());

      return handleDataState(response: response, fromJson: fromJson);
    } on DioException catch (e) {
      if (e.response == null) {
        Functions.logPrint("CATCH GET");
        Functions.logPrint(e.toString());
        return DataFailed(
          error: "unKnown Error",
          statusCode: 00,
        );
      } else {
        return handleDataState(response: e.response!, fromJson: fromJson);
      }
    }
  }

  Future<DataState<T>> postData<T>(
      {required String endPoint,
      required Object formData,
      required Function fromJson}) async {
    try {
      if (await checkInternet()) {
        return DataFailed(
          error: "لايوجد اتصال بالانترنت",
          statusCode: 0,
        );
      }
      final response = await _dio.post(baseUrl + endPoint,
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${box.read(TOKEN)}",
          }));

      Functions.logPrint(response.toString());
      return handleDataState(response: response, fromJson: fromJson);
    } on DioException catch (e) {
      Functions.logPrint("CATCH POST");
      Functions.logPrint(e.toString());
      if (e.response == null) {
        return DataFailed(
          error: "unKnownError",
          statusCode: 00,
        );
      } else {
        return handleDataState(response: e.response!, fromJson: fromJson);
      }
    }
  }

  Future<DataState<T>> handleDataState<T>({
    required Response response,
    required Function fromJson,
  }) async {
    Functions.logPrint("handle data state");

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      final object = fromJson(response.data);
      return DataSuccess(data: object as T, statusCode: response.statusCode!);
    } else if (response.statusCode == 401) {
      //  box.erase();
      //  getX.Get.offAllNamed(AppRouter.);
      return DataFailed(
        error: response.data['error'] ?? "",
        statusCode: 00,
      );
    } else if (response.statusCode == 500) {
      return DataFailed(
        error: 'حدث خطأ',
        statusCode: 500,
      );
    } else {
      return DataFailed(
        error: response.data['message'] ?? "",
        statusCode: 00,
      );
    }
  }

  checkInternet() async {
    if (await _networkInfo.isConnected == false) {
      return true;
    } else {
      return false;
    }
  }
}
