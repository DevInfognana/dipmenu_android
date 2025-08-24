import 'package:dip_menu/extra/common_widgets/text_form_field_2.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';
import '../../core/config/theme.dart';
import '../../core/static/stactic_values.dart';
import '../../presentation/logic/controller/authentication_controller.dart';
import '../../presentation/routes/routes.dart';

class FavLoginPopUp {
  final controller = Get.put(AuthController());

  showFavLoginAlertDialog(BuildContext context,
      {required TextEditingController userNameController,
      required TextEditingController passWordController,
      void Function()? onButtonTapped}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w)),
            content: SizedBox(
              width: 90.w,
              height: 40.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(0.01.h),
                  child: TextScaleFactorClamper(
                    child: Form(
                      key: controller.fromKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          Text(NameValues.singIn.tr,
                              textAlign: TextAlign.center,
                              style: TextStore.textTheme.displayMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 1.5.h),
                          AuthTextFromField2(
                              readOnly: false,
                              controller: userNameController,
                              obscureText: false,
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return NameValues.pleaseEnterEmail.tr;
                                } else if (!RegExp(
                                        ValidationRegex.validationEmail)
                                    .hasMatch(value)) {
                                  return NameValues.pleaseEnterValidEmail.tr;
                                } else {
                                  return null;
                                }
                              },
                              labelText: NameValues.email,
                              values: 1,
                              textInputAction: TextInputAction.next),
                          SizedBox(height: 1.5.h),
                          GetBuilder<AuthController>(
                            builder: (_) {
                              return AuthTextFromField2(
                                readOnly: false,
                                controller: passWordController,
                                obscureText:
                                    controller.isVisibilty ? true : false,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterPassword.tr;
                                  } else if (!RegExp(
                                      ValidationRegex.passwordRegex)
                                      .hasMatch(value)) {
                                    return NameValues.pleaseEnterValidPassword.tr;
                                  } else {
                                    return null;
                                  }
                                  // if (value.toString().trim().isEmpty ||
                                  //     value.toString().length < 6) {
                                  //   return 'Password should be 6 characters'.tr;
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                labelText: NameValues.password.tr,
                                values: 1,
                                textInputAction: TextInputAction.done,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      controller.visibility();
                                    },
                                    child: controller.isVisibilty
                                        ? const Icon(Icons.visibility_outlined,
                                            color: Colors.black)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.black)),
                              );
                            },
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWithFont().textWithPoppinsFont(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                  text: 'Create account? '.tr,
                                  color: hintColor),
                              InkWell(
                                  onTap: () {
                                    controller.fromKey.currentState?.reset();
                                    userNameController.clear();
                                    passWordController.clear();
                                    Get.toNamed(Routes.signUpScreen);
                                  },
                                  child: TextWithFont().textWithPoppinsFont(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w300,
                                      text: NameValues.singUP.tr,
                                      color: mainColor)),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  child: const Text('Back',style: TextStyle(color: Colors.white),)),
                              SizedBox(width: 3.w),
                              ElevatedButton(
                                  onPressed: () {
                                    if (controller.fromKey.currentState!
                                        .validate()) {
                                      onButtonTapped!();
                                      Get.back();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor),
                                  child: const Text('Login',style: TextStyle(color: Colors.white),))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
