import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
                  title: "الدعم الفني",
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SliverFillRemaining(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 70.h),
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
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        40.verticalSpace,
                        Image.asset(
                          'assets/png/target-logo.png',
                          height: 100.h,
                        ),
                        20.verticalSpace,
                        Text(
                          "TARGET",
                          style: kTextStyle.copyWith(
                              color: AppColor.newGolden,
                              fontSize: 20.sp,
                              letterSpacing: 5),
                        ),
                        Text(
                          "تارغيت",
                          style: kTextStyle.copyWith(color: AppColor.newGolden),
                        ),
                        const Divider(
                          color: AppColor.newGolden,
                        ),
                        /*  20.verticalSpace,
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
                        ), */
                        20.verticalSpace,
                        GetBuilder<HomeController>(builder: (controller) {
                          return HandleView(
                            requestState: controller.settingState,
                            errorWidget: CustomError(
                                message: controller.getSliderMessage,
                                onTap: () {
                                  controller.getSetting();
                                }),
                            loadingWidget: Text(
                              'يتم تحميل الرابط',
                              style: whiteSmallTextStyle.copyWith(
                                  color: AppColor.newGolden),
                            ),
                            defaultWidget: const Text("def"),
                            successWidget: GestureDetector(
                              onTap: () {
                                //   print(controller.settingList[3].value);
                                launch(controller.settingList[3].value);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.telegram,
                                    color:
                                        const Color.fromARGB(255, 51, 119, 220),
                                    size: 50.h,
                                  ),
                                  20.horizontalSpace,
                                  Text(
                                    'Target_Bot',
                                    style: kTextStyle.copyWith(
                                        fontSize: 20.sp,
                                        color: AppColor.newGolden),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        30.verticalSpace,
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
