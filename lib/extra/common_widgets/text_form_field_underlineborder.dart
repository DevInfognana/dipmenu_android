import 'package:dip_menu/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';

class TextFormFieldUnderlineBorder extends StatelessWidget {
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

  TextFormFieldUnderlineBorder({
    required this.controller,
    this.obscureText,
    required this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    required this.labelText,
    this.textInputAction,
    this.readOnly,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      cursorColor: mainColor,
      readOnly:readOnly! ,
      keyboardType: keyboardType,
      validator: (value) => validator(value),
      style: TextStore.textTheme.displaySmall?.copyWith(color: Colors.black),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
        fillColor: Theme.of(context).cardColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyle(
            color: descriptionColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
        filled: true,
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: authTextFromFieldErrorBorderColor.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
