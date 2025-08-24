import 'package:dip_menu/presentation/pages/auth/widget/signin_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controller/authentication_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: TextScaleFactorClamper(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      height: 12.h,
                      width: 75.w,
                      child: Image.asset(
                        ImageAsset.backgroundCurve,
                        color: mainColor,
                        fit: BoxFit.fill,
                      ))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 55.h,
                    width: double.infinity,
                    child: Image.asset(ImageAsset.backgroundImage,
                        color: mainColor, fit: BoxFit.fill),
                  )),
              Positioned(
                left: 7.w,
                top: 13.h,
                right: 7.w,
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.all(Radius.circular(3.h)),
                  child: Container(
                    width: 85.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(3.h))),
                    child: LoginScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
