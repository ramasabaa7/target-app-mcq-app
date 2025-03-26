
import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/setting/presentation/controller/switch_controller.dart';
import 'package:dopamin/futures/setting/presentation/screens/privacy_policy.dart';
import 'package:dopamin/futures/setting/presentation/widgets/setting_card.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SwitchController switchController = Get.put(SwitchController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavBarController>().selectedIndexScreens = 0;
        Get.find<BottomNavBarController>().update();
        return false;
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: CenterAppBar(
                    title: "الاعدادات",
                    onTap: () {},
                    withBack: false,
                  ),
                ),
                SliverFillRemaining(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.lightGrey.withOpacity(0.05),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Container(
                                  height: 60.h,
                                  width: 45.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/png/user_pic.png"),
                                        fit: BoxFit.fill,
                                      ))),
                              15.horizontalSpace,
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "الاسم : ${box.read(NAME) ?? ""}",
                                    style: kTextStyle.copyWith(
                                        fontSize: 17.sp,
                                        color: Theme.of(context).hintColor),
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    "اسم المستخدم : ${box.read(USERNAME) ?? ""}",
                                    style: kTextStyle.copyWith(
                                        fontSize: 17.sp,
                                        color: Theme.of(context).hintColor),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Obx(
                          () => Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColor.lightGrey.withOpacity(0.05),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SwitchListTile(
                                title: Text(switchController.title.value,
                                    style: kTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).hintColor)),
                                value: switchController.isSwitched.value,
                                onChanged: (value) {
                                  switchController.toggleSwitch();
                                 // print(box.read(MOOD));
                                },
                              )),
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SettingCard(
                            //   title: "اشتراكاتي",
                            //   iconData: Icons.subject_sharp,
                            //   onTap: () {
                            //     Get.toNamed(AppRouter.kMySubscriptionScreen);
                            //   },
                            // ),
                            SettingCard(
                              title: "تعديل المعلومات",
                              iconData: Icons.edit,
                              onTap: () {
                                Get.toNamed(AppRouter.kEditInfoScreen);
                              },
                            ),
                            20.horizontalSpace,
                            SettingCard(
                              title: "الدعم الفني",
                              iconData: Icons.support_agent,
                              onTap: () {
                                Get.toNamed(AppRouter.kSupportScreen);
                              },
                            ),
                          ],
                        ),
                        30.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SettingCard(
                              title: "مراكز البيع",
                              iconData: Icons.place_outlined,
                              onTap: () {
                                Get.toNamed(AppRouter.kPointSales);
                              },
                            ),
                            20.horizontalSpace,
                            SettingCard(
                              title: "حول التطبيق",
                              iconData: Icons.info_outline,
                              onTap: () {
                                Get.toNamed(AppRouter.kAboutAppScreen);
                              },
                            ),
                          ],
                        ),
                        30.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SettingCard(
                              title: "سياسة الخصوصية",
                              iconData: Icons.support_agent,
                              onTap: () {
                                Get.to(() => const PrivacyPolicyScreen());
                              },
                            ),
                            20.horizontalSpace,
                            SettingCard(
                              withArrow: false,
                              title: "تسجيل خروج",
                              iconData: Icons.logout,
                              onTap: () async {
                                String mood = box.read(MOOD);

                                //print("${mood}");
                                await box.erase();
                                await Hive.box<Subject>('subjects').clear();
                                await Hive.box<ExamCycle>('examCycle').clear();
                                await Hive.box<CategoryM>('categoryM').clear();
                                await Hive.box<Question>('question').clear();
                                await Hive.box<Lecture>('lecture').clear();
                                await Hive.box<Question>('questionInCategory')
                                    .clear();
                                await Hive.box<Question>('narrativeQuestions')
                                    .clear();

                                await Hive.box<MySubscription>('mySubscription')
                                    .clear();
                                await Hive.box<SliderM>('slider').clear();
                                await Hive.box<Notify>('notify').clear();
                                await Hive.box<City>('citiesAndPos').clear();
                                await Hive.box<HintsModel>('hints').clear();
                                await Hive.box<AcademicYear>('academicyear')
                                    .clear();

                                await box.write(MOOD, mood);

                             
                                Get.offAllNamed(AppRouter.kOnBoardingScreen);
                              },
                            ),
                          ],
                        ),
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
