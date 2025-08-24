import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../logic/controller/rewards_customize_edit_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

// ignore: must_be_immutable
class RewardDropdown extends StatefulWidget {
  RewardDropdown({Key? key,this.controller,required this.onViewbuttonpressed}) : super(key: key);


  RewardsCustomizeEditController? controller;
  void Function(dynamic) onViewbuttonpressed;

  @override
  State<RewardDropdown> createState() => _RewardDropdownState();
}

class _RewardDropdownState extends State<RewardDropdown> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
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
            // onTap: (){
                    //   widget.controller?.productSize=item.id!;
                    //   widget.controller?.defaultPrice=double.parse(
                    //       itemPointsId(item.id!, widget.controller?.priceRange));
                    //   widget.controller?.totalPrice=double.parse(
                    //       itemPointsId(item.id!, widget.controller?.priceRange));
                    //   widget.controller!.update();
                    // },
                    child: TextScaleFactorClamper(
              child: Text( item.description!,
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
          // icon: const Icon(
          //   Icons.expand_more,
          // ),
          // iconSize: 15.sp,  //30,
          // iconEnabledColor: titleColor,
          // iconDisabledColor: Colors.grey,
          // buttonHeight: 5.h,
          // buttonWidth: 40.w,    //160
          // buttonPadding: EdgeInsets.only(left: 2.w, right: 2.w),
          // buttonDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   border: Border.all(
          //     color: Colors.black26,
          //   ),
          //   color: Colors.white,
          // ),
          // buttonElevation: 2,
          // itemHeight: 4.h,  //40,
          // // itemPadding: const EdgeInsets.only(left: 14, right: 14),
          // dropdownMaxHeight:widget.controller?.itemSize.length.isLowerThan(5) ==true? 20.h:40.h,    //200,
          // dropdownWidth: 40.w,    //150,
          // dropdownPadding: null,
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.white,
          // ),
          // dropdownElevation: 8,
          // scrollbarRadius: const Radius.circular(10),
          // scrollbarThickness: 6,
          // scrollbarAlwaysShow: true,
          // offset: const Offset(0, 0),

          // instead of the above commented deprecated code
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
    );
  }
}