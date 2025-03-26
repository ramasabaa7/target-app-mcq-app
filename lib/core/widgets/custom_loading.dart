import 'package:dopamin/core/global/progress_controller.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.h,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: [AppColor.newGolden, AppColor.lightGrey],
            ),
          ),
          Text(
            " % 100 / ${Get.find<ProgressController>().number.value.floor()}",
            style: kTextStyle,
          )
        ],
      ),
    );
  }
}
