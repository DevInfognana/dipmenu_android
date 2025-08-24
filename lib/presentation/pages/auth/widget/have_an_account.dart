import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class HaveAccountText extends StatelessWidget {
  const HaveAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWithFont().textWithPoppinsFont(
            fontSize: getDeviceType() == 'phone' ? 12.sp : 17,
            fontWeight: FontWeight.w300,
            text: 'Have an account ? '.tr,
            color: hintColor),
        InkWell(
            onTap: () {
              Get.back();
            },
            child: TextWithFont().textWithPoppinsFont(
                fontSize: getDeviceType() == 'phone' ? 12.sp : 17,
                fontWeight: FontWeight.w300,
                text: NameValues.singIn.tr,
                color: mainColor))
      ],
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}
