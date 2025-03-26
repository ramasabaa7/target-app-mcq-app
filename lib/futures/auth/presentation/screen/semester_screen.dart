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

class SemesterScreen extends StatelessWidget {
  const SemesterScreen({super.key});

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
                          defaultWidget: const Text("def"),
                          loadingWidget: shimmerChapter(),
                          requestState: controller.getSemestersState,
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
                                  controller.selectSemester,
                                  style: kTextStyle.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                              ),
                              10.verticalSpace,
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return 10.verticalSpace;
                                  },
                                  itemCount: controller.semesterList.length,
                                  itemBuilder: (context, index) {
                                    return TanimateList(
                                      index: index,
                                      child: ZoomTapAnimation(
                                        onTap: () {
                                          controller.setSemester(index);
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
                                                          .selectedSemesterIndex ==
                                                      index
                                                  ? AppColor.golden
                                                  : AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            controller.semesterList[index].name,
                                            style: kTextStyle.copyWith(
                                              color: controller
                                                          .selectedSemesterIndex ==
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
                      // await box.write(
                      //     SEMESTERID,
                      //     controller
                      //         .semesterList[controller.selectedSemesterIndex]
                      //         .pivot
                      //         .id);

                      // await box.write(
                      //     SUBJECTTRACK,
                      //     box.read(SUBJECTTRACK) +
                      //         "-" +
                      //         controller
                      //             .semesterList[
                      //                 controller.selectedSemesterIndex]
                      //             .name);

                      Get.offAllNamed(AppRouter.kMainScreen);
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
                          color: controller.selectedSemesterIndex != -1
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
