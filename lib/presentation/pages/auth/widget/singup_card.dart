import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../extra/common_widgets/text_form_field_2.dart';
import '../../../logic/controller/authentication_controller.dart';
import 'have_an_account.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final TextEditingController locationController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
      body: TextScaleFactorClamper(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: Form(
                key: controller.singUpKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Text(NameValues.singUP.tr,
                        textAlign: TextAlign.center,
                        style: context
                            .theme.textTheme.displaySmall
                            ?.copyWith(
                            fontWeight: FontWeight.bold)


                    ),
                    SizedBox(height: 3.h),
                    AuthTextFromField2(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        obscureText: false,
                        values: 0,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues.pleaseEnterFirstName.tr;
                          } else if (!ValidationRegex.validCharacters
                              .hasMatch(value)) {
                            return NameValues.pleaseEnterValidFirstName.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.firstName.tr,
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 2.h),
                    AuthTextFromField2(
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        values: 0,
                        obscureText: false,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues.pleaseEnterLastName.tr;
                          } else if (!ValidationRegex.validCharacters
                              .hasMatch(value)) {
                            return NameValues.pleaseEnterValidLastName.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.lastName.tr,
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 2.h),
                    AuthTextFromField2(
                      controller: mobileController,
                      readOnly: false,
                      values: 0,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(14),
                      ],
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return NameValues.pleaseEnterMobileNumber.tr;
                        } else if (!RegExp(ValidationRegex.mobilePattern)
                            .hasMatch(value)) {
                          return 'Please Enter valid Mobile Number'.tr;
                        } else {
                          return null;
                        }
                      },
                      labelText: NameValues.mobileNumber.tr,
                      textInputAction: TextInputAction.next,
                    ),
                    // AuthTextFromField2(
                    //     controller: locationController,
                    //     keyboardType: TextInputType.text,
                    //     readOnly: false,
                    //     obscureText: false,
                    //     validator: (value) {
                    //       if (value.toString().trim().isEmpty) {
                    //         return 'Enter Location'.tr;
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     labelText: NameValues.location.tr,
                    //     textInputAction: TextInputAction.next),
                    SizedBox(height: 2.h),
                    AuthTextFromField2(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: false,
                        values: 0,
                        obscureText: false,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues.pleaseEnterEmail.tr;
                          } else if (!RegExp(ValidationRegex.validationEmail)
                              .hasMatch(value)) {
                            return NameValues.pleaseEnterValidEmail.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.email.tr,
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 2.h),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return AuthTextFromField2(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          values: 0,
                          obscureText: controller.isVisibilty ? true : false,
                          readOnly: false,
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return NameValues.pleaseEnterPassword.tr;
                            } else if (!RegExp(ValidationRegex.passwordRegex)
                                .hasMatch(value)) {
                              return NameValues.pleaseWrongPassword.tr;
                            } else {
                              return null;
                            }
                          },
                          labelText: NameValues.password.tr,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.visibility();
                            },
                            icon: controller.isVisibilty
                                ?  Icon(
                                    Icons.visibility_outlined,
                              color: Get.isDarkMode?Colors.white:Colors.black,
                                    size: 24,
                                  )
                                :  Icon(
                                    Icons.visibility_off_outlined,
                              color: Get.isDarkMode?Colors.white:Colors.black,
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 2.h),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return AuthTextFromField2(
                          controller: confirmPasswordController,
                          readOnly: false,
                          values: 0,
                          keyboardType: TextInputType.text,
                          obscureText:
                              controller.isConfirmVisibilty ? true : false,
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return NameValues.pleaseEnterConfirmPassword.tr;
                            } else if (value != passwordController.text) {
                              return NameValues.passwordNotMatch.tr;
                            } else {
                              return null;
                            }
                          },
                          labelText: NameValues.confirmPassword.tr,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.confirmVisibility();
                            },
                            icon: controller.isConfirmVisibilty
                                ?  Icon(Icons.visibility_outlined,
                                                  color: Get.isDarkMode?Colors.white:Colors.black, size: 24)
                                :  Icon(Icons.visibility_off_outlined,
                              color: Get.isDarkMode?Colors.white:Colors.black),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5.h),

                    // GetBuilder<AuthController>(builder: (controller) {
                    //   return AuthButtonloading(
                    //     text: NameValues.singUP.tr,
                    //     isLoading: controller.status.isLoading,
                    //     press: () {
                    //       if (controller.singUpKey.currentState!.validate()) {
                    //         controller.SingUp(
                    //             email: emailController.text.trim(),
                    //             password: passwordController.text.trim(),
                    //             fnName: firstNameController.text.trim(),
                    //             lsName: lastNameController.text.trim(),
                    //             // location: locationController.text.trim(),
                    //             mobileNo: mobileController.text.trim());
                    //       } /* else {
                    //         showSnackBar('Please fill all details');
                    //       }*/
                    //     },
                    //   );
                    // }),

                    GetBuilder<AuthController>(builder: (controller) {
                      return controller.status.isLoading
                          ? Container(
                              alignment: Alignment.center,
                              child:
                                  CircularProgressIndicator(color: mainColor),
                            )
                          : AuthButton(
                              text: NameValues.singUP.tr,
                              press: () {
                                if (controller.singUpKey.currentState!
                                    .validate()) {
                                  controller.singUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      fnName: firstNameController.text.trim(),
                                      lsName: lastNameController.text.trim(),
                                      // location: locationController.text.trim(),
                                      mobileNo: mobileController.text.trim());
                                }
                              },
                            );
                    }),
                    SizedBox(height: 5.h),
                    const HaveAccountText(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
