import 'package:dopamin/core/utils/app_extentions.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer({required double height, required double width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.3),
    highlightColor: Colors.grey[300]!,
    direction: ShimmerDirection.ltr,
    child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10))),
  );
}

shimmerCard() {
  return Column(
    children: [
      shimmer(height: 0.13.ld, width: 0.4.sw),
      5.verticalSpace,
      shimmer(height: 0.02.ld, width: 0.4.sw),
      5.verticalSpace,
      shimmer(height: 0.02.ld, width: 0.4.sw),
    ],
  );
}

Widget shimmerChapter() {
  return SingleChildScrollView(
    child: Column(
      children: [
        20.verticalSpace,
        shimmer(height: 0.07.ld, width: 1.sw),
        10.verticalSpace,
        shimmer(height: 0.07.ld, width: 1.sw),
        10.verticalSpace,
        shimmer(height: 0.07.ld, width: 1.sw),
        10.verticalSpace,
        shimmer(height: 0.07.ld, width: 1.sw),
      ],
    ),
  );
}

Widget shimmerChapter2() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        20.horizontalSpace,
        shimmer(height: 0.15.ld, width: 0.4.sw),
        10.horizontalSpace,
        shimmer(height: 0.15.ld, width: 0.4.sw),
        10.horizontalSpace,
        shimmer(height: 0.15.ld, width: 0.4.sw),
      ],
    ),
  );
}

Widget shimmerChapter3() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        20.horizontalSpace,
        shimmer(height: 0.05.ld, width: 0.3.sw),
        10.horizontalSpace,
        shimmer(height: 0.05.ld, width: 0.3.sw),
        10.horizontalSpace,
        shimmer(height: 0.05.ld, width: 0.3.sw),
      ],
    ),
  );
}

Widget shimmerHorizontal() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: shimmer(height: 0.1.ld, width: 1.sw),
      ),
      20.horizontalSpace,
      Expanded(
          flex: 2,
          child: Column(
            children: [
              shimmer(height: 0.02.ld, width: 1.sw),
              8.verticalSpace,
              shimmer(height: 0.02.ld, width: 1.sw),
              8.verticalSpace,
              shimmer(height: 0.02.ld, width: 1.sw),
            ],
          ))
    ],
  );
}

Widget cardHorizontalLoading() {
  return ListView(
    children: [
      shimmerHorizontal(),
      10.verticalSpace,
      shimmerHorizontal(),
      10.verticalSpace,
      shimmerHorizontal()
    ],
  );
}

Widget cardLoading() {
  return SizedBox(
    height: 0.22.ld,
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      scrollDirection: Axis.horizontal,
      children: [
        shimmerCard(),
        10.horizontalSpace,
        shimmerCard(),
        10.horizontalSpace,
        shimmerCard()
      ],
    ),
  );
}

Widget profileShimmer() {
  return SizedBox(
    height: 1.0.ld,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.grey[300]!,
            direction: ShimmerDirection.ltr,
            child: Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                )),
          ),
          shimmer(height: 0.05.ld, width: 0.5.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
          const Divider(),
          shimmer(height: 0.05.ld, width: 1.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
          shimmer(height: 0.05.ld, width: 1.sw),
        ],
      ),
    ),
  );
}

Widget shimmerLecture() {
  return Column(
    children: [
      30.verticalSpace,
      shimmer(height: 0.03.ld, width: 1.sw),
      15.verticalSpace,
      shimmer(height: 0.03.ld, width: 1.sw),
      15.verticalSpace,
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),

      /* cardHorizontalLoading(),
      cardHorizontalLoading() */
    ],
  );
}

Widget shimmerMcq() {
  return Column(
    children: [
      30.verticalSpace,
      shimmer(height: 0.03.ld, width: 1.sw),
      15.verticalSpace,
      shimmer(height: 0.03.ld, width: 1.sw),
      // 15.verticalSpace,
      shimmerChapter(),
      15.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          shimmer(height: 0.05.ld, width: 0.05.ld),
          shimmer(height: 0.05.ld, width: 0.05.ld),
          shimmer(height: 0.05.ld, width: 0.05.ld)
        ],
      )
    ],
  );
}

Widget shimmerPos() {
  return Column(
    children: [
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),
      15.verticalSpace,
      shimmerHorizontal(),

      /* cardHorizontalLoading(),
      cardHorizontalLoading() */
    ],
  );
}
