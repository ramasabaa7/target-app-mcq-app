import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

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
                  title: "حول التطبيق",
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SliverFillRemaining(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 30.h),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Image.asset(
                          'assets/png/target-logo.png',
                          height: 150.h,
                        ),
                        Text(
                          "تارغيت",
                          style: kTextStyle.copyWith(
                              color: AppColor.newGolden, fontSize: 20.sp),
                        ),
                        Text(
                          "TARGET",
                          style: kTextStyle.copyWith(
                              color: AppColor.newGolden, letterSpacing: 5),
                        ),
                        20.verticalSpace,
                        Container(
                          constraints: BoxConstraints(maxWidth: 1.sw / 1.3),
                          child: Text(
                            textAlign: TextAlign.center,
                            AbouAppTitle,
                            style: kTextStyle.copyWith(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        30.verticalSpace
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
