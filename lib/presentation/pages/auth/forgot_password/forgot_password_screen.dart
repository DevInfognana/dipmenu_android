import 'package:dip_menu/presentation/logic/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final controller1 = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();

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
        resizeToAvoidBottomInset: false,
        // backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
        body: TextScaleFactorClamper(
          child: Stack(
            fit: StackFit.loose,
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
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 55.h,
                    width: double.infinity,
                    child: Image.asset(
                      ImageAsset.backgroundImage,
                      color: mainColor,
                      fit: BoxFit.fill,
                    ),
                    /*decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageAsset.backgroundImage),
                              fit: BoxFit.fill))*/
                  )),
              Positioned(
                left: 7.w,
                top: 10.h,
                right: 7.w,
                child: Material(
                  elevation: 15,
                  child: Container(
                      width: 85.w,
                      height: 60.h,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Icon(
                                  Icons.lock,
                                  color: mainColor,
                                  size: 70,
                                ),
                              ),
                            ],
                          ),
                          Text(NameValues.forgotPassword.tr,
                              textAlign: TextAlign.center,
                              style:  context
                                  .theme.textTheme.displayMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.bold),
                              // style: context.theme.textTheme.displayMedium!.copyWith(
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold)
                          ),
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: 85.w,
                                  height: 40.h,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.h),
                                    child: Form(
                                      key: controller1.forgotpasswordKey,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5.h),
                                          GetBuilder<AuthController>(
                                              builder: (_) {
                                            return Semantics(
                                              textField: true,
                                              label: 'EmailTextField',
                                              child: AuthTextFromField2(
                                                  readOnly: false,
                                                  controller: emailController,
                                                  obscureText: false,
                                                  values: 0,
                                                  validator: (value) {
                                                    if (value
                                                        .toString()
                                                        .trim()
                                                        .isEmpty) {
                                                      return NameValues
                                                          .pleaseEnterEmail.tr;
                                                    } else if (!RegExp(
                                                            ValidationRegex
                                                                .validationEmail)
                                                        .hasMatch(value)) {
                                                      return NameValues
                                                          .pleaseEnterValidEmail
                                                          .tr;
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  labelText:
                                                      NameValues.email.tr,
                                                  textInputAction:
                                                      TextInputAction.done),
                                            );
                                          }),
                                          SizedBox(height: 5.h),
                                          GetBuilder<AuthController>(
                                              builder: (controller) {
                                            return controller.status.isLoading
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: mainColor),
                                                  )
                                                : AuthButton(
                                                    text: NameValues.change.tr,
                                                    press: () {
                                                      if (controller
                                                          .forgotpasswordKey
                                                          .currentState!
                                                          .validate()) {
                                                        dynamic emailValues =
                                                            emailController.text
                                                                .trim();

                                                        controller
                                                            .forgotPassword(
                                                                email:
                                                                    emailValues);
                                                      }
                                                    },
                                                  );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
