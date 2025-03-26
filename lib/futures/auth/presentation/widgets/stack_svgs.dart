import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackSvgsWidgets extends StatelessWidget {
  const StackSvgsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
              top: 30,
              right: 40.h,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(15 / 360),
                child: CustomSvg(
                  size: 70,
                  svgPath: "assets/svg/note2.svg",
                  color: AppColor.newGolden.withOpacity(0.2),
                ),
              )),
          Positioned(
              top: 40,
              right: 180.h,
              child: Container(
                padding: const EdgeInsetsDirectional.all(13),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.newGolden.withOpacity(0.1)),
              )),
          Positioned(
              top: 300.h,
              right: 30.w,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(25 / 360),
                child: CustomSvg(
                  size: 80,
                  svgPath: "assets/svg/question_mark.svg",
                  color: AppColor.newGolden.withOpacity(0.1),
                ),
              )),
          Positioned(
              top: 190.h,
              left: 80.w,
              child: Container(
                padding: const EdgeInsetsDirectional.all(13),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.newGolden.withOpacity(0.1)),
              )),
          Positioned(
              top: 160.h,
              right: 80.w,
              child: CustomSvg(
                size: 100,
                svgPath: "assets/svg/shape_onboarding.svg",
                color: AppColor.newGolden.withOpacity(0.4),
              )),
          Positioned(
              top: 320.h,
              left: 40.w,
              child: Container(
                padding: const EdgeInsetsDirectional.all(13),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.newGolden.withOpacity(0.1)),
              )),
          Positioned(
              bottom: 170,
              right: 50,
              child: Container(
                padding: const EdgeInsetsDirectional.all(13),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.newGolden.withOpacity(0.1)),
              )),
          Positioned(
              bottom: 150.h,
              left: 30.w,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(15 / 360),
                child: CustomSvg(
                  size: 70,
                  svgPath: "assets/svg/note2.svg",
                  color: AppColor.newGolden.withOpacity(0.2),
                ),
              )),
          Positioned(
              bottom: 20.h,
              right: 30.w,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(15 / 360),
                child: CustomSvg(
                  size: 100,
                  svgPath: "assets/svg/shape_onboarding.svg",
                  color: AppColor.newGolden.withOpacity(0.4),
                ),
              )),
        ],
      ),
    );
  }
}
