import 'package:flutter/material.dart';
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

class LoginWithGoogleScreen extends StatelessWidget {
  const LoginWithGoogleScreen({super.key});

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
              Positioned(
                top: 70.h,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
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
                      100.verticalSpace,
                      InkWell(
                        onTap: () async {
                          Functions.getDeviceToken().then((deviceToken) {
                            Get.find<MainController>()
                                .logInWithGoogle()
                                .then((value) async {
                              Get.find<MainController>().login(
                                authParams: GoogleAuthParams(
                                  deviceToken: deviceToken,
                                  accessToken: value,
                                ),
                                isGoogleAuth: true,
                              );
                            });
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 1.sw / 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.newGolden.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Theme.of(context).canvasColor),
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    'تسجيل دخول باستخدام غوغل',
                                    style: whiteSmallTextStyle.copyWith(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  20.horizontalSpace,
                                  Image(
                                    image: AssetImage(
                                        "assets/png/google_logo.png"),
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      40.verticalSpace
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
