import 'package:dip_menu/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthTextFromField2 extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final Function validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  TextInputAction? textInputAction;
  bool? readOnly = false;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  int?  values=0;

  AuthTextFromField2({
    required this.controller,
    this.obscureText,
    required this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    required this.labelText,
    this.textInputAction,
    this.readOnly,this.values,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
      autofocus: false,
      controller: controller,
      obscureText: obscureText!,
      cursorColor: mainColor,
      // cursorHeight: 20, //you can play with the number to get the result you want
      readOnly: readOnly!,
      keyboardType: keyboardType,
      validator: (value) => validator(value),
      style: values==0? context.theme.textTheme.headlineSmall:context.theme.textTheme.headlineSmall!.copyWith(color: Colors.black),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
        fillColor:values==0? Theme.of(Get.context!).scaffoldBackgroundColor :Colors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        errorMaxLines: 4,
        labelStyle: context
            .theme.textTheme.headlineMedium!
            .copyWith(
            color: hintColor,
            fontWeight: FontWeight.w500),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:Get.isDarkMode? descriptionColor:borderColor),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: authTextFromFieldErrorBorderColor.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:Get.isDarkMode? descriptionColor:borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
