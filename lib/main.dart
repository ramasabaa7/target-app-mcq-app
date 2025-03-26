import 'dart:io';
import 'dart:math';
import 'package:dopamin/core/global/progress_controller.dart';
import 'package:dopamin/core/router/app_router.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/functions.dart';
import 'package:dopamin/firebase_options.dart';
import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/auth/data/models/point_sale_model.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:dopamin/futures/home/presentation/controller/home_controller.dart';
import 'package:dopamin/futures/mcq/presentation/controller/progress_controller.dart';
import 'package:dopamin/futures/subjects/data/models/answer_model.dart';
import 'package:dopamin/futures/subjects/data/models/category_model.dart';
import 'package:dopamin/futures/subjects/data/models/doctor_model.dart';
import 'package:dopamin/futures/subjects/data/models/examcycle_model.dart';
import 'package:dopamin/futures/subjects/data/models/hint_model.dart';
import 'package:dopamin/futures/subjects/data/models/lecture_model.dart';
import 'package:dopamin/futures/subjects/data/models/question_model.dart';
import 'package:dopamin/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'futures/subjects/data/models/exam_cycles_and_categorizations_count.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  print('remoteMessage ${remoteMessage}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await rootBundle.load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  await initDependencies();
  await Hive.initFlutter();
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('message ${message.notification!.body}');
    Functions.viewNotification(message);
    Get.find<HomeController>().getNotification();
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('message ${message.notification!.body}');
    Functions.viewNotification(message);
    Get.find<HomeController>().getNotification();
  });

  await Functions.disableScreenshots();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(ExamCycleAdapter());
  Hive.registerAdapter(CategoryMAdapter());
  Hive.registerAdapter(AnswerAdapter());
  Hive.registerAdapter(DoctorsAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(LectureAdapter());
  Hive.registerAdapter(MySubscriptionAdapter());
  Hive.registerAdapter(CityAdapter());
  Hive.registerAdapter(SliderMAdapter());
  Hive.registerAdapter(PointSaleAdapter());
  Hive.registerAdapter(NotifyAdapter());
   Hive.registerAdapter(AcademicYearAdapter());
   Hive.registerAdapter(PivotAcademicAdapter());
    Hive.registerAdapter(HintsModelAdapter());

//  Hive.registerAdapter(ExamCyclesAndCategorizationsCountAdapter());

  await Hive.openBox<Subject>("subjects");
  await Hive.openBox<ExamCycle>("examCycle");
  await Hive.openBox<CategoryM>("categoryM");
  await Hive.openBox<Question>("question");
  await Hive.openBox<Lecture>("lecture");
  await Hive.openBox<Question>("questionInCategory");
  await Hive.openBox<Question>("narrativeQuestions");
  await Hive.openBox<MySubscription>("mySubscription");
  await Hive.openBox<City>("citiesAndPos");
  await Hive.openBox<SliderM>("slider");
  await Hive.openBox<Notify>("notify");
   await Hive.openBox<AcademicYear>("academicyear");
    await Hive.openBox<HintsModel>("hints");
  //await Hive.openBox<ExamCyclesAndCategorizationsCount>("counts");

  //box.erase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CircularProgressController());
    Get.put(ProgressController());
    return ScreenUtilInit(
        designSize: const Size(340, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child!);
              },
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: AppColor.darkMood,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: AppColor.newGolden),
                  hintColor: AppColor.newScafold,
                  canvasColor: Color.fromARGB(255, 27, 27, 27),
                  useMaterial3: true),
              themeMode: Functions.currenThem(),
              theme: ThemeData(
                scaffoldBackgroundColor: AppColor.newScafold,
                hintColor: AppColor.textBlack,
                canvasColor: const Color(0xffffffff),
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColor.newGolden),
                useMaterial3: true,
              ),
              locale: const Locale('ar'),
              // home: const Map(),
              getPages: AppRouter.pages,
              /*  translations: MyLocale(),
            locale: controllerLang.initLang,
            */
              initialRoute: box.read(SEMESTERID) == null
                  ? AppRouter.kOnBoardingScreen
                  : AppRouter.kMainScreen);
        });
  }
}
