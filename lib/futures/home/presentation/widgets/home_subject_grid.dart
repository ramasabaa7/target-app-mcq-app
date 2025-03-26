import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeSubjectCard extends StatelessWidget {
  const HomeSubjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return HandleView(
          requestState: controller.getSubjectState,
          errorWidget: CustomError(
              message: controller.getSubjectMessage,
              onTap: () {
                controller.getSubjects(
                    pivotId:
        
                        box.read(SEMESTERID));
              }),
          defaultWidget: const Text("def"),
          loadingWidget: shimmerChapter2(),
          successWidget: controller.subjectList.isNotEmpty
              ? AnimationLimiter(
                  child: Container(
                  height: Get.height * 0.2,
                  width: Get.width * 1,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ZoomTapAnimation(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 20),
                            child: InkResponse(
                              onTap: () {
                                controller.currentSubject =
                                    controller.subjectList[index];
                                Get.toNamed(AppRouter.kSubjectScreen);
                              },
                              child: Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.45,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15.w, top: 40.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor.newGolden,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomSvg(
                                                svgPath: 'assets/svg/srd.svg',
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                size: 40,
                                              ),
                                              10.horizontalSpace,
                                              Expanded(
                                                child: Text(
                                                  controller
                                                      .subjectList[index].name,
                                                  style: whiteSmallTextStyle
                                                      .copyWith(
                                                          fontSize: 13.sp,
                                                          color: Theme.of(
                                                                  context)
                                                              .scaffoldBackgroundColor),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    DateFormat('MM/dd/yyyy')
                                                        .format(DateTime.parse(
                                                            controller
                                                                .subjectList[
                                                                    index]
                                                                .createdAt)),
                                                    style: whiteSmallTextStyle
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor,
                                                            fontSize: 12.sp),
                                                    maxLines: 3,
                                                  ),
                                                  // Text(
                                                  //  controller
                                                  //           .subjectList[index],
                                                  //   style: whiteSmallTextStyle.copyWith(
                                                  //       fontSize: 12.sp),
                                                  //   maxLines: 3,
                                                  // ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .symmetric(
                                                        horizontal: 20.h,
                                                        vertical: 20.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .all(10.0),
                                                    child: CustomSvg(
                                                      svgPath:
                                                          'assets/svg/back-arrow.svg',
                                                      color: AppColor.newGolden,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                  .animate()
                                  .fadeIn(
                                      duration:
                                          const Duration(milliseconds: 500))
                                  .move(),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.subjectList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 5.horizontalSpace;
                      },
                    ),
                  ),
                ))
              : Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20.w, vertical: 40.h),
                  child: Text(
                    'لا يوجد مواد  في هذه السنة حتى الآن',
                    style: kTextStyle.copyWith(
                        fontSize: 13.sp,
                        color: AppColor.golden,
                        fontWeight: FontWeight.w300),
                  ),
                ));
    });
  }
}
