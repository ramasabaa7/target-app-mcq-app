import 'package:dopamin/core/services/enums.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/custom_text_field.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/count_time.dart';
import 'package:dopamin/futures/mcq/presentation/widget/dotted_line.dart';
import 'package:dopamin/futures/mcq/presentation/widget/question_mcq_widget.dart';
import 'package:dopamin/futures/mcq/presentation/widget/result_widget.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class McqScreen extends StatefulWidget {
  const McqScreen({super.key});

  @override
  State<McqScreen> createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<McqController>().getQuestionsState = RequestState.loading;
    Future.delayed(const Duration(milliseconds: 500)).then((v) {
      Get.previousRoute == "/categoriesScreen"
          ? Get.find<McqController>().getQuestionsByCategoryIdKindId()
          : Get.find<McqController>().getQuestionsByExamCycleId();
    });
  }

  final ScrollController _scrollController = ScrollController();
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
                  Get.find<McqController>()
                      .getQuestionsByExamCycleId(refresh: true);
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
    return WillPopScope(
      onWillPop: () async {
        Get.find<McqController>().clearResult();
        Get.back();
        return true;
      },
      child: Scaffold(
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton:
              GetBuilder<McqController>(builder: (controller) {
            return (controller.getQuestionsState == RequestState.success &&
                    controller.visibleResult == false)
                ? ExpandableFab(
                    pos: ExpandableFabPos.left,
                    distance: 80.h,

                    // openButtonBuilder: FloatingActionButtonBuilder(
                    //     builder: (context, onPressed, progress) => Container(
                    //           color: AppColor.newRed,
                    //           height: 20,
                    //           width: 20,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15)),
                    //         ),
                    //     size: 15),
                    // closeButtonBuilder: FloatingActionButtonBuilder(
                    //     builder: (context, onPressed, progress) => Container(
                    //           color: AppColor.newRed,
                    //           height: 20,
                    //           width: 20,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15)),
                    //         ),
                    //     size: 5),
                    type: ExpandableFabType.up,
                    closeButtonBuilder: FloatingActionButtonBuilder(
                      size: 120,
                      builder: (context, onPressed, progress) => Container(
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                                color: AppColor.newGolden, width: 2)),
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: AppColor.newGolden,
                        ),
                      ),
                    ),
                    openButtonBuilder: FloatingActionButtonBuilder(
                      size: 120,
                      builder: (context, onPressed, progress) => Container(
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.newGolden,
                            borderRadius: BorderRadius.circular(17)),
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    children: [
                      /*   FloatingActionButton.extended(
                          backgroundColor: AppColor.blue,
                          heroTag: "1",
                          label: Text(
                            "تشغيل المؤقت",
                            style: kTextStyle.copyWith(color: AppColor.white),
                          ),
                          onPressed: () {},
                        ), */
                      FloatingActionButton.extended(
                        backgroundColor: AppColor.newGolden,
                        heroTag: "2",
                        label: Text(
                          "تصفير الأجوبة",
                          style: kTextStyle.copyWith(
                              color: AppColor.white, fontSize: 12.sp),
                        ),
                        onPressed: () {
                          controller.clearAnswers();
                          controller.questionsList.forEach((element) {
                            element.isCorrect = false;
                          });
                        },
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: AppColor.newGolden,
                        heroTag: "3",
                        label: Text(
                          "عرض النتيجة",
                          style: kTextStyle.copyWith(
                              color: AppColor.white, fontSize: 12.sp),
                        ),
                        onPressed: () {
                          controller.viewResult();

                          _scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: AppColor.newGolden,
                        label: Text(
                          "عرض الاجوبة الصحيحة",
                          style: kTextStyle.copyWith(
                              color: AppColor.white, fontSize: 12.sp),
                        ),
                        onPressed: () {
                          controller.correctAllAnswer();
                        },
                      ),
                    ],
                  )
                : const SizedBox();
          }),
          body: SafeArea(
            child: GetBuilder<McqController>(builder: (controller) {
              return Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 20.w,
                                top: 20.h,
                                end: 10.w,
                                bottom: 20.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ZoomTapAnimation(
                                      onTap: () {
                                        controller.clearResult();
                                        Get.back();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13.h, horizontal: 13.w),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: CustomSvg(
                                            svgPath: 'assets/svg/back.svg',
                                            color:
                                                Theme.of(context).canvasColor,
                                            size: 18,
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        Get.find<HomeController>()
                                            .currentSubject
                                            .name,
                                        maxLines: 3,
                                        style: kTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            color: Theme.of(context).hintColor),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                  ],
                                ),
                                //   : _buildSearchField(controller),
                                const Divider(
                                  height: 30,
                                  endIndent: 10,
                                  indent: 10,
                                  color: AppColor.dividerGray,
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    10.horizontalSpace,

                                    5.horizontalSpace,
                                    if (controller.visibleResult) ...[
                                      20.verticalSpace,
                                      ResultWidget(
                                        mcqController: controller,
                                      ),
                                      20.verticalSpace,
                                      const Divider(
                                        color: AppColor.white,
                                        thickness: 5,
                                      ),
                                    ] else ...[
                                      Row(
                                        children: [
                                          CustomSvg(
                                            svgPath: 'assets/svg/clock.svg',
                                            size: 20,
                                            color: Theme.of(context).hintColor,
                                          ),
                                          20.horizontalSpace,
                                          const CounterTime(),
                                        ],
                                      )
                                    ],
                                    const Spacer(),
                                    // Container(
                                    //   decoration: const BoxDecoration(
                                    //       color: AppColor.green,
                                    //       shape: BoxShape.circle),
                                    //   child: const Icon(
                                    //     Icons.check,
                                    //     color: AppColor.white,
                                    //     size: 20,
                                    //   ),
                                    // ),
                                    // 10.horizontalSpace,
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: AppColor.newRed,
                                    //       shape: BoxShape.circle),
                                    //   child: Icon(
                                    //     Icons.close,
                                    //     color: AppColor.white,
                                    //     size: 20,
                                    //   ),
                                    // ),
                                    // 30.horizontalSpace,
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
                        // Container(
                        //   color: AppColor.white,
                        //   height: 10,
                        //   width: double.infinity,
                        //   child: Center(
                        //     child:
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          20.verticalSpace,
                          Container(
                            margin: EdgeInsetsDirectional.symmetric(
                                horizontal: 30.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.verticalSpace,
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    CustomTextField(
                                      verticalPadding: 10,
                                      fillColor: Theme.of(context).canvasColor,
                                      labelText: "بحث",
                                      focusNode: controller.focusNode,
                                      textEditingController:
                                          controller.searchController,
                                      prefixIconData: const Icon(Icons.search),
                                      onChanged: (query) {
                                        controller.onSearch(query);
                                      },
                                    ),
                                    ZoomTapAnimation(
                                        onTap: () {
                                          controller.deleteSearchQuery();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5.w),
                                          padding: EdgeInsets.all(1.w),
                                          decoration: const BoxDecoration(
                                              color: AppColor.white,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.close,
                                            size: 15.h,
                                            color: AppColor.newGolden,
                                          ),
                                        )),
                                  ],
                                ),
                                20.verticalSpace,
                                Row(
                                  children: [
                                    const CustomSvg(
                                      svgPath: 'assets/svg/question.svg',
                                      size: 30,
                                      color: AppColor.newGolden,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      'اختر الإجابة الصحيحة:',
                                      style: kTextStyle.copyWith(
                                          color: Theme.of(context).hintColor),
                                    )
                                  ],
                                ),
                                10.verticalSpace,
                                // Text(
                                //   "ملاحظة : ${Get.find<SubjectController>().currentExamCycle.note}",
                                //   style: kTextStyle.copyWith(fontSize: 15.sp),
                                // ),
                              ],
                            ),
                          ),
                          HandleView(
                            requestState: controller.getQuestionsState,
                            errorWidget: CustomError(
                              message: controller.getQuestionMessage,
                              onTap: () {
                                controller.getQuestionsByExamCycleId();
                              },
                            ),
                            loadingWidget: Padding(
                              padding: EdgeInsets.all(kHorizontalPadding),
                              child: shimmerMcq(),
                            ),
                            defaultWidget: const Text("def"),
                            successWidget: controller.questionsList.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) {
                                      return 10.verticalSpace;
                                    },
                                    itemCount: controller.questionsList.length,
                                    itemBuilder: (context, index) {
                                      return QuestionMcqWidget(
                                        controller: controller,
                                        index: index,
                                      );
                                    },
                                  )
                                : const EmptyFolderWidget(
                                    textt: 'لا يوجد أسئلة لعرضها',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }
}
