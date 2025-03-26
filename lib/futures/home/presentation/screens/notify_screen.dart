import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavBarController>().selectedIndexScreens = 0;
        Get.find<BottomNavBarController>().update();
        return false;
      },
      child: Container(
        color: AppColor.white,
        child: SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child:
                      //  Container(
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.withOpacity(0.2),
                      //         spreadRadius: 5,
                      //         blurRadius: 7,
                      //         offset: Offset(0, 3), // changes position of shadow
                      //       ),
                      //     ],
                      //     color: AppColor.white,
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsetsDirectional.only(
                      //         start: 20.w, top: 25.h, end: 10.w, bottom: 25.h),
                      //     child: Text(
                      //       textAlign: TextAlign.center,
                      //       'الاشعارات',
                      //       maxLines: 3,
                      //       style: kTextStyle.copyWith(fontSize: 18.sp),
                      //     ),
                      //   ),
                      // ),
                      CenterAppBar(
                    title: 'الاشعارات',
                    withBack: false,
                    onTap: () {},
                  ),
                ),
                SliverFillRemaining(
                  child: GetBuilder<HomeController>(builder: (controller) {
                    return HandleView(
                      defaultWidget: const Text("def"),
                      loadingWidget: shimmerChapter(),
                      requestState: controller.getNotificationState,
                      errorWidget: CustomError(
                        message: controller.getNotificationMessage,
                        onTap: () {
                          controller.getNotification();
                        },
                      ),
                      successWidget: controller.notificationList.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 10.w),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(15.w),
                                  width: 1.w,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomSvg(
                                        svgPath: "assets/svg/notifyoutline.svg",
                                        color: AppColor.newGolden,
                                        size: 45,
                                      ),
                                      10.horizontalSpace,
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.notificationList[index]
                                                  .title,
                                              style: kTextStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor),
                                            ),
                                            Text(
                                              controller.notificationList[index]
                                                  .subtitle,
                                              style: kTextStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          formatDateTime(
                                              controller.notificationList[index]
                                                  .createdAt,
                                              context),
                                          style: kTextStyle.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return 5.verticalSpace;
                              },
                              itemCount: controller.notificationList.length)
                          : const EmptyFolderWidget(
                              textt: 'لا يوجد إشعارات ',
                            ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatDateTime(String dateString, BuildContext context) {
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  Duration diff = DateTime.now().difference(dateTime);
  Locale locale = Localizations.localeOf(context);
  bool isArabic = locale.languageCode == 'ar';

  String formattedString;

  if (diff.inSeconds < 60) {
    formattedString = 'الأن';
  } else if (diff.inMinutes < 60) {
    formattedString = isArabic
        ? '${"دقائق مضت"} ${diff.inMinutes}'
        : '${diff.inMinutes} ${"دقائق مضت"}';
  } else if (diff.inHours < 24) {
    formattedString = isArabic
        ? '${"ساعة مضت"} ${diff.inHours}'
        : '${diff.inHours} ${"ساعة مضت"}';
  } else if (diff.inDays == 1) {
    formattedString = 'yesterday'.tr;
  } else {
    formattedString = isArabic
        ? '${"ايام مضت".tr} ${diff.inDays}'
        : '${diff.inDays} ${"ايام مضت".tr}';
  }

  return formattedString;
}
