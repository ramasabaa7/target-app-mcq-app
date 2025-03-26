import 'dart:async';

import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CounterTime extends StatefulWidget {
  const CounterTime({
    super.key,
  });

  @override
  State<CounterTime> createState() => _CounterTimeState();
}

class _CounterTimeState extends State<CounterTime> {
  Timer? timer;

  void startTimer() {
    Get.find<McqController>().timerSeconds = 0;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(() {
        Get.find<McqController>().timerSeconds++;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formatTimeFromSeconds(Get.find<McqController>().timerSeconds),
            style: kTextStyle.copyWith(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
          ),
          // 8.horizontalSpace,
          // const CustomSvg(svgPath: 'assets/svg/clock.svg'),
        ],
      ),
    );
  }
}

String formatTimeFromSeconds(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;

  String formattedTime = '';
  // if (hours > 0) {

// hours
  //formattedTime += '${hours.toString().padLeft(2, '0')}:';

  // }
  // if (minutes > 0) {
  formattedTime += '${minutes.toString().padLeft(2, '0')}:';
  // }
  formattedTime += remainingSeconds.toString().padLeft(2, '0');

  return formattedTime;
}
