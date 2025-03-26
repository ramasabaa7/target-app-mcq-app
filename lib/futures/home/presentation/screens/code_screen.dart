import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/core/widgets/custom_button.dart';
import 'package:dopamin/core/widgets/custom_text_field.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/core/widgets/qr_code.dart';
import 'package:dopamin/futures/home/data/models/buy_code_params.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/home/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavBarController>().selectedIndexScreens = 0;
        Get.find<BottomNavBarController>().update();
        return false;
      },
      child: Container(
        color: AppColor.white,
        child: SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: CenterAppBar(
                    title: "ادارة الاكواد",
                    onTap: () {},
                    withBack: false,
                    withRefresh: false,
                  ),
                ),
                SliverFillRemaining(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      children: [
                        70.verticalSpace,
                        Text(
                          "في حال ورود مشكلة يرجى التواصل مع الدعم الفني",
                          style: kTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: Theme.of(context).hintColor),
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          textInputAction: TextInputAction.done,
                          hintText: "الرمز",
                          textColor: Theme.of(context).hintColor,
                          textEditingController: codeController,
                        ),
                        20.verticalSpace,
                        GestureDetector(
                          onTap: () async {
                            codeController.text =
                                await scanCodes(context: context)
                                    .whenComplete(() => setState(() {}));
                          },
                          child: const PaymentCard(
                            svgPath: 'assets/svg/qrcode.svg',
                            title: "مسح الرمز",
                          ),
                        ),
                        30.verticalSpace,
                        GetBuilder<HomeController>(builder: (controller) {
                          return HandleView(
                            requestState: controller.buyCodeState,
                            loadingWidget: const CircularProgressIndicator(),
                            defaultWidget: CustomButton(
                                text: "شراء",
                                press: () async {
                                  controller.buyCode(
                                      buyCodeParams: BuyCodeParams(
                                          codeController.text,
                                          await Functions.getDeviceId()));
                                }),
                          );
                        })
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
