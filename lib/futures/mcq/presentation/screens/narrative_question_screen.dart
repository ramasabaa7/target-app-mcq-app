import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_expanssion_list_tile.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/mcq_details.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NarrativeQuestionScreen extends StatelessWidget {
  const NarrativeQuestionScreen({super.key});
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
                  Get.find<McqController>().getNarrativeQuestion(refresh: true);
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
        color: Theme.of(context).scaffoldBackgroundColor,
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
                                Get.find<SubjectController>()
                                    .currentLecture
                                    .name,
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
                              icon: Icon(Icons.refresh),
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
                child: GetBuilder<McqController>(builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: HandleView(
                      loadingWidget: shimmerChapter(),
                      requestState: controller.getNarrativeQuestionState,
                      errorWidget: CustomError(
                          message: controller.getNarrativeQuestionMessage,
                          onTap: () {
                            controller.getNarrativeQuestion();
                          }),
                      defaultWidget: const Text("data"),
                      successWidget: ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          itemBuilder: (context, index) {
                            return CustomExpanssionListTile(
                                index: index,
                                image: controller
                                    .narrativeQuestionList[index].image2,
                                // backgroundColor:
                                //     AppColor.blue.withOpacity(0.1),
                                //  childrenPadding: EdgeInsets.all(10.w),
                                title: controller
                                    .narrativeQuestionList[index].body,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "الجواب",
                                        style: kTextStyle.copyWith(
                                            color: AppColor.golden),
                                      ),
                                    ),
                                    Container(
                                      // color: AppColor.white,
                                      child: Align(
                                        alignment: isEnglishOnly(controller
                                                .narrativeQuestionList[index]
                                                .answers[0]
                                                .body)
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Directionality(
                                          textDirection: isEnglishOnly(
                                                  controller
                                                      .narrativeQuestionList[
                                                          index]
                                                      .answers[0]
                                                      .body)
                                              ? TextDirection.ltr
                                              : TextDirection.rtl,
                                          child: Text(
                                            controller
                                                .narrativeQuestionList[index]
                                                .answers[0]
                                                .body,
                                            style: kTextStyle.copyWith(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    10.verticalSpace,
                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child:
                                    //       NarrativeFavoriteWidget(index: index),
                                    // ),
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return 20.verticalSpace;
                          },
                          itemCount: controller.narrativeQuestionList.length),
                    ),
                  );
                }),
              )
            ],
          ),
        )));
  }
}

class NarrativeFavoriteWidget extends StatefulWidget {
  final int index;

  const NarrativeFavoriteWidget({
    super.key,
    required this.index,
  });

  @override
  State<NarrativeFavoriteWidget> createState() =>
      _NarrativeFavoriteWidgetState();
}

class _NarrativeFavoriteWidgetState extends State<NarrativeFavoriteWidget> {
  var controller = Get.find<McqController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.currentQuestion =
            controller.narrativeQuestionList[widget.index];
        controller.toggleFavoriteNarrative();
        setState(() {});
      },
      child: McqDetailsCard(
        color: controller.narrativeQuestionList[widget.index].isFavorite == true
            ? AppColor.red
            : AppColor.darkGrey,
        svgPath: 'assets/svg/heart-mcq.svg',
      ),
    );
  }
}
