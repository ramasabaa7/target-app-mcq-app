import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    required this.message,
    required this.onTap,
  });
  final String message;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: kTextStyle.copyWith(fontSize: 12.sp),
              ),
              IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.refresh,
                    color: AppColor.newGolden,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
