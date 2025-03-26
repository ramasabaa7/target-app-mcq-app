import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_button.dart';
import 'package:dopamin/core/widgets/custom_text_field.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NoteDialog extends StatefulWidget {
  NoteDialog({
    super.key,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text =
        Get.find<McqController>().currentQuestion.note ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text('اضافة ملاحظة',
          style: kTextStyle.copyWith(
              color: Theme.of(context).hintColor.withOpacity(0.5))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpace,
          CustomTextField(
            textEditingController: textEditingController,
            hintText: "ملاحظة",
            textColor: Theme.of(context).hintColor.withOpacity(0.5),
            prefixIconData: Icon(
              Icons.note,
              color: AppColor.newGolden,
            ),
            textInputType: TextInputType.multiline,
            maxLines: 500,
            minLines: 1,
            textInputAction: TextInputAction.newline,
          ),
          10.verticalSpace,
          CustomButton(
            text: "اضافة",
            press: () {
              if (textEditingController.text.trim().isNotEmpty) {
                Get.find<McqController>().addNote(
                    note: textEditingController.text,
                    questionId: Get.find<McqController>().currentQuestion.id);
                Get.find<McqController>().currentQuestion.note =
                    textEditingController.text;
                Get.find<McqController>().update();
                textEditingController.clear();
                Get.back();
              }
            },
          )
        ],
      ),
    );
  }
}
