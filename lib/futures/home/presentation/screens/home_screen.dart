import 'dart:io';

import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/home/presentation/widgets/active_codes.dart';
import 'package:dopamin/futures/home/presentation/widgets/carousol.dart';
import 'package:dopamin/futures/home/presentation/widgets/getyears.dart';
import 'package:dopamin/futures/home/presentation/widgets/home_subject_grid.dart';

import 'package:dopamin/futures/home/presentation/widgets/subject_list.dart';
import 'package:dopamin/futures/mcq/presentation/screens/subjcts.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(Get.find(), Get.find()));
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
          child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Get.dialog(
              AlertDialog(
                backgroundColor: AppColor.white,
                content: Text(
                  "تنبيه:  سيتم حذف البيانات الحالية وتحديثها , تأكد من وجود اتصال بالانترنت",
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
                          backgroundColor: AppColor.newScafold,
                        ),
                        child: Text(
                          'إلغاء',
                          style: kTextStyle.copyWith(fontSize: 15.sp),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
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
                          Get.find<HomeController>().getSubjects(
                              pivotId: box.read(SEMESTERID), refresh: true);
                          Get.find<HomeController>()
                              .getMySubscription(refresh: true);
                          Get.find<HomeController>().getAcademicYear(
                              pivotId: box.read(ACADENICYEARIDPIOVIT),
                              refresh: true);
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'موافق',
                          style: kTextStyle.copyWith(
                              fontSize: 15.sp, color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          child: SingleChildScrollView(
            //  physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/png/target-logo.png',
                                height: 60.h,
                              ),
                              10.horizontalSpace,
                              Text(
                                'TARGET',
                                style: kTextStyle.copyWith(
                                    letterSpacing: 7,
                                    fontSize: 20.sp,
                                    color: AppColor.newGolden),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRouter.kEditInfoScreen);
                            },
                            child: Image.asset(
                              'assets/png/edit_info.png',
                              height: 40.h,
                            ),
                          ),
                          30.horizontalSpace,
                        ],
                      ),
                      10.verticalSpace,

                      // Row(
                      //   children: [
                      //     const CustomSvg(
                      //       svgPath: "assets/svg/hand_home_icon.svg",
                      //       size: 35,
                      //     ),
                      //     10.horizontalSpace,
                      //     Text(' أهلا ${box.read(USERNAME) ?? ""} ',
                      //         style: kTextStyle.copyWith(
                      //             fontSize: 18.sp,
                      //             fontWeight: FontWeight.w600)),
                      //     SizedBox(
                      //       width: kHorizontalPadding,
                      //     ),
                      //   ],
                      // ),
                      //  10.verticalSpace,
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Row(
                          children: [
                            CustomSvg(
                              svgPath: "assets/svg/note2.svg",
                              size: 25.w,
                              color: AppColor.newGolden,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Text(
                                  box.read(SUBJECTTRACK),
                                  style: kTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const GetYears(),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Text(
                        ' مواد السنة',
                        style: kTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Theme.of(context).hintColor),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(const SubjectsScreennew());
                      },
                      child: Row(
                        children: [
                          Text('جميع المواد',
                              style: whiteSmallTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColor.newGolden)),
                          10.horizontalSpace,
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(180 / 360),
                            child: CustomSvg(
                              svgPath: "assets/svg/back.svg",
                              color: AppColor.newGolden,
                              size: 17,
                            ),
                          ),
                          20.horizontalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const HomeSubjectCard()),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 15.h, start: 30.w, bottom: 3.h),
                            child: Text(
                              'الأكواد المفعلة',
                              style: kTextStyle.copyWith(
                                fontSize: 15.sp,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const ActiveCodes(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<dynamic> confirmClose(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text('Confirm Exit'),
            content: Text(
              'هل متأكد من إغلاق التطبيق ؟',
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
                      Navigator.of(context).pop(false);
                    },
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColor.golden,
                    ),
                    child: Text(
                      'تأكيد',
                      style: kTextStyle.copyWith(
                          fontSize: 15.sp, color: AppColor.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              )
            ],
          );
        });

    //   return Container(
    //     color: Theme.of(context).scaffoldBackgroundColor,
    //     child: SafeArea(
    //         child: Scaffold(
    //       body: RefreshIndicator(
    //         onRefresh: () async {
    //           await Get.dialog(
    //             AlertDialog(
    //               backgroundColor: AppColor.white,
    //               content: Text(
    //                 "تنبيه:  سيتم حذف البيانات الحالية وتحديثها , تأكد من وجود اتصال بالانترنت",
    //                 textAlign: TextAlign.center,
    //                 style: kTextStyle,
    //               ),
    //               actions: <Widget>[
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         elevation: 0,
    //                         backgroundColor: AppColor.newScafold,
    //                       ),
    //                       child: Text(
    //                         'إلغاء',
    //                         style: kTextStyle.copyWith(fontSize: 15.sp),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.of(context).pop(false);
    //                       },
    //                     ),
    //                     SizedBox(
    //                       width: 10.h,
    //                     ),
    //                     ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         elevation: 0,
    //                         backgroundColor: AppColor.newGolden,
    //                       ),
    //                       onPressed: () {
    //                         Get.find<HomeController>().getSubjects(
    //                             pivotId: box.read(SEMESTERID), refresh: true);
    //                         Get.find<HomeController>()
    //                             .getMySubscription(refresh: true);
    //                         Get.find<HomeController>().getAcademicYear(
    //                             pivotId: box.read(ACADENICYEARIDPIOVIT));
    //                         Navigator.of(context).pop(false);
    //                       },
    //                       child: Text(
    //                         'موافق',
    //                         style: kTextStyle.copyWith(
    //                             fontSize: 15.sp, color: AppColor.white),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: <Widget>[
    //               Padding(
    //                 padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w),
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Image.asset(
    //                               'assets/png/target-logo.png',
    //                               height: 60.h,
    //                             ),
    //                             10.horizontalSpace,
    //                             Text(
    //                               'TARGET',
    //                               style: kTextStyle.copyWith(
    //                                   letterSpacing: 7,
    //                                   fontSize: 20.sp,
    //                                   color: AppColor.newGolden),
    //                             ),
    //                           ],
    //                         ),
    //                         const Spacer(),
    //                         InkWell(
    //                           onTap: () {
    //                             Get.toNamed(AppRouter.kEditInfoScreen);
    //                           },
    //                           child: Image.asset(
    //                             'assets/png/edit_info.png',
    //                             height: 40.h,
    //                           ),
    //                         ),
    //                         30.horizontalSpace,
    //                       ],
    //                     ),
    //                     10.verticalSpace,

    //                     // Row(
    //                     //   children: [
    //                     //     const CustomSvg(
    //                     //       svgPath: "assets/svg/hand_home_icon.svg",
    //                     //       size: 35,
    //                     //     ),
    //                     //     10.horizontalSpace,
    //                     //     Text(' أهلا ${box.read(USERNAME) ?? ""} ',
    //                     //         style: kTextStyle.copyWith(
    //                     //             fontSize: 18.sp,
    //                     //             fontWeight: FontWeight.w600)),
    //                     //     SizedBox(
    //                     //       width: kHorizontalPadding,
    //                     //     ),
    //                     //   ],
    //                     // ),
    //                     //  10.verticalSpace,
    //                     Padding(
    //                       padding: EdgeInsetsDirectional.only(start: 10.w),
    //                       child: Row(
    //                         children: [
    //                           CustomSvg(
    //                             svgPath: "assets/svg/note2.svg",
    //                             size: 25.w,
    //                             color: AppColor.newGolden,
    //                           ),
    //                           Expanded(
    //                             child: Padding(
    //                               padding: EdgeInsetsDirectional.symmetric(
    //                                   horizontal: 10.w, vertical: 10.h),
    //                               child: Text(
    //                                 box.read(SUBJECTTRACK),
    //                                 style: kTextStyle.copyWith(
    //                                     fontSize: 15.sp,
    //                                     color: Theme.of(context).hintColor,
    //                                     fontWeight: FontWeight.w600),
    //                               ),
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const GetYears(),
    //               Row(
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsetsDirectional.symmetric(
    //                         horizontal: 30.w, vertical: 10.h),
    //                     child: Text(
    //                       ' مواد السنة',
    //                       style: kTextStyle.copyWith(
    //                           fontWeight: FontWeight.w600,
    //                           fontSize: 14.sp,
    //                           color: Theme.of(context).hintColor),
    //                     ),
    //                   ),
    //                   const Spacer(),
    //                   InkWell(
    //                     onTap: () {
    //                       Get.to(const SubjectsScreennew());
    //                     },
    //                     child: Row(
    //                       children: [
    //                         Text('جميع المواد',
    //                             style: whiteSmallTextStyle.copyWith(
    //                                 fontWeight: FontWeight.w400,
    //                                 fontSize: 14.sp,
    //                                 color: AppColor.newGolden)),
    //                         10.horizontalSpace,
    //                         const RotationTransition(
    //                           turns: AlwaysStoppedAnimation(180 / 360),
    //                           child: CustomSvg(
    //                             svgPath: "assets/svg/back.svg",
    //                             color: AppColor.newGolden,
    //                             size: 17,
    //                           ),
    //                         ),
    //                         20.horizontalSpace,
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.symmetric(vertical: 10.h),
    //                   child: const HomeSubjectCard()),
    //               Row(
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsetsDirectional.only(top: 30, start: 30.w),
    //                     child: Text(
    //                       'الأكواد المفعلة',
    //                       style: kTextStyle.copyWith(
    //                         fontSize: 15.sp,
    //                         color: Theme.of(context).hintColor,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const ActiveCodes()
    //             ],
    //           ),
    //         ),
    //       ),
    //     )),
    //   );
    // }

    // Future<dynamic> confirmClose(BuildContext context) {
    //   return showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         //title: Text('Confirm Exit'),
    //         content: Text(
    //           'هل متأكد من إغلاق التطبيق ؟',
    //           textAlign: TextAlign.center,
    //           style: kTextStyle,
    //         ),
    //         actions: <Widget>[
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   elevation: 0,
    //                   backgroundColor: AppColor.scaffoldColor,
    //                 ),
    //                 child: Text(
    //                   'إلغاء',
    //                   style: kTextStyle.copyWith(fontSize: 15.sp),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop(false);
    //                 },
    //               ),
    //               SizedBox(
    //                 width: 10.h,
    //               ),
    //               ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   elevation: 0,
    //                   backgroundColor: AppColor.golden,
    //                 ),
    //                 child: Text(
    //                   'تأكيد',
    //                   style: kTextStyle.copyWith(
    //                       fontSize: 15.sp, color: AppColor.white),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop(true);
    //                 },
    //               ),
    //             ],
    //           )
    //         ],
    //       );
    //   },
    //);
  }
}
