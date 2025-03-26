import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/custom_button.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';
import 'package:dopamin/core/widgets/custom_text_field.dart';
import 'package:dopamin/core/widgets/handle_view.dart';
import 'package:dopamin/futures/auth/data/models/auth_model.dart';
import 'package:dopamin/futures/auth/presentation/controller/main_controller.dart';
import 'package:dopamin/futures/auth/presentation/widgets/stack_svgs.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool pp = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController passController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const StackSvgsWidgets(),
            // Positioned(
            //     right: -40.h,
            //     top: 80.h,
            //     child: const CustomSvg(
            //       size: 200,
            //       svgPath: "assets/svg/right-white.svg",
            //       color: AppColor.white,
            //     )),
            /*      Positioned(
                bottom: -70.h,
                left: -20.h,
                right: -20.h,
                child: const CustomSvg(
                  size: 200,
                  svgPath: "assets/svg/bottom-white.svg",
                  color: AppColor.white,
                )), */
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/target-logo.png',
                      height: 150.h,
                    ),
                    Text(
                      "تارغيت",
                      style: kTextStyle.copyWith(
                          color: AppColor.newGolden, fontSize: 25.sp),
                    ),
                    Text(
                      "TARGET",
                      style: kTextStyle.copyWith(
                          color: AppColor.newGolden,
                          letterSpacing: 5,
                          fontSize: 27.sp),
                    ),
                    10.verticalSpace,
                    Container(
                      constraints: BoxConstraints(maxWidth: 1.sw / 1.3),
                      child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        "أهلا بك في تطبيق تارغيت",
                        style: kTextStyle.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    /*  Container(
                      constraints: BoxConstraints(maxWidth: 1.sw / 1.3),
                      child: Text(
                        textAlign: TextAlign.right,
                        "أنت الآن تقوم بتفعيل النسخة المجانية",
                        style: kTextStyle.copyWith(color: AppColor.black),
                      ),
                    ), */
                    20.verticalSpace,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CustomSvg(
                                  svgPath: "assets/svg/person.svg",
                                  size: 30,
                                  color: AppColor.newGolden,
                                ),
                                10.horizontalSpace,
                                Text(
                                  "الاسم الكامل",
                                  style: kTextStyle.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            CustomTextField(
                              borderRadius: 15,
                              fillColor: Theme.of(context).canvasColor,
                              textEditingController: nameController,
                              textColor: Theme.of(context).hintColor,
                              validator: (value) {
                                return validateTextField(value!);
                              },
                            ),
                            20.verticalSpace,
                            Row(
                              children: [
                                const CustomSvg(
                                  svgPath: "assets/svg/person.svg",
                                  size: 30,
                                  color: AppColor.newGolden,
                                ),
                                10.horizontalSpace,
                                Text(
                                  "اسم المستخدم",
                                  style: kTextStyle.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            CustomTextField(
                              borderRadius: 15,
                              fillColor: Theme.of(context).canvasColor,
                              textEditingController: userNameController,
                              textColor: Theme.of(context).hintColor,
                              validator: (value) {
                                return validateTextField(value!);
                              },
                            ),
                            20.verticalSpace,
                            Row(
                              children: [
                                const CustomSvg(
                                  svgPath: "assets/svg/person.svg",
                                  size: 30,
                                  color: AppColor.newGolden,
                                ),
                                10.horizontalSpace,
                                Text(
                                  "كلمة المرور",
                                  style: kTextStyle.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            CustomTextField(
                              borderRadius: 15,
                              maxLines: 1,
                              suffixIcon: 'assets/svg/visible.svg',
                              obscureText: true,
                              fillColor: Theme.of(context).canvasColor,
                              textEditingController: passController,
                              textColor: Theme.of(context).hintColor,
                              validator: (value) {
                                return validatePassword(value!);
                              },
                            ),
                            20.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                    value: pp,
                                    onChanged: (value) {
                                      setState(() {
                                        pp = !pp;
                                      });
                                    },
                                  ),
                                ),
                                //  20.horizontalSpace,
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    "الموافقة على  سياسة الخصوصية",
                                    style: kTextStyle.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            20.verticalSpace,
                            GetBuilder<MainController>(builder: (controller) {
                              return HandleView(
                                requestState: controller.registerState,
                                loadingWidget:
                                    const CircularProgressIndicator(),
                                defaultWidget: CustomButton(
                                    text: "تسجيل حساب",
                                    press: () async {
                                      String x =
                                          await Functions.getDeviceToken();
                                      Functions.logPrint(x);
                                      if (globalKey.currentState!.validate()) {
                                        controller.register(
                                            authParams: AuthParams(
                                                deviceToken: await Functions
                                                    .getDeviceToken(),
                                                name: nameController.text,
                                                userName:
                                                    userNameController.text,
                                                password: passController.text));
                                      }
                                    }),
                              );
                            }),
                            30.verticalSpace,
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: AppColor.newGolden),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: TextButton(
                                  onPressed: () {
                                    Get.offAllNamed(AppRouter.kLoginScreen);
                                  },
                                  child: Text(
                                    "تسجيل دخول",
                                    style: kTextStyle.copyWith(
                                        fontSize: 13.sp,
                                        color: Theme.of(context).hintColor),
                                  )),
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
