import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return HandleView(
          requestState: controller.getSubjectState,
          errorWidget: CustomError(
              message: controller.getSubjectMessage,
              onTap: () {
                controller.getSubjects(pivotId: box.read(SEMESTERID));
              }),
          defaultWidget: const Text("def"),
          loadingWidget: shimmerChapter(),
          successWidget: controller.subjectList.isNotEmpty
              ? AnimationLimiter(
                  child: ListView.separated(
                      //  physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Color color;
                        if (index % 2 == 0) {
                          color = AppColor.newGolden;
                          // } else if (index % 3 == 1) {
                          //   color = AppColor.containerBlue;
                        } else {
                          color = AppColor.newGolden;
                        }

                        return TanimateList(
                          index: index,
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20.w),
                            child: ZoomTapAnimation(
                              onTap: () {
                                controller.currentSubject =
                                    controller.subjectList[index];
                                Get.toNamed(AppRouter.kSubjectScreen);
                              },
                              child: Column(
                                children: [
                                  if (index == 0) ...[30.verticalSpace],
                                  Container(
                                    width: 1.sw,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.w, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.newGolden
                                              .withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: color, width: 0.5)),
                                          child: CustomSvg(
                                              svgPath: "assets/svg/book1.svg",
                                              size: 55.h,
                                              color: color),
                                        ),
                                        20.horizontalSpace,
                                        Expanded(
                                          child: Text(
                                            maxLines: 2,
                                            controller.subjectList[index].name,
                                            style: kTextStyle.copyWith(
                                                color: color, fontSize: 15.sp),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (index + 1 ==
                                      controller.subjectList.length) ...[
                                    70.verticalSpace
                                  ]
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 10.verticalSpace;
                      },
                      itemCount: controller.subjectList.length),
                )
              : EmptyFolderWidget(
                  textt: 'لا يوجد مواد في هذه السنة حتى الآن ',
                ));
    });
  }
}
