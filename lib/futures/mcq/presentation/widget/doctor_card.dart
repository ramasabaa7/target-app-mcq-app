import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Center(
          child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColor.newGolden,
              width: 2,
            )),
        child: Text(
          title,
          style:
              kTextStyle.copyWith(color: AppColor.textBlack, fontSize: 12.sp),
        ),
      )),
    );
  }
}
