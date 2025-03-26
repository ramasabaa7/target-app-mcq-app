import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_button.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController(Get.find())).getCities();

    return Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: 30.h, horizontal: 10.w),
            child: GetBuilder<MainController>(builder: (controller) {
              return CustomButton(
                  text: "حفظ",
                  press: () async {
                    if (controller.selectedAcademicYearIndex != -1 &&
                        controller.selectedCityIndex != -1) {
                      await box.write(
                          SEMESTERID,
                          controller
                              .academicYearList[
                                  controller.selectedAcademicYearIndex]
                              .pivot
                              .id);

                      await box.write(
                          ACADENICYEARIDPIOVIT,
                          controller
                              .specificationList[
                                  controller.selectedSpecificationIndex]
                              .pivot
                              .id);

                      String temp =
                          "${controller.citiesList[controller.selectedCityIndex].name}-${controller.specificationList[controller.selectedSpecificationIndex].name}";

                      await box.write(SUBJECTTRACK, temp);

                      // await Hive.box<Subject>('subjects').clear();
                      // await Hive.box<ExamCycle>('examCycle').clear();
                      // await Hive.box<CategoryM>('categoryM').clear();
                      // await Hive.box<Question>('question').clear();

                      Get.find<BottomNavBarController>().selectedIndexScreens =
                          0;
                      Get.find<BottomNavBarController>().update();
                      Get.offAllNamed(AppRouter.kMainScreen);
                    } else {
                      Functions.showSnackbarFailed(
                          "يرجى اختيار جميع المعلومات");
                    }
                  });
            }),
          ),
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CenterAppBar(
                    onTap: () {
                      Get.back();
                    },
                    title: "تعديل المعلومات"),
              ),
              SliverFillRemaining(child: SingleChildScrollView(
                child: GetBuilder<MainController>(builder: (controller) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          35.verticalSpace,
                          Text(
                            controller.selectCity,
                            style: kTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          10.verticalSpace,

                          // المحافظة
                          HandleView(
                            errorWidget: CustomError(
                                message: "Try again",
                                onTap: () {
                                  controller.getCities();
                                }),
                            requestState: controller.getCitiesState,
                            loadingWidget: Row(
                              children: [
                                shimmer(height: 60.h, width: 150.h),
                                10.horizontalSpace,
                                shimmer(height: 60.h, width: 150.h),
                              ],
                            ),
                            defaultWidget: const Text("data"),
                            successWidget: Wrap(
                                runSpacing: 10.w,
                                spacing: 10.w,
                                children: List.generate(
                                    controller.citiesList.length, (index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Material(
                                      color:
                                          controller.selectedCityIndex == index
                                              ? AppColor.white
                                              : AppColor.newGolden,
                                      child: InkWell(
                                        onTap: () {
                                          controller.selectedSemesterIndex = -1;
                                          controller.selectedAcademicYearIndex =
                                              -1;
                                          controller
                                              .selectedSpecificationIndex = -1;
                                          controller.selectedCityIndex = index;
                                          controller.getSpecifications();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: AppColor.newRed),
                                              color: controller
                                                          .selectedCityIndex ==
                                                      index
                                                  ? AppColor.newGolden
                                                  : AppColor.newGray,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            controller.citiesList[index].name,
                                            style: kTextStyle.copyWith(
                                                fontSize: 13.sp,
                                                color: controller
                                                            .selectedCityIndex ==
                                                        index
                                                    ? AppColor.white
                                                    : AppColor.textBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                          ),
                          20.verticalSpace,
                          if (controller.selectedCityIndex != -1) ...[
                            Text(
                              controller.selectSpecification,
                              style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: Theme.of(context).hintColor),
                            ),
                            10.verticalSpace,

                            //الكلية
                            HandleView(
                              defaultWidget: const Text("def"),
                              loadingWidget: Row(
                                children: [
                                  shimmer(height: 60.h, width: 150.h),
                                  10.horizontalSpace,
                                  shimmer(height: 60.h, width: 150.h),
                                ],
                              ),
                              requestState: controller.getSpecificationsState,
                              errorWidget: CustomError(
                                  message: "Try Again",
                                  onTap: () {
                                    controller.getSpecifications();
                                  }),
                              successWidget: Wrap(
                                  runSpacing: 10.w,
                                  spacing: 10.w,
                                  children: List.generate(
                                      controller.specificationList.length,
                                      (index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: controller
                                                    .selectedSpecificationIndex ==
                                                index
                                            ? AppColor.white
                                            : AppColor.newGolden,
                                        child: InkWell(
                                          onTap: () {
                                            controller.selectedSemesterIndex =
                                                0;
                                            controller
                                                .selectedAcademicYearIndex = 0;
                                            controller
                                                    .selectedSpecificationIndex =
                                                index;
                                            controller.getAcademicYear();
                                            // print(
                                            //     "${controller.specificationList[controller.selectedSpecificationIndex].pivot.id}");
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(10.w),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                              .selectedSpecificationIndex ==
                                                          index
                                                      ? AppColor.newGolden
                                                      : AppColor.newGray,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .symmetric(
                                                        horizontal: 30.h),
                                                child: Text(
                                                  controller
                                                      .specificationList[index]
                                                      .name,
                                                  style: kTextStyle.copyWith(
                                                      fontSize: 13.sp,
                                                      color: controller
                                                                  .selectedSpecificationIndex ==
                                                              index
                                                          ? AppColor.white
                                                          : AppColor.textBlack),
                                                ),
                                              )),
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                          20.verticalSpace,
                          ////////// year
                          // if (controller.selectedSpecificationIndex != -1) ...[
                          //   Text(
                          //     controller.selectYear,
                          //     style: kTextStyle.copyWith(
                          //         fontWeight: FontWeight.bold, fontSize: 17.sp),
                          //   ),
                          //   10.verticalSpace,

                          //   // االسنه
                          //   HandleView(
                          //     defaultWidget: const Text("def"),
                          //     loadingWidget: Row(
                          //       children: [
                          //         shimmer(height: 60.h, width: 150.h),
                          //         10.horizontalSpace,
                          //         shimmer(height: 60.h, width: 150.h),
                          //       ],
                          //     ),
                          //     requestState: controller.getAcademicYearState,
                          //     errorWidget: CustomError(
                          //         message: "Try Again",
                          //         onTap: () {
                          //           controller.getAcademicYear();
                          //         }),
                          //     successWidget: Wrap(
                          //         runSpacing: 10.w,
                          //         spacing: 10.w,
                          //         children: List.generate(
                          //             controller.academicYearList.length,
                          //             (index) {
                          //           return ClipRRect(
                          //             borderRadius: BorderRadius.circular(10),
                          //             child: Material(
                          //               color: controller
                          //                           .selectedAcademicYearIndex ==
                          //                       index
                          //                   ? AppColor.white
                          //                   : AppColor.newGolden,
                          //               child: InkWell(
                          //                 onTap: () {
                          //                   controller.selectedSemesterIndex =
                          //                       -1;
                          //                   controller
                          //                       .selectedAcademicYearIndex = 0;
                          //                   controller.getSemesters();

                          //                   print(
                          //                       "${controller.academicYearList[controller.selectedAcademicYearIndex].pivot.id}yearrr rori \n");
                          //                 },
                          //                 child: Container(
                          //                     padding: EdgeInsets.all(10.w),
                          //                     decoration: BoxDecoration(
                          //                         color: controller
                          //                                     .selectedAcademicYearIndex ==
                          //                                 index
                          //                             ? AppColor.newGolden
                          //                             : AppColor.newGray,
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 10)),
                          //                     child: Padding(
                          //                       padding: EdgeInsetsDirectional
                          //                           .symmetric(
                          //                               horizontal: 15.w,
                          //                               vertical: 0.h),
                          //                       child: Text(
                          //                         controller
                          //                             .academicYearList[index]
                          //                             .name,
                          //                         style: kTextStyle.copyWith(
                          //                             fontSize: 13.sp,
                          //                             color: controller
                          //                                         .selectedAcademicYearIndex ==
                          //                                     index
                          //                                 ? AppColor.white
                          //                                 : AppColor.textBlack),
                          //                       ),
                          //                     )),
                          //               ),
                          //             ),
                          //           );
                          //         })),
                          //   ),
                          // ],
                          // ////

                          // 20.verticalSpace,
                          // //16389
                          // if (controller.selectedAcademicYearIndex != -1) ...[
                          //   Text(
                          //     controller.selectSemester,
                          //     style: kTextStyle.copyWith(
                          //         fontWeight: FontWeight.bold, fontSize: 17.sp),
                          //   ),
                          //   10.verticalSpace,

                          //   // الفصل

                          //   HandleView(
                          //     defaultWidget: const Text("def"),
                          //     loadingWidget: Row(
                          //       children: [
                          //         shimmer(height: 60.h, width: 150.h),
                          //         10.horizontalSpace,
                          //         shimmer(height: 60.h, width: 150.h),
                          //       ],
                          //     ),
                          //     requestState: controller.getSemestersState,
                          //     errorWidget: CustomError(
                          //         message: "Try Again",
                          //         onTap: () {
                          //           controller.getSemesters();
                          //         }),
                          //     successWidget: Wrap(
                          //         runSpacing: 10.w,
                          //         spacing: 10.w,
                          //         children: List.generate(
                          //             controller.semesterList.length, (index) {
                          //           return ClipRRect(
                          //             borderRadius: BorderRadius.circular(10),
                          //             child: Material(
                          //               color:
                          //                   controller.selectedSemesterIndex ==
                          //                           index
                          //                       ? AppColor.newGolden
                          //                       : AppColor.white,
                          //               child: InkWell(
                          //                 onTap: () {
                          //                   controller.selectedSemesterIndex =
                          //                       index;
                          //                   controller.update();
                          //                   print(
                          //                       "${controller.semesterList[controller.selectedSemesterIndex].pivot.id}semester rori \n");
                          //                 },
                          //                 child: Container(
                          //                   padding: EdgeInsets.all(10.w),
                          //                   decoration: BoxDecoration(
                          //                       color: controller
                          //                                   .selectedSemesterIndex ==
                          //                               index
                          //                           ? AppColor.newGolden
                          //                           : AppColor.newGray,
                          //                       borderRadius:
                          //                           BorderRadius.circular(10)),
                          //                   child: Text(
                          //                     controller
                          //                         .semesterList[index].name,
                          //                     style: kTextStyle.copyWith(
                          //                         fontSize: 13.sp,
                          //                         color: controller
                          //                                     .selectedSemesterIndex ==
                          //                                 index
                          //                             ? AppColor.white
                          //                             : AppColor.textBlack),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         })),
                          //   ),
                          //  ],
                        ],
                      ),
                    ),
                  );
                }),
              ))
            ],
          ),
        )));
  }
}
