import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AcademicYearScreen extends StatelessWidget {
  const AcademicYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.scaffoldColor,
      child: SafeArea(child: GetBuilder<MainController>(builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: CenterAppBar(
                        onTap: () {
                          Get.back();
                        },
                        title: "إكمال البيانات"),
                  ),
                  SliverFillRemaining(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: GetBuilder<MainController>(builder: (controller) {
                        return HandleView(
                          defaultWidget: Text("def"),
                          loadingWidget: shimmerChapter(),
                          requestState: controller.getAcademicYearState,
                          errorWidget: CustomError(
                            message: "Try again",
                            onTap: () {
                              controller.getCities();
                            },
                          ),
                          successWidget: Column(
                            children: [
                              20.verticalSpace,
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  controller.selectYear,
                                  style: kTextStyle.copyWith(color: Theme.of(context).hintColor),
                                ),
                              ),
                              10.verticalSpace,
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return 10.verticalSpace;
                                  },
                                  itemCount: controller.academicYearList.length,
                                  itemBuilder: (context, index) {
                                    return TanimateList(
                                      index: index,
                                      child: ZoomTapAnimation(
                                        onTap: () {
                                          controller.setYear(index);
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          alignment: Alignment.center,
                                          width: 1.sw,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .selectedAcademicYearIndex ==
                                                      index
                                                  ? AppColor.newGolden
                                                  : AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            controller
                                                .academicYearList[index].name,
                                            style: kTextStyle.copyWith(
                                              color: controller
                                                          .selectedAcademicYearIndex ==
                                                      index
                                                  ? AppColor.white
                                                  : AppColor.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GetBuilder<MainController>(builder: (controller) {
                  return ZoomTapAnimation(
                    onTap: () async {
                      if (controller.selectedAcademicYearIndex != -1) {
                        // await box.write(
                        //     SUBJECTTRACK,
                        //     box.read(SUBJECTTRACK) +
                        //         "-" +
                        //         controller
                        //             .academicYearList[
                        //                 controller.selectedAcademicYearIndex]
                        //             .name);
                        //  controller.selectedAcademicYearIndex = 0;
                        await box.write(SEMESTERID,
                            controller.academicYearList[0].pivot.id);

                        controller.getSemesters();
                        Get.toNamed(AppRouter.kSemestersScreen);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: EdgeInsets.only(
                          left: kHorizontalPadding,
                          right: kHorizontalPadding,
                          bottom: kHorizontalPadding),
                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 50.h,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          color: controller.selectedAcademicYearIndex != -1
                              ? AppColor.golden
                              : AppColor.newGolden,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "التالي",
                        style: kTextStyle.copyWith(color: AppColor.white),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        );
      })),
    );
  }
}
