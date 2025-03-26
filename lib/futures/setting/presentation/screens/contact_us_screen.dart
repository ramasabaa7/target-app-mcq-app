import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
                  title: "تواصل معنا",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/png/logo.png',
                            height: 100.h,
                          ),
                          Column(
                            children: [
                              Text(
                                "دوبامين",
                                style: kTextStyle.copyWith(
                                    color: AppColor.golden, fontSize: 20.sp),
                              ),
                              Text(
                                "Dopamine",
                                style:
                                    kTextStyle.copyWith(color: AppColor.golden),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColor.white,
                      ),
                      20.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          launch("whatsapp://send?phone=0941760333");
                        },
                        child: Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: const Color.fromARGB(255, 37, 184, 52),
                              size: 50.h,
                            ),
                            10.verticalSpace,
                            Text(
                              '0941760333',
                              style: kTextStyle.copyWith(fontSize: 20.sp),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          launch("https://t.me/Dopaminetwasl2024_bot");
                        },
                        child: Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.telegram,
                              color: const Color.fromARGB(255, 51, 119, 220),
                              size: 50.h,
                            ),
                            10.verticalSpace,
                            Text(
                              'Dopamine_Bot',
                              style: kTextStyle.copyWith(fontSize: 20.sp),
                            ),
                          ],
                        ),
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
