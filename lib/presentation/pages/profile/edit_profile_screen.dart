import 'dart:convert';
import 'package:dip_menu/presentation/pages/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../logic/controller/edit_profile_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();

  // TextEditingController locationController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final profileController = Get.find<EditProfileController>();
  String? profileImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = profileController.argumentData.email!;
    // locationController.text = profileController.argumentData.location!;
    firstNameController.text = profileController.argumentData.firstName!;
    lastNameController.text = profileController.argumentData.lastName!;
    mobileController.text = profileController.argumentData.mobile!;
    profileImageUrl = profileController.argumentData.profileImageurl ??
        'https://m.media-amazon.com/images/I/41ONa5HOwfL.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: AppBar(
              leading: AuthBackButton(
                press: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: TextScaleFactorClamper(
                  child: AuthTitleText(text: NameValues.completeYourProfile)))),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: TextScaleFactorClamper(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: Form(
                key: profileController.singUpKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Center(
                        child: ProfilePictureUpdate(
                            controller: profileController,
                            imageUrl: profileImageUrl)),
                    AuthTextFromField(
                        controller: firstNameController,
                        labelStyle: context.theme.textTheme.headlineMedium!
                            .copyWith(
                            color: hintColor,
                            fontWeight: FontWeight.w500),
                        readOnly: false,
                        obscureText: false,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues.pleaseEnterFirstName.tr;
                          } else if (!ValidationRegex.validCharacters
                              .hasMatch(value)) {
                            return NameValues
                                .pleaseEnterValidFirstName.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.firstName.tr,
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 1.5.h),
                    AuthTextFromField(
                        controller: lastNameController,
                        readOnly: false,
                        labelStyle: context.theme.textTheme.headlineMedium!
                            .copyWith(
                            color: hintColor,
                            fontWeight: FontWeight.w500),
                        obscureText: false,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues.pleaseEnterLastName.tr;
                          } else if (!ValidationRegex.validCharacters
                              .hasMatch(value)) {
                            return NameValues
                                .pleaseEnterValidLastName.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.lastName.tr,
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 1.5.h),
                    AuthTextFromField(
                        controller: mobileController,
                        readOnly: false,
                        labelStyle: context.theme.textTheme.headlineMedium!
                            .copyWith(
                            color: hintColor,
                            fontWeight: FontWeight.w500),
                        obscureText: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(14),
                        ],
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return NameValues
                                .pleaseEnterMobileNumber.tr;
                          } else if (!RegExp(
                              ValidationRegex.mobilePattern)
                              .hasMatch(value)) {
                            return NameValues
                                .pleaseEnterValidMobileNumber.tr;
                          } else {
                            return null;
                          }
                        },
                        keyboardType:
                        const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        labelText: NameValues.mobileNumber.tr,
                        textInputAction: TextInputAction.done),
                    SizedBox(height: 1.5.h),
                    AuthTextFromField(
                        controller: emailController,
                        readOnly: true,
                        labelStyle: context.theme.textTheme.headlineMedium!
                            .copyWith(
                            color: hintColor,
                            fontWeight: FontWeight.w500),
                        obscureText: false,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(ValidationRegex.validationEmail)
                                  .hasMatch(value)) {
                            return NameValues.pleaseEnterEmail.tr;
                          } else {
                            return null;
                          }
                        },
                        labelText: NameValues.email.tr,
                        keyboardType:
                        const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        textInputAction: TextInputAction.next),
                    SizedBox(height: 4.h),
                    AuthButton(
                      text: NameValues.updateProfile.tr,
                      press: () async {
                        if (profileController.singUpKey.currentState!
                            .validate()) {
                          List<int> imageBytes = await profileController
                              .imageFile
                              ?.readAsBytes() ??
                              <int>[];
                          String base64Image = base64Encode(imageBytes);
                          profileController.editProfile(
                              email: emailController.text.trim(),
                              fnName: firstNameController.text.trim(),
                              lsName: lastNameController.text.trim(),
                              // location: locationController.text.trim(),
                              mobileNo: mobileController.text.trim(),
                              imageUrl: base64Image.toString().isEmpty
                                  ? profileImageUrl!
                                  : base64Image,
                              imageName:
                              profileController.fileNamevalue !=
                                  null
                                  ? profileController.fileNamevalue!
                                  : '',
                              imageUpload:
                              base64Image.toString().isEmpty
                                  ? false
                                  : profileController.imageupload!);
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                  ],
                )),
          ),
        ),
      )
    );
  }
}
