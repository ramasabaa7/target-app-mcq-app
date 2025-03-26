import 'package:dopamin/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/png/target-logo.png',
          height: 150.h,
        ),
        40.verticalSpace,
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowGray.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Divider(
            height: 2,
            thickness: 5,
            color: AppColor.newGolden,
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
