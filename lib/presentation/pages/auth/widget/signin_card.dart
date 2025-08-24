import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../extra/common_widgets/text_form_field_2.dart';
import '../../../logic/controller/authentication_controller.dart';
import 'forgot_password.dart';
import 'no_have_account.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                Get.offNamed(Routes.mainScreen);
                return false; // Prevent default back button behavior
              },
              child: Column(
                children: [
                  SizedBox(
                    width: 85.w,
                    height: 70.h,
                    child: Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Form(
                        key: controller.fromKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            Text(NameValues.singIn.tr,
                                textAlign: TextAlign.center,
                                style:  context
                                    .theme.textTheme.displaySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.bold)
                            ),
                            Text(NameValues.singInWithYourEmail.tr,
                                textAlign: TextAlign.center,
                                style:  context
                                    .theme.textTheme.displaySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.w300)
                            ),
                            SizedBox(height: 4.h),
                            Semantics(
                              textField: true,
                              label: 'EmailTextField',
                              child: AuthTextFromField2(
                                readOnly: false,
                                controller: controller.emailController,
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
                                //suffixIcon: const Text(""),
                                labelText: NameValues.email,
                                values: 0,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            GetBuilder<AuthController>(
                              builder: (_) {
                                return Semantics(
                                  textField: true,
                                  label: 'PasswordTextField',
                                  child: AuthTextFromField2(
                                    readOnly: false,
                                    controller: controller.passwordController,
                                    obscureText: controller.isSignInVisibilty
                                        ? true
                                        : false,
                                    validator: (value) {
                                      if (value.toString().trim().isEmpty) {
                                        return NameValues
                                            .pleaseEnterPassword.tr;
                                      } else if (!RegExp(
                                              ValidationRegex.passwordRegex)
                                          .hasMatch(value)) {
                                        return NameValues
                                            .pleaseWrongPassword.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    labelText: NameValues.password.tr,
                                    values: 0,
                                    textInputAction: TextInputAction.done,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        controller.signInVisibilty();
                                      },
                                      child: controller.isSignInVisibilty
                                          ?  Icon(
                                              Icons.visibility_outlined,
                                              color: Get.isDarkMode?Colors.white:Colors.black)
                                          :  Icon(
                                              Icons.visibility_off_outlined,
                                              color: Get.isDarkMode?Colors.white:Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 5.h),
                            GetBuilder<AuthController>(builder: (controller) {
                              return controller.status.isLoading
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                          color: mainColor),
                                    )
                                  : AuthButton(
                                      text: NameValues.login.tr,
                                      press: () {
                                        if (controller.fromKey.currentState!
                                            .validate()) {
                                          String email = controller
                                              .emailController.text
                                              .trim();
                                          String password = controller
                                              .passwordController.text
                                              .trim();
                                          controller.login(
                                              email: email, password: password);
                                        }
                                        // else{
                                        //   showSnackBar('Please fill all details');
                                        // }
                                      },
                                    );
                            }),
                            ForgotPassword(),
                            const Spacer(),
                            GestureDetector(
                              child: const ContinueAsGuest(),
                              onTap: () {
                                controller.guestLogin();
                              },
                            ),
                            NoAccountText(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

/*class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Content View'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'This is the Content View',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
