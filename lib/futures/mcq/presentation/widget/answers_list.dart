import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AnswersList extends StatelessWidget {
//   const AnswersList(
//       {super.key,
//       required this.questionIndex,
//       required this.mcqController,
//       required this.selectAnswer});
//   final int questionIndex;
//   final McqController mcqController;
//   final selectAnswer;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       addAutomaticKeepAlives: false,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       separatorBuilder: (context, i) {
//         return 10.verticalSpace;
//       },
//       itemCount: mcqController.questionsList[questionIndex].answers.length,
//       itemBuilder: (context, answerIndex) {
//         return InkWell(
//           borderRadius: BorderRadius.circular(10),
//           onTap: () {
//             selectAnswer(answerIndex);
//           },
//           child: Container(
//             alignment: Alignment.center,
//             width: 1.sw,
//             padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
//             decoration: BoxDecoration(
//               border: Border.all(
//                   width: 2,
//                   color: mcqController.isWrongAnswer(
//                           answerIndex: answerIndex,
//                           questionIndex: questionIndex)
//                       ? AppColor.red
//                       : mcqController.isHaveAnswer(
//                               answerIndex: answerIndex,
//                               questionIndex: questionIndex)
//                           ? mcqController.questionsList[questionIndex].color!
//                           : AppColor.scaffoldColor),
//               color: AppColor.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Directionality(
//               textDirection: isEnglishOnly(
//                 mcqController
//                     .questionsList[questionIndex].answers[answerIndex].body,
//               )
//                   ? TextDirection.ltr
//                   : TextDirection.rtl,
//               child: Align(
//                 alignment: isEnglishOnly(mcqController
//                         .questionsList[questionIndex].answers[answerIndex].body)
//                     ? Alignment.centerLeft
//                     : Alignment.centerRight,
//                 child: Text(
//                   mcqController
//                       .questionsList[questionIndex].answers[answerIndex].body,
//                   style: kTextStyle.copyWith(
//                     fontSize: 13.sp,
//                     color: mcqController.isWrongAnswer(
//                             answerIndex: answerIndex,
//                             questionIndex: questionIndex)
//                         ? AppColor.red
//                         : mcqController.isHaveAnswer(
//                                 answerIndex: answerIndex,
//                                 questionIndex: questionIndex)
//                             ? mcqController.questionsList[questionIndex].color!
//                             : AppColor.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
Widget answersList(
        {required int questionIndex,
        required McqController mcqController,
        required selectAnswer}) =>
    ListView.separated(
      addAutomaticKeepAlives: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, i) {
        return 10.verticalSpace;
      },
      itemCount: mcqController.questionsList[questionIndex].answers.length,
      itemBuilder: (context, answerIndex) {
        return Container(
          decoration: BoxDecoration(
            color: mcqController.isWrongAnswer(
                    answerIndex: answerIndex, questionIndex: questionIndex)
                ? AppColor.red
                : mcqController.isHaveAnswer(
                        answerIndex: answerIndex, questionIndex: questionIndex)
                    ? mcqController.questionsList[questionIndex].color!
                    : Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              selectAnswer(answerIndex);
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 1.sw,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                  child: Directionality(
                    textDirection: isEnglishOnly(
                      mcqController.questionsList[questionIndex]
                          .answers[answerIndex].body,
                    )
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Align(
                      alignment: isEnglishOnly(mcqController
                              .questionsList[questionIndex]
                              .answers[answerIndex]
                              .body)
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 20.h, vertical: 15.w),
                          child: getAnswier(
                              answerIndex,
                              mcqController.questionsList[questionIndex]
                                  .answers[answerIndex].body,
                              context)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
Text getAnswier(int answerIndex, String s, BuildContext context) {
  if (answerIndex == 0) {
    return Text(
      'A    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
  } else if (answerIndex == 1)
    // ignore: curly_braces_in_flow_control_structures
    return Text(
      'B    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
  else if (answerIndex == 2)
    // ignore: curly_braces_in_flow_control_structures
    return Text(
      'C    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
  else if (answerIndex == 3)
    // ignore: curly_braces_in_flow_control_structures
    return Text(
      'D    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
  else if (answerIndex == 4)
    // ignore: curly_braces_in_flow_control_structures
    return Text(
      'E    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
  else
    // ignore: curly_braces_in_flow_control_structures
    return Text(
      'F    $s',
      style: kTextStyle.copyWith(
          fontSize: 13.sp, color: Theme.of(context).hintColor),
    );
}
