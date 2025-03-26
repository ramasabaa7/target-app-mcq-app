import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/home/presentation/widgets/slidercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return HandleView(
        errorWidget: CustomError(
            message: controller.getSliderMessage,
            onTap: () {
              controller.getSlider();
            }),
        loadingWidget: shimmer(height: 120.h, width: 1.sw),
        defaultWidget: const Text("def"),
        requestState: controller.getSliderState,
        successWidget: CarouselSlider(
                options: CarouselOptions(
                  height: 120.h,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.18,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {},
                ),
                items: controller.sliderList
                    .map((e) => SliderCard(
                          ads: e,
                        ))
                    .toList())
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 500))
            .move(),
      );
    });
  }
}
