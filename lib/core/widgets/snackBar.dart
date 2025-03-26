import 'package:dopamin/core/utils/app_color.dart';
import 'package:flutter/material.dart';

SnackBar showSnackBar(String text, {Color? color}) {
  return SnackBar(
    backgroundColor: color ?? AppColor.red,
    content: Text(text),
  );
}
