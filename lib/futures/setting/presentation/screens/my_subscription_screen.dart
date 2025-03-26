import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/setting/presentation/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>().getMySubscription();
    return Container(
      color: AppColor.white,
      child: SafeArea(
          child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CenterAppBar(
                title: "اشتراكاتي",
                onTap: () {
                  Get.back();
                },
                withRefresh: true,
                onRefresh: () {
                  Get.find<HomeController>().getMySubscription(refresh: true);
                },
              ),
            ),
            SliverFillRemaining(
              child: GetBuilder<HomeController>(builder: (controller) {
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
                      ? ListView.separated(
                          padding: EdgeInsets.all(kHorizontalPadding),
                          itemBuilder: (context, index) {
                            return ZoomTapAnimation(
                              onTap: () async {
                                // Get.find<BottomNavBarController>()
                                //   ..selectedIndexScreens = 0
                                //   ..update();
                                // await box.write(
                                //     SUBJECTTRACK,
                                //     controller.mySubscriptionList[index]
                                //         .puchasedSemesterTrack);
                                // await box.write(
                                //     SEMESTERID,
                                //     controller
                                //         .mySubscriptionList[index].aypssId);

                                //Get.back();
                                // Get.find<HomeController>().getSubjects(
                                //     pivotId: controller
                                //         .mySubscriptionList[index].aypssId);
                              },
                              child: SubscriptionCard(
                                mySubscription:
                                    controller.mySubscriptionList[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 20.verticalSpace;
                          },
                          itemCount: controller.mySubscriptionList.length)
                      : const EmptyFolderWidget(
                          textt: 'لا يوجد أكواد مفعلة حتى الآن ',
                        ),
                );
              }),
            )
          ],
        ),
      )),
    );
  }
}
