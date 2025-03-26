import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:dopamin/futures/subjects/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
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
                  Get.find<SubjectController>().getCategories(refresh: true);
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
                                "التصنيفات",
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
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    child: const CategoriesList()),
              )
            ],
          ),
        )));
  }
}
