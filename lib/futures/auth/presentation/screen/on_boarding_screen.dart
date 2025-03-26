import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:dopamin/futures/auth/presentation/widgets/stack_svgs.dart';
import 'package:dopamin/futures/auth/presentation/widgets/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const StackSvgsWidgets(),
              Positioned(
                top: 70.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const TopWidget(),
                    30.verticalSpace,
                    Text(
                      'TARGET',
                      style: redTitleTextStyle.copyWith(
                          fontSize: 28.sp, letterSpacing: 6),
                    ),
                    Text(
                      'تارغيت',
                      style: redTitleTextStyle.copyWith(fontSize: 18.sp),
                    ),
                    20.verticalSpace,
                    Container(
                      constraints: BoxConstraints(maxWidth: 1.sw / 1.3),
                      child: Text(
                        textAlign: TextAlign.center,
                        AbouAppTitle,
                        strutStyle: const StrutStyle(
                          height: 1.7,
                          leading: 0.8,
                        ),
                        style: kTextStyle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor),
                      ),
                    ),
                    70.verticalSpace,
                    ElevatedButton(
                        onPressed: () {
                          if (box.read(IS_GOOGLE_AUTH) != true) {
                            Get.offAllNamed(AppRouter.kLoginScreen);
                          } else {
                            Get.offAllNamed(AppRouter.loginWithGoogleScreen);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.newGolden)),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 10.h, horizontal: 30.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'التالي',
                                style: labelTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                              15.horizontalSpace,
                              CustomSvg(
                                  svgPath: "assets/svg/next.svg",
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor)
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
