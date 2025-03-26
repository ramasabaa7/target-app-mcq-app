import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EmptyFolderWidget extends StatelessWidget {
  const EmptyFolderWidget({super.key, required this.textt});
  final String textt;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Container(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvg(
              svgPath: 'assets/svg/folder-empty.svg',
              color: AppColor.newGolden,
              size: 160.h,
            ),
            Text(textt,
                style: whiteSmallTextStyle.copyWith(
                    color: AppColor.newGolden, fontSize: 12.sp))
          ],
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 500)).move(),
    );
  }
}
