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
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/setting/presentation/widgets/subscription_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';

class ActiveCodes extends StatelessWidget {
  const ActiveCodes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return HandleView(
        errorWidget: CustomError(
          message: controller.getMySubscriptionMessage,
          onTap: () {
            controller.getMySubscription();
          },
        ),
        requestState: controller.getMySubscriptionState,
        loadingWidget: Padding(
          padding: EdgeInsets.all(kHorizontalPadding),
          child: shimmerChapter(),
        ),
        defaultWidget: const Text("def"),
        successWidget: controller.mySubscriptionList.isNotEmpty
            ? Container(
                width: Get.width * 0.9,
                height: Get.height * 0.5,
                child: ListView.separated(
                    padding: EdgeInsets.all(kHorizontalPadding),
                    itemBuilder: (context, index) {
                      return ZoomTapAnimation(
                        onTap: () async {
                          Subject subject = Subject(
                            id: controller.mySubscriptionList[index].id,
                            name: controller.mySubscriptionList[index].name,
                            about: controller.mySubscriptionList[index].about,
                            subjectContactNumber: controller
                                .mySubscriptionList[index].subjectContactNumber,
                            AYPSSID:
                                controller.mySubscriptionList[index].AYPSSID,
                            academicYearPivotId: "-1",
                            orderNumber: controller
                                .mySubscriptionList[index].orderNumber,
                            numberOfQuestions: controller
                                .mySubscriptionList[index].numberOfQuestions,
                            createdAt:
                                controller.mySubscriptionList[index].createdAt,
                            updatedAt:
                                controller.mySubscriptionList[index].updatedAt,
                          );
                          Get.find<HomeController>().currentSubject = subject;
                          Get.toNamed(AppRouter.kSubjectScreen);

              
                        },
                        child: Container(
                          height: Get.height * 0.1,
                          width: Get.width * 0.7,
                          child: SubscriptionCard(
                            mySubscription:
                                controller.mySubscriptionList[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      if (index == controller.mySubscriptionList.length) {
                        return 100.verticalSpace;
                      } else {
                        return 20.verticalSpace;
                      }
                    },
                    itemCount: controller.mySubscriptionList.length),
              )
            : const EmptyFolderWidget(
                textt: 'لا يوجد أكواد مفعلة حتى الآن ',
              ),
      );
    });
  }
}
