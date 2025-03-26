import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';

class ExamCyclesCard extends StatelessWidget {
  const ExamCyclesCard({
    super.key,
    required this.examCycle,
  });
  final ExamCycle examCycle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomSvg(
              svgPath: examCycle.isLocked == false
                  ? "assets/svg/exam-cycles.svg"
                  : "assets/svg/lock_gray.svg",
              color: examCycle.isLocked == false
                  ? AppColor.newGolden
                  : AppColor.textgray,
              size: 40,
            ),
          ),

          5.verticalSpace,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    examCycle.name,
                    style: kTextStyle.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            " عدد الاسئلة: ${examCycle.numberOfQuestions} ",
            maxLines: 2,
            style: kTextStyle.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: 12.sp,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500),
          ),

          Text(
            DateFormat('MM/dd/yyyy')
                .format(DateTime.parse("2024-01-25T12:16:17.000000Z")),
            style: kTextStyle.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [

          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
