import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension DoubleExtensions on double {
  double get sd => Get.size.shortestSide * this;
  double get ld => Get.size.longestSide * this;


  
}

extension ContextExtensions on BuildContext {
  bool get isTablet {
    final size = MediaQuery.of(this).size;
    final diagonal = sqrt((size.width * size.width) + (size.height * size.height));
    return diagonal >= 7.0; 
  }
}