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
import 'package:dopamin/futures/auth/presentation/widgets/top_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const StackSvgsWidgets(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const TopWidget(),
                    Container(
                      padding: EdgeInsetsDirectional.only(top: 15.h),
                      constraints: BoxConstraints(maxWidth: 1.sw / 1.7),
                      child: Text(
                        textAlign: TextAlign.center,
                        "أهلا بك في تطبيق تارغيت أنت الآن تقوم بتفعيل النسخة المجانية",
                        style: kTextStyle.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      margin: EdgeInsetsDirectional.symmetric(
                          horizontal: 17.w, vertical: 20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.newGolden),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            20.verticalSpace,
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 15.w),
                              child: Row(
                                children: [
                                  CustomSvg(
                                    svgPath: "assets/svg/person.svg",
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    size: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "الاسم الكامل",
                                    style: labelTextStyle.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ),
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            CustomTextField(
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              textColor: Theme.of(context).hintColor,
                              borderRadius: 26,
                              textInputAction: TextInputAction.next,
                              textEditingController: userNameController,
                              validator: (value) {
                                return validateTextField(value!);
                              },
                            ),
                            20.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Row(
                                children: [
                                  CustomSvg(
                                    svgPath: "assets/svg/person.svg",
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    size: 28,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "كلمة المرور",
                                    style: labelTextStyle.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ),
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            CustomTextField(
                              textInputAction: TextInputAction.done,
                              // maxLines: 1,
                              borderRadius: 26,

                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              textColor: Theme.of(context).hintColor,
                              textEditingController: passController,
                              validator: (value) {
                                return validateTextField(value!);
                              },
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRouter.kRegisterScreen);
                      },
                      child: Text(
                        'هل تريد إنشاء حساب جديد؟',
                        style: kTextStyle.copyWith(
                          fontSize: 15.sp,
                          color: Theme.of(context).hintColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    GetBuilder<MainController>(builder: (controller) {
                      return HandleView(
                          requestState: controller.loginState,
                          loadingWidget: const CircularProgressIndicator(),
                          defaultWidget: ElevatedButton(
                              onPressed: () async {
                                if (globalKey.currentState!.validate()) {
                                  controller.login(
                                    isGoogleAuth: false,
                                      authParams: AuthParams(
                                          userName: userNameController.text,
                                          password: passController.text));
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.newGolden)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 10.h, horizontal: 30.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'التالي',
                                      style: labelTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    20.horizontalSpace,
                                    CustomSvg(
                                      svgPath: "assets/svg/next.svg",
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    )
                                  ],
                                ),
                              )));
                    }),
                    // TextButton(
                    //     onPressed: () {
                    //       Get.offAllNamed(AppRouter.kRegisterScreen);
                    //     },
                    //     child: Text(
                    //       "تسجيل حساب",
                    //       style: kTextStyle.copyWith(fontSize: 15.sp),
                    //     )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
