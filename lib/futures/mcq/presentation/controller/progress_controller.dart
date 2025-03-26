import 'dart:async';
import 'package:get/get.dart';

class CircularProgressController extends GetxController {
  RxDouble value = 0.0.obs;

  void increaseProgress({required selectedAnswer, required wrongAnswer}) {
    const duration = Duration(milliseconds: 50);
    Timer.periodic(duration, (Timer timer) {
      if (value >=
          ((selectedAnswer.length - wrongAnswer.length) /
              selectedAnswer.length)) {
        timer.cancel();
      } else {
        value.value += 0.01;
      }
    });
    value = 0.0.obs;
  }
}
