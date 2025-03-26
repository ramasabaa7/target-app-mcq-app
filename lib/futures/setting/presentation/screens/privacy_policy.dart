import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:dopamin/core/widgets/center_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Theme.of(context).canvasColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CenterAppBar(
                    title: "سياسة الخصوصية",
                    onTap: () {
                      Get.back();
                    }),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 20.w, vertical: 20.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Text('المقدمة',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              ' نحن في [تارغيت] نقدر خصوصيتك ونلتزم بحماية معلوماتك الشخصية. توضح سياسة الخصوصية هذه كيف نجمع ونستخدم ونشارك المعلومات التي نحصل عليها من خلال استخدامك لتطبيقنا الذي يقدم مواد دراسية، أسئلة، واختبارات.',
                              context),
                          buildDivider(),
                          Text('البيانات التي نجمعها',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              'البيانات الشخصية:',
                              'قد نجمع بيانات شخصية مثل الاسم، البريد الإلكتروني، والموقع الجغرافي لتسهيل تقديم الخدمات.',
                              context),
                          info(
                              'بيانات الاستخدام:',
                              'نجمع معلومات حول كيفية استخدامك للتطبيق مثل الصفحات التي تزورها والوقت الذي تقضيه في التطبيق.',
                              context),
                          info(
                              'الأداء والتحليلات:',
                              'لتحسين تطبيقنا، قد نجمع بيانات تتعلق بأدائك في الاختبارات والأسئلة.',
                              context),
                          buildDivider(),
                          Text('كيف نستخدم بياناتك',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              '- لتقديم وتحسين خدماتنا. \n - للتواصل معك حول التحديثات والمعلومات الهامة.\n- لتحليل استخدام التطبيق وتحسين تجربة المستخدم.',
                              context),
                          buildDivider(),
                          Text('مشاركة البيانات',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              'لا نشارك بياناتك الشخصية مع أطراف ثالثة إلا في الحالات التالية:\n  - بموافقتك الصريحة.\n  -للامتثال للقوانين.\n  - لحماية حقوق أو ملكية [تارغيت].',
                              context),
                          buildDivider(),
                          Text(' حقوق المستخدم',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              'لديك الحق في الوصول إلى بياناتك الشخصية، تصحيحها، أو طلب حذفها. يمكنك أيضًا الاعتراض على معالجة بياناتك في بعض الظروف.',
                              context),
                          buildDivider(),
                          Text('تأمين البيانات',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              'نستخدم تدابير أمان معقولة لحماية بياناتك ومنع الوصول غير المصرح به إليها.',
                              context),
                          buildDivider(),
                          Text('تغييرات على سياسة الخصوصية',
                              style: kTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  height: 2,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600)),
                          info(
                              '',
                              'قد نحدث سياسة الخصوصية هذه من وقت لآخر. سننشر أي تغييرات على هذه الصفحة ونوصي بمراجعته',
                              context),
                          40.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget info(String title, String value, BuildContext context) {
    return RichText(
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: kTextStyle.copyWith(
                fontSize: 18.sp,
                height: 2,
                color: Theme.of(context).hintColor,
              )),
          TextSpan(
              text: value,
              style: kTextStyle.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w300,
                height: 2,
                color: Theme.of(context).hintColor,
              )),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return  const Divider(
      height: 30,
      endIndent: 40,
      indent: 40,
      color: AppColor.newGolden,
      thickness: 2,
    );
  }
}
