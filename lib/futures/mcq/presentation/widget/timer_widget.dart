import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, required this.controller});
  final SubjectController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      child: Row(
        children: [
          20.horizontalSpace,
          const CustomSvg(svgPath: 'assets/svg/clock.svg'),
          10.horizontalSpace,
          GetBuilder<SubjectController>(builder: (_) {
            return Text(
              "1:00",
              style: kTextStyle,
            );
          }),
          const Spacer(),
          20.horizontalSpace,
        ],
      ),
    );
  }
}
