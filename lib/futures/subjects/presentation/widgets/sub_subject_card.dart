import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SubSubjectCard extends StatelessWidget {
  const SubSubjectCard(
      {super.key,
      required this.onTap,
      required this.svgPath,
      required this.title});
  final VoidCallback onTap;
  final String svgPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).canvasColor),
        child: Column(
          children: [
            10.horizontalSpace,
            CustomSvg(
              svgPath: svgPath,
              color: AppColor.newGolden,
              size: 40,
            ),
            const Spacer(),
            Text(
              title,
              style: redTitleTextStyle.copyWith(
                  fontSize: 16, color: AppColor.newGolden),
            ),
            10.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
