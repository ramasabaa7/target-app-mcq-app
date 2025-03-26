import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GetYears extends StatelessWidget {
  const GetYears({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return HandleView(
        requestState: controller.academicYearState,
        errorWidget: CustomError(
          message: controller.getacademicYearMessage,
          onTap: () {
            controller.getAcademicYear(pivotId: box.read(ACADENICYEARIDPIOVIT));
          },
        ),
        defaultWidget: const Text("def"),
        loadingWidget: Padding(
          padding: const EdgeInsets.all(10),
          child: shimmerChapter3(),
        ),
        successWidget: AnimationLimiter(
          child: Container(
            padding: const EdgeInsetsDirectional.only(start: 20),
            height: Get.height * 0.08,
            width: Get.width * 1,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return ZoomTapAnimation(
                      onTap: () async {
                        controller.selectedAcademicYearIndex = index;
                        controller.getSubjects(
                            pivotId: controller
                                .academicYearList[
                                    controller.selectedAcademicYearIndex]
                                .pivot
                                .id,
                            );
                        await box.write(
                            SEMESTERID,
                            controller
                                .academicYearList[
                                    controller.selectedAcademicYearIndex]
                                .pivot
                                .id);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color:
                                  controller.selectedAcademicYearIndex == index
                                      ? AppColor.golden.withOpacity(0.7)
                                      : AppColor.golden.withOpacity(0.3),
                              border: Border.all(
                                  width: 2,
                                  color: controller.selectedAcademicYearIndex ==
                                          index
                                      ? AppColor.golden
                                      : AppColor.golden.withOpacity(0.3))),
                          //
                          height: Get.height * 0.08,
                          width: Get.width * 0.3,
                          child: Center(
                              child: Text(
                            controller.academicYearList[index].name,
                            style: kTextStyle.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ))));
                },
                separatorBuilder: (context, index) {
                  return 15.horizontalSpace;
                },
                itemCount: controller.academicYearList.length),
          ),
        ),
      );
    });
  }
}
