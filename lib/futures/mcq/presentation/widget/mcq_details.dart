import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class McqDetailsCard extends StatelessWidget {
  const McqDetailsCard({
    super.key,
    required this.svgPath,
    this.color,
  });
  final String svgPath;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.newGolden,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CustomSvg(
          svgPath: svgPath,
          color: color!,
          size: 23,
        ),
      ),
    );
  }
}
