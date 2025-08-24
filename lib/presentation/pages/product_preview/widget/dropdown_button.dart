import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controller/product_preview_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

// ignore: must_be_immutable
class DropdownMethod extends StatefulWidget {
  DropdownMethod({Key? key, this.controller, required this.onViewbuttonpressed})
      : super(key: key);

  ProductPreviewController? controller;
  void Function(dynamic) onViewbuttonpressed;

  @override
  State<DropdownMethod> createState() => _DropdownMethodState();
}

class _DropdownMethodState extends State<DropdownMethod> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextScaleFactorClamper(
        // child: DropdownButtonHideUnderline(
        //   child: DropdownButton2(
        //     isExpanded: true,
        //     hint: Row(
        //       children: [
        //         Expanded(
        //           child: Text(NameValues.selectSize,
        //               style: TextStore.textTheme.titleLarge
        //                   ?.copyWith(color: titleColor)),
        //         ),
        //       ],
        //     ),
        //     items: widget.controller?.itemSize
        //         .map((item) => DropdownMenuItem<String>(
        //               value: item.code,
        //               child: TextScaleFactorClamper(
        //                 child: Text(item.description!.trim(),
        //                     style: TextStore.textTheme.titleLarge
        //                         ?.copyWith(color: titleColor)),
        //               ),
        //             ))
        //         .toList(),
        //     value: widget.controller?.selectedValue,
        //     onChanged: (value) {
        //       setState(() {
        //         widget.onViewbuttonpressed(value);
        //       });
        //     },
        //     icon: const Icon(Icons.expand_more),
        //     iconSize: 15.sp,
        //     iconEnabledColor: titleColor,
        //     iconDisabledColor: Colors.grey,
        //     buttonHeight: 5.h,
        //     //50,
        //     buttonWidth: 40.w,
        //     //160,
        //     buttonPadding: EdgeInsets.only(left: 2.w, right: 2.w),
        //     //(left: 14, right: 14),
        //     buttonDecoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         color: Colors.black26,
        //       ),
        //       color: Colors.white,
        //     ),
        //     buttonElevation: 2,
        //     itemHeight: 4.h,
        //     //40,
        //     // itemPadding: const EdgeInsets.only(left: 14, right: 14),
        //     dropdownMaxHeight: widget.controller?.itemSize.length.isLowerThan(5) ==true? 20.h:40.h,
        //     dropdownWidth: 40.w,
        //     //150,
        //     dropdownPadding: null,
        //     dropdownDecoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.white,
        //     ),
        //     dropdownElevation: 8,
        //     scrollbarRadius: const Radius.circular(10),
        //     scrollbarThickness: 6,
        //     scrollbarAlwaysShow: true,
        //     offset: const Offset(0, 0),
        //   ),
        // ),

        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(NameValues.selectSize,
                      style: TextStore.textTheme.titleLarge
                          ?.copyWith(color: titleColor)),
                ),
              ],
            ),
            items: widget.controller?.itemSize
                .map((item) => DropdownMenuItem<String>(
              value: item.code,
              child: TextScaleFactorClamper(
                child: Text(item.description!.trim(),
                    style: TextStore.textTheme.titleLarge
                        ?.copyWith(color: titleColor)),
              ),
            ))
                .toList(),
            value: widget.controller?.selectedValue,
            onChanged: (value) {
              setState(() {
                widget.onViewbuttonpressed(value);
              });
            },
            buttonStyleData: ButtonStyleData( // Changed from individual button parameters
              height: 5.h,
              width: 40.w,
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.white,
              ),
              elevation: 2,
            ),
            iconStyleData: IconStyleData( // Changed from individual icon parameters
              icon: Icon(Icons.expand_more),
              iconSize: 15.sp,
              iconEnabledColor: titleColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: widget.controller?.itemSize.length.isLowerThan(5) == true ? 20.h : 40.h,
              width: 40.w,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              elevation: 8,
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: WidgetStateProperty.all(Colors.black26), // Changed from MaterialStateProperty
                radius: const Radius.circular(10),
                thickness: WidgetStateProperty.all(6), // Changed from MaterialStateProperty
                thumbVisibility: WidgetStateProperty.all(true), // Changed from MaterialStateProperty
              ),
            ),
            menuItemStyleData: MenuItemStyleData( // Changed from itemHeight
              height: 4.h,
            ),
          ),
        ),

      ),
    );
  }
}
