/* import 'package:dopamin/core/utils/text_style.dart';
import 'package:pre_x/core/global/global_controller.dart';
import 'package:pre_x/core/utils/text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String title;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.title,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Icon(
            Icons.arrow_drop_down,
            color: AppColor.textGrey,
          ),
          items: widget.items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: kTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: Get.find<GlobalController>().selectedCity,
          onChanged: (newValue) {
            setState(() {
              Get.find<GlobalController>().selectedCity = newValue!;
            });
            widget.onChanged(newValue);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.borderTextField,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            elevation: 0,
          ),
          iconStyleData: IconStyleData(
            icon: Text(
              widget.title,
              style: kTextStyle.copyWith(color: AppColor.textGrey),
              overflow: TextOverflow.ellipsis,
            ),
            iconSize: 14,
            iconEnabledColor: AppColor.textGrey,
            iconDisabledColor: AppColor.textGrey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 1.sw / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: AppColor.kGrayColor,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(5),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          /*  menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ), */
        ),
      ),
    );
  }
}
 
 ///////////impl 
 ////
 /* CustomDropdownButton(
                                    items: controller.citiesList.map((e) {
                                      return e.name;
                                    }).toList(),
                                    onChanged: (value) {
                                      signUpController.cityId.text = controller
                                          .citiesList
                                          .where((element) =>
                                              element.name ==
                                              controller.selectedCity)
                                          .first
                                          .id
                                          .toString();
                                    },
                                    title: "select city"), */ */