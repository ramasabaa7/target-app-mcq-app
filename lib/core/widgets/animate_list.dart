import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TanimateList extends StatelessWidget {
  const TanimateList({super.key, required this.child, required this.index});
  final Widget child;
  final int index;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        duration: const Duration(milliseconds: 600),
        position: index,
        child: SlideAnimation(
            // duration: const Duration(milliseconds: 100),
            child: FadeInAnimation(
          //  duration: const Duration(milliseconds: 100),
          child: child,
        )));
  }
}

class TanimateListHorizontal extends StatelessWidget {
  const TanimateListHorizontal(
      {super.key, required this.child, required this.index});
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 5000),
        delay: const Duration(milliseconds: 100),
        child: SlideAnimation(
            verticalOffset:
                0.0, // Set vertical offset to 0 for horizontal movement
            horizontalOffset: -50.0, // Adjust the horizontal offset as needed
            duration: const Duration(milliseconds: 4000),
            curve: Curves.fastLinearToSlowEaseIn,
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
              child: child,
            )));
  }
}
