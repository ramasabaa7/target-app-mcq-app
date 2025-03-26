import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key, required this.mySubscription});
  final MySubscription mySubscription;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.h),
        width: 1.sw,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.newGolden.withOpacity(0.1),
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
            10.horizontalSpace,
            const CustomSvg(
              svgPath: "assets/svg/note2.svg",
              color: AppColor.newGolden,
              size: 35,
            ),
            15.horizontalSpace,
            Expanded(
              child: Text(
                maxLines: 2,
                mySubscription.name,
                style: kTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor),
              ),
            ),
            15.horizontalSpace,
          ],
        ).animate().fadeIn(duration: const Duration(milliseconds: 500)).move());
  }
}
