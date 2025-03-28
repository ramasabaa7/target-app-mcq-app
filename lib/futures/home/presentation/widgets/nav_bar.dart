import 'package:dopamin/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dopamin/core/widgets/custom_svg.dart';

class SalomonBottomBar extends StatelessWidget {
  SalomonBottomBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  final List<SalomonBottomBarItem> items;

  final int currentIndex;

  final Function(int)? onTap;

  final Color? backgroundColor;

  final Color? selectedItemColor;

  final Color? unselectedItemColor;

  final double? selectedColorOpacity;

  final ShapeBorder itemShape;

  final EdgeInsets margin;

  final EdgeInsets itemPadding;

  final Duration duration;

  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: backgroundColor ?? AppColor.newGolden,
      child: SafeArea(
        minimum: margin,
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Row(
            mainAxisAlignment: items.length <= 2
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                  ),
                  curve: curve,
                  duration: duration,
                  builder: (context, t, _) {
                    final _selectedColor = item.selectedColor ??
                        selectedItemColor ??
                        theme.primaryColor;

                    final _unselectedColor = item.unselectedColor ??
                        unselectedItemColor ??
                        theme.iconTheme.color;

                    return Material(
                      color: Color.lerp(
                          _selectedColor.withOpacity(0.0), _selectedColor, t),
                      shape: itemShape,
                      child: InkWell(
                        onTap: () => onTap?.call(items.indexOf(item)),
                        customBorder: itemShape,
                        focusColor: _selectedColor.withOpacity(0.1),
                        highlightColor: _selectedColor.withOpacity(0.1),
                        splashColor: _selectedColor.withOpacity(0.1),
                        hoverColor: _selectedColor.withOpacity(0.1),
                        child: Padding(
                          padding: itemPadding -
                              (Directionality.of(context) == TextDirection.ltr
                                  ? EdgeInsets.only(
                                      right: itemPadding.right * t)
                                  : EdgeInsets.only(
                                      left: itemPadding.left * t)),
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 5.w),
                            child: Row(
                              children: [
                                IconTheme(
                                  data: IconThemeData(
                                    color: Color.lerp(
                                        _unselectedColor, _selectedColor, t),
                                    size: 24,
                                  ),
                                  child: items.indexOf(item) == currentIndex
                                      ? CustomSvg(
                                            svgPath: item.svgurl!,
                                            //size: 30,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ) ??
                                          CustomSvg(
                                            svgPath: item.svgurl!,
                                            //  size: 0,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          )
                                      : CustomSvg(
                                          svgPath: item.svgurl!,
                                          //size: 30,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                ),
                                ClipRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    height: 25,
                                    child: Align(
                                      alignment: const Alignment(-0.2, 0.0),
                                      widthFactor: t,
                                      child: Padding(
                                        padding: Directionality.of(context) ==
                                                TextDirection.ltr
                                            ? EdgeInsets.only(
                                                left: itemPadding.left / 2,
                                                right: itemPadding.right)
                                            : EdgeInsets.only(
                                                left: itemPadding.left,
                                                right: itemPadding.right / 2),
                                        child: DefaultTextStyle(
                                          style: TextStyle(
                                            fontFamily: "MyFont",
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          child: item.title,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tab to display in a [SalomonBottomBar]
class SalomonBottomBarItem {
  /// An icon to display.
  final Widget icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  final String? svgurl;

  SalomonBottomBarItem(
      {required this.icon,
      required this.title,
      this.selectedColor,
      this.unselectedColor,
      this.activeIcon,
      this.svgurl});
}
