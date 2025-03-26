import 'dart:math';

import 'package:dopamin/futures/auth/presentation/controller/main_bindings.dart';
import 'package:dopamin/futures/auth/presentation/screen/academic_year_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/cities_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/edit_info_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/login_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/login_with_google_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/on_boarding_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/register_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/semester_screen.dart';
import 'package:dopamin/futures/auth/presentation/screen/specification_screen.dart';
import 'package:dopamin/futures/home/presentation/screens/main_screen.dart';
import 'package:dopamin/futures/mcq/presentation/controller/mcq_binding.dart';
import 'package:dopamin/futures/mcq/presentation/screens/favorite_questions_screen.dart';
import 'package:dopamin/futures/mcq/presentation/screens/mcq_screen.dart';
import 'package:dopamin/futures/mcq/presentation/screens/narrative_question_screen.dart';
import 'package:dopamin/futures/mcq/presentation/screens/subjcts.dart';
import 'package:dopamin/futures/setting/presentation/controller/point_sales_binding.dart';
import 'package:dopamin/futures/setting/presentation/screens/about_app_screen.dart';
import 'package:dopamin/futures/setting/presentation/screens/about_developer.dart';
import 'package:dopamin/futures/setting/presentation/screens/contact_us_screen.dart';
import 'package:dopamin/futures/setting/presentation/screens/my_subscription_screen.dart';
import 'package:dopamin/futures/setting/presentation/screens/point_sales_screen.dart';
import 'package:dopamin/futures/setting/presentation/screens/support_screen.dart';
import 'package:dopamin/futures/subjects/presentation/controller/subject_binding.dart';
import 'package:dopamin/futures/subjects/presentation/screens/about_subject_screen.dart';
import 'package:dopamin/futures/subjects/presentation/screens/categories_screen.dart';
import 'package:dopamin/futures/subjects/presentation/screens/exam_cycles_screen.dart';
import 'package:dopamin/futures/subjects/presentation/screens/hints_screen.dart';
import 'package:dopamin/futures/subjects/presentation/screens/lectures_screen.dart';
import 'package:dopamin/futures/subjects/presentation/screens/subject_screen.dart';
import 'package:get/get.dart';

mixin AppRouter {
  static const String kMainScreen = '/';
  static const String kOnBoardingScreen = '/onBoardingScreen';
  static const String kLoginScreen = '/loginScreen';
  static const String kRegisterScreen = '/registerScreen';

  static const String kCitiesScreen = '/citiesScreen';
  static const String kSubjectScreen = '/subjectScreen';
  static const String kExamCyclesScreen = '/examCyclesScreen';
  static const String kExamCyclesScreen2 = '/examCyclesScreen2';
  static const String kMcqScreen = '/mcqScreen';
  static const String kCategoriesScreen = '/categoriesScreen';
  static const String kSpecificationScreen = '/specificationScreen';
  static const String kAcademicYearScreen = '/academicYearScreen';
  static const String kSemestersScreen = '/semestersScreen';
  static const String kAboutAppScreen = '/aboutAppScreen';
  static const String kContactUsScreen = '/contactUsScreen';
  static const String kSupportScreen = '/supportScreen';
  static const String kPointSales = '/pointSalesScreen';
  static const String kAboutDeveloper = '/aboutDeveloper';
  static const String kEditInfoScreen = '/editInfoScreen';
  static const String kFavoriteQuestionsScreen = '/favoriteQuestionsScreen';
  static const String kAboutSubjectScreen = '/aboutSubjectScreen';
  static const String kLecturesScreen = '/lecturesScreen';
  static const String kNarrativeQuestionScreen = '/narrativeQuestionScreen';
  static const String kMySubscriptionScreen = '/mySubscriptionScreen';

  static const String kMySubjectsScreen = '/mySubjectsScreen';
  static const String hintsScreen = '/hintsScreen';
 static const String loginWithGoogleScreen = '/loginWithGoogleScreen';
  static final pages = [
    GetPage(
      name: kMySubscriptionScreen,
      page: () => const MySubscriptionScreen(),

      //    binding: NarrativeQuestionBinding()
    ),
    GetPage(
        name: kNarrativeQuestionScreen,
        page: () => const NarrativeQuestionScreen(),
        binding: NarrativeQuestionBinding()),
    GetPage(
        name: kLecturesScreen,
        page: () => const LecturesScreen(),
        binding: LecturesBinding()),
    GetPage(
      name: kAboutSubjectScreen,
      page: () => const AboutSubjectScreen(),
    ),
    GetPage(
      name: kEditInfoScreen,
      page: () => const EditInfoScreen(),
      binding: HomeBinding()
    ),
    GetPage(
      name: kAboutDeveloper,
      page: () => const AboutDeveloperScreen(),
    ),
    GetPage(
      name: kMainScreen,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: kOnBoardingScreen,
      page: () => const OnBoardingScreen(),
      binding: MainBinding(),
    ),
    GetPage(
        name: kLoginScreen, page: () => LoginScreen(), binding: MainBinding()),
    GetPage(
      name: kRegisterScreen,
      page: () => const RegisterScreen(),
      //binding: MainBinding()
    ),
    GetPage(
      name: kCitiesScreen,
      page: () => const CitiesScreen(),
    ),
    GetPage(
        name: kSubjectScreen,
        page: () => const SubjectScreen(),
        binding: CountBinding()),
    GetPage(
        name: kExamCyclesScreen,
        page: () => const ExamCyclesScreen(),
        binding: ExamCycleBinding()),
    GetPage(
      name: kMcqScreen,
      page: () => const McqScreen(),
      binding: McqBinding(),
    ),
    GetPage(
        name: kCategoriesScreen,
        page: () => const CategoriesScreen(),
        binding: CategoriesBinding()),
    GetPage(
      name: kAcademicYearScreen,
      page: () => const AcademicYearScreen(),
    ),
    GetPage(
      name: kSpecificationScreen,
      page: () => const SpecificationScreen(),
    ),
    GetPage(
      name: kSemestersScreen,
      page: () => const SemesterScreen(),
    ),
    GetPage(
      name: kAboutAppScreen,
      page: () => const AboutAppScreen(),
    ),
    GetPage(
      name: kContactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: kSupportScreen,
      page: () => const SupportScreen(),
      binding: SetttingBinding(),
    ),
    GetPage(
        name: kPointSales,
        page: () => const PointSalesScreen(),
        binding: PointSalesBinding()),
    GetPage(
        name: kFavoriteQuestionsScreen,
        page: () => const FavoriteQuestionsScreen(),
        binding: FavoriteBinding()),
    GetPage(
      name: kMySubjectsScreen,
      page: () => const SubjectsScreennew(),
    ),
    GetPage(
        name: hintsScreen,
        page: () => const HintsScreen(),
        binding: HintBinding()),
  
        GetPage(
        name: loginWithGoogleScreen,
        page: () => const LoginWithGoogleScreen(),
        binding: MainBinding(),
        ),
  ];
}
