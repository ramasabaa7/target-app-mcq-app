import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:dopamin/futures/subjects/presentation/screens/exam_cycles_screen.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/display_counts_widget.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/sub_subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Theme.of(context).canvasColor,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 15.h, vertical: 30.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10.h, left: 10),
                            child: ZoomTapAnimation(
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
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              Get.find<HomeController>().currentSubject.name,
                              style: kTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                         
                        ],
                      ),
                      30.verticalSpace,
                      const DisplayCountsWidget(),
                 
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: kVerticalPadding),
                      itemCount: svgPath.length,
                      itemBuilder: (context, index) {
                        return TanimateList(
                          index: index,
                          child: SubSubjectCard(
                            svgPath: svgPath[index],
                            onTap: () {
                              if (index == 0) {
                                Get.toNamed(AppRouter.kExamCyclesScreen);
                              }
                              if (index == 1) {
                                Get.toNamed(AppRouter.kCategoriesScreen);
                              }

                              if (index == 2) {
                                Get.toNamed(AppRouter.kLecturesScreen);
                              }
                              if (index == 3) {
                                Get.toNamed(AppRouter.kFavoriteQuestionsScreen);
                              }

                              if (index == 4) {
                                Get.toNamed(AppRouter.kAboutSubjectScreen);
                              }
                              if (index == 5) {
                                Get.toNamed(AppRouter.hintsScreen);
                              }
                            },
                            title: titles[index],
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3.8 / 4,
                      ),
                      physics: const ClampingScrollPhysics(),
                    ),

                    // Padding(
                    //   padding: EdgeInsetsDirectional.symmetric(
                    //       vertical: 10.h, horizontal: 15.w),
                    //   child: Container(
                    //     padding: EdgeInsetsDirectional.symmetric(
                    //         horizontal: 20, vertical: 15.h),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         colors: [AppColor.lightGolden, AppColor.newGolden],
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsetsDirectional.symmetric(
                    //           horizontal: 5.w, vertical: 15.h),
                    //       child: Row(
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 ' حافظ على تقدمك',
                    //                 style: whiteBigTextStyle,
                    //               ),
                    //               10.verticalSpace,
                    //               Text(
                    //                 'نتيجنك الحالية :',
                    //                 style: whiteBigTextStyle.copyWith(
                    //                     fontSize: 17.sp,
                    //                     fontWeight: FontWeight.w500),
                    //               )
                    //             ],
                    //           ),
                    //           const Spacer(),
                    //           CircularPercentIndicator(
                    //             radius: 45.0,
                    //             lineWidth: 3.0,
                    //             animation: true,
                    //             percent: 0.25,
                    //             center: Text(
                    //               "25%",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: AppColor.newScafold,
                    //                   fontSize: 15.0.sp),
                    //             ),
                    //             circularStrokeCap: CircularStrokeCap.round,
                    //             progressColor: AppColor.textBlack,
                    //             backgroundColor: AppColor.newScafold,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    if (Get.find<HomeController>()
                            .currentSubject
                            .subjectContactNumber !=
                        "لايوجد رقم حالياٌ") ...[
                      GestureDetector(
                        onTap: () {
                          launch(
                              "tg://resolve?domain=${Get.find<HomeController>().currentSubject.subjectContactNumber}");
                        },
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).canvasColor),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "للتواصل العلمي والإستفسار",
                                      style: kTextStyle.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    10.horizontalSpace,
                                    const FaIcon(
                                      FontAwesomeIcons.telegram,
                                      color: AppColor.telegramColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> svgPath = [
  'assets/svg/exam-cycles.svg',
  'assets/svg/category.svg',
  'assets/svg/srd.svg',
  'assets/svg/heart.svg',
  'assets/svg/about.svg',
  'assets/svg/lamp2.svg',
];

List<String> titles = [
  'الاتمتة',
  'التصنيفات',
  'الأسئلة',
  'المفضلة',
  'حول المادة',
  'التلميحات',
];
