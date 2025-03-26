import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CenterAppBar extends StatelessWidget {
  const CenterAppBar({
    super.key,
    required this.title,
    required this.onTap,
    this.withBack = true,
    this.withRefresh = false,
    this.onRefresh,
  });
  final String title;
  final VoidCallback onTap;
  final bool? withBack;
  final bool? withRefresh;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  padding: EdgeInsetsDirectional.only(top: 15, bottom: 20),
      width: 1.sw,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowGray.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (withBack == true) ...[
            Positioned(
              top: 20.h,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: ZoomTapAnimation(
                    onTap: onTap,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomSvg(
                          svgPath: 'assets/svg/back.svg',
                          color: Theme.of(context).canvasColor,
                          size: 18.h,
                        )),
                  ),
                ),
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (withRefresh == true) ...[const Spacer()],
              Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                  child: Text(
                    title,
                    maxLines: 3,
                    style:
                        kTextStyle.copyWith(color: Theme.of(context).hintColor),
                  ),
                ),
              ),
              if (withRefresh == true) ...[
                const Spacer(),
                ZoomTapAnimation(
                    onTap: () {
                      Get.dialog(AlertDialog(
                        content: Text(
                          "تنبيه:  سيتم تحديث البيانات الحالية , تأكد من اتصالك بالانترنت",
                          textAlign: TextAlign.center,
                          style: kTextStyle,
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.scaffoldColor,
                                ),
                                child: Text(
                                  'إلغاء',
                                  style: kTextStyle.copyWith(fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColor.newGolden,
                                  ),
                                  onPressed: () {
                                    onRefresh!();
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text(
                                    'موافق',
                                    style: kTextStyle.copyWith(
                                        fontSize: 15.sp, color: AppColor.white),
                                  )),
                            ],
                          )
                        ],
                      ));
                    },
                    child: const Icon(Icons.refresh,
                        color: AppColor.white, size: 30))
              ],
            ],
          ),
        ],
      ),
    );
  }
}
