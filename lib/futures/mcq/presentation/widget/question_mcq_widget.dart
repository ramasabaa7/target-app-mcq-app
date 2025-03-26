import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/answers_list.dart';
import 'package:dopamin/futures/mcq/presentation/widget/doctor_list.dart';
import 'package:dopamin/futures/mcq/presentation/widget/hint_dialog.dart';
import 'package:dopamin/futures/mcq/presentation/widget/mcq_details.dart';
import 'package:dopamin/futures/mcq/presentation/widget/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuestionMcqWidget extends StatefulWidget {
  const QuestionMcqWidget({
    super.key,
    required this.index,
    required this.controller,
  });
  final int index;
  final McqController controller;

  @override
  State<QuestionMcqWidget> createState() => _QuestionMcqWidgetState();
}

class _QuestionMcqWidgetState extends State<QuestionMcqWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Directionality(
              textDirection: isEnglishOnly(
                      widget.controller.questionsList[widget.index].body)
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Align(
                alignment: isEnglishOnly(
                        widget.controller.questionsList[widget.index].body)
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 20.h, horizontal: 25.h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Text(
                    '${widget.index + 1} - ${widget.controller.questionsList[widget.index].body} :',
                    style: kTextStyle.copyWith(
                        fontSize: 13.sp, color: Theme.of(context).hintColor),
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).canvasColor,
              ),
              child: Column(
                children: [
                  answersList(
                      selectAnswer: (answerIndex) {
                        widget.controller.selectAnswer(
                            questionIndex: widget.index,
                            answerIndex: answerIndex);
                        setState(() {});
                      },
                      questionIndex: widget.index,
                      mcqController: widget.controller),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.controller.questionsList[widget.index].answers
                              .length >
                          2) ...[
                        GestureDetector(
                          onTap: () {
                            widget.controller.correctOneQuestion(
                              questionIndex: widget.index,
                            );
                            setState(() {});
                          },
                          child: McqDetailsCard(
                            svgPath: 'assets/svg/true-mcq.svg',
                            color: widget.controller.questionsList[widget.index]
                                    .isCorrect!
                                ? AppColor.green
                                : Theme.of(context).canvasColor,
                          ),
                        ),
                      ],

                      /*  GestureDetector(
                  onTap: () {
                    controller.correctOneQuestion(
                      questionIndex: index,
                    );
                  },
                  child: McqDetailsCard(
                    svgPath: 'assets/svg/true-mcq.svg',
                    color: controller.questionsList[index].isCorrect!
                        ? AppColor.green
                        : AppColor.darkGrey,
                  ),
                ), */
                      if (widget.controller.questionsList[widget.index].answers
                              .length !=
                          1) ...[
                        GestureDetector(
                          onTap: () {
                            widget.controller.currentQuestion =
                                widget.controller.questionsList[widget.index];
                            Get.dialog(NoteDialog());
                          },
                          child: McqDetailsCard(
                            svgPath: 'assets/svg/note.svg',
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ],
                      GestureDetector(
                        onTap: () {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     backgroundColor: Colors.white,
                          //     content: HintDialog(
                          //       hint:
                          //           widget.controller.questionsList[widget.index].hint,
                          //     ),
                          //     // behavior: SnackBarBehavior.floating,
                          //     // margin: EdgeInsets.only(
                          //     //   bottom: 20.h,
                          //     //   right: 20.h,
                          //     //   left: 20.h,
                          //     // ),
                          //   ),
                          // );
                          Get.bottomSheet(
                            barrierColor: Colors.transparent,
                            HintDialog(
                              hint: widget
                                  .controller.questionsList[widget.index].hint,
                            ),
                          );
                        },
                        child: McqDetailsCard(
                          svgPath: 'assets/svg/lamp2.svg',
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.controller.currentQuestion =
                              widget.controller.questionsList[widget.index];

                          if (widget.controller.questionsList[widget.index]
                                  .answers.length ==
                              1) {
                            widget.controller.toggleFavoriteNarrative();
                          } else {
                            widget.controller.toggleFavorite();
                          }
                          setState(() {});
                          /*  controller.currentQuestion =
                        controller.questionsList[index];
                    controller.toggleFavorite(); */
                        },
                        child: McqDetailsCard(
                          color: widget.controller.questionsList[widget.index]
                                      .isFavorite ==
                                  true
                              ? AppColor.red
                              : Theme.of(context).canvasColor,
                          svgPath: 'assets/svg/heart-mcq.svg',
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  if (widget.controller.questionsList[widget.index].note !=
                      null) ...[
                    Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'ملاحظة: ',
                              style: kTextStyle.copyWith(
                                  fontSize: 13.sp,
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget
                                  .controller.questionsList[widget.index].note!,
                              style: kTextStyle.copyWith(
                                  fontSize: 13.sp, color: AppColor.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                      child: DoctorList(
                        index: widget.index,
                        mcqController: widget.controller,
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ],
              ),
            ),
            5.verticalSpace,
            widget.controller.questionsList[widget.index].image2 != null
                ? Image.memory(
                    widget.controller.questionsList[widget.index].image2!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
