import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/home/presentation/widgets/subject_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SubjectsScreennew extends StatelessWidget {
  const SubjectsScreennew({super.key});

  @override
  Widget build(BuildContext context) {
    String sub = box.read(SUBJECTTRACK);

    List<String> nameList = sub.split('-');

    Get.put(HomeController(Get.find(), Get.find()));

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
          //  physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 20.w, top: 30.h, end: 10.w, bottom: 20.h),
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
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CustomSvg(
                                        svgPath: 'assets/svg/back.svg',
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        size: 18,
                                      )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '${nameList[1]} - ${nameList[0]}',
                                    maxLines: 3,
                                    style: kTextStyle.copyWith(
                                        fontSize: 16.sp,
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
                hasScrollBody: true,
                child: Padding(
                    padding: EdgeInsets.only(), child: const SubjectList()))
          ]),
    ));
  }
}
