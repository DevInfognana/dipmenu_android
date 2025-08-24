import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';
import '../../core/config/theme.dart';


floatingIcon({String? values, void Function()? onButtonTapped,String? devicetype}) {
  return Padding(
    padding:  EdgeInsets.only(top: 2.h),
    child: GestureDetector(
      onTap: (){
        onButtonTapped!();
      },
      child: Container(
        height: 8.h,
        width: 8.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            border: Border.all(color: Colors.white, width: 0.5.w),
            color: Colors.red),
        child: devicetype=='phone'?
        Stack(
            children: <Widget>[
        Align(
          alignment: Alignment.center,
            child: Icon(Icons.shopping_cart, color: Colors.white, size: 25.sp)),
              Positioned(
                right:5,
                top: 5,
                child: CircleAvatar(
                  radius: 3.w,
                  backgroundColor: Colors.white,
                  child: Text(
                    values!,
                    style: TextStore.textTheme.headlineSmall!
                        .copyWith(color: mainColor),
                  ),
                ),
              )

            ],
          ) :
        Stack(
            children: <Widget>[
        Align(
          alignment: Alignment.center,
            child: Icon(Icons.shopping_cart, color: Colors.white, size: 16.sp)),
              Positioned(
                right:3,
                top: 3,
                child: CircleAvatar(
                  radius: 2.4.w,
                  backgroundColor: Colors.white,
                  child: Text(
                    values!,
                    style: TextStore.textTheme.headlineSmall!
                        .copyWith(color: mainColor),
                  ),
                ),
              )

            ],
          ),
      ),
    ),
  );
}


