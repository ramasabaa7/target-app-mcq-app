import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_loading.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/exam_cycles_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(builder: (controller) {
      return HandleView(
        requestState: controller.getCategoriesState,
        errorWidget: CustomError(
            message: controller.getCategoriesMessage,
            onTap: () {
              controller.getCategories();
            }),
        loadingWidget: const CustomLoading(),
        defaultWidget: const Text("def"),
        successWidget: ListView.separated(
          itemCount: controller.categoriesList.length,
          separatorBuilder: (context, index) {
            return 10.verticalSpace;
          },
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 20.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSvg(
                            svgPath: 'assets/svg/teacher-mark.svg',
                            color: AppColor.newGolden,
                            size: 20,
                          ),
                          10.horizontalSpace,
                          Text(
                            controller.categoriesList[index].name,
                            style: kTextStyle.copyWith(
                                fontSize: 16.sp,
                                color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                     
                    ],
                  ),
                ),
                10.verticalSpace,
                controller.categoriesList[index].kinds.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: 2 / 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index2) {
                          return InkWell(
                            onTap: () {
                              if (controller.categoriesList[index].kinds[index2]
                                      .isLocked ==
                                  false) {
                                controller.currentCategoryId =
                                    controller.categoriesList[index].id;
                                controller.currentExamCycle = controller
                                    .categoriesList[index].kinds[index2];
                                Get.toNamed(AppRouter.kMcqScreen);
                              }
                            },
                            child: ExamCyclesCard(
                              examCycle: controller
                                  .categoriesList[index].kinds[index2],
                            ),
                          );
                        },
                        itemCount:
                            controller.categoriesList[index].kinds.length)
                    : Container(
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical: 60.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'لا يوجد اختبارات',
                          style: kTextStyle.copyWith(
                              fontSize: 13.sp,
                              color: Theme.of(context).hintColor),
                        ))
              ],
            );
          },
        ),
      );
    });
  }
}
