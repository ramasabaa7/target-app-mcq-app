import 'package:auto_size_text/auto_size_text.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    super.key,
    required this.ads,
  });

  final SliderM ads;

  @override
  Widget build(BuildContext context) {
    
   

    return ZoomTapAnimation(
      onTap: () {
        if (ads.url != '') {
          launch(ads.url);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.w, left: 20.w, right: 10.w),
            height: 150.h,
            width: 1.sw,
            decoration: BoxDecoration(
              color: ads.color != ""
                  ? Color(int.parse('0xff${ads.color.substring(1)}'))
                  : AppColor.red, //Color(int.parse(color))

              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ads.title,
                  style: kTextStyle.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                5.verticalSpace,
                Expanded(
                  child: AutoSizeText(
                    maxLines: 3,
                    minFontSize: 1,
                    ads.subtitle,
                    style: kTextStyle.copyWith(color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: -70.h,
                    child: Transform.rotate(
                      angle: 4.5,
                      child: CustomSvg(
                        svgPath: 'assets/svg/right-white.svg',
                        color: AppColor.white.withOpacity(0.3),
                        size: 150,
                      ),
                    )),
                Positioned(
                    right: -10.h,
                    bottom: -70.h,
                    child: Transform.rotate(
                      angle: 1,
                      child: CustomSvg(
                        svgPath: 'assets/svg/right-white.svg',
                        color: AppColor.white.withOpacity(0.3),
                        size: 150,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
