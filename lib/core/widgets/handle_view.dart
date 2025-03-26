import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

// ignore: must_be_immutable
class HandleView extends StatelessWidget {
  HandleView(
      {super.key,
      required this.requestState,
      required this.loadingWidget,
      required this.defaultWidget,
      this.successWidget,
      this.errorWidget});
  RequestState requestState;
  Widget loadingWidget;
  Widget defaultWidget;
  Widget? successWidget;
  CustomError? errorWidget;

  @override
  Widget build(BuildContext context) {
    
    if (requestState == RequestState.success) {
      return successWidget ?? defaultWidget;
    }
    if (requestState == RequestState.error) {
      return errorWidget ?? defaultWidget;
    }
    if (requestState == RequestState.loading) {
      return loadingWidget;
    }
    if (requestState == RequestState.empty) {
      return Center(
        child: LottieBuilder.asset(
          "assets/lottie/nodata.json",
          height: 150.h,
          fit: BoxFit.cover,
        ),
      );
    }

    return successWidget ?? defaultWidget;
  }
}