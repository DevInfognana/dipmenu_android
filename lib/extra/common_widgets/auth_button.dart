import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';
// import '../../core/config/theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function? press;

  const AuthButton({required this.text, Key? key, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press as void Function()?,
      style: ElevatedButton.styleFrom(
        side: BorderSide.none,
        // elevation: 5,
        fixedSize: Size(90.w, DeviceTypeValues.getDeviceType()=="phone"?7.h:6.h),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
        ),
      ),
      child: TextWithFont().textWithPoppinsFont(
        color: Colors.white,
        fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 14.sp :20 , //14.sp,
        fontWeight: FontWeight.normal,
        text: text,
      ),
    );
  }
  // static String getDeviceType() {
  //   final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  //   return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  // }
}

