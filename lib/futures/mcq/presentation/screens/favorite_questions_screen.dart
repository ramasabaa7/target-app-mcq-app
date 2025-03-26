import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/shimmer.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_error.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/empty_folder.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:dopamin/futures/mcq/presentation/widget/question_mcq_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FavoriteQuestionsScreen extends StatelessWidget {
  const FavoriteQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(body: GetBuilder<McqController>(builder: (controller) {
          return Center(
            child: HandleView(
              requestState: controller.getQuestionsState,
              errorWidget: CustomError(
                message: controller.getQuestionMessage,
                onTap: () {
                  controller.getFavoriteQuestions();
                },
              ),
              loadingWidget: Padding(
                padding: EdgeInsets.all(kHorizontalPadding),
                child: shimmerLecture(),
              ),
              defaultWidget: const Text("def"),
              successWidget: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CenterAppBar(
                          title: "الأسئلة المفضلة",
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: controller.questionsList.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return 10.verticalSpace;
                            },
                            itemCount: controller.questionsList.length,
                            //  padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemBuilder: (context, index) {
                              return QuestionMcqWidget(
                                controller: controller,
                                index: index,
                              );
                            },
                          )
                        : EmptyFolderWidget(
                            textt: 'لا يوجد اسئلة في المفضلة',
                          ),
                  )
                ],
              ),
            ),
          );
        })),
      ),
    );
  }
}
