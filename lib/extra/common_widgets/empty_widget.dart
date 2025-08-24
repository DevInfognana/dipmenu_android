import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';
import '../../core/config/icon_config.dart';
import '../../domain/local_handler/Local_handler.dart';
import '../../presentation/routes/routes.dart';

emptyWidget(String? title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(ImageAsset.emptyResult,
          height: 50.h, width: 12.w, reverse: true, fit: BoxFit.fill),
      Text(title!,
          textAlign: TextAlign.center,
          style: TextStore.textTheme.displaySmall!
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w600))
    ],
  );
}


clearValues(){
  SharedPrefs.instance.clear();
  Get.showSnackbar(
    const GetSnackBar(
      //title: title,
      message: 'Unauthorized person. Please Login Again',
      icon: Icon(Icons.close,color: Colors.red),
      isDismissible: true,borderRadius: 8.0,
      backgroundColor: Colors.black38,
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: 340.0,
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.all(10.0),
      duration: Duration(milliseconds: 30),
    ),
  );
  Get.offAndToNamed(Routes.loginScreen);
  }
