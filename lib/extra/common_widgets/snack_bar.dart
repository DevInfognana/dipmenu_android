import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController showSnackBar(String? values) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: TextScaleFactorClamper(child: Text(values!)),
      // message: Text(values!),
      // icon: const Icon(Icons.close,color: Colors.red),
      isDismissible: true,
      borderRadius: 8.0,
      backgroundColor: Colors.black38,
      snackPosition: SnackPosition.TOP,
      maxWidth: 300.0,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(seconds:1 ),
    ),
  );
}

SnackbarController posMessageSnackBar(String? values) {
  return Get.showSnackbar(
    GetSnackBar(
      //title: title,
      message: values!,
      icon: const Icon(Icons.close, color: Colors.red),
      isDismissible: true,
      borderRadius: 8.0,
      backgroundColor: Colors.black38,
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: 340.0,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(days: 1),
    ),
  );
}

SnackbarController didNotCartSnackBar(String? values) {
  return Get.showSnackbar(
    GetSnackBar(
      message: values!,
      icon: const Icon(Icons.close, color: Colors.red),
      isDismissible: true,
      borderRadius: 8.0,
      backgroundColor: Colors.black38,
      snackPosition: SnackPosition.TOP,
      maxWidth: 300.0,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(seconds: 3),
    ),
  );
}

SnackbarController maxminumchoose(String? values) {
  return Get.showSnackbar(
    GetSnackBar(
      message: values!,
      isDismissible: true,
      borderRadius: 8.0,
      backgroundColor: Colors.black38,
      snackPosition: SnackPosition.TOP,
      maxWidth: 300.0,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(milliseconds: 100),
    ),
  );
}


SnackbarController errorSnackBar(String? values) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: TextScaleFactorClamper(child: Text(values!)),
      // message: Text(values!),
      // icon: const Icon(Icons.close,color: Colors.red),
      isDismissible: true,
      borderRadius: 8.0,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
      maxWidth: 300.0,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(seconds:5 ),
    ),
  );
}
