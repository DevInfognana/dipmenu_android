import 'package:dip_menu/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final Function? validator;
  TextInputAction? textInputAction;
  bool? readOnly = false;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  TextStyle? labelStyle;
   String? labelText;

  AuthTextFromField(
      {required this.controller,
      this.obscureText,
      this.validator,
      this.textInputAction,
      this.readOnly,
      this.keyboardType,
      this.inputFormatters,
      this.labelStyle,
        this.labelText,
      Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      cursorColor: mainColor,
      validator: (value) => validator!(value),
      style:  context.theme.textTheme.headlineSmall,
      readOnly: readOnly!,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
        fillColor: Theme.of(Get.context!).scaffoldBackgroundColor ,
        labelText: labelText,
        labelStyle: labelStyle,
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
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/*     AuthTextFromField2(
                                    readOnly: false,
                                    controller:
                                        giftCardController.amountController,
                                    obscureText: false,
                                    inputFormatters: <TextInputFormatter>[
                                      //FilteringTextInputFormatter.digitsOnly,
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"),
                                      ),
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    validator: (value) {
                                      if (value.toString().trim().isEmpty) {
                                        return NameValues.pleaseEnterAmount.tr;
                                      } else if (double.parse(value)
                                          .isLowerThan(0.9)) {
                                        return NameValues
                                            .pleaseEnterValidAmount.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    labelText: NameValues.amount,
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                  ),*/
