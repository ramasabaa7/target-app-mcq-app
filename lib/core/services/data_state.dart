import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final int? statusCode;
  final String? error;
  
  DataState({
    this.statusCode,
    this.data,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({required T data, required int statusCode})
      : super(data: data, statusCode: statusCode);
}

class DataFailed<T> extends DataState<T> {
  DataFailed({required String error, required int statusCode})
      : super(error: error, statusCode: statusCode);
}
