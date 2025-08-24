import 'package:dip_menu/presentation/logic/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        child: TextWithFont().textWithPoppinsFont(
          color: mainColor,
          fontSize:getDeviceType() == 'phone' ?  12.sp:17,
          text: 'Forgot Password?'.tr,
          fontWeight: FontWeight.w300,
        ),
        onPressed: () {
          controller.fromKey.currentState?.reset();
          controller.emailController.clear();
          controller.passwordController.clear();
           Get.toNamed(Routes.forgotPasswordScreen);
        },
      ),
    );
  }
  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}