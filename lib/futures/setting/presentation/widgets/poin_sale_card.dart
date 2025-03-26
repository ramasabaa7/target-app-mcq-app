import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/models/point_sale_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';

class PointSalesCard extends StatelessWidget {
  const PointSalesCard({
    super.key,
    required this.pointSale,
  });
  final PointSale pointSale;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      width: 1.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          const Expanded(
            child: CustomSvg(
              svgPath: "assets/svg/location-barcode.svg",
              color: AppColor.newGolden,
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
                  pointSale.name,
                  style:
                      kTextStyle.copyWith(color: Theme.of(context).hintColor),
                ),
                Text(
                  pointSale.address,
                  style: kTextStyle.copyWith(
                      color: AppColor.textGrey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
