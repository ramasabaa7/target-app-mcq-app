import 'package:dio/dio.dart';
import 'package:dopamin/core/services/data_repo.dart';
import 'package:dopamin/core/services/internet_checker.dart';
import 'package:dopamin/futures/auth/data/repo/main_repo.dart';
import 'package:dopamin/futures/auth/data/repo/main_repo_impl.dart';
import 'package:dopamin/futures/home/data/repo/home_repo.dart';
import 'package:dopamin/futures/home/data/repo/home_repo_impl.dart';
import 'package:dopamin/futures/home/data/repo/home_local_repo.dart';
import 'package:dopamin/futures/home/presentation/controller/bottom_nav_bar_controller.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_local_repo.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_repo.dart';
import 'package:dopamin/futures/mcq/data/repo/mcq_repo_impl.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_local_repo.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo.dart';
import 'package:dopamin/futures/subjects/data/repo/subject_repo_impl.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> initDependencies() async {
  Get.put<Dio>(Dio());
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));
  Get.lazyPut<DataService>(() => DataService(Get.find(), Get.find()));
  Get.put<DataService>(DataService(Get.find(), Get.find()));

  Get.put(BottomNavBarController());

  Get.put<MainRepo>(MainRepoImpl(Get.find()));
  Get.put<HomeRepo>(HomeRepoImpl(Get.find()));
  Get.put<HomeLocalData>(HomeLocalDataImpl());

  Get.put<SubjectRepo>(SubjectRepoImpl(Get.find()));
  Get.put<SubjectLocalRepo>(SubjectLocalRepoImpl());

  Get.put<McqRepo>(McqRepoImpl(Get.find()));
  Get.put<McqLocalRepo>(McqLocalRepoImpl());

}
