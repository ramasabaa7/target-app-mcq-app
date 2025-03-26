import 'package:auto_size_text/auto_size_text.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/controller/progress_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/count_time.dart';
import 'package:flutter/foundation.dart';
// import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({super.key, required this.mcqController});
  final McqController mcqController;
  @override
  Widget build(BuildContext context) {
    CircularProgressController progressController =
        Get.find<CircularProgressController>();
    return Container(
      padding: const EdgeInsetsDirectional.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColor.newGolden,
                AppColor.white,
                AppColor.newGolden
              ])),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "النتيجة",
              style: kTextStyle.copyWith(color: Theme.of(context).hintColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    8.verticalSpace,
                    Row(
                      children: [
                        const CustomSvg(svgPath: 'assets/svg/true.svg'),
                        5.horizontalSpace,
                        AutoSizeText(
                          minFontSize: 0,
                          maxLines: 1,
                          'الأسئلة الصحيحة',
                          style: whiteSmallTextStyle.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        5.horizontalSpace,
                        AutoSizeText(
                          minFontSize: 0,
                          maxLines: 1,
                          (mcqController.selectedAnswer.length -
                                  mcqController.wrongAnswer.length)
                              .toString(),
                          style: whiteSmallTextStyle.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        5.horizontalSpace,
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        const CustomSvg(svgPath: 'assets/svg/false.svg'),
                        5.horizontalSpace,
                        AutoSizeText(
                          minFontSize: 0,
                          maxLines: 1,
                          'الأسئلة الخاطئة',
                          style: whiteSmallTextStyle.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        5.horizontalSpace,
                        AutoSizeText(
                          minFontSize: 0,
                          maxLines: 1,
                          mcqController.wrongAnswer.length.toString(),
                          style: whiteSmallTextStyle.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                  ],
                ),
                20.horizontalSpace,
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 5,
                        value: 10,
                        color: AppColor.dividerGray,
                      ),
                    ),
                    Obx(() {
                      return SizedBox(
                        height: 70.h,
                        width: 70.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          value: progressController.value.value,
                          color: AppColor.dividerGray,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      );
                    }),
                    Text(
                      "${"${mcqController.getPercent((mcqController.selectedAnswer.length - mcqController.wrongAnswer.length) / mcqController.selectedAnswer.length)}".substring(0, 3)}%",
                      style: kTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  minFontSize: 0,
                  maxLines: 1,
                  "الوقت المستغرق للحل",
                  style: kTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Theme.of(context).hintColor),
                ),
                5.horizontalSpace,
                AutoSizeText(
                  formatTimeFromSeconds(Get.find<McqController>().timerSeconds),
                  style: kTextStyle.copyWith(
                      fontSize: 15.sp, color: Theme.of(context).hintColor),
                  minFontSize: 0,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
