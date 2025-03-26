import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_loading.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/lecture_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen({super.key});
  Future<void> _refreshHints() async {
    // Call the refresh method in your controller
    await Get.dialog(AlertDialog(
      content: Text(
        "تنبيه:  سيتم تحديث البيانات الحالية , تأكد من اتصالك بالانترنت",
        textAlign: TextAlign.center,
        style: kTextStyle,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColor.scaffoldColor,
              ),
              child: Text(
                'إلغاء',
                style: kTextStyle.copyWith(fontSize: 15.sp),
              ),
              onPressed: () {
                Get.back(result: false);
              },
            ),
            SizedBox(
              width: 10.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColor.newGolden,
                ),
                onPressed: () {
                  Get.find<SubjectController>().getLectures(refresh: true);
                  Get.back(result: false);
                },
                child: Text(
                  'موافق',
                  style: kTextStyle.copyWith(
                      fontSize: 15.sp, color: AppColor.white),
                )),
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
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
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 20.w, top: 20.h, end: 10.w, bottom: 20.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ZoomTapAnimation(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 13.w),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).highlightColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CustomSvg(
                                    svgPath: 'assets/svg/back.svg',
                                    color: Theme.of(context).canvasColor,
                                    size: 18,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                textAlign: TextAlign.center,
                                "المحاضرات",
                                maxLines: 3,
                                style: kTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await _refreshHints();
                              },
                              icon: const Icon(Icons.refresh),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //  CenterAppBar(
                //   title: Get.find<HomeController>().currentSubject.name,
                //   onTap: () {
                //     Get.back();
                //   },
                //   withRefresh: true,
                //   onRefresh: () {
                //     Get.find<SubjectController>().getExamCycles(refresh: true);
                //   },
                // ),
              ),
              SliverFillRemaining(
                child: GetBuilder<SubjectController>(builder: (controller) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: HandleView(
                      requestState: controller.getLecturesState,
                      loadingWidget: const CustomLoading(),
                      defaultWidget: const Text("def"),
                      errorWidget: CustomError(
                          message: controller.getLecturesMessage,
                          onTap: () {
                            controller.getLectures();
                          }),
                      successWidget: controller.lecturesList.isNotEmpty
                          ? AnimationLimiter(
                              child: ListView.separated(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemBuilder: (context, index) {
                                    return TanimateList(
                                      index: index,
                                      child: ZoomTapAnimation(
                                        onTap: () {
                                          if (!controller
                                              .lecturesList[index].isLocked) {
                                            controller.currentLecture =
                                                controller.lecturesList[index];
                                            Get.toNamed(AppRouter
                                                .kNarrativeQuestionScreen);
                                          }
                                        },
                                        child: LectureCard(
                                            lecture:
                                                controller.lecturesList[index]),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return 10.verticalSpace;
                                  },
                                  itemCount: controller.lecturesList.length))
                          : const EmptyFolderWidget(
                              textt: 'لا يوجد محاضرات لعرضها',
                            ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
