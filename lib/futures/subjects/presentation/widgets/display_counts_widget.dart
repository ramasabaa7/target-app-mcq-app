import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/subjects/presentation/controller/count_controller.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DisplayCountsWidget extends StatelessWidget {
  const DisplayCountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountController>(builder: (controller) {
      return HandleView(
          requestState: controller.examCyclesAndCategorizationsCountState,
        
          errorWidget: CustomError(
              message: controller.getExamCyclesAndCategorizationsCountMessage,
              onTap: () {
                controller.getExamCyclesAndCategorizationsCount();
              }),
          loadingWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'محتويات المادة',
                  style: kTextStyle.copyWith(
                      fontSize: 13.sp, color: Theme.of(context).hintColor),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const CustomSvg(
                      svgPath: "assets/svg/srd.svg",
                      size: 20,
                      color: AppColor.newGolden,
                    ),
                    10.horizontalSpace,
                    Text(
                      'الدورات _',
                      style: kTextStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
              5.horizontalSpace,
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const CustomSvg(
                      svgPath: "assets/svg/category.svg",
                      color: AppColor.newGolden,
                      size: 20,
                    ),
                    10.horizontalSpace,
                    Text('التصنيفات _ ',
                        style: kTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).hintColor)),
                  ],
                ),
              )
            ],
          ),
          defaultWidget: const Text("def"),
          successWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'محتويات المادة',
                  style: kTextStyle.copyWith(
                      fontSize: 13.sp, color: Theme.of(context).hintColor),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const CustomSvg(
                      svgPath: "assets/svg/srd.svg",
                      size: 20,
                      color: AppColor.newGolden,
                    ),
                    10.horizontalSpace,
                    Text(
                      'الدورات ${controller.examCyclesCount}',
                      style: kTextStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
              5.horizontalSpace,
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const CustomSvg(
                      svgPath: "assets/svg/category.svg",
                      color: AppColor.newGolden,
                      size: 20,
                    ),
                    10.horizontalSpace,
                    Text('التصنيفات ${controller.categorizationsCount}',
                        style: kTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).hintColor)),
                  ],
                ),
              )
            ],
          ));
    });
  }
}
