import 'package:dip_menu/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../../core/config/app_textstyle.dart';

class SearchTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final Function? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  TextInputAction? textInputAction;
  final void Function()? onEditingCompleted;
  final void Function(String)? onChanged;
  SearchTextFromField({
    required this.controller,
    this.obscureText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.textInputAction,
    this.onEditingCompleted,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      cursorColor: mainColor,
      keyboardType: TextInputType.text,
      validator: (value) => validator!(value),
      style:  context.theme.textTheme.headlineSmall,
      textInputAction: textInputAction,
      onEditingComplete: onEditingCompleted,
      onChanged:onChanged ,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(25.0, 1.0, 10.0, 1.0),
        fillColor:Theme.of(context).cardColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle:  context.theme.textTheme.headlineMedium!.copyWith(
            color: hintColor,
            fontWeight: FontWeight.w500),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}