import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/theme.dart';

class paymentTextFromField extends StatelessWidget {
  final TextEditingController controller;

  final Function? validator;

  final String? labelText;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChanged;
  bool obscureText = false;
  VoidCallback? onEditingComplete;
  final Widget? suffixIcon;

  paymentTextFromField({
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    required this.obscureText,
    this.labelText,
    this.onEditingComplete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: mainColor,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) => validator!(value),
      style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
        fillColor: Theme.of(context).cardColor,
        labelText: labelText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
            color: hintColor, fontSize: 13.sp, fontWeight: FontWeight.w500),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: authTextFromFieldErrorBorderColor.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

/*TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter()
                              ],
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
                                fillColor: Theme.of(context).cardColor,
                                hintText: 'MM/YY',
                                hintStyle: TextStyle(
                                    color: hintColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                    borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: authTextFromFieldErrorBorderColor
                                            .withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),*/
