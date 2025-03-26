import 'package:dopamin/core/utils/app_color.dart';
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    this.onChanged,
    this.textEditingController,
    this.autofillHints,
    this.textInputType,
    this.autoFocus = false,
    this.obscureText = false,
    this.textInputAction,
    this.focusNode,
    this.prefixIconData,
    this.suffixIcon,
    this.hintText,
    this.readOnly = false,
    this.labelText,
    this.errorText,
    this.helperText,
    this.showLabelAboveTextField = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.fillColor,
    this.accentColor,
    this.textColor = Colors.black,
    this.borderRadius = 6,
    this.validator,
    this.showError = true,
    this.verticalPadding = 18,
    this.horizontalPadding = 12,
    this.onTap,
    Key? key,
    this.maxLines,
    this.minLines,
  }) : super(key: key);
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final Iterable<String>? autofillHints;
  final TextInputType? textInputType;
  final bool autoFocus;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefixIconData;
  final String? suffixIcon;

  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool readOnly;
  final VoidCallback? onTap;

  /// Text placed below the text field
  final String? helperText;
  final bool showLabelAboveTextField;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? fillColor;
  final Color? accentColor;
  final Color textColor;
  final double borderRadius;
  String? Function(String?)? validator;
  final bool showError;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  State<CustomTextField> createState() => _LoginScreentate();
}

class _LoginScreentate extends State<CustomTextField> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  late bool hasFocus;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    hasFocus = false;
    textEditingController =
        widget.textEditingController ?? TextEditingController();

    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder buildFocusedBorder() {
      return OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.newGolden, width: 1.25),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    }

    OutlineInputBorder buildEnabledBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(
          color: AppColor.golden,
        ),
      );
    }

    TextStyle? buildLabelStyle() {
      if (hasFocus) {
        return kTextStyle.copyWith(color: AppColor.newGolden, fontSize: 12.sp);
      } else {
        return kTextStyle.copyWith(color: AppColor.hintText, fontSize: 12.sp);
      }
    }

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor:
            widget.accentColor?.withOpacity(.33) ?? AppColor.newGolden,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null && widget.showLabelAboveTextField) ...[
            Text(widget.labelText!,
                style: kTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: hasFocus ? AppColor.newGolden : Colors.grey[700],
                )),
            const SizedBox(height: 6),
          ],
          TextFormField(
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            validator: widget.validator,
            focusNode: focusNode,
            controller: textEditingController,
            autofillHints: widget.autofillHints,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,

            /* (val) {
               setState(() {
                hasError = false;
                hasConfirmation = isValid;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              } */
            // },
            style:
                kTextStyle.copyWith(color: widget.textColor, fontSize: 15.sp),
            cursorColor: widget.textColor,
            obscureText: isVisible && widget.obscureText,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              errorStyle:
                  kTextStyle.copyWith(fontSize: 12.sp, color: AppColor.darkred),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              isDense: true,
              hintText: widget.hintText,
              hintStyle:
                  kTextStyle.copyWith(color: widget.textColor.withOpacity(.45)),
              labelText:
                  widget.showLabelAboveTextField ? null : widget.labelText,
              labelStyle: buildLabelStyle(),
              floatingLabelBehavior: widget.floatingLabelBehavior,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              focusedBorder: buildFocusedBorder(),
              enabledBorder: buildEnabledBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              prefixIcon: widget.prefixIconData != null
                  ? Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 12, end: 12),
                      child: widget.prefixIconData,
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 12, end: 12),
                    child: widget.obscureText == true
                        ? SvgPicture.asset(
                            widget.suffixIcon!,
                            color: isVisible == false
                                ? AppColor.newGolden
                                : AppColor.textGrey,
                          )
                        : const SizedBox()),
              ),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
            ),
          ),
          if (widget.helperText != null) ...[
            SizedBox(height: 6.w),
            Text(
              widget.helperText!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ]
        ],
      ),
    );
  }
}
