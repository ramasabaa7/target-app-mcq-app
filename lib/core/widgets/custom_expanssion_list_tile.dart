import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/const.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpanssionListTile extends StatefulWidget {
  const CustomExpanssionListTile(
      {Key? key,
      required this.title,
      required this.child,
      required this.index,
      this.image})
      : super(key: key);
  final String title;
  final Widget child;
  final int index;
  final Uint8List? image;
  @override
  // ignore: library_private_types_in_public_api
  _CustomExpanssionListTileState createState() =>
      _CustomExpanssionListTileState();
}

class _CustomExpanssionListTileState extends State<CustomExpanssionListTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(25),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          // border: const Border.symmetric(
          //   horizontal: BorderSide(
          //     color: AppColor.golden,
          //     width: 1,
          //   ),
          // ),
        ),
        child: InkWell(
          onTap: () => setState(() {
            isExpanded = !isExpanded;
            if (isExpanded) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          }),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: isEnglishOnly(widget.title)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Align(
                          alignment: isEnglishOnly(widget.title)
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: AutoSizeText(
                            "${widget.index + 1} - ${widget.title}",
                            style: kTextStyle.copyWith(
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: Tween(
                        begin: 0.0,
                        end: 0.5,
                      ).animate(_controller),
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_left,
                        color: AppColor.golden,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.image != null) ...[
                8.verticalSpace,
                Image.memory(
                  widget.image!,
                  fit: BoxFit.cover,
                  // height: 200,
                  width: double.infinity,
                ),
                8.verticalSpace,
              ],
              AnimatedSize(
                duration: const Duration(milliseconds: 150),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: isExpanded ? 8.h : 0),
                  child: isExpanded ? widget.child : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
