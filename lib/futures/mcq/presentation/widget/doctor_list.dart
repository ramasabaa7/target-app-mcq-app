import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorList extends StatelessWidget {
  const DoctorList(
      {super.key, required this.index, required this.mcqController});
  final int index;
  final McqController mcqController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.horizontalSpace,
          Expanded(
            child: Wrap(
                spacing: 20.w,
                runSpacing: 10.w,
                children: List.generate(
                    //2,
                    mcqController.questionsList[index].categorizations.length,
                    (index3) => DoctorCard(
                        // title: 'د.نبيل دندشلي'
                        title: mcqController
                            .questionsList[index].categorizations[index3]))),
          ),
        ],
      ),
    );
  }
}
