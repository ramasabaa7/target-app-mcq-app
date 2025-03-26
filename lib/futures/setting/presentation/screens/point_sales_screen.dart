import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/animate_list.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/setting/presentation/widgets/poin_sale_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class PointSalesScreen extends StatelessWidget {
  const PointSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            child: Scaffold(
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CenterAppBar(
                    title: "مراكز البيع",
                    onTap: () {
                      Get.back();
                    }),
              ),
              SliverFillRemaining(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: GetBuilder<HomeController>(builder: (controller) {
                      return HandleView(
                        requestState: controller.getPointSalesState,
                        errorWidget: CustomError(
                            message: controller.getPointSalesMessage,
                            onTap: () {
                              controller.getPointSales();
                            }),
                        loadingWidget: shimmerChapter(),
                        defaultWidget: const Text("def"),
                        successWidget: ListView.separated(
                          itemCount: controller.pointSalesList.length,
                          separatorBuilder: (context, index) {
                            return 10.verticalSpace;
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                20.verticalSpace,
                                Row(
                                  children: [
                                    const CustomSvg(
                                      svgPath: 'assets/svg/teacher-mark.svg',
                                      size: 22,
                                      color: AppColor.newGolden,
                                    ),
                                    20.horizontalSpace,
                                    Text(
                                      controller.pointSalesList[index].name,
                                      style: kTextStyle.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                AnimationLimiter(
                                  child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index2) {
                                        return TanimateList(
                                          index: index,
                                          child: PointSalesCard(
                                            pointSale: controller
                                                .pointSalesList[index]
                                                .cityLibrary[index2],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return 10.verticalSpace;
                                      },
                                      itemCount: controller
                                          .pointSalesList[index]
                                          .cityLibrary
                                          .length),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    })),
              )
            ],
          ),
        )));
  }
}
