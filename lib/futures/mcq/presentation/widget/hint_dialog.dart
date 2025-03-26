import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HintDialog extends StatelessWidget {
  const HintDialog({
    super.key,
    required this.hint,
  });
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                  margin: EdgeInsets.all(8.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColor.newGolden,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: const Center(
                    child: Text(
                      'إخفاء',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.newGolden,
          ),
          // width: double.infinity,
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  hint,
                  style: kTextStyle.copyWith(
                      color: AppColor.white, fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
