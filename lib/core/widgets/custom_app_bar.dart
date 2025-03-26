/* import 'dart:math';

import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.svgPath,
    required this.title,
    this.press,
    required this.pressBack,
  });
  final String? svgPath;
  final String title;
  final VoidCallback? press;
  final VoidCallback pressBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: pressBack,
            child: const CustomSvg(svgPath: "assets/svgs/arrow-left.svg")),
        ZoomTapAnimation(
          onTap: press,
          child: Row(
            children: [
              Text(
                title,
                style:
                    kTextStyle.copyWith(color: AppColor.newGolden, fontSize: 14.sp),
              ),
              2.horizontalSpace,
              svgPath == null ? const SizedBox() : CustomSvg(svgPath: svgPath!),
            ],
          ),
        )
      ],
    );
  }
}
 */