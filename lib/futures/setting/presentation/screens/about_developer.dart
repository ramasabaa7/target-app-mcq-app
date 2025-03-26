import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CenterAppBar(
                  title: "حول المطورين",
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SliverFillRemaining(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Image.asset('assets/png/tlogo.png', height: 200.h),
                      20.verticalSpace,
                      FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: const Color.fromARGB(255, 37, 184, 52),
                        size: 50.h,
                      ),
                      10.verticalSpace,
                      Text(
                        '0993454955',
                        style: kTextStyle.copyWith(fontSize: 20.sp),
                      ),
                    ],
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
