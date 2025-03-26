import 'package:flutter/material.dart';

class WrapperWidget extends StatelessWidget {
  final bool condition;
  final Widget child;
  final Widget Function(Widget child) widget;
  final Widget Function(Widget child) fallBack;
  const WrapperWidget({
    super.key,
    required this.condition,
    required this.child,
    required this.widget,
    required this.fallBack,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? widget(child) : fallBack(child);
  }
}
