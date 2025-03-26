import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingCard extends StatelessWidget {
  const SettingCard(
      {super.key,
      required this.iconData,
      required this.title,
      required this.onTap,
      this.withArrow = true});
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final bool? withArrow;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.35,
        padding: EdgeInsetsDirectional.symmetric(vertical: 25.h),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.lightGrey.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Icon(
              iconData,
              color: AppColor.newGolden,
              size: 27.h,
            ),
            15.verticalSpace,
            Text(
              title,
              style: kTextStyle.copyWith(
                  fontSize: 13.sp, color: Theme.of(context).hintColor),
            ),
          ],
        ),
      ),
    );
  }
}
