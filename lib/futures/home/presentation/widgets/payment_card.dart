import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.svgPath,
    required this.title,
  });
  final String svgPath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColor.textGrey,
                  //   offset: const Offset(-1, 1),
                  blurRadius: 1,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(5)),
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                color: Theme.of(context).hintColor.withOpacity(0.7),
              ),
              10.horizontalSpace,
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: kTextStyle.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(0.7)),
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          )),
    );
  }
}
