
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/authentication_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class NoAccountText extends StatelessWidget {
  NoAccountText({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWithFont().textWithPoppinsFont(
              fontSize:getDeviceType() == 'phone' ? 12.sp:17,
              fontWeight: FontWeight.w300,
              text: 'Don\'t have an account ? '.tr,
              color: hintColor),
          InkWell(
            onTap: () {
              controller.fromKey.currentState?.reset();
              controller.emailController.clear();
              controller.passwordController.clear();
              Get.toNamed(Routes.signUpScreen);
            },
            child: TextWithFont().textWithPoppinsFont(
                fontSize:getDeviceType() == 'phone' ?  12.sp:17,
                fontWeight: FontWeight.w300,
                text: NameValues.singUP.tr,
                color: mainColor),
          ),
        ],
      ),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

}


class ContinueAsGuest extends StatelessWidget {
  const ContinueAsGuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextScaleFactorClamper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Continue As Guest',
          style:  context
              .theme.textTheme.displaySmall
              ?.copyWith(
              fontWeight: FontWeight.bold)
            // style:  Theme.of(context).textTheme.headlineSmall?.copyWith(
            //   fontWeight: FontWeight.bold,color: Colors.black)

          )
        ],
      ),
    );
  }
}

