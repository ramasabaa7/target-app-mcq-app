

import 'package:dopamin/core/utils/app_color.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DottedLineMcq extends StatelessWidget {
  const DottedLineMcq({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: AppColor.lightGrey,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}
