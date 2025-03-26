import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.press, this.color});
  final String text;
  final VoidCallback press;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: 1.sw,
        decoration: BoxDecoration(
            color: color ?? AppColor.newGolden,
            borderRadius: BorderRadius.circular(50)),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: kTextStyle.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }
}
