import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LectureCard extends StatelessWidget {
  const LectureCard({
    super.key,
    required this.lecture,
  });
  final Lecture lecture;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(10.w),
        width: 1.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadiusDirectional.circular(25),
          color: Theme.of(context).canvasColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Expanded(
              child: CustomSvg(
                svgPath: lecture.isLocked
                    ? "assets/svg/lock1.svg"
                    : "assets/svg/note2.svg",
                color: AppColor.golden,
                size: 30,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lecture.name,
                    style: kTextStyle.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: 16.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600),
                  ),
                  15.verticalSpace,
                  Text(
                    "${lecture.numberOfQuestions}  عدد الاسئلة",
                    style: kTextStyle.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: 12.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Text(''),
                Text(
                  DateFormat('MM/dd/yyyy')
                      .format(DateTime.parse("2024-01-25T12:16:17.000000Z")),
                  style: kTextStyle.copyWith(
                      color: AppColor.golden, fontSize: 10.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
