import 'package:dip_menu/extra/common_widgets/text_form_field_2.dart';
import 'package:dip_menu/presentation/logic/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.7.h),
          child: AppBar(
            leading: AuthBackButton(
              press: () {
                Get.back(); //Get.offAllNamed(Routes.mainScreen, arguments: 0);
              },
            ),
          ),
        ),
        backgroundColor:   Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: TextScaleFactorClamper(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      height: 12.h,
                      width: 75.w,
                      child: Image.asset(ImageAsset.backgroundCurve,
                          color: mainColor, fit: BoxFit.fill))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      height: 55.h,
                      width: double.infinity,
                      child: Image.asset(ImageAsset.backgroundImage,
                          color: mainColor, fit: BoxFit.fill))),
              Positioned(
                left: 7.w,
                top: 10.h,
                right: 7.w,
                child: Material(
                  elevation: 15,
                  child: Container(
                      width: 85.w,
                      height: 65.h,
                      color:  Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Icon(Icons.lock,
                                  color: mainColor, //Colors.orange,
                                  size: 60)),
                          SizedBox(height: 1.h),
                          controller.argumentData.toString().isNotEmpty
                              ? Text(NameValues.changePassword.tr,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.displaySmall!
                                      .copyWith(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold))
                              : Text(NameValues.forgotPassword.tr,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.displaySmall!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                          // controller.argumentData.toString().isNotEmpty
                          //     ? Text(NameValues.changePasswordSubtitle.tr,
                          //         textAlign: TextAlign.center,
                          //         style: TextStore.textTheme.headlineSmall!
                          //             .copyWith(
                          //                 color: descriptionColor,
                          //                 fontWeight: FontWeight.w300))
                          //     : const SizedBox(),
                          SizedBox(
                            width: 85.w,
                            height: 35.h,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Form(
                                  key: controller.changepasswordKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 2.h),
                                      GetBuilder<AuthController>(
                                        builder: (_) {
                                          return AuthTextFromField2(
                                            readOnly: false,
                                            controller: passwordController,
                                            obscureText: controller.isVisibilty
                                                ? true
                                                : false,
                                            validator: (value) {
                                              if (value
                                                      .toString()
                                                      .trim()
                                                      .isEmpty ||
                                                  value.toString().length < 6) {
                                                return NameValues
                                                    .pleaseEnterPassword.tr;
                                              } else if (!RegExp(ValidationRegex
                                                      .passwordRegex)
                                                  .hasMatch(value)) {
                                                return NameValues
                                                    .pleaseWrongPassword.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                            labelText: NameValues.password.tr,
                                            values: 0,
                                            textInputAction:
                                                TextInputAction.next,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                controller.visibility();
                                              },
                                              icon: controller.isVisibilty
                                                  ? const Icon(
                                                      Icons.visibility_outlined,
                                                      color: Colors.black)
                                                  : const Icon(
                                                      Icons
                                                          .visibility_off_outlined,
                                                      color: Colors.black),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 2.h),
                                      GetBuilder<AuthController>(
                                        builder: (_) {
                                          return AuthTextFromField2(
                                            readOnly: false,
                                            controller:
                                                confirmpasswordController,
                                            obscureText:
                                                controller.isConfirmVisibilty
                                                    ? true
                                                    : false,
                                            validator: (value) {
                                              if (value
                                                      .toString()
                                                      .trim()
                                                      .isEmpty ||
                                                  value.toString().length < 6) {
                                                return NameValues
                                                    .pleaseEnterConfirmPassword
                                                    .tr;
                                              } else if (!RegExp(ValidationRegex
                                                      .passwordRegex)
                                                  .hasMatch(value)) {
                                                return NameValues
                                                    .pleaseWrongPassword.tr;
                                              } else if (value !=
                                                  passwordController.text) {
                                                return NameValues.passwordNotMatch;
                                              } else {
                                                return null;
                                              }
                                            },
                                            labelText:
                                                NameValues.confirmPassword.tr,
                                            values: 0,
                                            textInputAction:
                                                TextInputAction.done,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                controller.confirmVisibility();
                                              },
                                              icon: controller
                                                      .isConfirmVisibilty
                                                  ? const Icon(
                                                      Icons.visibility_outlined,
                                                      color: Colors
                                                          .black //authTextFromFieldHintTextColor
                                                      )
                                                  : const Icon(
                                                      Icons
                                                          .visibility_off_outlined,
                                                      color: Colors.black),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 2.h),
                                      AuthButton(
                                        text: NameValues.update.tr,
                                        press: () {
                                          if (controller
                                              .changepasswordKey.currentState!
                                              .validate()) {
                                            String confirmpassword =
                                                confirmpasswordController.text
                                                    .trim();
                                            String password =
                                                passwordController.text.trim();
                                            controller.changePassword(
                                                oldpassword: password,
                                                newpassword: confirmpassword);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
