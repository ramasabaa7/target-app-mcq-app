import 'package:dopamin/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg(
      {super.key, required this.svgPath, this.size = 20, this.color});
  final String svgPath;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      height: size.h,
      width: size.h,
      color: color,
    );
  }
}
