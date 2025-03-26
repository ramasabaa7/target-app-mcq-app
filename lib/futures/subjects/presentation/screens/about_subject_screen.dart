import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutSubjectScreen extends StatelessWidget {
  const AboutSubjectScreen({super.key});

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
                child: CenterAppBar(
                  title: "معلومات عن المادة",
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Center(
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: Theme.of(context).canvasColor),
                            child: Column(
                              children: [
                                Text(
                                  'معلومات عن  ${Get.find<HomeController>().currentSubject.name}',
                                  style: kTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor),
                                ),
                              const  Divider(
                                  height: 40,
                                  endIndent: 40,
                                  indent: 40,
                                  color: AppColor.newGolden,
                                  thickness: 2,
                                ),
                                Text(
                                  Get.find<HomeController>()
                                      .currentSubject
                                      .about,
                                  style: kTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor),
                                ),
                                30.verticalSpace
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
