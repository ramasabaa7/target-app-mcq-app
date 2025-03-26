import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_loading.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/hint_conrtoller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/exam_cycles_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:dopamin/core/utils/text_style.dart';

class HintsScreen extends StatelessWidget {
  const HintsScreen({super.key});
  //SubjectController controller = Get.find<SubjectController>();

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
                  Get.find<HintConrtoller>().hint(refresh: true);
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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(
                                textAlign: TextAlign.center,
                                'التلميحات',
                                maxLines: 3,
                                style: kTextStyle.copyWith(
                                    fontSize: 17.sp,
                                    color: Theme.of(context).hintColor),
                              ),
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
            ),
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: GetBuilder<HintConrtoller>(builder: (controller) {
                  return HandleView(
                      defaultWidget: const Text("def"),
                      loadingWidget:  shimmerChapter(),
                      requestState: controller.hintState,
                      errorWidget: CustomError(
                          message: controller.hintMessage,
                          onTap: () {
                            controller.hint();
                          }),
                      successWidget: list(controller));
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget list(HintConrtoller controller) {
    return controller.hintsModel.hints.isNotEmpty
        ? AnimationLimiter(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return ZoomTapAnimation(
                  child: Container(
                      width: Get.width * 0.8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.lightGrey.withOpacity(0.05),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).canvasColor,
                      ),
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundColor: AppColor.golden,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${index + 1}',
                                      style: whiteSmallTextStyle.copyWith(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              controller.hintsModel.hints[index].toString(),
                              style: whiteSmallTextStyle.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                          )
                        ],
                      )),
                );
              },
              itemCount: controller.hintsModel.hints.length,
              separatorBuilder: (BuildContext context, int index) {
                return 10.verticalSpace;
              },
            ),
          )
        : const EmptyFolderWidget(
            textt: 'لا يوجد تلميحات للمادة',
          );
  }
}
